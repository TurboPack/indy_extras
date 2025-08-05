unit dmod_main;
{
Copyright (c) 2025 J. Peter Mugaas.  All Rights Reserved.

Licensed under the Modified TaurusTLS BSD Licence or MPL 1.1.
}
interface

uses
  System.SysUtils, System.Classes, Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc;

type
  TOnDebugLog = procedure (ASender : TObject; const AText : String) of object;
  TdmodMain = class(TDataModule)
    projFile: TXMLDocument;
  strict private
    { Private declarations }
    FOnDebugLog : TOnDebugLog;
    procedure DoOnDebugLog(const AText : String);
    procedure UpdatePackage(const APkg: String;
      const AMajorVersion, AMinorVersion, ARelease, ABuild: Integer;
      const ACompanyName, ACopyright: String);
    procedure UpdateLazPkg(const APkg: String;
      const AMajorVersion, AMinorVersion, ARelease, ABuild: Integer;
      const ACompanyName: String);
  public
    { Public declarations }
    procedure CreateFromTemplates;
    procedure UpdatePackages(const AMajorVersion, AMinorVersion, ARelease,
      ABuild: Integer; const ACompanyName, ACopyright: String);
    procedure UpdateProductCopyright(const AProduct, ACopyright: String);
    procedure UpdateIncFile(const AMajorVersion, AMinorVersion, ARelease,
      ABuild: Integer; const AProductName: String);
    procedure WriteVersions_txt(const AProduct : String;
      const AMajorVersion, AMinorVersion, ARelease, ABuild: Integer);
    property OnDebugLog : TOnDebugLog read fOnDebugLog write fOnDebugLog;
  end;

var
  dmodMain: TdmodMain;

implementation

uses Variants, IdGlobal, IOUtils;
{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TdmodMain }

procedure IterateThroughSourceDir(VRT_Units, VDT_Units, VRegister: TStrings);
var
  LCurFile: TSearchRec;
begin
  VRT_Units.Clear;
  VDT_Units.Clear;
  VRegister.Clear;
  if FindFirst('..\..\..\..\Source\*.pas', faAnyFile, LCurFile) = 0 then
  begin
    repeat
      if (LCurFile.Attr and faDirectory) = 0 then
      begin
        if Pos('TaurusTLS_Dsn_', LCurFile.Name) = 1 then
        begin
          VDT_Units.Add(LCurFile.Name);
          if Pos('procedure Register;', IOUtils.TFile.ReadAllText('..\..\..\..\Source\'+LCurFile.Name)) > 0 then
          begin
             VRegister.Add(LCurFile.Name);
          end;
        end
        else
        begin
          VRT_Units.Add(LCurFile.Name);
        end;
      end;
    until FindNext(LCurFile) <> 0;
    FindClose(LCurFile);
  end;
end;

function ListUnitsForLPK(AUnits, ARegister: TStrings): string;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to AUnits.Count - 1 do
  begin
    Result := Result + #9#9#9+'<Item>' + sLineBreak;
    Result := Result + #9#9#9#9+'<Filename Value="..\..\Source\' + AUnits[i] + '"/>' + sLineBreak;
    if ARegister.IndexOf(AUnits[i]) > -1 then
    begin
      Result := Result + #9#9#9#9+'<HasRegisterProc Value="True"/>'  + sLineBreak;
    end;
    Result := Result + #9#9#9#9+'<UnitName Value="' + ChangeFileExt(AUnits[i],
      '') + '"/>' + sLineBreak;
    Result := Result + #9#9#9+'</Item>';
    if i < AUnits.Count -1 then
    begin
      Result := Result + sLineBreak;
    end;
  end;
end;

function ListUnitsForPAS(AUnits: TStrings): string;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to AUnits.Count - 1 do
  begin
    Result := Result + '  ' + ChangeFileExt(AUnits[i], '');
    if i = AUnits.Count - 1 then
    begin
      Result := Result + ';';
    end
    else
    begin
      Result := Result + ',' + sLineBreak;
    end;
  end;
end;

function ListUnitsForDPROJ(AUnits : TStrings) : string;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to AUnits.Count - 1 do
  begin
     Result := Result + '		<DCCReference Include="..\..\Source\' + AUnits[i] + '"/>' + sLineBreak;
  end;
end;

function ListUnitsForDPK(AUnits: TStrings): string;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to AUnits.Count - 1 do
  begin
    Result := Result + '  ' + ChangeFileExt(AUnits[i], '') + ' in ''..\..\Source\'
      + AUnits[i] + '''';
    if i = AUnits.Count - 1 then
    begin
      Result := Result + ';';
    end
    else
    begin
      Result := Result + ',' + sLineBreak;
    end;
  end;
end;

procedure FindFilesToRead(root:String; AResults : TStrings);
var
  SR:TSearchRec;
  LFileToRead : String;
begin
  root:=IncludeTrailingPathDelimiter(root);
  if FindFirst(root+'*.*',faAnyFile,SR) = 0 then
  begin
      repeat
          LFileToRead := root+SR.Name;
          if ((SR.Attr and faDirectory) = SR.Attr ) and (pos('.',SR.Name)=0) then
          begin
             FindFilesToRead(LFileToRead, AResults);
          end
          else
          begin
           if IdGlobal.PosInStrArray(ExtractFileExt(SR.Name), ['.pas', '.lpk','.dpk','.dproj']) >  -1 then
           begin
              AResults.Add(LFileToRead);

           end;
          end;
      until FindNext(SR)<>0;
      FindClose(SR);
  end;
end;

procedure TdmodMain.CreateFromTemplates;
var
  LRTL_Units, LDT_Units, L_Register: TStrings;
  LFilesToRead : TStrings;
  LFileContents : String;
  i : Integer;
  LFileToWrite : String;
begin
    LRTL_Units := TStringList.Create;
    LDT_Units := TStringList.Create;
    L_Register := TStringList.Create;
    LFilesToRead := TStringList.Create;
    try
      IterateThroughSourceDir(LRTL_Units, LDT_Units, L_Register);
      FindFilesToRead('..\..\Templates', LFilesToRead);
      for i := 0 to LFilesToRead.Count - 1 do
      begin
        Self.DoOnDebugLog( 'Read: '+ExpandFileName(LFilesToRead[i]));
        LFileContents :=  System.IOUtils.TFile.ReadAllText( LFilesToRead[i]);
        LFileToWrite :=  ExpandFileName( StringReplace( LFilesToRead[i],'..\..\Templates','..\..\..\..\Packages',[rfIgnoreCase]));
        LFileContents := StringReplace( LFileContents, '{$LPK_FILES_DT}', ListUnitsForLPK(LDT_Units, L_Register),[rfReplaceAll]);
        LFileContents := StringReplace( LFileContents, '{$LPK_FILES_RT}', ListUnitsForLPK(LRTL_Units, L_Register),[rfReplaceAll]);

        LFileContents := StringReplace( LFileContents, '{$DPROJ_FILES_DT}', ListUnitsForDPROJ(LDT_Units),[rfReplaceAll]);
        LFileContents := StringReplace( LFileContents, '{$DPROJ_FILES_RT}', ListUnitsForDPROJ(LRTL_Units),[rfReplaceAll]);

        LFileContents := StringReplace( LFileContents, '{$DPK_FILES_DT}', ListUnitsForDPK(LDT_Units),[rfReplaceAll]);
        LFileContents := StringReplace( LFileContents, '{$DPK_FILES_RT}', ListUnitsForDPK(LRTL_Units),[rfReplaceAll]);
         Self.DoOnDebugLog( 'Write: '+LFileToWrite );
        System.IOUtils.TFile.WriteAllText( LFileToWrite, LFileContents );
      end;
    finally
      FreeAndNil(LFilesToRead);
      FreeAndNil(L_Register);
      FreeAndNil(LDT_Units);
      FreeAndNil(LRTL_Units);
    end;
end;

procedure TdmodMain.DoOnDebugLog(const AText : String);
begin
  if Assigned(fOnDebugLog) then
  begin
    fOnDebugLog(Self,AText);
  end;
end;

procedure TdmodMain.UpdateIncFile(const AMajorVersion, AMinorVersion, ARelease,
  ABuild: Integer; const AProductName: String);
var
  Lstr: TStringList;
begin
  Lstr := TStringList.Create;
  try
    Lstr.Add('const');
    Lstr.Add('  gsTaurusTLSVersionMajor = ' + IntToStr(AMajorVersion) + ';');
    Lstr.Add('  {$NODEFINE gsTaurusTLSVersionMajor}');
    Lstr.Add('  gsTaurusTLSVersionMinor = ' + IntToStr(AMinorVersion) + ';');
    Lstr.Add('  {$NODEFINE gsTaurusTLSVersionMinor}');
    Lstr.Add('  gsTaurusTLSVersionRelease = ' + IntToStr(ARelease) + ';');
    Lstr.Add('  {$NODEFINE gsTaurusTLSVersionRelease}');
    Lstr.Add('  gsTaurusTLSVersionBuild = ' + IntToStr(ABuild) + ';');
    Lstr.Add('  {$NODEFINE gsTaurusTLSVersionBuild}');
    Lstr.Add('');
    Lstr.Add('  (*$HPPEMIT ''#define gsTaurusTLSVersionMajor ' +
      IntToStr(AMajorVersion) + '''*)');
    Lstr.Add('  (*$HPPEMIT ''#define gsTaurusTLSVersionMinor ' +
      IntToStr(AMinorVersion) + '''*)');
    Lstr.Add('  (*$HPPEMIT ''#define gsTaurusTLSVersionRelease ' +
      IntToStr(ARelease) + '''*)');
    Lstr.Add('  (*$HPPEMIT ''#define gsTaurusTLSVersionBuild ' +
      IntToStr(ABuild) + '''*)');
    Lstr.Add('  (*$HPPEMIT ''''*)');
    Lstr.Add('');
    Lstr.Add('  gsTaurusTLSVersion = ''' + IntToStr(AMajorVersion) + '.' +
      IntToStr(AMinorVersion) + '.' + IntToStr(ARelease) + '.' +
      IntToStr(ABuild) + '''; {do not localize}');
    Lstr.Add('  gsTaurusTLSProductName = ''' + AProductName +
      ''';  {do not localize}');
    Lstr.Add('  gsTaurusTLSProductVersion = ''' + IntToStr(AMajorVersion) + '.'
      + IntToStr(AMinorVersion) + '.' + IntToStr(ARelease) + '.' +
      IntToStr(ABuild) + '''; {do not localize}');
    // C:\msys64\home\jpmugaas\TaurusTLS\devtools\VersionManager\Win64\Debug
    // C:\msys64\home\jpmugaas\TaurusTLS\Source
    Lstr.SaveToFile('..\..\..\..\Source\TaurusTLS_Vers.inc');
  finally
    FreeAndNil(Lstr);
  end;
end;

procedure TdmodMain.UpdateLazPkg(const APkg: String;
  const AMajorVersion, AMinorVersion, ARelease, ABuild: Integer;
  const ACompanyName: String);
var
  LRoot, LXMLNode: IXMLNode;
  i: Integer;
begin
  projFile.FileName := APkg;
  projFile.Active := True;
  try
    LRoot := projFile.DocumentElement;
    for i := 0 to LRoot.ChildNodes.Count - 1 do
    begin
      LXMLNode := LRoot.ChildNodes[i];
      LXMLNode.ChildNodes['Author'].Attributes['Value'] := ACompanyName;
      LXMLNode.ChildNodes.Delete('Version');
      LXMLNode.ChildNodes['Version'].Attributes['Major'] := AMajorVersion;
      if AMinorVersion <> 0 then
      begin
        LXMLNode.ChildNodes['Version'].Attributes['Minor'] := AMinorVersion;
      end;
      if ARelease <> 0 then
      begin
        LXMLNode.ChildNodes['Version'].Attributes['Release'] := ARelease;
      end;
      if ABuild <> 0 then
      begin
        LXMLNode.ChildNodes['Version'].Attributes['Build'] := ABuild;
      end;
    end;
    projFile.SaveToFile(APkg);
  finally
    projFile.Active := False;
  end;
end;

procedure TdmodMain.UpdatePackage(const APkg: String;
  const AMajorVersion, AMinorVersion, ARelease, ABuild: Integer;
  const ACompanyName, ACopyright: String);
var
  LRoot, LXMLNode: IXMLNode;
  i: Integer;

begin
  projFile.FileName := APkg;
  projFile.Active := True;
  try
    LRoot := projFile.DocumentElement;
    for i := 0 to LRoot.ChildNodes.Count - 1 do
    begin
      LXMLNode := LRoot.ChildNodes[i];
      if LXMLNode.HasChildNodes then
      begin
        if not VarIsNull(LXMLNode['VerInfo_Keys']) then
        begin
          LXMLNode['VerInfo_Keys'] := 'CompanyName=' + ACompanyName +
            ';FileDescription=$(MSBuildProjectName);FileVersion=' +
            IntToStr(AMajorVersion) + '.' + IntToStr(AMinorVersion) + '.' +
            IntToStr(ARelease) + '.' + IntToStr(ABuild) + ';InternalName=' +
            ChangeFileExt(ExtractFileName(APkg), '.bpl') + ';LegalCopyright=' +
            ACopyright + ';LegalTrademarks=;OriginalFilename=' +
            ChangeFileExt(ExtractFileName(APkg), '.bpl') +
            ';ProgramID=com.embarcadero.$(MSBuildProjectName);ProductName=$(MSBuildProjectName);ProductVersion='
            + IntToStr(AMajorVersion) + '.' + IntToStr(AMinorVersion) + '.' +
            IntToStr(ARelease) + '.' + IntToStr(ABuild) + ';Comments=';
        end;
      end;
    end;
    projFile.SaveToFile(APkg);
  finally
    projFile.Active := False;
  end;
end;


procedure TdmodMain.UpdatePackages(
  const AMajorVersion, AMinorVersion, ARelease, ABuild: Integer;
  const ACompanyName, ACopyright: String);
begin
  UpdatePackage('..\..\..\..\Packages\d13\TaurusTLS_RTForIndy370.dproj',
            AMajorVersion, AMinorVersion, ARelease, ABuild, ACompanyName,
            ACopyright);
  UpdatePackage('..\..\..\..\Packages\d13\TaurusTLS_DTForIndy370.dproj',
            AMajorVersion, AMinorVersion, ARelease, ABuild, ACompanyName,
            ACopyright);
  UpdatePackage('..\..\..\..\Packages\d13\TaurusTLS_RT.dproj',
            AMajorVersion, AMinorVersion, ARelease, ABuild, ACompanyName,
            ACopyright);
  UpdatePackage('..\..\..\..\Packages\d13\TaurusTLS_DT.dproj',
            AMajorVersion, AMinorVersion, ARelease, ABuild, ACompanyName,
            ACopyright);


  UpdatePackage('..\..\..\..\Packages\d12\TaurusTLS_RTForIndy290.dproj',
            AMajorVersion, AMinorVersion, ARelease, ABuild, ACompanyName,
            ACopyright);
  UpdatePackage('..\..\..\..\Packages\d12\TaurusTLS_DTForIndy290.dproj',
            AMajorVersion, AMinorVersion, ARelease, ABuild, ACompanyName,
            ACopyright);
  UpdatePackage('..\..\..\..\Packages\d12\TaurusTLS_RT.dproj',
            AMajorVersion, AMinorVersion, ARelease, ABuild, ACompanyName,
            ACopyright);
  UpdatePackage('..\..\..\..\Packages\d12\TaurusTLS_DT.dproj',
            AMajorVersion, AMinorVersion, ARelease, ABuild, ACompanyName,
            ACopyright);
  UpdatePackage('..\..\..\..\Packages\d11\TaurusTLS_RTForIndy280.dproj',
            AMajorVersion, AMinorVersion, ARelease, ABuild, ACompanyName,
            ACopyright);
  UpdatePackage('..\..\..\..\Packages\d11\TaurusTLS_DTForIndy280.dproj',
            AMajorVersion, AMinorVersion, ARelease, ABuild, ACompanyName,
            ACopyright);
  UpdatePackage('..\..\..\..\Packages\d11\TaurusTLS_RT.dproj',
            AMajorVersion, AMinorVersion, ARelease, ABuild, ACompanyName,
            ACopyright);
   UpdatePackage('..\..\..\..\Packages\d11\TaurusTLS_DT.dproj',
            AMajorVersion, AMinorVersion, ARelease, ABuild, ACompanyName,
            ACopyright);

  UpdatePackage('..\..\..\..\Packages\drio\TaurusTLS_RTForIndy260.dproj',
            AMajorVersion, AMinorVersion, ARelease, ABuild, ACompanyName,
            ACopyright);
  UpdatePackage('..\..\..\..\Packages\drio\TaurusTLS_DTForIndy260.dproj',
            AMajorVersion, AMinorVersion, ARelease, ABuild, ACompanyName,
            ACopyright);
   UpdatePackage('..\..\..\..\Packages\drio\TaurusTLS_RT.dproj',
            AMajorVersion, AMinorVersion, ARelease, ABuild, ACompanyName,
            ACopyright);
   UpdatePackage('..\..\..\..\Packages\drio\TaurusTLS_DT.dproj',
            AMajorVersion, AMinorVersion, ARelease, ABuild, ACompanyName,
            ACopyright);

  UpdatePackage('..\..\..\..\Packages\dtokyo\TaurusTLS_RTForIndy250.dproj',
            AMajorVersion, AMinorVersion, ARelease, ABuild, ACompanyName,
            ACopyright);
  UpdatePackage('..\..\..\..\Packages\dtokyo\TaurusTLS_DTForIndy250.dproj',
            AMajorVersion, AMinorVersion, ARelease, ABuild, ACompanyName,
            ACopyright);
   UpdatePackage('..\..\..\..\Packages\dtokyo\TaurusTLS_RT.dproj',
            AMajorVersion, AMinorVersion, ARelease, ABuild, ACompanyName,
            ACopyright);
   UpdatePackage('..\..\..\..\Packages\dtokyo\TaurusTLS_DT.dproj',
            AMajorVersion, AMinorVersion, ARelease, ABuild, ACompanyName,
            ACopyright);

  UpdatePackage('..\..\..\..\Packages\dberlin\TaurusTLS_RTForIndy240.dproj',
            AMajorVersion, AMinorVersion, ARelease, ABuild, ACompanyName,
            ACopyright);
  UpdatePackage('..\..\..\..\Packages\dberlin\TaurusTLS_DTForIndy240.dproj',
            AMajorVersion, AMinorVersion, ARelease, ABuild, ACompanyName,
            ACopyright);
   UpdatePackage('..\..\..\..\Packages\dberlin\TaurusTLS_RT.dproj',
            AMajorVersion, AMinorVersion, ARelease, ABuild, ACompanyName,
            ACopyright);
   UpdatePackage('..\..\..\..\Packages\dberlin\TaurusTLS_DT.dproj',
            AMajorVersion, AMinorVersion, ARelease, ABuild, ACompanyName,
            ACopyright);

  UpdatePackage('..\..\..\..\Packages\dseattle\TaurusTLS_RTForIndy230.dproj',
            AMajorVersion, AMinorVersion, ARelease, ABuild, ACompanyName,
            ACopyright);
  UpdatePackage('..\..\..\..\Packages\dseattle\TaurusTLS_DTForIndy230.dproj',
            AMajorVersion, AMinorVersion, ARelease, ABuild, ACompanyName,
            ACopyright);
   UpdatePackage('..\..\..\..\Packages\dseattle\TaurusTLS_RT.dproj',
            AMajorVersion, AMinorVersion, ARelease, ABuild, ACompanyName,
            ACopyright);
   UpdatePackage('..\..\..\..\Packages\dseattle\TaurusTLS_DT.dproj',
            AMajorVersion, AMinorVersion, ARelease, ABuild, ACompanyName,
            ACopyright);

  UpdatePackage('..\..\..\..\Packages\dsydney\TaurusTLS_RTForIndy270.dproj',
            AMajorVersion, AMinorVersion, ARelease, ABuild, ACompanyName,
            ACopyright);
  UpdatePackage('..\..\..\..\Packages\dsydney\TaurusTLS_DTForIndy270.dproj',
            AMajorVersion, AMinorVersion, ARelease, ABuild, ACompanyName,
            ACopyright);
  UpdatePackage('..\..\..\..\Packages\dsydney\TaurusTLS_RT.dproj',
            AMajorVersion, AMinorVersion, ARelease, ABuild, ACompanyName,
            ACopyright);
  UpdatePackage('..\..\..\..\Packages\dsydney\TaurusTLS_DT.dproj',
            AMajorVersion, AMinorVersion, ARelease, ABuild, ACompanyName,
            ACopyright);

   UpdateLazPkg('..\..\..\..\Packages\Lazarus\taurustlsrt.lpk',
            AMajorVersion, AMinorVersion, ARelease, ABuild, ACompanyName);
   UpdateLazPkg('..\..\..\..\Packages\Lazarus\taurustlsldsgn.lpk',
            AMajorVersion, AMinorVersion, ARelease, ABuild, ACompanyName);
end;

procedure TdmodMain.UpdateProductCopyright(
  const  AProduct, ACopyright: String);
var Lstr: TStringList; i: Integer;
begin
  Lstr := TStringList.Create;
  try
    Lstr.LoadFromFile('..\..\..\..\Source\TaurusTLS_Dsn_ResourceStrings.pas');
    for i := 0 to Lstr.Count - 1 do
    begin
      if Pos(' RSCopyright = ', Lstr[i]) > 0 then
      begin
        Lstr[i] := '  RSCopyright = ''' + ACopyright
            + ''';';
      end;
      if Pos(' RSTaurusTLS = ', Lstr[i]) > 0  then
      begin
        Lstr[i] := '  RSTaurusTLS = ''' + AProduct + ''';';
      end;
      if Pos(' RSAAboutMenuItemName = ', Lstr[i]) > 0 then
      begin
        Lstr[i] := '  RSAAboutMenuItemName = ''&About ' + AProduct + ' %s...'';'
      end;
    end;
    Lstr.SaveToFile('..\..\..\..\Source\TaurusTLS_Dsn_ResourceStrings.pas');
  finally
    FreeAndNil(Lstr);
  end;
end;

 procedure TdmodMain.WriteVersions_txt(const AProduct : String;
   const AMajorVersion, AMinorVersion, ARelease, ABuild: Integer);
var
  versions_txt : TextFile;
  LYear, LMonth, LDay : Word;
  LHour, LMin, LSec, LMSec : Word;
begin
  System.Assign(versions_txt,'..\..\..\..\version.txt');
  Rewrite(versions_txt);
  WriteLn(versions_txt,Format('%s: %d.%d.%d.%d',[AProduct, AMajorVersion, AMinorVersion, ARelease, ABuild]));
  DecodeDate(Now,LYear,LMonth,LDay);
  DecodeTime(Now,LHour,LMin,LSec,LMSec);
  WriteLn(versions_txt,FormatDateTime('yyyy-mm-dd hh:nn:ss.zzz',Now));
  Close(versions_txt);
 end;

end.

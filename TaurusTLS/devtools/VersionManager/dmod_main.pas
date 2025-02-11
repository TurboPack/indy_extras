unit dmod_main;
{
Copyright (c) 2025 J. Peter Mugaas.  All Rights Reserved.

Licensed under the Modified TaurusTLS BSD Licence or MPL 1.1.
}
interface

uses
  System.SysUtils, System.Classes, Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc;

type
  TdmodMain = class(TDataModule)
    projFile: TXMLDocument;
  strict private
    { Private declarations }
    procedure UpdatePackage(const APkg: String;
      const AMajorVersion, AMinorVersion, ARelease, ABuild: Integer;
      const ACompanyName, ACopyright: String);
    procedure UpdateLazPkg(const APkg: String;
      const AMajorVersion, AMinorVersion, ARelease, ABuild: Integer;
      const ACompanyName: String);
  public
    { Public declarations }
    procedure UpdatePackages(const AMajorVersion, AMinorVersion, ARelease,
      ABuild: Integer; const ACompanyName, ACopyright: String);
    procedure UpdateProductCopyright(const AProduct, ACopyright: String);
    procedure UpdateIncFile(const AMajorVersion, AMinorVersion, ARelease,
      ABuild: Integer; const AProductName: String);
  end;

var
  dmodMain: TdmodMain;

implementation

uses Variants;
{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TdmodMain }

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
  UpdatePackage('..\..\..\..\Packages\12AndAbove\Delphi\TaurusTLS_RTForIndy290.dproj',
            AMajorVersion, AMinorVersion, ARelease, ABuild, ACompanyName,
            ACopyright);
  UpdatePackage('..\..\..\..\Packages\12AndAbove\Delphi\TaurusTLS_DTForIndy290.dproj',
            AMajorVersion, AMinorVersion, ARelease, ABuild, ACompanyName,
            ACopyright);
  UpdatePackage('..\..\..\..\Packages\12AndAbove\Delphi\TaurusTLS_RT.dproj',
            AMajorVersion, AMinorVersion, ARelease, ABuild, ACompanyName,
            ACopyright);
  UpdatePackage('..\..\..\..\Packages\12AndAbove\Delphi\TaurusTLS_DT.dproj',
            AMajorVersion, AMinorVersion, ARelease, ABuild, ACompanyName,
            ACopyright);
  UpdatePackage('..\..\..\..\Packages\Alexandria\Delphi\TaurusTLS_RTForIndy280.dproj',
            AMajorVersion, AMinorVersion, ARelease, ABuild, ACompanyName,
            ACopyright);
  UpdatePackage('..\..\..\..\Packages\Alexandria\Delphi\TaurusTLS_DTForIndy280.dproj',
            AMajorVersion, AMinorVersion, ARelease, ABuild, ACompanyName,
            ACopyright);
  UpdatePackage('..\..\..\..\Packages\Alexandria\Delphi\TaurusTLS_RT.dproj',
            AMajorVersion, AMinorVersion, ARelease, ABuild, ACompanyName,
            ACopyright);
   UpdatePackage('..\..\..\..\Packages\Alexandria\Delphi\TaurusTLS_DT.dproj',
            AMajorVersion, AMinorVersion, ARelease, ABuild, ACompanyName,
            ACopyright);

   UpdatePackage('..\..\..\..\Packages\Rio\Delphi\TaurusTLS_RT.dproj',
            AMajorVersion, AMinorVersion, ARelease, ABuild, ACompanyName,
            ACopyright);
   UpdatePackage('..\..\..\..\Packages\Rio\Delphi\TaurusTLS_DT.dproj',
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

 end.

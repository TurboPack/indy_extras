unit dmod_main;

interface

uses
  System.SysUtils, System.Classes, Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc;

type
  TdmodMain = class(TDataModule)
    projFile: TXMLDocument;
  private
    { Private declarations }
    procedure UpdatePackage(const APkg, AVerInfo : String); overload;
    procedure UpdatePackage(const APkg : String;
      const AMajorVersion, AMinorVersion, ARelease, ABuild : Integer;
      const AProductName, ACompanyName, ACopyright: String); overload;
  public
    { Public declarations }
    procedure UpdatePackages(const AMajorVersion, AMinorVersion, ARelease,
      ABuild: Integer; const AProductName, ACompanyName, ACopyright : String);
    procedure UpdateProductCopyright(const AProduct, ACopyright : String);
    procedure UpdateIncFile(const AMajorVersion, AMinorVersion, ARelease, ABuild : Integer; const AProductName : String);
  end;

var
   dmodMain :  TdmodMain;

implementation
uses Dialogs, Variants;
{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmodMain }

procedure TdmodMain.UpdateIncFile(const AMajorVersion, AMinorVersion, ARelease,
  ABuild: Integer; const AProductName : String);
var Lstr : TStringList;
begin
  LStr := TStringList.Create;
  try
    LStr.Add('const');
    LStr.Add('  gsTaurusTLSVersionMajor = '+IntToStr(AMajorVersion)+';');
    LStr.Add('  {$NODEFINE gsTaurusTLSVersionMajor}');
    LStr.Add('  gsTaurusTLSVersionMinor = '+IntToStr(AMinorVersion)+';');
    LStr.Add('  {$NODEFINE gsTaurusTLSVersionMinor}');
    LStr.Add('  gsTaurusTLSVersionRelease = '+IntToStr(ARelease)+';');
    LStr.Add('  {$NODEFINE gsTaurusTLSVersionRelease}');
    LStr.Add('  gsTaurusTLSVersionBuild = '+IntToStr(ABuild)+';');
    LStr.Add('  {$NODEFINE gsTaurusTLSVersionBuild}');
    LStr.Add('');
    LStr.Add('  (*$HPPEMIT ''#define gsTaurusTLSVersionMajor '+IntToStr(AMajorVersion)+'''*)');
    LStr.Add('  (*$HPPEMIT ''#define gsTaurusTLSVersionMinor '+IntToStr(AMinorVersion)+'''*)');
    LStr.Add('  (*$HPPEMIT ''#define gsTaurusTLSVersionRelease '+IntToStr(ARelease)+'''*)');
    LStr.Add('  (*$HPPEMIT ''#define gsTaurusTLSVersionBuild '+IntToStr(ABuild)+'''*)');
    LStr.Add('  (*$HPPEMIT ''''*)');
    LStr.Add('');
    LStr.Add('  gsTaurusTLSVersion = '''+IntToStr(AMajorVersion)+'.'+IntToStr(AMinorVersion)+'.'+ IntToStr(ARelease)+'.'+IntToStr(ABuild)+'''; {do not localize}');
    LStr.Add('  gsTaurusTLSProductName = '''+AProductName+''';  {do not localize}');
    LStr.Add('  gsTaurusTLSProductVersion = '''+IntToStr(AMajorVersion)+'.'+IntToStr(AMinorVersion)+'.'+ IntToStr(ARelease)+'.'+IntToStr(ABuild)+'''; {do not localize}');
    //C:\msys64\home\jpmugaas\TaurusTLS\devtools\VersionManager\Win64\Debug
    //C:\msys64\home\jpmugaas\TaurusTLS\Source
    LStr.SaveToFile('..\..\..\..\Source\TaurusTLS_Vers.inc');
  finally
    FreeAndNil(LStr);
  end;
end;

procedure TdmodMain.UpdatePackage(const APkg: String; const AMajorVersion,
  AMinorVersion, ARelease, ABuild: Integer; const AProductName, ACompanyName,
  ACopyright: String);
begin
  var LVerINfo : String;
  LVerInfo := 'CompanyName='+ ACompanyName+
    ';FileDescription=$(MSBuildProjectName);FileVersion='+
    IntToStr(AMajorVersion)+'.'+IntToStr(AMinorVersion)+'.'+IntToStr(ARelease)+'.'+IntToStr(ABuild)
    +';InternalName='
    + ChangeFileExt(ExtractFileName(APkg),'.bpl')
    +';LegalCopyright='+ ACopyright
    +';LegalTrademarks=;OriginalFilename='
    + ChangeFileExt(ExtractFileName(APkg),'.bpl')
    +';ProgramID=com.embarcadero.$(MSBuildProjectName);ProductName=$(MSBuildProjectName);ProductVersion='
    +IntToStr(AMajorVersion)+'.'+IntToStr(AMinorVersion)+'.'+IntToStr(ARelease)+'.'+IntToStr(ABuild)
    +';Comments=';
    UpdatePackage(APkg,LVerInfo);
end;

procedure TdmodMain.UpdatePackage(const APkg, AVerInfo: String);
var
  LRoot,
  LXMLNode, LXMLNode2 : IXMLNode;
  i,j : Integer;
begin
  projFile.FileName := APkg;
  projFile.Active := True;
  try
    LRoot := projFile.DocumentElement;
    for i := 0 to LRoot.ChildNodes.Count -1 do
    begin
      LXMLNode := LRoot.ChildNodes[i];
      if LXMLNode.HasChildNodes then
      begin
        if not VarIsNull(LXMLNode['VerInfo_Keys'] ) then
        begin
//          Dialogs.MessageDlg(LXMLNode['VerInfo_Keys'],mtInformation,[mbOk],0);
          LXMLNode['VerInfo_Keys'] := AVerInfo;
        end;
      end;
     end;
     projFile.SaveToFile(APkg);
  finally
    projFile.Active := False;
  end;
end;

procedure TdmodMain.UpdatePackages(const AMajorVersion, AMinorVersion, ARelease,
  ABuild: Integer; const AProductName, ACompanyName, ACopyright: String);
begin
  UpdatePackage('..\..\..\..\Packages\12AndAbove\Delphi\TaurusTLS_RTForIndy290.dproj',AMajorVersion,AMinorVersion,ARelease,ABuild,AProductName,ACompanyName,ACopyright);
  UpdatePackage('..\..\..\..\Packages\12AndAbove\Delphi\TaurusTLS_DTForIndy290.dproj',AMajorVersion,AMinorVersion,ARelease,ABuild,AProductName,ACompanyName,ACopyright);
  UpdatePackage('..\..\..\..\Packages\12AndAbove\Delphi\TaurusTLS_RT.dproj',AMajorVersion,AMinorVersion,ARelease,ABuild,AProductName,ACompanyName,ACopyright);
  UpdatePackage('..\..\..\..\Packages\12AndAbove\Delphi\TaurusTLS_DT.dproj',AMajorVersion,AMinorVersion,ARelease,ABuild,AProductName,ACompanyName,ACopyright);

  UpdatePackage('..\..\..\..\Packages\Alexandria\Delphi\TaurusTLS_RT.dproj',AMajorVersion,AMinorVersion,ARelease,ABuild,AProductName,ACompanyName,ACopyright);
  UpdatePackage('..\..\..\..\Packages\Alexandria\Delphi\TaurusTLS_DT.dproj',AMajorVersion,AMinorVersion,ARelease,ABuild,AProductName,ACompanyName,ACopyright);

  UpdatePackage('..\..\..\..\Packages\Rio\Delphi\TaurusTLS_RT.dproj',AMajorVersion,AMinorVersion,ARelease,ABuild,AProductName,ACompanyName,ACopyright);
  UpdatePackage('..\..\..\..\Packages\Rio\Delphi\TaurusTLS_DT.dproj',AMajorVersion,AMinorVersion,ARelease,ABuild,AProductName,ACompanyName,ACopyright);

end;

procedure TdmodMain.UpdateProductCopyright(const AProduct, ACopyright : String);
var Lstr : TStringList;
  i : Integer;
begin
  LStr := TStringList.Create;
  try
    LStr.LoadFromFile('..\..\..\..\Source\TaurusTLS_Dsn_ResourceStrings.pas');
    for i := 0 to LStr.Count -1 do
    begin
      if Pos(' RSCopyright = ',LStr[i]) > 0 then
      begin
         LStr[i] := '  RSCopyright = '''+ ACopyright+''';';
      end;
      if Pos(' RSTaurusTLS = ', LStr[i]) > 0 then
      begin
        LStr[i] := '  RSTaurusTLS = '''+ AProduct+''';';
      end;
      if Pos(' RSAAboutMenuItemName = ',LStr[i]) > 0 then
      begin
        LStr[i] := '  RSAAboutMenuItemName = ''&About '+AProduct+' %s...'';'
      end;
    end;
    LStr.SaveToFile('..\..\..\..\Source\TaurusTLS_Dsn_ResourceStrings.pas');
  finally
    FreeAndNil(LStr);
  end;
end;



end.

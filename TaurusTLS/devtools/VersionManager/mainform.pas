unit mainform;
{
Copyright (c) 2025 J. Peter Mugaas.  All Rights Reserved.

Licensed under the Modified TaurusTLS BSD Licence or MPL 1.1.
}
interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Xml.xmldom, Xml.XMLIntf,
  Xml.Win.msxmldom, Xml.XMLDoc, Vcl.StdCtrls, Vcl.Samples.Spin;

type
  TfrmMainForm = class(TForm)
    spnMajorVersion: TSpinEdit;
    spnMinorVersion: TSpinEdit;
    spnedtRelease: TSpinEdit;
    spnedtBuild: TSpinEdit;
    lblMajorVersion: TLabel;
    lblMinorVersion: TLabel;
    lblRelease: TLabel;
    lblBuild: TLabel;
    edtCompanyName: TEdit;
    lblCompanyName: TLabel;
    edtCopyright: TEdit;
    lblCopyright: TLabel;
    btnGenerateFiles: TButton;
    edtProductName: TEdit;
    lblProductName: TLabel;
    mmoLog: TMemo;
    procedure btnGenerateFilesClick(Sender: TObject);
  private
    { Private declarations }
    procedure OnDebugLog(ASender : TObject; const AText : String);
  public
    { Public declarations }
    constructor Create(AOwner : TComponent);  override;
    destructor Destroy; override;
  end;

var
  frmMainForm: TfrmMainForm;

implementation
uses IniFiles, dmod_main;

{$R *.dfm}

{ TfrmMainForm }

procedure TfrmMainForm.btnGenerateFilesClick(Sender: TObject);
begin
  dmod_main.dmodMain.OnDebugLog := OnDebugLog;
  dmod_main.dmodMain.CreateFromTemplates;

  dmod_main.dmodMain.UpdateIncFile(spnMajorVersion.Value,
    spnMinorVersion.Value,
    spnedtRelease.Value,
    spnedtBuild.Value,
    edtProductName.Text);
  dmodMain.UpdateProductCopyright(Self.edtProductName.Text,Self.edtCopyright.Text);
  dmodMain.UpdatePackages(spnMajorVersion.Value,
    spnMinorVersion.Value,
    spnedtRelease.Value,
    spnedtBuild.Value,
    edtCompanyName.Text,
    edtCopyright.Text);
  dmodMain.WriteVersions_txt(edtProductName.Text, spnMajorVersion.Value,
    spnMinorVersion.Value,
    spnedtRelease.Value,
    spnedtBuild.Value);
end;

constructor TfrmMainForm.Create(AOwner: TComponent);
var LIni : TIniFile;
begin
  inherited Create(AOwner);
   Lini := TIniFile.Create( ChangeFileExt(ParamStr(0),'.ini'));
   try
     spnMajorVersion.Value := Lini.ReadInteger('Version','major',1);
     spnMinorVersion.Value := Lini.ReadInteger('Version','minor', 0);
     spnedtRelease.Value := Lini.ReadInteger('Version','release', 0);
     spnedtBuild.Value := Lini.ReadInteger('Version','build', 4);
     edtCompanyName.Text := Lini.ReadString('Company','Name', '');
     edtCopyright.Text := LIni.ReadString('Copyright','Notice', '');
     edtProductName.Text := LIni.ReadString('Product','Name','');
   finally
     FreeAndNil(Lini);
   end;
end;

destructor TfrmMainForm.Destroy;
var LIni : TIniFile;
begin
   Lini := TIniFile.Create( ChangeFileExt(ParamStr(0),'.ini'));
   try
     Lini.WriteInteger('Version','major',spnMajorVersion.Value);
     Lini.WriteInteger('Version','minor',Self.spnMinorVersion.Value);
     Lini.WriteInteger('Version','release',Self.spnedtRelease.Value);
     Lini.WriteInteger('Version','build',Self.spnedtBuild.Value);
     LIni.WriteString('Product','Name',edtProductName.Text);
     Lini.WriteString('Company','Name',Self.edtCompanyName.Text);
     LIni.WriteString('Copyright','Notice',Self.edtCopyright.Text);
   finally
     FreeAndNil(Lini);
   end;
  inherited;
end;

procedure TfrmMainForm.OnDebugLog(ASender: TObject; const AText: String);
begin
  Self.mmoLog.Lines.Add(AText);
end;

end.

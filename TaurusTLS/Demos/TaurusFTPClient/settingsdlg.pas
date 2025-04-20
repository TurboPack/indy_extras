unit settingsdlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, Vcl.ExtCtrls,
  System.ImageList, Vcl.ImgList, Vcl.VirtualImageList, Vcl.BaseImageCollection,
  Vcl.ImageCollection, Vcl.Dialogs, Vcl.CheckLst, Vcl.Samples.Spin;

type
  TfrmSettings = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    PageControl1: TPageControl;
    tbshtFont: TTabSheet;
    tbshtFTPSettings: TTabSheet;
    tbshtFrewallProxy: TTabSheet;
    OKBtn: TButton;
    CancelBtn: TButton;
    cboTransferTypes: TComboBox;
    lblTransferType: TLabel;
    ImageCollection1: TImageCollection;
    VirtualImageList1: TVirtualImageList;
    FontDialog1: TFontDialog;
    btnFontSelect: TButton;
    chklbAdvancedOptions: TCheckListBox;
    lblAdvancedOptions: TLabel;
    redtTextSamples: TRichEdit;
    ScrollBox1: TScrollBox;
    lblErrors: TLabel;
    lblTLSMessages: TLabel;
    lblDirOutput: TLabel;
    cboErrorForeground: TColorBox;
    cboErrorBackground: TColorBox;
    cboTLSMessageForeground: TColorBox;
    cboTLSMessageBackground: TColorBox;
    cboDirOutputForeground: TColorBox;
    cboDirOutputBackground: TColorBox;
    lblForeground: TLabel;
    lblBackground: TLabel;
    cboDebugForeground: TColorBox;
    cboDebugBackground: TColorBox;
    lblDebugOutput: TLabel;
    tbshtDebugSetting: TTabSheet;
    chkLogDebug: TCheckBox;
    btnNATSettings: TButton;
    btnTransparentProxy: TButton;
    btnFTPProxySettings: TButton;
    chkDirOutput: TCheckBox;
    chkDebugSSLInfo: TCheckBox;
    cboRegularForeground: TColorBox;
    cboRegularBackground: TColorBox;
    lblRegular: TLabel;
    cboDisplayMode: TComboBox;
    lblDisplayMode: TLabel;
    procedure btnFontSelectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chklbAdvancedOptionsClickCheck(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cboErrorForegroundChange(Sender: TObject);
    procedure cboErrorBackgroundChange(Sender: TObject);
    procedure cboTLSMessageBackgroundChange(Sender: TObject);
    procedure cboTLSMessageForegroundChange(Sender: TObject);
    procedure cboDirOutputForegroundChange(Sender: TObject);
    procedure cboDirOutputBackgroundChange(Sender: TObject);
    procedure cboDebugForegroundSelect(Sender: TObject);
    procedure cboDebugBackgroundSelect(Sender: TObject);
    procedure btnNATSettingsClick(Sender: TObject);
    procedure btnTransparentProxyClick(Sender: TObject);
    procedure btnFTPProxySettingsClick(Sender: TObject);
    procedure cboDisplayModeChange(Sender: TObject);
  private
    function GetConnected: Boolean;
    procedure SetConnected(const Value: Boolean);
    procedure HandleThemes;
  protected
    FRegularForeground: TColor;
    FRegularBackground: TColor;
    FErrorForeground: TColor;
    FErrorBackground: TColor;
    FSSLMessageForeground: TColor;
    FSSLMessageBackground: TColor;
    FDirOutputForeground: TColor;
    FDirOutputBackground: TColor;
    FDebugForeground: TColor;
    FDebugBackground: TColor;
    // proxy/firewall settings for subdialog-boxes
    FNATPortMin: Word;
    FNATPortMax: Word;
    FNATIPAddress: String;
    FProxyPort: Word;
    FProxyHost: String;
    FProxyUsername: String;
    FProxyPassword: String;
    FProxyType: Integer;
    FFTPProxyPort: Word;
    FFTPProxyType: Integer;
    FFTPProxyPassword: String;
    FFTPProxyHost: String;
    FFTPProxyUsername: String;
    //
    function GetUsePortTransferType: Boolean;
    procedure SetUsePortTransferType(const Value: Boolean);
    procedure EnableDisableCheckBoxes;
    procedure DisplaySampleTexts;
    procedure SetRegularBackground(const Value: TColor);
    procedure SetRegularForeground(const Value: TColor);
    procedure SetDirOutputBackground(const Value: TColor);
    procedure SetDirOutputForeground(const Value: TColor);
    procedure SetErrorBackground(const Value: TColor);
    procedure SetErrorForeground(const Value: TColor);
    procedure SetSSLMessageBackground(const Value: TColor);
    procedure SetSSLMessageForeground(const Value: TColor);
    function GetRegularBackground: TColor;
    function GetRegularForeground: TColor;
    function GetDirOutputBackground: TColor;
    function GetDirOutputForeground: TColor;
    function GetErrorBackground: TColor;
    function GetErrorForeground: TColor;
    function GetSSLMessageBackground: TColor;
    function GetSSLMessageForeground: TColor;
    function GetDebugBackground: TColor;
    function GetDebugForeground: TColor;
    procedure SetDebugBackground(const Value: TColor);
    procedure SetDebugForeground(const Value: TColor);
    procedure WMSettingChange(var Message: TWMSettingChange);
      message WM_SETTINGCHANGE;
    { Private declarations }
  public
    { Public declarations }
    property Connected: Boolean read GetConnected write SetConnected;
    property UsePortTransferType: Boolean read GetUsePortTransferType
      write SetUsePortTransferType;
    property RegularForeground: TColor read GetRegularForeground
      write SetRegularForeground;
    property RegularBackground: TColor read GetRegularBackground
      write SetRegularBackground;
    property ErrorForeground: TColor read GetErrorForeground
      write SetErrorForeground;
    property ErrorBackground: TColor read GetErrorBackground
      write SetErrorBackground;
    property SSLMessageForeground: TColor read GetSSLMessageForeground
      write SetSSLMessageForeground;
    property SSLMessageBackground: TColor read GetSSLMessageBackground
      write SetSSLMessageBackground;
    property DirOutputForeground: TColor read GetDirOutputForeground
      write SetDirOutputForeground;
    property DirOutputBackground: TColor read GetDirOutputBackground
      write SetDirOutputBackground;
    property DebugForeground: TColor read GetDebugForeground
      write SetDebugForeground;
    property DebugBackground: TColor read GetDebugBackground
      write SetDebugBackground;
    property NATPortMin: Word read FNATPortMin write FNATPortMin;
    property NATPortMax: Word read FNATPortMax write FNATPortMax;
    property NATIPAddress: String read FNATIPAddress write FNATIPAddress;
    property ProxyPort: Word read FProxyPort write FProxyPort;
    property ProxyHost: String read FProxyHost write FProxyHost;
    property ProxyUsername: String read FProxyUsername write FProxyUsername;
    property ProxyPassword: String read FProxyPassword write FProxyPassword;
    property ProxyType: Integer read FProxyType write FProxyType;

    property FTPProxyPort: Word read FFTPProxyPort write FFTPProxyPort;
    property FTPProxyHost: String read FFTPProxyHost write FFTPProxyHost;
    property FTPProxyUsername: String read FFTPProxyUsername
      write FFTPProxyUsername;
    property FTPProxyPassword: String read FFTPProxyPassword
      write FFTPProxyPassword;
    property FTPProxyType: Integer read FFTPProxyType write FFTPProxyType;

  end;

var
  frmSettings: TfrmSettings;

implementation

uses TaurusTLS, ProgUtils, dlgNATSettings, dlgFTPProxySettings,
  dlgProxySettings, WindowsDarkMode;

{$R *.dfm}
{ TfrmSettings }

procedure TfrmSettings.btnFontSelectClick(Sender: TObject);
begin
  FontDialog1.Font := redtTextSamples.Font;
  if FontDialog1.Execute then
  begin
    redtTextSamples.Font := FontDialog1.Font;
    Self.redtTextSamples.Font := FontDialog1.Font;
    Self.DisplaySampleTexts;
  end;
end;

procedure TfrmSettings.cboDirOutputBackgroundChange(Sender: TObject);
begin
  FDirOutputBackground := cboDirOutputBackground.Selected;
  DisplaySampleTexts;
end;

procedure TfrmSettings.cboDirOutputForegroundChange(Sender: TObject);
begin
  FDirOutputForeground := cboDirOutputForeground.Selected;
  DisplaySampleTexts;
end;

procedure TfrmSettings.cboErrorBackgroundChange(Sender: TObject);
begin
  FErrorBackground := cboErrorBackground.Selected;
  DisplaySampleTexts;
end;

procedure TfrmSettings.cboErrorForegroundChange(Sender: TObject);
begin
  FErrorForeground := cboErrorForeground.Selected;
  DisplaySampleTexts;
end;

procedure TfrmSettings.cboTLSMessageBackgroundChange(Sender: TObject);
begin
  FSSLMessageBackground := cboTLSMessageBackground.Selected;
  DisplaySampleTexts;
end;

procedure TfrmSettings.cboTLSMessageForegroundChange(Sender: TObject);
begin
  FSSLMessageForeground := cboTLSMessageForeground.Selected;
  DisplaySampleTexts;
end;

procedure TfrmSettings.chklbAdvancedOptionsClickCheck(Sender: TObject);
begin
  EnableDisableCheckBoxes;
end;

procedure TfrmSettings.btnFTPProxySettingsClick(Sender: TObject);
var
  Lfrm: TfrmFTPProxySettings;
begin
  Lfrm := TfrmFTPProxySettings.Create(Application);
  try
    Lfrm.Caption := DlgCaptionToFormCaption(btnFTPProxySettings.Caption);
    Lfrm.cboProxyType.ItemIndex := FFTPProxyType;
    Lfrm.edtProxyServerName.Text := FFTPProxyHost;
    Lfrm.edtProxyServerUserName.Text := FFTPProxyUsername;
    Lfrm.edtProxyServerPassword.Text := FFTPProxyPassword;
    Lfrm.spededtProxyPort.Value := FFTPProxyPort;
    if Lfrm.ShowModal = mrOk then
    begin
      FFTPProxyType := Lfrm.cboProxyType.ItemIndex;
      FFTPProxyHost := Lfrm.edtProxyServerName.Text;
      FFTPProxyUsername := Lfrm.edtProxyServerUserName.Text;
      FFTPProxyPassword := Lfrm.edtProxyServerPassword.Text;
      FFTPProxyPort := Lfrm.spededtProxyPort.Value;
    end;
  finally
    FreeAndNil(Lfrm);
  end;
end;

procedure TfrmSettings.btnNATSettingsClick(Sender: TObject);
var
  Lfrm: TfrmNATSettings;
begin
  Lfrm := TfrmNATSettings.Create(Application);
  try
    Lfrm.Caption := DlgCaptionToFormCaption(btnNATSettings.Caption);
    Lfrm.edtExternalIPAddress.Text := FNATIPAddress;
    Lfrm.spnedtPortMinimum.Value := FNATPortMin;
    Lfrm.spnedtPortMaximum.Value := FNATPortMax;
    if Lfrm.ShowModal = mrOk then
    begin
      FNATIPAddress := Lfrm.edtExternalIPAddress.Text;
      FNATPortMin := Lfrm.spnedtPortMinimum.Value;
      FNATPortMax := Lfrm.spnedtPortMaximum.Value;
    end;
  finally
    FreeAndNil(Lfrm);
  end;
end;

procedure TfrmSettings.btnTransparentProxyClick(Sender: TObject);
var
  Lfrm: TfrmProxySettings;
begin
  Lfrm := TfrmProxySettings.Create(Application);
  try
    Lfrm.Caption := DlgCaptionToFormCaption(btnTransparentProxy.Caption);
    Lfrm.cboProxyType.ItemIndex := FProxyType;
    Lfrm.edtProxyServerName.Text := FProxyHost;
    Lfrm.edtProxyServerUserName.Text := FProxyUsername;
    Lfrm.edtProxyServerPassword.Text := FProxyPassword;
    Lfrm.spededtProxyPort.Value := FProxyPort;
    if Lfrm.ShowModal = mrOk then
    begin
      FProxyType := Lfrm.cboProxyType.ItemIndex;
      FProxyHost := Lfrm.edtProxyServerName.Text;
      FProxyUsername := Lfrm.edtProxyServerUserName.Text;
      FProxyPassword := Lfrm.edtProxyServerPassword.Text;
      FProxyPort := Lfrm.spededtProxyPort.Value;
    end;
  finally
    FreeAndNil(Lfrm);
  end;
end;

procedure TfrmSettings.cboDebugBackgroundSelect(Sender: TObject);
begin
  FDebugBackground := cboDebugBackground.Selected;
  DisplaySampleTexts;
end;

procedure TfrmSettings.cboDebugForegroundSelect(Sender: TObject);
begin
  FDebugForeground := cboDebugForeground.Selected;
  DisplaySampleTexts;
end;

procedure TfrmSettings.cboDisplayModeChange(Sender: TObject);
begin
  case cboDisplayMode.ItemIndex of
    0:
      SetAppropriateThemeMode(THEME_DARK, THEME_LIGHT);
    1:
      SetSpecificThemeMode(False, THEME_DARK, THEME_LIGHT);
  else
    SetSpecificThemeMode(True, THEME_DARK, THEME_LIGHT);
  end;
end;

procedure TfrmSettings.DisplaySampleTexts;
begin
  redtTextSamples.Lines.Clear;
  redtTextSamples.Font.Color := Self.FRegularForeground;
  redtTextSamples.Color := Self.FRegularBackground;
  redtTextSamples.Lines.Add('Regular Text');
  cboRegularForeground.Selected := FRegularForeground;
  cboRegularBackground.Selected := FRegularBackground;
  redtTextSamples.SelAttributes.Color := FErrorForeground;
  cboErrorForeground.Selected := FErrorForeground;
  redtTextSamples.SelAttributes.BackColor := FErrorBackground;
  cboErrorBackground.Selected := FErrorBackground;
  redtTextSamples.Lines.Add('Error Text');
  redtTextSamples.SelAttributes.Color := FSSLMessageForeground;
  cboTLSMessageForeground.Selected := FSSLMessageForeground;
  redtTextSamples.SelAttributes.BackColor := FSSLMessageBackground;
  cboTLSMessageBackground.Selected := FSSLMessageBackground;
  redtTextSamples.Lines.Add('SSL Information');
  redtTextSamples.SelAttributes.Color := FDirOutputForeground;
  cboDirOutputForeground.Selected := FDirOutputForeground;
  redtTextSamples.SelAttributes.BackColor := FDirOutputBackground;
  cboDirOutputBackground.Selected := FDirOutputBackground;
  redtTextSamples.Lines.Add('Directory List Output');
  redtTextSamples.SelAttributes.Color := FDebugForeground;
  redtTextSamples.SelAttributes.BackColor := FDebugBackground;
  cboDebugForeground.Selected := FDebugForeground;
  cboDebugBackground.Selected := FDebugBackground;
  redtTextSamples.Lines.Add('Debug Output');
  ScrollToTop(redtTextSamples);
end;

procedure TfrmSettings.EnableDisableCheckBoxes;
begin
  if chklbAdvancedOptions.Checked[1] = False then
  begin
    chklbAdvancedOptions.ItemEnabled[2] := False;
  end
  else
  begin
    chklbAdvancedOptions.ItemEnabled[2] := True;
  end;
end;

procedure TfrmSettings.FormCreate(Sender: TObject);
begin
  chklbAdvancedOptions.ItemEnabled[2] := False;
  DisplaySampleTexts;
end;

procedure TfrmSettings.FormShow(Sender: TObject);
begin
  EnableDisableCheckBoxes;
end;

function TfrmSettings.GetConnected: Boolean;
begin
  Result := not cboTransferTypes.Enabled;
end;

function TfrmSettings.GetDebugBackground: TColor;
begin
  Result := cboDebugBackground.Selected;
end;

function TfrmSettings.GetDebugForeground: TColor;
begin
  Result := cboDebugForeground.Selected;
end;

function TfrmSettings.GetDirOutputBackground: TColor;
begin
  Result := cboDirOutputBackground.Selected;
end;

function TfrmSettings.GetDirOutputForeground: TColor;
begin
  Result := cboDirOutputForeground.Selected;
end;

function TfrmSettings.GetErrorBackground: TColor;
begin
  Result := cboErrorBackground.Selected;
end;

function TfrmSettings.GetErrorForeground: TColor;
begin
  Result := cboErrorForeground.Selected;
end;

function TfrmSettings.GetRegularBackground: TColor;
begin
  Result := cboRegularBackground.Selected;
end;

function TfrmSettings.GetRegularForeground: TColor;
begin
  Result := cboRegularForeground.Color;
end;

function TfrmSettings.GetSSLMessageBackground: TColor;
begin
  Result := cboTLSMessageBackground.Selected;
end;

function TfrmSettings.GetSSLMessageForeground: TColor;
begin
  Result := cboTLSMessageForeground.Selected;
end;

function TfrmSettings.GetUsePortTransferType: Boolean;
begin
  Result := cboTransferTypes.ItemIndex = 1;
end;

procedure TfrmSettings.HandleThemes;
begin

end;

procedure TfrmSettings.SetConnected(const Value: Boolean);
begin
  cboTransferTypes.Enabled := not Value;
  lblTransferType.Enabled := not Value;
  chklbAdvancedOptions.Enabled := not Value;
  lblAdvancedOptions.Enabled := not Value;
  btnNATSettings.Enabled := not Value;
  btnTransparentProxy.Enabled := not Value;
  btnFTPProxySettings.Enabled := not Value;
end;

procedure TfrmSettings.SetDebugBackground(const Value: TColor);
begin
  FDebugBackground := Value;
  DisplaySampleTexts;
end;

procedure TfrmSettings.SetDebugForeground(const Value: TColor);
begin
  FDebugForeground := Value;
  DisplaySampleTexts;
end;

procedure TfrmSettings.SetDirOutputBackground(const Value: TColor);
begin
  FDirOutputBackground := Value;
  DisplaySampleTexts;
end;

procedure TfrmSettings.SetDirOutputForeground(const Value: TColor);
begin
  FDirOutputForeground := Value;
  DisplaySampleTexts;
end;

procedure TfrmSettings.SetErrorBackground(const Value: TColor);
begin
  FErrorBackground := Value;
  DisplaySampleTexts;
end;

procedure TfrmSettings.SetErrorForeground(const Value: TColor);
begin
  FErrorForeground := Value;
  DisplaySampleTexts;
end;

procedure TfrmSettings.SetRegularBackground(const Value: TColor);
begin
  FRegularBackground := Value;
  DisplaySampleTexts;
end;

procedure TfrmSettings.SetRegularForeground(const Value: TColor);
begin
  FRegularForeground := Value;
  DisplaySampleTexts;
end;

procedure TfrmSettings.SetSSLMessageBackground(const Value: TColor);
begin
  FSSLMessageBackground := Value;
  DisplaySampleTexts;
end;

procedure TfrmSettings.SetSSLMessageForeground(const Value: TColor);
begin
  FSSLMessageForeground := Value;
  DisplaySampleTexts;
end;

procedure TfrmSettings.SetUsePortTransferType(const Value: Boolean);
begin
  if Value then
  begin
    cboTransferTypes.ItemIndex := 1;
  end
  else
  begin
    cboTransferTypes.ItemIndex := 0;
  end;
end;

procedure TfrmSettings.WMSettingChange(var Message: TWMSettingChange);
begin
  if cboDisplayMode.ItemIndex = 0 then
  begin
    SetAppropriateThemeMode(THEME_DARK, THEME_LIGHT);
  end;
end;

end.

unit TaurusTLS_Dsn_AboutDlg;

{$I TaurusTLSCompilerDefines.inc}

interface

procedure AboutDlg(const AVersion: String);

implementation

uses
  IdGlobal,
  Classes, SysUtils,
  TaurusTLS_Dsn_ResourceStrings,
  {$IFDEF FPC}
  Controls, Forms, Graphics,
  StdCtrls;
  {$ELSE}
  Vcl.Controls, Vcl.Forms, Vcl.Graphics,
  Vcl.StdCtrls;
  {$ENDIF}

type
  TfrmAbout = class(TForm)
  public
    procedure btnThirdPartyAcknowlegementClick(Sender: TObject);
  end;

  TfrmAcknowlegements = class(TForm)

  end;

procedure AboutDlg(const AVersion: String);
var
  frmAbout: TfrmAbout;
  lblProductName: TLabel;
  lblVersion: TLabel;
  lblCopyright: TLabel;
  lblAllRightsReserved: TLabel;
  btnOk: TButton;
  mmoLicense: TMemo;
  btnThirdPartyAcknowlegement: TButton;
  LLabelWidth: Integer;

begin
  frmAbout := TfrmAbout.CreateNew(Application);
  try
    lblProductName := TLabel.Create(frmAbout);
    lblVersion := TLabel.Create(frmAbout);
    lblCopyright := TLabel.Create(frmAbout);
    lblAllRightsReserved := TLabel.Create(frmAbout);
    btnOk := TButton.Create(frmAbout);
    mmoLicense := TMemo.Create(frmAbout);
    btnThirdPartyAcknowlegement := TButton.Create(frmAbout);

    frmAbout.Name := 'frmAbout';
    frmAbout.Left := 0;
    frmAbout.Top := 0;
    frmAbout.Anchors := [akLeft, akRight, akBottom];
    frmAbout.BorderStyle := bsDialog;
    frmAbout.Caption := 'About TaurusTLS';
    frmAbout.ClientHeight := 335;
    frmAbout.ClientWidth := 427;
    frmAbout.Color := clBtnFace;
    frmAbout.Position := poDesktopCenter;
    LLabelWidth := frmAbout.ClientWidth - 16;
    lblProductName.Name := 'lblProductName';
    lblProductName.Parent := frmAbout;
    lblProductName.Left := 8;
    lblProductName.Top := 16;
    lblProductName.Width := LLabelWidth;
    lblProductName.Height := 41;
    lblProductName.Alignment := taCenter;
    lblProductName.Anchors := [akLeft, akTop, akRight];
    lblProductName.AutoSize := False;
    lblProductName.Caption := 'TaurusTLS';
    lblProductName.ParentFont := False;
    lblProductName.Layout := tlCenter;
    lblProductName.Font.Height := -36;
    lblProductName.Font.Name := 'Arial Black';
    lblVersion.Name := 'lblVersion';
    lblVersion.Parent := frmAbout;
    lblVersion.Left := 8;
    lblVersion.Top := 63;
    lblVersion.Width := LLabelWidth;
    lblVersion.Height := 25;
    lblVersion.Alignment := taCenter;
    lblVersion.Anchors := [akLeft, akTop, akRight];
    lblVersion.AutoSize := False;
    lblVersion.Caption := IndyFormat('Version %s', [AVersion]);
    lblVersion.ParentFont := False;
    lblVersion.Layout := tlCenter;
    lblVersion.Font.Height := -15;
    lblVersion.Font.Name := 'Arial';
    lblCopyright.Name := 'lblCopyright';
    lblCopyright.Parent := frmAbout;
    lblCopyright.Left := 8;
    lblCopyright.Top := 86;
    lblCopyright.Width := LLabelWidth;
    lblCopyright.Height := 35;
    lblCopyright.Alignment := taCenter;
    lblCopyright.Anchors := [akLeft, akTop, akRight, akBottom];
    lblCopyright.AutoSize := False;
    lblCopyright.Caption := RSCopyright;
    lblCopyright.ParentFont := False;
    lblCopyright.Layout := tlCenter;
    btnOk.Name := 'btnOk';
    btnOk.Parent := frmAbout;
    btnOk.Left := 347;
    btnOk.Top := frmAbout.ClientHeight - 35;
    btnOk.Width := 75;
    btnOk.Height := 25;
    btnOk.Anchors := [akRight, akBottom];
    btnOk.Caption := RSOk;
    btnOk.Default := True;
    btnOk.ModalResult := 1;
    btnOk.TabOrder := 2;
    mmoLicense.Name := 'mmoLicense';
    mmoLicense.Parent := frmAbout;
    mmoLicense.Left := 8;
    mmoLicense.Top := 156;
    mmoLicense.ReadOnly := True;
    mmoLicense.Width := LLabelWidth;
    mmoLicense.Height := 109;
    mmoLicense.TabStop := False;
    mmoLicense.Anchors := [akLeft, akTop, akRight, akBottom];
    mmoLicense.Lines.Clear;
    mmoLicense.Lines.Add(RSLicense);
    mmoLicense.TabOrder := 0;
    btnThirdPartyAcknowlegement.Name := 'btnThirdPartyAcknowlegement';
    btnThirdPartyAcknowlegement.Parent := frmAbout;
    btnThirdPartyAcknowlegement.Left := 8;
    btnThirdPartyAcknowlegement.Top := 271;
    btnThirdPartyAcknowlegement.Width := LLabelWidth;
    btnThirdPartyAcknowlegement.Height := 25;
    btnThirdPartyAcknowlegement.Anchors := [akLeft, akRight, akBottom];
    btnThirdPartyAcknowlegement.Caption := RSThirdPartyAcknowlegements;
    btnThirdPartyAcknowlegement.TabOrder := 1;
    btnThirdPartyAcknowlegement.OnClick :=
      frmAbout.btnThirdPartyAcknowlegementClick;
    frmAbout.ShowModal;
  finally
    FreeAndNil(frmAbout);
  end;
end;

{ TfrmAbout }

procedure TfrmAbout.btnThirdPartyAcknowlegementClick(Sender: TObject);
var
  frmAcknowlegements: TfrmAcknowlegements;
  mmoIndyLicense: TMemo;
  btnOk: TButton;

begin
  frmAcknowlegements := TfrmAcknowlegements.CreateNew(Self);
  try
    mmoIndyLicense := TMemo.Create(frmAcknowlegements);
    btnOk := TButton.Create(frmAcknowlegements);

    frmAcknowlegements.Name := 'frmAcknowlegements';
    frmAcknowlegements.Left := 0;
    frmAcknowlegements.Top := 0;
    frmAcknowlegements.Caption := RSThirdPartyAcknowlegements;
    frmAcknowlegements.ClientHeight := 335;
    frmAcknowlegements.ClientWidth := 427;
    frmAcknowlegements.Color := clBtnFace;
    frmAcknowlegements.Position := poDesktopCenter;
    mmoIndyLicense.Name := 'mmoIndyLicense';
    mmoIndyLicense.Parent := frmAcknowlegements;
    mmoIndyLicense.Left := 8;
    mmoIndyLicense.Top := 8;
    mmoIndyLicense.Width := frmAcknowlegements.ClientWidth - 16;
    mmoIndyLicense.Height := 281;
    mmoIndyLicense.TabStop := False;
    mmoIndyLicense.Anchors := [akLeft, akRight];
    mmoIndyLicense.ReadOnly := True;
    mmoIndyLicense.Lines.Clear;
    mmoIndyLicense.Lines.Add(RSIndyPortionsOf);
    mmoIndyLicense.Lines.Add(RSIndyPortionsOfTwo);
    mmoIndyLicense.Lines.Add('');
    mmoIndyLicense.Lines.Add(RSIndyRedistributionOf);
    mmoIndyLicense.Lines.Add('');
    mmoIndyLicense.Lines.Add(RSDisclaimerCondOne);
    mmoIndyLicense.Lines.Add('');
    mmoIndyLicense.Lines.Add(RSDisclaimerCondTwo);
    mmoIndyLicense.Lines.Add('');
    mmoIndyLicense.Lines.Add(RSIndyDisclaimer);
    mmoIndyLicense.TabOrder := 0;
    btnOk.Name := 'btnOk';
    btnOk.Parent := frmAcknowlegements;
    btnOk.Left := 347;
    btnOk.Top := 302;
    btnOk.Width := 75;
    btnOk.Height := 25;
    btnOk.Anchors := [akRight, akBottom];
    btnOk.Caption := RSOk;
    btnOk.Default := True;
    btnOk.ModalResult := 1;
    btnOk.TabOrder := 1;
    frmAcknowlegements.ShowModal;
  finally
    FreeAndNil(frmAcknowlegements);
  end;
end;

end.

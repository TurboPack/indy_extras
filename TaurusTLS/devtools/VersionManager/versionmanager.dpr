program versionmanager;

uses
  Vcl.Forms,
  mainform in 'mainform.pas' {frmMainForm},
  dmod_main in 'dmod_main.pas' {dmodMain: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMainForm, frmMainForm);
  Application.CreateForm(TdmodMain, dmodMain);
  Application.Run;
end.

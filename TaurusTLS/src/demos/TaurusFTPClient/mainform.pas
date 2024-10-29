unit mainform;

interface

{$I ..\..\TaurusTLSCompilerDefines.inc}

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.BaseImageCollection,
  Vcl.ImageCollection, frmProgress, System.ImageList, Vcl.ImgList,
  Vcl.VirtualImageList,
  System.Actions, Vcl.ActnList, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ToolWin, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdFTP, IdCTypes,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL,
  IdIntercept, IdLogBase, IdLogEvent, Vcl.Menus, Vcl.StdActns,
  IdZLibCompressorBase, IdCompressorZLib, IdConnectThroughHttpProxy,
  IdCustomTransparentProxy, IdSocks, IdThreadSafe,
  TaurusTLSHeaders_ossl_typ, TaurusTLS_X509, TaurusTLS;

type
  TfrmMainForm = class(TForm)
    vimglstMainProgram: TVirtualImageList;
    imgcolMainProgram: TImageCollection;
    actlstMainProgram: TActionList;
    actFileDownload: TAction;
    actFileUpload: TAction;
    sbrMainForm: TStatusBar;
    pnlLog: TPanel;
    tbrMainProgram: TToolBar;
    spltrLog: TSplitter;
    pnlMainWindow: TPanel;
    pnlLocalBrowser: TPanel;
    pnlRemoteBrowser: TPanel;
    actFileConnect: TAction;
    ToolButton1: TToolButton;
    IdFTPClient: TIdFTP;
    ToolButton2: TToolButton;
    actFileDisconnect: TAction;
    FIdLog: TIdLogEvent;
    ToolButton3: TToolButton;
    ppmnuLog: TPopupMenu;
    EditCopy1: TEditCopy;
    EditSelectAll1: TEditSelectAll;
    Copy1: TMenuItem;
    N1: TMenuItem;
    SelectAll1: TMenuItem;
    vimglstSmall: TVirtualImageList;
    IdCompressorZLib1: TIdCompressorZLib;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Connect1: TMenuItem;
    Disonnct1: TMenuItem;
    Edit1: TMenuItem;
    Copy2: TMenuItem;
    N2: TMenuItem;
    SelectAll2: TMenuItem;
    View1: TMenuItem;
    Help1: TMenuItem;
    actViewSetting: TAction;
    Settings1: TMenuItem;
    FileExit1: TFileExit;
    actFileFTPSites: TAction;
    N3: TMenuItem;
    FTPSites1: TMenuItem;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    N4: TMenuItem;
    Exit1: TMenuItem;
    actHelpAbout: TAction;
    About1: TMenuItem;
    lvLocalFiles: TListView;
    lvRemoteFiles: TListView;
    cboLocalCurrentDir: TComboBox;
    cboRemoteCurrentDir: TComboBox;
    lblLocalCurrentDir: TLabel;
    lblRemotDir: TLabel;
    N5: TMenuItem;
    Dowload1: TMenuItem;
    Upload1: TMenuItem;
    redtLog: TRichEdit;
    Splitter1: TSplitter;
    actFileRemoteDelete: TAction;
    actFileLocalDelete: TAction;
    ppmnuRemote: TPopupMenu;
    ppmnuLocal: TPopupMenu;
    Upload2: TMenuItem;
    N6: TMenuItem;
    actFileLocalDelete1: TMenuItem;
    Dowload2: TMenuItem;
    N7: TMenuItem;
    Delete1: TMenuItem;
    actFileRemoteRename: TAction;
    actFileLocalRename: TAction;
    Rename1: TMenuItem;
    Rename2: TMenuItem;
    actFileRemoteMakeDirectory: TAction;
    actFileLocalMakeDirectory: TAction;
    N8: TMenuItem;
    MakeDirectory1: TMenuItem;
    N9: TMenuItem;
    actFileLocalMakeDirectory1: TMenuItem;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    SocksInfo: TIdSocksInfo;
    HTTPConnectThrough: TIdConnectThroughHttpProxy;
    iosslFTP: TTaurusTLSIOHandlerSocket;
    procedure FormCreate(Sender: TObject);
    procedure actFileConnectExecute(Sender: TObject);
    procedure actFileConnectUpdate(Sender: TObject);
    procedure actFileDisconnectExecute(Sender: TObject);
    procedure actFileDisconnectUpdate(Sender: TObject);
    procedure actHelpAboutExecute(Sender: TObject);
    procedure actViewSettingExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lvRemoteFilesColumnClick(Sender: TObject; Column: TListColumn);
    procedure lvRemoteFilesCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure lvRemoteFilesDblClick(Sender: TObject);
    procedure lvLocalFilesCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure lvLocalFilesColumnClick(Sender: TObject; Column: TListColumn);
    procedure lvLocalFilesDblClick(Sender: TObject);
    procedure actFileFTPSitesExecute(Sender: TObject);
    procedure actFileFTPSitesUpdate(Sender: TObject);
    procedure cboRemoteCurrentDirKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actFileUploadExecute(Sender: TObject);
    procedure actFileDownloadExecute(Sender: TObject);
    procedure actFileUploadUpdate(Sender: TObject);
    procedure actFileDownloadUpdate(Sender: TObject);
    procedure cboLocalCurrentDirKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actFileRemoteDeleteUpdate(Sender: TObject);
    procedure actFileRemoteDeleteExecute(Sender: TObject);
    procedure actFileLocalDeleteExecute(Sender: TObject);
    procedure actFileLocalDeleteUpdate(Sender: TObject);
    procedure actFileLocalRenameExecute(Sender: TObject);
    procedure actFileLocalRenameUpdate(Sender: TObject);
    procedure actFileRemoteRenameExecute(Sender: TObject);
    procedure actFileRemoteRenameUpdate(Sender: TObject);
    procedure actFileRemoteMakeDirectoryExecute(Sender: TObject);
    procedure actFileRemoteMakeDirectoryUpdate(Sender: TObject);
    procedure actFileLocalMakeDirectoryExecute(Sender: TObject);
    procedure actFileLocalMakeDirectoryUpdate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
{$IFDEF USE_STRICT_PRIVATE_PROTECTED}strict{$ENDIF} private
    { Private declarations }
    FLocalColumnToSort: Integer;
    FLocalAscending: Boolean;

    FRemoteColumnToSort: Integer;
    FRemoteAscending: Boolean;

    FThreadRunning: TIdThreadSafeBoolean;

    // colors
    FErrorForeground: TColor;
    FErrorBackground: TColor;
    FSSLMessageForeground: TColor;
    FSSLMessageBackground: TColor;
    FDirOutputForeground: TColor;
    FDirOutputBackground: TColor;
    FDebugForeground: TColor;
    FDebugBackground: TColor;
    FLogDebugOutput: Boolean;
    FLogDirOutput: Boolean;

    FProgressIndicator: TfrmFileProgress;
    function GetThreadRunning: Boolean;
    procedure SetThreadRunning(const Value: Boolean);
{$IFDEF USE_STRICT_PRIVATE_PROTECTED}strict{$ENDIF} protected

    procedure InitLog;
    // Thread procedure starts
    procedure ConnectFTP;
    procedure ChangeLocalDir(const ADir: String);
    procedure ChangeRemoteDir(const ADir: String);
    //

    procedure RemoteLvClearArrows;
    procedure LocalClearArrows;
    procedure DownloadFile(const AFile: String);
    procedure UploadFile(const AFile: String);
    procedure LocalDeleteFile(const AFile: String);
    procedure RemoteDeleteFile(const AFile: String);
    procedure LocalRemoveDir(const ADir: String);
    procedure RemoteRemoveDir(const ADir: String);
    procedure LocalRename(const AOldPathName, ANewPathName: String);
    procedure RemoteRename(const AOldPathName, ANewPathName: String);
    procedure LocalMakeDir(const ADir: String);
    procedure RemoteMakeDir(const ADir: String);
    procedure SetProxyType(const AType: Integer);
  public
    { Public declarations }
    // accessed by worker threads
    procedure PopulateLocalFiles;
    procedure PopulateRemoteFiles(const ACurDir: String);
    procedure SetupPRogressIndicator(const AFileName: String;
      const AWorkMode: TWorkMode; const AWorkCount, AWorkMax: Int64);
    procedure UpdateProgressIndicator(const AFileName: String;
      const AWorkMode: TWorkMode; const AWorkCount, AWorkMax: Int64);
    procedure CloseProgressIndicator;
    //
    property LogDirOutput: Boolean read FLogDirOutput write FLogDirOutput;
    property LogDebugOutput: Boolean read FLogDebugOutput write FLogDebugOutput;
    property ThreadRunning: Boolean read GetThreadRunning
      write SetThreadRunning;
    property ErrorForeground: TColor read FErrorForeground
      write FErrorForeground;
    property ErrorBackground: TColor read FErrorBackground
      write FErrorBackground;
    property DirOutputForeground: TColor read FDirOutputForeground
      write FDirOutputForeground;
    property DirOutputBackground: TColor read FDirOutputBackground
      write FDirOutputBackground;
    property DebugForeground: TColor read FDebugForeground
      write FDebugForeground;
    property DebugBackground: TColor read FDebugBackground
      write FDebugBackground;
    property SSLMessageForeground: TColor read FSSLMessageForeground
      write FSSLMessageForeground;
    property SSLMessageBackground: TColor read FSSLMessageBackground
      write FSSLMessageBackground;
    property ProgressIndicator: TfrmFileProgress read FProgressIndicator
      write FProgressIndicator;
  end;

  TFTPThread = class(TThread)
{$IFDEF USE_STRICT_PRIVATE_PROTECTED}strict{$ENDIF} protected
    FVerifyResult: Boolean;
    FKeyPassword: String;
    FError: Integer;
    FDepth: Integer;
    FX509: TTaurusTLSX509;
    FFTP: TIdFTP;
    FLog: TIdLogEvent;
    FIO: TTaurusTLSIOHandlerSocket;
    // logging
    procedure LogRegularOutput(const AStr: String);
    procedure LogCipherEvent(const AStr: String);
    procedure LogFTPError(const AStr: String);
    procedure LogSSLEvent(const AStr: String);
    procedure LogDirListing(AListing: TStrings);
    procedure OnLogSent(ASender: TComponent; const AText, AData: string);
    procedure OnLogReceived(ASender: TComponent; const AText, AData: string);
    procedure OnStatusInfo(ASender: TObject; const AsslSocket: PSSL;
      const AWhere, Aret: TIdC_INT; const AType, AMsg: string);
    procedure OnSSLNegotiated(ASender: TTaurusTLSIOHandlerSocket);
    //
    // Dumy method to ensure all queued items are comopleted
    procedure DummySync;
    //
    procedure PromptVerifyCert;
    procedure PromptPassword;
    procedure OnGetPassword(ASender: TObject; var VPassword: String;
      const AIsWrite: Boolean);
    function OnVerifyPeer(Certificate: TTaurusTLSX509; const AOk: Boolean;
      const ADepth, AError: Integer): Boolean;
  public
    constructor Create(AFTP: TIdFTP);
    destructor Destroy; override;
  end;

  TConnectThread = class(TFTPThread)
  public
    procedure Execute(); override;
  end;

  TRemoteChangeDirThread = class(TFTPThread)
{$IFDEF USE_STRICT_PRIVATE_PROTECTED}strict{$ENDIF} protected
    FNewDir: String;
  public
    constructor Create(AFTP: TIdFTP; const ANewDir: String); reintroduce;
    procedure Execute(); override;
  end;

  TFileThread = class(TFTPThread)
{$IFDEF USE_STRICT_PRIVATE_PROTECTED}strict{$ENDIF} protected
    FFile: String;
    FSize: Int64;
  public
    constructor Create(AFTP: TIdFTP; const AFile: String); reintroduce;
  end;

  TFileOnWorkThread = class(TFileThread)
{$IFDEF USE_STRICT_PRIVATE_PROTECTED}strict{$ENDIF} protected
    procedure OnWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
    procedure OnWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure OnWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
  public
    constructor Create(AFTP: TIdFTP; const AFile: String);
  end;

  TDownloadFileThread = class(TFileOnWorkThread)
  public
    procedure Execute(); override;
  end;

  TUploadFileThread = class(TFileOnWorkThread)
  public
    procedure Execute(); override;
  end;

  TDeleteFileThread = class(TFileThread)
  public
    procedure Execute(); override;
  end;

  TRemoveDirThread = class(TFileThread)
  public
    procedure Execute(); override;
  end;

  TRenamePathThread = class(TFileThread)
{$IFDEF USE_STRICT_PRIVATE_PROTECTED}strict{$ENDIF} protected
    FNewName: String;
  public
    constructor Create(AFTP: TIdFTP; const AOldName, ANewName: String);
      reintroduce;
    procedure Execute(); override;
  end;

  TMakeDirThread = class(TFileThread)
  public
    procedure Execute(); override;
  end;

var
  frmMainForm: TfrmMainForm;

implementation

uses dkgFTPConnect, settingsdlg, frmAbout, frmBookmarks, CertViewer,
  IdException,
  IdAllFTPListParsers,
  IdFTPCommon,
  IdFTPList, IdGlobal, IdGlobalProtocols, IdReplyRFC, TaurusTLSLoader,
  System.IOUtils, System.IniFiles, System.UITypes,
  Winapi.CommCtrl, ProgUtils, AcceptableCerts;

const
  DIR_IMAGE_IDX = 6;
  FILE_IMAGE_IDX = 7;
  ARROW_UP_IMAGE_IDX = 8;
  ARROW_DOWN_IMAGE_IDX = 9;

{$R *.dfm}

procedure TfrmMainForm.actFileDisconnectExecute(Sender: TObject);
begin
  IdFTPClient.Disconnect;
  lvRemoteFiles.Items.Clear;
  lvRemoteFiles.Enabled := False;
end;

procedure TfrmMainForm.actFileDisconnectUpdate(Sender: TObject);
begin
  actFileDisconnect.Enabled := (not ThreadRunning) and IdFTPClient.Connected;
end;

procedure TfrmMainForm.actFileDownloadExecute(Sender: TObject);
var
  Li: TListItem;
begin
  if lvRemoteFiles.ItemIndex > -1 then
  begin
    Li := lvRemoteFiles.Items[lvRemoteFiles.ItemIndex];
    DownloadFile(Li.Caption);
  end;
end;

procedure TfrmMainForm.actFileDownloadUpdate(Sender: TObject);
var
  Li: TListItem;
begin

  actFileDownload.Enabled := (not ThreadRunning) and IdFTPClient.Connected and
    (lvRemoteFiles.ItemIndex > -1);
  if actFileDownload.Enabled then
  begin
    Li := lvRemoteFiles.Items[lvRemoteFiles.ItemIndex];
    actFileDownload.Enabled := Li.ImageIndex = FILE_IMAGE_IDX;
  end;
end;

procedure TfrmMainForm.actFileFTPSitesExecute(Sender: TObject);
var
  LFrm: TfrmFTPSites;
  LFTPSite: TFTPSite;
begin
  LFrm := TfrmFTPSites.Create(nil);
  try
    if LFrm.ShowModal = mrOk then
    begin
      if LFrm.lbxFTPSites.ItemIndex > -1 then
      begin
        LFTPSite := LFrm.FTPSites[LFrm.lbxFTPSites.ItemIndex];
        IdFTPClient.Host := LFTPSite.HostName;
        IdFTPClient.Username := LFTPSite.Username;
        IdFTPClient.Password := LFTPSite.Password;
        IdFTPClient.Account := LFTPSite.Account;
        IdFTPClient.Port := LFTPSite.Port;
        case LFTPSite.FTPPRotocol of
          0:
            IdFTPClient.UseTLS := utNoTLSSupport;
          1:
            IdFTPClient.UseTLS := utUseExplicitTLS;
          2:
            IdFTPClient.UseTLS := utUseRequireTLS;
          3:
            IdFTPClient.UseTLS := utUseImplicitTLS;
        end;
        case LFTPSite.TransferMode of
          0:
            IdFTPClient.Passive := not ReadTransferDefault;
          1:
            IdFTPClient.Passive := True;
          2:
            IdFTPClient.Passive := False;
        end;
        Self.iosslFTP.SSLOptions.CertFile := LFTPSite.PublicKey;
        Self.iosslFTP.SSLOptions.KeyFile := LFTPSite.PrivateKey;
        Self.iosslFTP.SSLOptions.RootCertFile := LFTPSite.CAKey;
        ConnectFTP;
      end;
    end;
  finally
    FreeAndNil(LFrm);
  end;
end;

procedure TfrmMainForm.actFileFTPSitesUpdate(Sender: TObject);
begin
  actFileFTPSites.Enabled := (not ThreadRunning) and
    (not IdFTPClient.Connected);
end;

procedure TfrmMainForm.actFileLocalDeleteExecute(Sender: TObject);
var
  Li: TListItem;
begin
  if lvLocalFiles.ItemIndex > -1 then
  begin
    Li := lvLocalFiles.Items[lvLocalFiles.ItemIndex];
    case Li.ImageIndex of
      FILE_IMAGE_IDX:
        LocalDeleteFile(Li.Caption);
      DIR_IMAGE_IDX:
        LocalRemoveDir(Li.Caption);
    end;
  end;
end;

procedure TfrmMainForm.actFileLocalDeleteUpdate(Sender: TObject);
var
  Li: TListItem;
  LRes: Boolean;
begin
  LRes := (not ThreadRunning) and (lvLocalFiles.ItemIndex > -1);
  if LRes then
  begin
    Li := lvLocalFiles.Items[lvLocalFiles.ItemIndex];
    LRes := Li.ImageIndex in [FILE_IMAGE_IDX, DIR_IMAGE_IDX];
  end;
  actFileLocalDelete.Enabled := LRes;
end;

procedure TfrmMainForm.actFileLocalMakeDirectoryExecute(Sender: TObject);
var
  LNewDir: String;
begin
  if InputQuery('Make Directory', 'New Directory Name: ', LNewDir) then
  begin
    if LNewDir <> '' then
    begin
      LocalMakeDir(LNewDir);
    end;
  end;
end;

procedure TfrmMainForm.actFileLocalMakeDirectoryUpdate(Sender: TObject);
begin
  actFileLocalMakeDirectory.Enabled := (not ThreadRunning);
end;

procedure TfrmMainForm.actFileLocalRenameExecute(Sender: TObject);
var
  Li: TListItem;
{$IFNDEF USE_INLINE_VAR}
  LNewName: String;
{$ENDIF}
begin
  if lvLocalFiles.ItemIndex > -1 then
  begin
    Li := lvLocalFiles.Items[lvLocalFiles.ItemIndex];
    if Li.ImageIndex in [FILE_IMAGE_IDX, DIR_IMAGE_IDX] then
    begin
{$IFDEF USE_INLINE_VAR}
      var
        LNewName: String;
{$ENDIF}
      if InputQuery('Rename', 'Rename ' + Li.Caption + ' to:', LNewName) then
      begin
        if LNewName <> '' then
        begin
          LocalRename(Li.Caption, LNewName);
        end;
      end;
    end;
  end;
end;

procedure TfrmMainForm.actFileLocalRenameUpdate(Sender: TObject);
var
  Li: TListItem;
  LRes: Boolean;
begin
  LRes := (not ThreadRunning) and (lvLocalFiles.ItemIndex > -1);
  if LRes then
  begin
    Li := lvLocalFiles.Items[lvLocalFiles.ItemIndex];
    LRes := Li.ImageIndex in [FILE_IMAGE_IDX, DIR_IMAGE_IDX];
  end;
  actFileLocalRename.Enabled := LRes;

end;

procedure TfrmMainForm.actFileRemoteDeleteExecute(Sender: TObject);
var
  Li: TListItem;
begin
  if lvRemoteFiles.ItemIndex > -1 then
  begin
    Li := lvRemoteFiles.Items[lvRemoteFiles.ItemIndex];
    case Li.ImageIndex of
      FILE_IMAGE_IDX:
        RemoteDeleteFile(Li.Caption);
      DIR_IMAGE_IDX:
        RemoteRemoveDir(Li.Caption);
    end;

  end;
end;

procedure TfrmMainForm.actFileRemoteDeleteUpdate(Sender: TObject);
var
  Li: TListItem;
  LRes: Boolean;
begin
  LRes := (not ThreadRunning) and IdFTPClient.Connected and
    (lvRemoteFiles.ItemIndex > -1);
  if LRes then
  begin
    Li := lvRemoteFiles.Items[lvRemoteFiles.ItemIndex];
    LRes := Li.ImageIndex in [FILE_IMAGE_IDX, DIR_IMAGE_IDX];
  end;
  actFileRemoteDelete.Enabled := LRes;
end;

procedure TfrmMainForm.actFileRemoteMakeDirectoryExecute(Sender: TObject);
var
  LNewDir: String;
begin
  if InputQuery('Make Directory', 'New Directory Name: ', LNewDir) then
  begin
    if LNewDir <> '' then
    begin
      RemoteMakeDir(LNewDir);
    end;
  end;
end;

procedure TfrmMainForm.actFileRemoteMakeDirectoryUpdate(Sender: TObject);
begin
  actFileRemoteMakeDirectory.Enabled := (not ThreadRunning) and
    IdFTPClient.Connected
end;

procedure TfrmMainForm.actFileRemoteRenameExecute(Sender: TObject);
var
  Li: TListItem;
{$IFNDEF USE_INLINE_VAR}
  LNewName: String;
{$ENDIF}
begin
  if lvRemoteFiles.ItemIndex > -1 then
  begin
    Li := lvRemoteFiles.Items[lvRemoteFiles.ItemIndex];
    if Li.ImageIndex in [FILE_IMAGE_IDX, DIR_IMAGE_IDX] then
    begin
{$IFDEF USE_INLINE_VAR}
      var
        LNewName: String;
{$ENDIF}
      if InputQuery('Rename', 'Rename ' + Li.Caption + ' to:', LNewName) then
      begin
        if LNewName <> '' then
        begin
          RemoteRename(Li.Caption, LNewName);
        end;
      end;
    end;
  end;
end;

procedure TfrmMainForm.actFileRemoteRenameUpdate(Sender: TObject);
var
  Li: TListItem;
  LRes: Boolean;
begin
  LRes := (not ThreadRunning) and IdFTPClient.Connected and
    (lvRemoteFiles.ItemIndex > -1);
  if LRes then
  begin
    Li := lvRemoteFiles.Items[lvRemoteFiles.ItemIndex];
    LRes := Li.ImageIndex in [FILE_IMAGE_IDX, DIR_IMAGE_IDX];
  end;
  actFileRemoteRename.Enabled := LRes;

end;

procedure TfrmMainForm.actFileUploadExecute(Sender: TObject);
var
  Li: TListItem;
begin
  if lvLocalFiles.ItemIndex > -1 then
  begin
    Li := lvLocalFiles.Items[lvLocalFiles.ItemIndex];
    UploadFile(Li.Caption);
  end;
end;

procedure TfrmMainForm.actFileUploadUpdate(Sender: TObject);
var
  Li: TListItem;
begin
  actFileUpload.Enabled := (not ThreadRunning) and IdFTPClient.Connected and
    (lvLocalFiles.ItemIndex > -1);
  if actFileUpload.Enabled then
  begin
    Li := lvLocalFiles.Items[lvLocalFiles.ItemIndex];
    actFileUpload.Enabled := Li.ImageIndex = FILE_IMAGE_IDX;
  end;
end;

procedure TfrmMainForm.actHelpAboutExecute(Sender: TObject);
var
  LFrm: TAboutBox;
begin
  LFrm := TAboutBox.Create(nil);
  try
    LFrm.ShowModal;
  finally
    FreeAndNil(LFrm);
  end;
end;

procedure TfrmMainForm.actViewSettingExecute(Sender: TObject);
var
  LFrm: TfrmSettings;
  LIni: TIniFile;
begin
  LFrm := TfrmSettings.Create(Application);
  try
    LIni := TIniFile.Create(GetIniFilePath);
    try
      LFrm.UsePortTransferType := LIni.ReadBool('Transfers',
        'Use_PORT_Transfers', False);
      LFrm.redtLog.Font.Name := redtLog.Font.Name;
      LFrm.redtTextSamples.Font.Name := LFrm.redtLog.Font.Name;
      LFrm.redtLog.Font.Size := redtLog.Font.Size;
      LFrm.redtTextSamples.Font.Size := LFrm.redtLog.Font.Size;
      LFrm.ErrorForeground := FErrorForeground;
      LFrm.ErrorBackground := FErrorBackground;
      LFrm.SSLMessageForeground := FSSLMessageForeground;
      LFrm.SSLMessageBackground := FSSLMessageBackground;
      LFrm.DirOutputForeground := FDirOutputForeground;
      LFrm.DirOutputBackground := FDirOutputBackground;
      LFrm.DebugForeground := FDebugForeground;
      LFrm.DebugBackground := FDebugBackground;
      LFrm.NATIPAddress := IdFTPClient.ExternalIP;
      LFrm.NATPortMin := IdFTPClient.DataPortMin;
      LFrm.NATPortMax := IdFTPClient.DataPortMax;
      LFrm.chklbAdvancedOptions.Checked[0] := IdFTPClient.UseHOST;
      LFrm.chklbAdvancedOptions.Checked[1] := IdFTPClient.UseExtensionDataPort;
      LFrm.chklbAdvancedOptions.Checked[2] := IdFTPClient.TryNATFastTrack;
      LFrm.chklbAdvancedOptions.Checked[3] := IdFTPClient.UseMLIS;
      if not Assigned(iosslFTP.TransparentProxy) then
      begin
        // 0 - none
        LFrm.ProxyType := 0;
      end
      else
      begin
        // 1 - HTTP Connect Proxy
        if iosslFTP.TransparentProxy = HTTPConnectThrough then
        begin
          LFrm.ProxyType := 1;
        end
        else
        begin

          case SocksInfo.Version of
            svNoSocks:
              begin
                LFrm.ProxyType := 0;
              end;
            // 2 - SOCKS4
            svSocks4:
              begin
                LFrm.ProxyType := 2;
              end;
            // 3 - SOCKS4A
            svSocks4A:
              begin
                LFrm.ProxyType := 3;
              end;
            // 4 - SOCKS5
            svSocks5:
              begin
                LFrm.ProxyType := 4;
              end;
          end;
        end;
      end;
      LFrm.ProxyHost := SocksInfo.Host;
      LFrm.ProxyUsername := SocksInfo.Username;
      LFrm.ProxyPassword := SocksInfo.Password;
      LFrm.ProxyPort := SocksInfo.Port;
      LFrm.FTPProxyType := Ord(IdFTPClient.ProxySettings.ProxyType);
      LFrm.FTPProxyHost := IdFTPClient.ProxySettings.Host;
      LFrm.FTPProxyPort := IdFTPClient.ProxySettings.Port;
      LFrm.FTPProxyUsername := IdFTPClient.ProxySettings.Username;
      LFrm.FTPProxyPassword := IdFTPClient.ProxySettings.Password;
      LFrm.Connected := IdFTPClient.Connected;
      LFrm.chkLogDebug.Checked := FLogDebugOutput;
      LFrm.chkDirOutput.Checked := FLogDirOutput;
      if LFrm.ShowModal = mrOk then
      begin
        FLogDebugOutput := LFrm.chkLogDebug.Checked;
        FLogDirOutput := LFrm.chkDirOutput.Checked;
        FErrorForeground := LFrm.ErrorForeground;
        FErrorBackground := LFrm.ErrorBackground;
        FSSLMessageForeground := LFrm.SSLMessageForeground;
        FSSLMessageBackground := LFrm.SSLMessageBackground;
        FDirOutputForeground := LFrm.DirOutputForeground;
        FDirOutputBackground := LFrm.DirOutputBackground;
        FDebugForeground := LFrm.DebugForeground;
        FDebugBackground := LFrm.DebugBackground;
        IdFTPClient.UseHOST := LFrm.chklbAdvancedOptions.Checked[0];
        IdFTPClient.ExternalIP := LFrm.NATIPAddress;
        IdFTPClient.DataPortMin := LFrm.NATPortMin;
        IdFTPClient.DataPortMax := LFrm.NATPortMax;
        // Do things in a round about way because NAT fasttracking requires extended DataPort commands.
        IdFTPClient.TryNATFastTrack := False;

        IdFTPClient.UseExtensionDataPort :=
          LFrm.chklbAdvancedOptions.Checked[1];
        if IdFTPClient.UseExtensionDataPort then
        begin
          IdFTPClient.TryNATFastTrack := LFrm.chklbAdvancedOptions.Checked[2];
        end;
        IdFTPClient.UseMLIS := LFrm.chklbAdvancedOptions.Checked[3];
        LIni.WriteBool('FTP', 'Use_HOST_Command', IdFTPClient.UseHOST);
        LIni.WriteString('NAT', 'NAT_IP_Address', IdFTPClient.ExternalIP);
        LIni.WriteInteger('NAT', 'Data_PORT_Minimum', IdFTPClient.DataPortMin);
        LIni.WriteInteger('NAT', 'Data_PORT_Maximum', IdFTPClient.DataPortMax);
        LIni.WriteBool('Transfers', 'Use_Extended_Data_Port_Commands',
          IdFTPClient.UseExtensionDataPort);
        LIni.WriteBool('Transfers', 'Try_Using_NAT_Fast_Track',
          IdFTPClient.TryNATFastTrack);
        LIni.WriteBool('FTP', 'Use_MLSD_Command_Instead_Of_DIR_Command',
          IdFTPClient.UseMLIS);

        LIni.WriteBool('Transfers', 'Use_PORT_Transfers',
          LFrm.UsePortTransferType);
        LIni.WriteBool('Transfers', 'Use_EPSV_EPRT_Data_Transfer',
          LFrm.chklbAdvancedOptions.Checked[1]);
        IdFTPClient.Passive := not LFrm.UsePortTransferType;
        LIni.WriteBool('Debug', 'Log_Debug_Output', FLogDebugOutput);
        LIni.WriteBool('Debug', 'Log_Directory_Output', FLogDirOutput);
        redtLog.Font := LFrm.redtLog.Font;
        LIni.WriteString('Log_Font', 'Name', redtLog.Font.Name);
        LIni.WriteInteger('Log_Font', 'Size', redtLog.Font.Size);

        LIni.WriteString('Log_Font', 'Name', redtLog.Font.Name);
        LIni.WriteInteger('Log_Font', 'CharSet', redtLog.Font.Charset);
        LIni.WriteInteger('Log_Font', 'Size', redtLog.Font.Size);
        LIni.WriteInteger('Log_Font', 'Style', Byte(redtLog.Font.Style));
        LIni.WriteInteger('Log_Font', 'Error_Foreground', FErrorForeground);
        LIni.WriteInteger('Log_Font', 'Error_Background', FErrorBackground);
        LIni.WriteInteger('Log_Font', 'SSL_Message_Foreground',
          FSSLMessageForeground);
        LIni.WriteInteger('Log_Font', 'SSL_Message_Background',
          FSSLMessageBackground);
        LIni.WriteInteger('Log_Font', 'Directory_Foreground',
          FDirOutputForeground);
        LIni.WriteInteger('Log_Font', 'Directory_Background',
          FDirOutputBackground);
        LIni.WriteInteger('Log_Font', 'Debug_Output_Foreground',
          FDebugForeground);
        LIni.WriteInteger('Log_Font', 'Debug_Output_Background',
          FDebugBackground);
        SetProxyType(LFrm.ProxyType);
        LIni.WriteInteger('Proxy', 'Type', LFrm.ProxyType);
        SocksInfo.Host := LFrm.ProxyHost;
        SocksInfo.Port := LFrm.ProxyPort;
        SocksInfo.Username := LFrm.ProxyUsername;
        SocksInfo.Password := LFrm.ProxyPassword;
        if (SocksInfo.Username <> '') and (SocksInfo.Password <> '') then
        begin
          SocksInfo.Authentication := saUsernamePassword;
        end;
        HTTPConnectThrough.Host := SocksInfo.Host;
        HTTPConnectThrough.Port := SocksInfo.Port;
        HTTPConnectThrough.Username := SocksInfo.Username;
        HTTPConnectThrough.Password := SocksInfo.Password;
        LIni.WriteString('Proxy', 'Server_Name', SocksInfo.Host);
        LIni.WriteString('Proxy', 'User_Name', SocksInfo.Username);
        LIni.WriteString('Proxy', 'Password', SocksInfo.Password);
        LIni.WriteInteger('Proxy', 'Port', SocksInfo.Port);
        IdFTPClient.ProxySettings.ProxyType :=
          TIdFtpProxyType(LFrm.FTPProxyType);
        IdFTPClient.ProxySettings.Host := LFrm.FTPProxyHost;
        IdFTPClient.ProxySettings.Port := LFrm.FTPProxyPort;
        IdFTPClient.ProxySettings.Username := LFrm.FTPProxyUsername;
        IdFTPClient.ProxySettings.Password := LFrm.FTPProxyPassword;
        LIni.WriteInteger('FTP_Proxy', 'Type', LFrm.FTPProxyType);
        LIni.WriteString('FTP_Proxy', 'Server_Name', SocksInfo.Host);
        LIni.WriteString('FTP_Proxy', 'User_Name', SocksInfo.Username);
        LIni.WriteString('FTP_Proxy', 'Password', SocksInfo.Password);
        LIni.WriteInteger('FTP_Proxy', 'Port', SocksInfo.Port);
      end;
    finally
      FreeAndNil(LIni);
    end;
  finally
    FreeAndNil(LFrm);
  end;
end;

procedure TfrmMainForm.cboLocalCurrentDirKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    ChangeLocalDir(cboLocalCurrentDir.Text);
  end;
end;

procedure TfrmMainForm.cboRemoteCurrentDirKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = 13 then
  begin
    ChangeRemoteDir(cboRemoteCurrentDir.Text);
  end;
end;

procedure TfrmMainForm.ChangeLocalDir(const ADir: String);
begin
  if System.SysUtils.SetCurrentDir(ADir) then
  begin
    PopulateLocalFiles;
  end
  else
  begin
    System.SysUtils.RaiseLastOSError;
  end;
end;

procedure TfrmMainForm.ChangeRemoteDir(const ADir: String);
begin
  TRemoteChangeDirThread.Create(IdFTPClient, ADir);
end;

procedure TfrmMainForm.ConnectFTP;
begin
  if IdFTPClient.UseTLS <> utNoTLSSupport then
  begin
    IdFTPClient.DataPortProtection := ftpdpsPrivate;
  end;
  InitLog;
  TConnectThread.Create(IdFTPClient);
end;

procedure TfrmMainForm.DownloadFile(const AFile: String);
begin
  TDownloadFileThread.Create(IdFTPClient, AFile);
end;

procedure TfrmMainForm.UploadFile(const AFile: String);
begin
  TUploadFileThread.Create(IdFTPClient, AFile);
end;

procedure TfrmMainForm.actFileConnectExecute(Sender: TObject);
var
  LFrm: TfrmConnect;
begin
  LFrm := TfrmConnect.Create(Application);
  try
    LFrm.Caption := 'Connect';
    LFrm.QuickConnect := True;
    LFrm.cboConnectionType.ItemIndex := 0;
    if LFrm.ShowModal = mrOk then
    begin
      IdFTPClient.Host := LFrm.edtHostname.Text;
      IdFTPClient.Username := LFrm.Username;
      IdFTPClient.Password := LFrm.Password;
      IdFTPClient.Account := LFrm.edtAccount.Text;
      IdFTPClient.Port := LFrm.spnedtPort.Value;
      IdFTPClient.IOHandler := iosslFTP;
      IdFTPClient.Passive := not LFrm.UsePortTransferType;
      IdFTPClient.UseTLS := LFrm.UseTLS;
      iosslFTP.SSLOptions.KeyFile := LFrm.edtPrivateKeyFile.Text;
      iosslFTP.SSLOptions.CertFile := LFrm.edtPublicKey.Text;
      iosslFTP.SSLOptions.RootCertFile := LFrm.edtCAKey.Text;
      ConnectFTP;
    end;
  finally
    FreeAndNil(LFrm);
  end;
end;

procedure TfrmMainForm.actFileConnectUpdate(Sender: TObject);
begin
  actFileConnect.Enabled := (not ThreadRunning) and (not IdFTPClient.Connected);
end;

procedure TfrmMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ThreadRunning then
  begin
    Action := caNone;
  end
  else
  begin
    IdFTPClient.Disconnect;
  end;
end;

procedure TfrmMainForm.FormCreate(Sender: TObject);
var
  LIni: TIniFile;
  i: Integer;
begin

  FThreadRunning := TIdThreadSafeBoolean.Create;
  FThreadRunning.Value := False;
  FLocalColumnToSort := 0;
  FLocalAscending := True;

  FRemoteColumnToSort := 0;
  FRemoteAscending := True;
  Self.IdFTPClient.ClientInfo.ClientName := Application.Title;;
  Self.IdFTPClient.ClientInfo.ClientVersion := GetProgramVersion;
{$IFDEF WIN64}
  Self.IdFTPClient.ClientInfo.PlatformDescription := 'Win64';
{$ELSE}
  Self.IdFTPClient.ClientInfo.PlatformDescription := 'Win32';
{$ENDIF}
  LocalClearArrows;
  PopulateLocalFiles;
  RemoteLvClearArrows;
  pnlLocalBrowser.Constraints.MinWidth := pnlLocalBrowser.Width;
  // pnlDivider.Constraints.MinWidth := pnlDivider.Width;
  // pnlDivider.Constraints.MaxWidth := pnlDivider.Width;
  pnlMainWindow.Constraints.MinHeight := pnlMainWindow.Height;
  pnlRemoteBrowser.Constraints.MinWidth := pnlRemoteBrowser.Width;
  IdFTPClient.Compressor := IdCompressorZLib1;
  Application.Title := Caption;
  LIni := TIniFile.Create(GetIniFilePath);
  try
    IdFTPClient.Passive := not LIni.ReadBool('Transfers',
      'Use_PORT_Transfers', False);
    FLogDebugOutput := LIni.ReadBool('Debug', 'Log_Debug_Output', False);
    FLogDirOutput := LIni.ReadBool('Debug', 'Log_Directory_Output', False);
    redtLog.Font.Name := LIni.ReadString('Log_Font', 'Name', redtLog.Font.Name);
    redtLog.Font.Charset := LIni.ReadInteger('Log_Font', 'CharSet',
      redtLog.Font.Charset);
    redtLog.Font.Size := LIni.ReadInteger('Log_Font', 'Size',
      redtLog.Font.Size);
    redtLog.Font.Style := TFontStyles(Byte(LIni.ReadInteger('Log_Font', 'Style',
      Byte(redtLog.Font.Style))));
    FErrorForeground := LIni.ReadInteger('Log_Font', 'Error_Foreground', clRed);
    FErrorBackground := LIni.ReadInteger('Log_Font',
      'Error_Background', clWhite);
    FSSLMessageForeground := LIni.ReadInteger('Log_Font',
      'SSL_Message_Foreground', clTeal);
    FSSLMessageBackground := LIni.ReadInteger('Log_Font',
      'SSL_Message_Background', clWhite);
    FDirOutputForeground := LIni.ReadInteger('Log_Font',
      'Directory_Foreground', clBlue);
    FDirOutputBackground := LIni.ReadInteger('Log_Font',
      'Directory_Background', clWhite);
    FDebugForeground := LIni.ReadInteger('Log_Font', 'Debug_Output_Foreground',
      clPurple);
    FDebugBackground := LIni.ReadInteger('Log_Font',
      'Debug_Output_Background', clWhite);
    IdFTPClient.UseHOST := LIni.ReadBool('FTP', 'Use_HOST_Command',
      IdFTPClient.UseHOST);
    IdFTPClient.UseExtensionDataPort := LIni.ReadBool('Transfers',
      'Use_Extended_Data_Port_Commands', IdFTPClient.UseExtensionDataPort);
    IdFTPClient.TryNATFastTrack := LIni.ReadBool('Transfers',
      'Try_Using_NAT_Fast_Track', IdFTPClient.TryNATFastTrack);
    IdFTPClient.UseMLIS := LIni.ReadBool('FTP',
      'Use_MLSD_Command_Instead_Of_DIR_Command', IdFTPClient.UseMLIS);
    IdFTPClient.ExternalIP := LIni.ReadString('NAT', 'NAT_IP_Address', '');
    IdFTPClient.DataPortMin := LIni.ReadInteger('NAT', 'Data_PORT_Minimum', 0);
    IdFTPClient.DataPortMax := LIni.ReadInteger('NAT', 'Data_PORT_Maximum', 0);
    i := LIni.ReadInteger('Proxy', 'Type', 0);
    SetProxyType(i);
    if (SocksInfo.Username <> '') and (SocksInfo.Password <> '') then
    begin
      SocksInfo.Authentication := saUsernamePassword;
    end;
    SocksInfo.Host := LIni.ReadString('Proxy', 'Server_Name', '');
    SocksInfo.Username := LIni.ReadString('Proxy', 'User_Name', '');
    SocksInfo.Password := LIni.ReadString('Proxy', 'Password', '');
    SocksInfo.Port := LIni.ReadInteger('Proxy', 'Port', 1080);
    HTTPConnectThrough.Username := SocksInfo.Username;
    HTTPConnectThrough.Password := SocksInfo.Password;
    HTTPConnectThrough.Port := SocksInfo.Port;
    IdFTPClient.ProxySettings.ProxyType :=
      TIdFtpProxyType(LIni.ReadInteger('FTP_Proxy', 'Type', 0));
    IdFTPClient.ProxySettings.Host := LIni.ReadString('FTP_Proxy',
      'Server_Name', '');
    IdFTPClient.ProxySettings.Username := LIni.ReadString('FTP_Proxy',
      'User_Name', '');
    IdFTPClient.ProxySettings.Password := LIni.ReadString('FTP_Proxy',
      'Password', '');
    IdFTPClient.ProxySettings.Port := LIni.ReadInteger('FTP_Proxy', 'Port', 0);
  finally
    FreeAndNil(LIni);
  end;
  InitLog;
end;

procedure TfrmMainForm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FThreadRunning);
end;

function TfrmMainForm.GetThreadRunning: Boolean;
begin
  Result := FThreadRunning.Value;
end;

procedure TfrmMainForm.InitLog;
var
  i: Integer;
begin
  redtLog.Lines.Clear;

  redtLog.Lines.Add('Operating System: ' + TOSVersion.ToString);
  redtLog.Lines.Add('     RTL Version: ' + IntToStr(Hi(GetRTLVersion)) + '.' +
    IntToStr(Lo(GetRTLVersion)));
{$IFDEF WIN64}
  redtLog.Lines.Add('    Compiled For: Win64');
{$ELSE}
  redtLog.Lines.Add('    Compiled For: Win32');
{$ENDIF}
  redtLog.Lines.Add(' OpenSSL Version: ' + OpenSSLVersion);
  if GetOpenSSLLoader.GetFailedToLoad.Count > 0 then
  begin
    redtLog.Lines.Add('  Failed To Load: ');
    for i := 0 to GetOpenSSLLoader.GetFailedToLoad.Count - 1 do
    begin
      redtLog.Lines.Add(GetOpenSSLLoader.GetFailedToLoad[i]);
    end;
  end;
  ScrollToEnd(redtLog);
end;

procedure TfrmMainForm.LocalClearArrows;
var
  i: Integer;
  LMax: Integer;
begin
  lvLocalFiles.Columns.BeginUpdate;
  try
    LMax := lvRemoteFiles.Columns.Count - 1;
    for i := 0 to LMax do
    begin
      lvLocalFiles.Columns[i].ImageIndex := -1;
    end;
    if FRemoteAscending then
    begin
      lvLocalFiles.Columns[FLocalColumnToSort].ImageIndex := ARROW_UP_IMAGE_IDX;
    end
    else
    begin
      lvLocalFiles.Columns[FLocalColumnToSort].ImageIndex :=
        ARROW_DOWN_IMAGE_IDX;
    end;
  finally
    lvLocalFiles.Columns.EndUpdate;
  end;

end;

procedure TfrmMainForm.LocalDeleteFile(const AFile: String);
begin
  if MessageDlg('Delete ' + AFile + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes
  then
  begin
    System.SysUtils.DeleteFile(AFile);
    PopulateLocalFiles;
  end;
end;

procedure TfrmMainForm.LocalMakeDir(const ADir: String);
begin
  System.SysUtils.CreateDir(ADir);
  PopulateLocalFiles;
end;

procedure TfrmMainForm.LocalRemoveDir(const ADir: String);
begin
  if MessageDlg('Remove Directory ' + ADir + '?', mtConfirmation, [mbYes, mbNo],
    0) = mrYes then
  begin
    System.SysUtils.RemoveDir(ADir);
    PopulateLocalFiles;
  end;
end;

procedure TfrmMainForm.LocalRename(const AOldPathName, ANewPathName: String);
begin
  System.SysUtils.RenameFile(AOldPathName, ANewPathName);
end;

function CompareCaptions(Item1, Item2: TListItem): Integer;
begin
  if Item1.Caption > Item2.Caption then
  begin
    Result := 1;
  end
  else
  begin
    if Item1.Caption < Item2.Caption then
    begin
      Result := -1;
    end
    else
    begin
      Result := 0;
    end;
  end;
end;

procedure TfrmMainForm.lvLocalFilesColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  if Column.Index = FLocalColumnToSort then
  begin
    FLocalAscending := not FLocalAscending
  end
  else
  begin
    FLocalColumnToSort := Column.Index;
  end;
  LocalClearArrows;
  lvLocalFiles.Items.BeginUpdate;
  lvLocalFiles.AlphaSort;
  lvLocalFiles.Items.EndUpdate;
end;

procedure TfrmMainForm.lvLocalFilesCompare(Sender: TObject;
  Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
begin
  //
  case FLocalColumnToSort of
    0: // file name
      begin
        Compare := CompareCaptions(Item1, Item2);
      end;
    1: // file type, file name
      begin
        if Item1.SubItems[0] > Item2.SubItems[0] then
        begin
          Compare := 1;
        end
        else
        begin
          if Item1.SubItems[0] > Item2.SubItems[0] then
          begin
            Compare := 1;
          end
          else
          begin
            if Item1.SubItems[0] < Item2.SubItems[0] then
            begin
              Compare := -1;
            end
            else
            begin
              Compare := CompareCaptions(Item1, Item2);
            end;
          end;
        end;
      end;
    2: // file size, file name
      begin
        if Item1.SubItems[1] > Item2.SubItems[1] then
        begin
          Compare := 1;
        end
        else
        begin
          if Item1.SubItems[1] > Item2.SubItems[1] then
          begin
            Compare := 1;
          end
          else
          begin
            if Item1.SubItems[1] < Item2.SubItems[1] then
            begin
              Compare := -1;
            end
            else
            begin
              Compare := CompareCaptions(Item1, Item2);
            end;
          end;
        end;

      end;
    3: // file modified date, file name
      begin
        if Item1.SubItems[2] > Item2.SubItems[2] then
        begin
          Compare := 1;
        end
        else
        begin
          if Item1.SubItems[2] > Item2.SubItems[2] then
          begin
            Compare := 1;
          end
          else
          begin
            if Item1.SubItems[2] < Item2.SubItems[2] then
            begin
              Compare := -1;
            end
            else
            begin
              Compare := CompareCaptions(Item1, Item2);
            end;
          end;
        end;
      end;
  end;
  if FLocalAscending then
  begin
    Compare := 0 - Compare;
  end;

end;

procedure TfrmMainForm.lvLocalFilesDblClick(Sender: TObject);
var
  Li: TListItem;
{$IFNDEF USE_INLINE_VAR}
  LCurDir: String;
{$ENDIF}
begin
  //
  if lvLocalFiles.ItemIndex > -1 then
  begin
    Li := lvLocalFiles.Items[lvLocalFiles.ItemIndex];
    if Li.ImageIndex = DIR_IMAGE_IDX then
    begin
{$IFDEF USE_INLINE_VAR}
      var
        LCurDir: String;
{$ENDIF}
      LCurDir := GetCurrentDir;
      LCurDir := LCurDir + '\' + Li.Caption;
      ChangeLocalDir(LCurDir);
    end;
    if Li.ImageIndex = FILE_IMAGE_IDX then
    begin
      UploadFile(Li.Caption);
    end;
  end;
end;

procedure TfrmMainForm.lvRemoteFilesColumnClick(Sender: TObject;
  Column: TListColumn);

begin
  if Column.Index = FRemoteColumnToSort then
  begin
    FRemoteAscending := not FRemoteAscending
  end
  else
  begin
    FRemoteColumnToSort := Column.Index;
  end;
  RemoteLvClearArrows;
  lvRemoteFiles.Items.BeginUpdate;
  lvRemoteFiles.AlphaSort;
  lvRemoteFiles.Items.EndUpdate;
end;

procedure TfrmMainForm.lvRemoteFilesCompare(Sender: TObject;
  Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
begin
  //
  case FRemoteColumnToSort of
    0: // file name
      begin
        Compare := CompareCaptions(Item1, Item2);
      end;
    1: // file type, file name
      begin
        if Item1.SubItems[0] > Item2.SubItems[0] then
        begin
          Compare := 1;
        end
        else
        begin
          if Item1.SubItems[0] > Item2.SubItems[0] then
          begin
            Compare := 1;
          end
          else
          begin
            if Item1.SubItems[0] < Item2.SubItems[0] then
            begin
              Compare := -1;
            end
            else
            begin
              Compare := CompareCaptions(Item1, Item2);
            end;
          end;
        end;
      end;
    2: // file size, file name
      begin
        if Item1.SubItems[1] > Item2.SubItems[1] then
        begin
          Compare := 1;
        end
        else
        begin
          if Item1.SubItems[1] > Item2.SubItems[1] then
          begin
            Compare := 1;
          end
          else
          begin
            if Item1.SubItems[1] < Item2.SubItems[1] then
            begin
              Compare := -1;
            end
            else
            begin
              Compare := CompareCaptions(Item1, Item2);
            end;
          end;
        end;

      end;
    3: // file modified date, file name
      begin
        if Item1.SubItems[2] > Item2.SubItems[2] then
        begin
          Compare := 1;
        end
        else
        begin
          if Item1.SubItems[2] > Item2.SubItems[2] then
          begin
            Compare := 1;
          end
          else
          begin
            if Item1.SubItems[2] < Item2.SubItems[2] then
            begin
              Compare := -1;
            end
            else
            begin
              Compare := CompareCaptions(Item1, Item2);
            end;
          end;
        end;
      end;
  end;
  if FRemoteAscending then
  begin
    Compare := 0 - Compare;
  end;
end;

procedure TfrmMainForm.lvRemoteFilesDblClick(Sender: TObject);
var
  Li: TListItem;
begin
  if lvRemoteFiles.ItemIndex > -1 then
  begin
    Li := lvRemoteFiles.Items[lvRemoteFiles.ItemIndex];
    if Li.ImageIndex = DIR_IMAGE_IDX then
    begin
      ChangeRemoteDir(Li.Caption);
    end;
    if Li.ImageIndex = FILE_IMAGE_IDX then
    begin
      DownloadFile(Li.Caption);
    end;
  end;
end;

procedure TfrmMainForm.PopulateLocalFiles;
var
  Li: TListItem;
  LF: TSearchRec;
begin
  lvLocalFiles.Items.BeginUpdate;
  try
    lvLocalFiles.Items.Clear;
    lvLocalFiles.LargeImages := vimglstMainProgram;
    cboLocalCurrentDir.Text := GetCurrentDir;
    if FindFirst(GetCurrentDir + '\*.*', faAnyFile, LF) = 0 then
    begin
      repeat
        Li := lvLocalFiles.Items.Add;
        Li.Caption := LF.Name;
        if LF.Attr and faDirectory <> 0 then
        begin
          Li.SubItems.Add('Directory');
          Li.ImageIndex := DIR_IMAGE_IDX;
        end
        else
        begin
          Li.SubItems.Add('File');
          Li.ImageIndex := FILE_IMAGE_IDX;
        end;
        Li.SubItems.Add(IntToStr(LF.Size));
        Li.SubItems.Add(DateTimeToStr(LF.TimeStamp));
      until FindNext(LF) <> 0;
      FindClose(LF);
    end;
    lvLocalFiles.AlphaSort;
  finally
    lvLocalFiles.Items.EndUpdate;
  end;
end;

procedure TfrmMainForm.PopulateRemoteFiles(const ACurDir: String);
var
  i: Integer;
  Li: TListItem;
begin
  lvRemoteFiles.Items.BeginUpdate;
  try
    cboRemoteCurrentDir.Text := ACurDir;
    lvRemoteFiles.Items.Clear;
    lvRemoteFiles.LargeImages := vimglstMainProgram;
    for i := 0 to IdFTPClient.DirectoryListing.Count - 1 do
    begin
      Li := lvRemoteFiles.Items.Add;
      Li.Caption := IdFTPClient.DirectoryListing[i].FileName;
      case IdFTPClient.DirectoryListing[i].ItemType of
        ditDirectory:
          begin
            Li.SubItems.Add('Directory');
            Li.ImageIndex := DIR_IMAGE_IDX;
          end;
        ditFile:
          begin
            Li.SubItems.Add('File');
            Li.ImageIndex := FILE_IMAGE_IDX;
          end;
        ditSymbolicLink:
          begin
            Li.SubItems.Add('Symbolic link');
          end;
        ditSymbolicLinkDir:
          begin
            Li.SubItems.Add('Symbolic link');
          end;
        ditBlockDev:
          begin
            Li.SubItems.Add('Block Device');
          end;
        ditCharDev:
          begin
            Li.SubItems.Add('Character Device');
          end;
        ditFIFO:
          begin
            Li.SubItems.Add('Named Pipe');
          end;
        ditSocket:
          begin
            Li.SubItems.Add('Socket');
          end;
      end;
      if IdFTPClient.DirectoryListing[i].SizeAvail then
      begin
        Li.SubItems.Add(IntToStr(IdFTPClient.DirectoryListing[i].Size));
      end
      else
      begin
        Li.SubItems.Add('');
      end;
      if IdFTPClient.DirectoryListing[i].ModifiedAvail then
      begin
        Li.SubItems.Add(DateTimeToStr(IdFTPClient.DirectoryListing[i]
          .ModifiedDate));
      end
      else
      begin
        Li.SubItems.Add('');
      end;
    end;
    lvRemoteFiles.AlphaSort;
  finally
    lvRemoteFiles.Items.EndUpdate;
    lvRemoteFiles.Enabled := True;
  end;
end;

procedure TfrmMainForm.RemoteDeleteFile(const AFile: String);
begin
  if MessageDlg('Delete ' + AFile + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes
  then
  begin
    TDeleteFileThread.Create(IdFTPClient, AFile);
  end;
end;

procedure TfrmMainForm.RemoteLvClearArrows;
var
  i: Integer;
  LMax: Integer;
begin
  lvRemoteFiles.Columns.BeginUpdate;
  try
    LMax := lvRemoteFiles.Columns.Count - 1;
    for i := 0 to LMax do
    begin
      lvRemoteFiles.Columns[i].ImageIndex := -1;
    end;
    if FRemoteAscending then
    begin
      lvRemoteFiles.Columns[FRemoteColumnToSort].ImageIndex :=
        ARROW_UP_IMAGE_IDX;
    end
    else
    begin
      lvRemoteFiles.Columns[FRemoteColumnToSort].ImageIndex :=
        ARROW_DOWN_IMAGE_IDX;
    end;
  finally
    lvRemoteFiles.Columns.EndUpdate;
  end;
end;

procedure TfrmMainForm.RemoteMakeDir(const ADir: String);
begin
  TMakeDirThread.Create(IdFTPClient, ADir);
end;

procedure TfrmMainForm.RemoteRemoveDir(const ADir: String);
begin
  TRemoveDirThread.Create(IdFTPClient, ADir);
end;

procedure TfrmMainForm.RemoteRename(const AOldPathName, ANewPathName: String);
begin
  TRenamePathThread.Create(IdFTPClient, AOldPathName, ANewPathName);
end;

procedure TfrmMainForm.SetProxyType(const AType: Integer);
begin
  case AType of
    0:
      iosslFTP.TransparentProxy := nil;
    1:
      iosslFTP.TransparentProxy := HTTPConnectThrough;
    2:
      begin
        iosslFTP.TransparentProxy := SocksInfo;
        SocksInfo.Version := svSocks4;
      end;
    3:
      begin
        iosslFTP.TransparentProxy := SocksInfo;
        SocksInfo.Version := svSocks4A;
      end;
    4:
      begin
        iosslFTP.TransparentProxy := SocksInfo;
        SocksInfo.Version := svSocks5;
      end;
  end;
end;

procedure TfrmMainForm.SetThreadRunning(const Value: Boolean);
begin
  FThreadRunning.Value := Value;
end;

procedure TfrmMainForm.SetupPRogressIndicator(const AFileName: String;
  const AWorkMode: TWorkMode; const AWorkCount, AWorkMax: Int64);
begin
  if not Assigned(FProgressIndicator) then
  begin
    FProgressIndicator := TfrmFileProgress.Create(Application);
  end;
  FProgressIndicator.UpdateProgressIndicator(AFileName, AWorkMode, AWorkCount,
    AWorkMax);
  FProgressIndicator.Show;
  FProgressIndicator.Repaint;
  Application.ProcessMessages;
end;

procedure TfrmMainForm.UpdateProgressIndicator(const AFileName: String;
  const AWorkMode: TWorkMode; const AWorkCount, AWorkMax: Int64);
begin
  if not Assigned(FProgressIndicator) then
  begin
    FProgressIndicator := TfrmFileProgress.Create(Application);
  end;
  FProgressIndicator.UpdateProgressIndicator(AFileName, AWorkMode, AWorkCount,
    AWorkMax);
  FProgressIndicator.Show;
  FProgressIndicator.Repaint;
end;

procedure TfrmMainForm.CloseProgressIndicator;
begin
  FreeAndNil(FProgressIndicator);
end;

{ TFTPThread }

constructor TFTPThread.Create(AFTP: TIdFTP);
begin
  inherited Create(False);
  FFTP := AFTP;
  FIO := AFTP.IOHandler as TTaurusTLSIOHandlerSocket;
  // FIO.OnVerifyPeer := OnVerifyPeer;
  FIO.OnGetPassword := OnGetPassword;
  FIO.OnStatusInfo := OnStatusInfo;
  FIO.OnSSLNegotiated := OnSSLNegotiated;
  FLog := FIO.Intercept as TIdLogEvent;
  FLog.OnReceived := Self.OnLogReceived;
  FLog.OnSent := Self.OnLogSent;
  FreeOnTerminate := True;
end;

destructor TFTPThread.Destroy;
begin
  FIO.OnVerifyPeer := nil;
  FIO.OnGetPassword := nil;
  FLog.OnReceived := nil;
  FLog.OnSent := nil;
  FFTP.OnWorkBegin := nil;
  FFTP.OnWork := nil;
  FFTP.OnWorkEnd := nil;
  inherited;
end;

procedure TFTPThread.DummySync;
begin
  // You don't need to do anything here. It's just used
  // as a fence to stop the thread ending before all the
  // Queued messages are processed.
end;

procedure TFTPThread.OnGetPassword(ASender: TObject; var VPassword: String;
  const AIsWrite: Boolean);
begin
  Synchronize(Self, PromptPassword);
  VPassword := FKeyPassword;
end;

function TFTPThread.OnVerifyPeer(Certificate: TTaurusTLSX509;
  const AOk: Boolean; const ADepth, AError: Integer): Boolean;
begin
  FX509 := Certificate;
  FError := AError;
  FDepth := ADepth;
  Synchronize(Self, PromptVerifyCert);
  Result := FVerifyResult;
end;

procedure TFTPThread.LogCipherEvent(const AStr: String);
begin
  frmMainForm.redtLog.SelAttributes.Color := frmMainForm.SSLMessageForeground;
  frmMainForm.redtLog.SelAttributes.BackColor :=
    frmMainForm.SSLMessageBackground;
  LogRegularOutput(AStr);
end;

procedure TFTPThread.LogDirListing(AListing: TStrings);
var
  i: Integer;
begin
  if frmMainForm.LogDirOutput then
  begin
    frmMainForm.redtLog.Lines.BeginUpdate;
    try
      for i := 0 to AListing.Count - 1 do
      begin
        frmMainForm.redtLog.SelAttributes.Color :=
          frmMainForm.DirOutputForeground;
        frmMainForm.redtLog.SelAttributes.BackColor :=
          frmMainForm.DirOutputBackground;
        frmMainForm.redtLog.Lines.Add(AListing[i]);
      end;
    finally
      frmMainForm.redtLog.Lines.EndUpdate;
    end;
    ScrollToEnd(frmMainForm.redtLog);
  end;
end;

procedure TFTPThread.LogFTPError(const AStr: String);
begin
  frmMainForm.redtLog.SelAttributes.Color := frmMainForm.ErrorForeground;
  frmMainForm.redtLog.SelAttributes.BackColor := frmMainForm.ErrorBackground;
  LogRegularOutput(AStr);
end;

procedure TFTPThread.LogRegularOutput(const AStr: String);
begin
  frmMainForm.redtLog.Lines.Add(AStr);
  ScrollToEnd(frmMainForm.redtLog);
end;

procedure TFTPThread.LogSSLEvent(const AStr: String);
begin
  if frmMainForm.LogDebugOutput then
  begin
    frmMainForm.redtLog.SelAttributes.Color := frmMainForm.DebugForeground;
    frmMainForm.redtLog.SelAttributes.BackColor := frmMainForm.DebugBackground;
    LogRegularOutput(AStr);
  end;
end;

procedure TFTPThread.OnLogReceived(ASender: TComponent;
  const AText, AData: string);
var
  LData: String;
begin
  LData := Trim(AData);
  if Length(LData) > 0 then
  begin
    if CharInSet(LData[1], ['4', '5']) then
    begin
      queue(
        procedure
        begin
          LogFTPError(LData);
        end);
    end
    else
    begin
      queue(
        procedure
        begin
          LogRegularOutput(LData);
        end);
    end;
  end;
end;

procedure TFTPThread.OnLogSent(ASender: TComponent; const AText, AData: string);
begin
  if IndyPos('PASS ', AData) > 0 then
  begin
    queue(
      procedure
      begin
        LogRegularOutput('PASS ***');
      end);
  end
  else
  begin
    queue(
      procedure
      begin
        LogRegularOutput(Trim(AData));
      end);
  end;
end;

procedure TFTPThread.OnSSLNegotiated(ASender: TTaurusTLSIOHandlerSocket);
var
{$IFNDEF USE_INLINE_VAR}
  LStr: String;
{$ENDIF}
  LNo: Integer;
begin
//use synchronize to prevent an AV
  Synchronize(
    procedure
    begin
      if Assigned(ASender.SSLSocket) then
      begin
{$IFDEF USE_INLINE_VAR}
        var
          LStr: String;
{$ENDIF}
        LStr := ASender.SSLSocket.SSLProtocolVersionStr;
        if LStr <> '' then
        begin
          LogCipherEvent('       TLS Version: ' + LStr);
        end;
        if Assigned(ASender.SSLSocket.Cipher) then
        begin
          LStr := ASender.SSLSocket.Cipher.Name;
          if LStr <> '' then
            LogCipherEvent('       Cipher Name: ' + LStr);
          LStr := ASender.SSLSocket.Cipher.Description;
          if LStr <> '' then
            LogCipherEvent('Cipher Description: ' + Trim(LStr));
          LStr := ASender.SSLSocket.Cipher.Version;
          if LStr <> '' then
            LogCipherEvent('    Cipher Version: ' + LStr);
          LNo := ASender.SSLSocket.Cipher.Bits;
          if LNo <> 0 then
          begin
            LogCipherEvent('       Cipher Bits: ' + IntToStr(LNo));
          end;
        end;
      end;
    end);
end;

procedure TFTPThread.OnStatusInfo(ASender: TObject; const AsslSocket: PSSL;
const AWhere, Aret: TIdC_INT; const AType, AMsg: string);
begin
  LogSSLEvent(AType);
  LogSSLEvent(AMsg);
end;

procedure TFTPThread.PromptPassword;
begin
  InputQuery('Key Password', 'Enter Key Password:', FKeyPassword);
end;

procedure TFTPThread.PromptVerifyCert;
var
  LFrm: TfrmCertViewer;
begin
  try
    if GAcceptableCertificates.IndexOf(FX509.Fingerprints.SHA512AsString) = -1
    then
    begin
      LFrm := TfrmCertViewer.Create(nil);
      try
        LFrm.ErrorForeground := frmMainForm.ErrorForeground;
        LFrm.ErrorBackground := frmMainForm.ErrorBackground;
        LFrm.X509 := FX509;
        LFrm.ErrorCode := FError;
        FVerifyResult := LFrm.ShowModal = mrYes;
        if FVerifyResult and (LFrm.chkacceptOnlyOnce.Checked = False) then
        begin
          GAcceptableCertificates.Add(FX509.Fingerprints.SHA512AsString);
        end;
      finally
        FreeAndNil(LFrm);
      end;
    end
    else
    begin
      FVerifyResult := True;
    end;
    (FFTP.IOHandler as TTaurusTLSIOHandlerSocket).OnVerifyPeer := nil;
  except
    FVerifyResult := False;
  end;
end;

{ TConnectThread }

procedure TConnectThread.Execute;
var
  LCurDir: String;
begin
  try
    frmMainForm.ThreadRunning := True;
    Synchronize(
      procedure
      begin
        FIO.OnVerifyPeer := OnVerifyPeer;
      end);
    FFTP.Connect;
    if FFTP.IsCompressionSupported then
    begin
      FFTP.TransferMode(dmDeflate);
    end;
    LCurDir := FFTP.RetrieveCurrentDir;
    FFTP.List;
    queue(
      procedure
      begin
        LogDirListing(FFTP.ListResult);
      end);
    queue(
      procedure
      begin
        frmMainForm.PopulateRemoteFiles(LCurDir);
      end);
  except
    // This is already reported in the FTP log Window
    on E: EIdReplyRFCError do;
    on E: Exception do
      queue(
        procedure
        begin
          LogFTPError(E.Message);
        end);
  end;
  Synchronize(DummySync);
  frmMainForm.ThreadRunning := False;
end;

{ TRemoteChangeDirThread }

constructor TRemoteChangeDirThread.Create(AFTP: TIdFTP; const ANewDir: String);
begin
  inherited Create(AFTP);
  FNewDir := ANewDir;
end;

procedure TRemoteChangeDirThread.Execute;
var
  LCurDir: String;
begin
  frmMainForm.ThreadRunning := True;
  try
    FFTP.ChangeDir(FNewDir);
    LCurDir := FFTP.RetrieveCurrentDir;
    FFTP.List;
    queue(
      procedure
      begin
        LogDirListing(FFTP.ListResult);
      end);
    queue(
      procedure
      begin
        frmMainForm.PopulateRemoteFiles(LCurDir);
      end);
  except
    // This is already reported in the FTP log Window
    on E: EIdReplyRFCError do;
    on E: Exception do
      queue(
        procedure
        begin
          LogFTPError(E.Message);
        end);
  end;
  Synchronize(DummySync);
  frmMainForm.ThreadRunning := False;
end;

{ TFileThread }

constructor TFileThread.Create(AFTP: TIdFTP; const AFile: String);
begin
  inherited Create(AFTP);
  FFile := AFile;
end;

{ TFileOnWorkThread }

constructor TFileOnWorkThread.Create(AFTP: TIdFTP; const AFile: String);
begin
  inherited Create(AFTP, AFile);
  FFTP.OnWorkBegin := Self.OnWorkBegin;
  FFTP.OnWork := Self.OnWork;
  FFTP.OnWorkEnd := Self.OnWorkEnd;
end;

procedure TFileOnWorkThread.OnWork(ASender: TObject; AWorkMode: TWorkMode;
AWorkCount: Int64);
begin
  queue(
    procedure
    begin
      frmMainForm.UpdateProgressIndicator(FFile, AWorkMode, AWorkCount, FSize);
    end);
  if Assigned(frmMainForm.ProgressIndicator) then
  begin
    if frmMainForm.ProgressIndicator.CancelPressed then
    begin
      Self.FFTP.Abort;
      frmMainForm.ProgressIndicator.CancelPressed := False;
    end;
  end;
end;

procedure TFileOnWorkThread.OnWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
AWorkCountMax: Int64);
begin

  queue(
    procedure
    begin
      frmMainForm.SetupPRogressIndicator(Self.FFile, AWorkMode, 0, FSize);
    end);
end;

procedure TFileOnWorkThread.OnWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
begin
  queue(
    procedure
    begin
      frmMainForm.CloseProgressIndicator;
    end);
end;

{ TDownloadFileThread }

procedure TDownloadFileThread.Execute;
var
  LFile: TStream;
begin
  frmMainForm.ThreadRunning := True;
  try
    FSize := FFTP.Size(FFile);

    LFile := TFileStream.Create(FFile, fmCreate);
    try
      FFTP.TransferType := ftBinary;
      FFTP.Get(FFile, LFile);
    finally
      FreeAndNil(LFile);
    end;
    TFile.SetLastWriteTime(FFile, FFTP.FileDate(FFile));
    queue(
      procedure
      begin
        frmMainForm.PopulateLocalFiles;
      end);
  except
    // This is already reported in the FTP log Window
    on E: EIdReplyRFCError do;
    on E: Exception do
      queue(
        procedure
        begin
          LogFTPError(E.Message);
        end);
  end;
  Synchronize(DummySync);
  frmMainForm.ThreadRunning := False;
end;

{ TUploadFileThread }

procedure TUploadFileThread.Execute;
var
  LFile: TStream;
{$IFNDEF USE_INLINE_VAR}
  LCurDir: String;
{$ENDIF}
begin
  frmMainForm.ThreadRunning := True;
  try
    FSize := IdGlobalProtocols.FileSizeByName(FFile);
    LFile := TFileStream.Create(FFile, fmOpenRead);
    try
      FFTP.TransferType := ftBinary;
      FFTP.Put(LFile, FFile);
    finally
      FreeAndNil(LFile);
    end;
    FFTP.SetModTime(FFile, TFile.GetLastWriteTime(FFile));
{$IFDEF USE_INLINE_VAR}
    var
      LCurDir: String;
{$ENDIF}
    LCurDir := FFTP.RetrieveCurrentDir;
    FFTP.List;
    queue(
      procedure
      begin
        LogDirListing(FFTP.ListResult);
      end);
    queue(
      procedure
      begin
        frmMainForm.PopulateRemoteFiles(LCurDir);
      end);
  except
    // This is already reported in the FTP log Window
    on E: EIdReplyRFCError do;
    on E: Exception do
      queue(
        procedure
        begin
          LogFTPError(E.Message);
        end);
  end;
  Synchronize(DummySync);
  frmMainForm.ThreadRunning := False;
end;

{ TDeleteFileThread }

procedure TDeleteFileThread.Execute;

{$IFNDEF USE_INLINE_VAR}
var
  LCurDir: String;
{$ENDIF}
begin
  frmMainForm.ThreadRunning := True;
  try
    FFTP.Delete(FFile);
{$IFDEF USE_INLINE_VAR}
    var
      LCurDir: String;
{$ENDIF}
    LCurDir := FFTP.RetrieveCurrentDir;
    FFTP.List;
    queue(
      procedure
      begin
        LogDirListing(FFTP.ListResult);
      end);
    queue(
      procedure
      begin
        frmMainForm.PopulateRemoteFiles(LCurDir);
      end);
  except
    // This is already reported in the FTP log Window
    on E: EIdReplyRFCError do;
    on E: Exception do
      queue(
        procedure
        begin
          LogFTPError(E.Message);
        end);
  end;
  Synchronize(DummySync);
  frmMainForm.ThreadRunning := False;
end;

{ TRemoveDirThread }

procedure TRemoveDirThread.Execute;
{$IFNDEF USE_INLINE_VAR}
var
  LCurDir: String;
{$ENDIF}
begin
  frmMainForm.ThreadRunning := True;
  try
    FFTP.RemoveDir(FFile);
{$IFDEF USE_INLINE_VAR}
    var
      LCurDir: String;
{$ENDIF}
    LCurDir := FFTP.RetrieveCurrentDir;
    FFTP.List;
    queue(
      procedure
      begin
        LogDirListing(FFTP.ListResult);
      end);
    queue(
      procedure
      begin
        frmMainForm.PopulateRemoteFiles(LCurDir);
      end);
  except
    // This is already reported in the FTP log Window
    on E: EIdReplyRFCError do;
    on E: Exception do
      queue(
        procedure
        begin
          LogFTPError(E.Message);
        end);
  end;
  Synchronize(DummySync);
  frmMainForm.ThreadRunning := False;
end;

{ TRenamePathThread }

constructor TRenamePathThread.Create(AFTP: TIdFTP;
const AOldName, ANewName: String);
begin
  inherited Create(AFTP, AOldName);
  FNewName := ANewName;
end;

procedure TRenamePathThread.Execute;
{$IFNDEF USE_INLINE_VAR}
var
  LCurDir: String;
{$ENDIF}
begin
  frmMainForm.ThreadRunning := True;
  try
    FFTP.Rename(FFile, FNewName);
{$IFDEF USE_INLINE_VAR}
    var
      LCurDir: String;
{$ENDIF}
    LCurDir := FFTP.RetrieveCurrentDir;
    FFTP.List;
    queue(
      procedure
      begin
        LogDirListing(FFTP.ListResult);
      end);
    queue(
      procedure
      begin
        frmMainForm.PopulateRemoteFiles(LCurDir);
      end);
  except
    // This is already reported in the FTP log Window
    on E: EIdReplyRFCError do;
    on E: Exception do
      queue(
        procedure
        begin
          LogFTPError(E.Message);
        end);
  end;
  Synchronize(DummySync);
  frmMainForm.ThreadRunning := False;
end;

{ TMakeDirThread }

procedure TMakeDirThread.Execute;
{$IFNDEF USE_INLINE_VAR}
var
  LCurDir: String;
{$ENDIF}
begin
  frmMainForm.ThreadRunning := True;
  try
    FFTP.MakeDir(FFile);
{$IFDEF USE_INLINE_VAR}
    var
      LCurDir: String;
{$ENDIF}
    LCurDir := FFTP.RetrieveCurrentDir;
    FFTP.List;
    queue(
      procedure
      begin
        LogDirListing(FFTP.ListResult);
      end);
    queue(
      procedure
      begin
        frmMainForm.PopulateRemoteFiles(LCurDir);
      end);
  except
    // EIdReplyRFCError exceptions reported in log Window
    on E: EIdReplyRFCError do;
    on E: Exception do
      queue(
        procedure
        begin
          LogFTPError(E.Message);
        end);
  end;
  Synchronize(DummySync);
  frmMainForm.ThreadRunning := False;
end;

initialization

GetOpenSSLLoader.OpenSSLPath := ExtractFilePath(ParamStr(0));

end.

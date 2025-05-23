program TaurusFTPServer;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  IdFIPS,
  IdExplicitTLSClientServerBase,
  IdCompressorZLib,
  IdFTPCommon,
  IdFTPList,
  IdFTPListOutput,
  IdFTPServer,
  IdFTPServerContextBase,
  IdStack,
  IdSSL,
  TaurusTLS,
  System.Classes,
  System.IniFiles,
  System.SysUtils,
  System.IOUtils,
  WinApi.Windows;

type
  TFTPServerApp = class(TObject)
  private
    FCompressor: TIdCompressorZLib;
    FIOExplicit: TTaurusTLSServerIOHandler;
    FIOImplicit: TTaurusTLSServerIOHandler;
    FFTPServExplicit: TIdFTPServer;
    FFTPServImplicit: TIdFTPServer;
    procedure ioOnGetPasswordEx(ASender: TObject; var VPassword: String;
      const AIsWrite: Boolean; var VOk: Boolean);
    procedure ftpsrvOnHostCheck(ASender: TIdFTPServerContext;
      const AHost: String; var VAccepted: Boolean);
    procedure ftpsrvOnLogin(ASender: TIdFTPServerContext;
      const AUsername, APassword: string; var AAuthenticated: Boolean);
    procedure ftpsrvOnClient(ASender: TIdFTPServerContext; const AID: String);
    procedure ftpsrvOnList(ASender: TIdFTPServerContext;
      const APath: TIdFTPFileName; ADirectoryListing: TIdFTPListOutput;
      const ACmd: String; const ASwitches: String);
    procedure ftpsrvOnMLST(ASender: TIdFTPServerContext;
      const APath: TIdFTPFileName; ADirectoryListing: TIdFTPListOutput);
    procedure ftpsrvOnCWD(ASender: TIdFTPServerContext;
      var VDirectory: TIdFTPFileName);
    procedure ftpsrvOnMakeDirectory(ASender: TIdFTPServerContext;
      var VDirectory: TIdFTPFileName);
    procedure ftpsrvOnRemoveDirectory(ASender: TIdFTPServerContext;
      var VDirectory: TIdFTPFileName);
    procedure ftpsrvOnRenameFile(ASender: TIdFTPServerContext;
      const ARenameFromFile, ARenameToFile: TIdFTPFileName);
    procedure ftpsrvOnRetrieveFile(ASender: TIdFTPServerContext;
      const AFileName: TIdFTPFileName; var VStream: TStream);
    procedure ftpsrvOnStoreFile(ASender: TIdFTPServerContext;
      const AFileName: TIdFTPFileName; AAppend: Boolean; var VStream: TStream);
    procedure ftpsrvOnDeleteFile(ASender: TIdFTPServerContext;
      const APathName: TIdFTPFileName);
    procedure ftpsrvOnGetFileDate(ASender: TIdFTPServerContext;
      const AFileName: TIdFTPFileName; var VFileDate: TDateTime);
    procedure ftpsrvOnSetModFileDate(ASender: TIdFTPServerContext;
      const AFileName: TIdFTPFileName; var AFileTime: TDateTime);
    procedure ftpsrvOnSetCreationFileDate(ASender: TIdFTPServerContext;
      const AFileName: TIdFTPFileName; var AFileTime: TDateTime);
    procedure ftpsrvOnFileExistCheck(ASender: TIdFTPServerContext;
      const APathName: TIdFTPFileName; var VExist: Boolean);
    procedure ftpsrvOnGetFileSize(ASender: TIdFTPServerContext;
      const AFileName: TIdFTPFileName; var VFileSize: Int64);
    procedure ftpsrvOnSiteUTIME(ASender: TIdFTPServerContext;
      const AFileName: TIdFTPFileName; var VLastAccessTime, VLastModTime,
      VCreateDate: TDateTime; var VAUth: Boolean);
    function SetupFTPServer(AIni: TIniFile): TIdFTPServer;
    function SetupIOHandler(AIni: TIniFile): TTaurusTLSServerIOHandler;
  public
    constructor Create;
    destructor Destroy; override;
  end;

var
  app: TFTPServerApp;

function SetFileLastAccessDateTime(const FileName: String; DateTime: TDateTime)
  : Boolean; inline;
begin
  Result := (FileName <> '') and (FileExists(FileName) = True);
  if Result then
  begin
    TFile.SetLastAccessTime(FileName, DateTime);
  end;
end;

function SetFileLastModifiedDateTime(const FileName: String;
  DateTime: TDateTime): Boolean; inline;
begin
  Result := (FileName <> '') and (FileExists(FileName) = True);
  if Result then
  begin
    TFile.SetLastWriteTime(FileName, DateTime);
  end;
end;

function SetFileCreationDateTime(const FileName: String; DateTime: TDateTime)
  : Boolean; inline;
begin
  Result := (FileName <> '') and (FileExists(FileName) = True);
  if Result then
  begin
    TFile.SetCreationTime(FileName, DateTime);
  end;
end;

// This is necessary because FileAge does not work with directories.
function GetFileLastModifiedDateTime(const FileName: String;
  var VDateTime: TDateTime): Boolean;
var
  F: TSearchRec;

begin
  Result := FindFirst(FileName, faAnyFile, F) = 0;
  if Result then
  begin
    VDateTime := F.TimeStamp;
    System.SysUtils.FindClose(F);
  end;
end;

// based on https://stackoverflow.com/questions/17064672/programmatical-log-in-by-providing-credentials
function ConnectAs(const lpszUsername, lpszPassword: string): Boolean;
var
  hToken: THandle;
begin
  Result := LogonUser(PChar(lpszUsername), nil, PChar(lpszPassword),
    LOGON32_LOGON_INTERACTIVE, LOGON32_PROVIDER_DEFAULT, hToken);
  if Result then
  begin
    Result := ImpersonateLoggedOnUser(hToken);
  end;
end;

function FTPPathToLocalPath(const APath: String;
  const AAnonymous: Boolean): String;
begin
  if AAnonymous then
  begin
    Result := StringReplace(System.IOUtils.TPath.GetSharedDocumentsPath + '\' +
      APath, '/', '\', [rfReplaceAll]);
  end
  else
  begin
    Result := StringReplace(System.IOUtils.TPath.GetDocumentsPath + '\' + APath,
      '/', '\', [rfReplaceAll]);
  end;
  Result := StringReplace(Result, '\\', '\', [rfReplaceAll]);
end;

procedure FileNotFound(const APathName: String);
begin
  raise Exception.Create(APathName + ' not found');
end;

procedure PermissionDenied;
begin
  raise Exception.Create('permission denied');
end;

{ TFTPServerApp }

function TFTPServerApp.SetupFTPServer(AIni: TIniFile): TIdFTPServer;
begin
  Result := TIdFTPServer.Create(nil);
  Result.Greeting.Text.Text := 'TaurusFTP Server..';
  Result.PASVBoundPortMin := AIni.ReadInteger('Server',
    'PASV_Bound_Port_Minimum', 0);
  Result.PASVBoundPortMax := AIni.ReadInteger('Server',
    'PASV_Bound_Port_Maximum', 0);
  Result.Compressor := FCompressor;
  { This must be set to 0 so PASV will work properly.  If left
    at its default, the data port will timeout doing PASV.  That
    is a serious thing since some FTP clients default to PASV or
    even will NOT support PORT transfers. }
  Result.DefaultDataPort := 0;
  // Make the special Unix value case-insensitive
  if AIni.ReadBool('Server', 'Unix_Emulation', True) then
  begin
    Result.DirFormat := ftpdfUnix;
  end
  else
  begin
    Result.DirFormat := ftpdfDOS;
  end;

  Result.FTPSecurityOptions.PasswordAttempts :=
    AIni.ReadInteger('Server', 'Password_Attempts', DEF_FTP_PASSWORDATTEMPTS);
  Result.FTPSecurityOptions.InvalidPassDelay :=
    AIni.ReadInteger('Server', 'Delay_On_Failed_Password_Attempt',
    DEF_FTP_INVALIDPASS_DELAY);
  Result.FTPSecurityOptions.NoReservedRangePORT :=
    AIni.ReadBool('Server', 'No_PORT_Requests_To_Ports_In_Reserved_Range',
    DEF_FTP_NO_RESERVED_PORTS);
  Result.FTPSecurityOptions.BlockAllPORTTransfers :=
    AIni.ReadBool('Server', 'Do_Not_Accept_PORT_Transfers',
    DEF_FTP_BLOCK_ALL_PORTS);
  Result.FTPSecurityOptions.DisableSYSTCommand :=
    AIni.ReadBool('Server', 'Disable_SYST_Command', DEF_FTP_DISABLE_SYST);
  Result.FTPSecurityOptions.DisableSTATCommand :=
    AIni.ReadBool('Server', 'Disable_STAT_Command', DEF_FTP_DISABLE_STAT);
  Result.FTPSecurityOptions.RequirePORTFromSameIP :=
    AIni.ReadBool('Server', 'Reqiore_PORT_Connection_From_Same_IP_Address',
    DEF_FTP_PORT_SAME_IP);
  Result.FTPSecurityOptions.RequirePASVFromSameIP :=
    AIni.ReadBool('Server', 'Require_PASV_Connection_From_Same_IP_Address',
    DEF_FTP_PASV_SAME_IP);
  Result.FTPSecurityOptions.PermitCCC := AIni.ReadBool('Server',
    'Permit_CCC_Clear_Command_Connection_In_TLS_FTP', DEF_FTP_PERMIT_CCC);

  Result.AllowAnonymousLogin := AIni.ReadBool('Server',
    'Allow_Anonymous_FTP', false);
  Result.MLSDFacts := [mlsdFileCreationTime, mlsdFileLastAccessTime,
    mlsdWin32Attributes, mlsdPerms];
  Result.OnHostCheck := ftpsrvOnHostCheck;
  Result.SupportXAUTH := AIni.ReadBool('Server', 'SupportXAUTH', false);
  Result.OnUserLogin := ftpsrvOnLogin;
  Result.OnClientID := ftpsrvOnClient;
  Result.PathProcessing := ftppDOS;
  Result.OnChangeDirectory := ftpsrvOnCWD;
  Result.OnMakeDirectory := ftpsrvOnMakeDirectory;
  Result.OnRemoveDirectory := ftpsrvOnRemoveDirectory;
  Result.OnListDirectory := ftpsrvOnList;
  Result.OnRenameFile := ftpsrvOnRenameFile;
  Result.OnRetrieveFile := ftpsrvOnRetrieveFile;
  Result.OnStoreFile := ftpsrvOnStoreFile;
  // OnCRCFile uses the same code as OnRetrieveFile
  if AIni.ReadBool('Server', 'Allow_File_Checksums', True) then
  begin
    Result.OnCRCFile := ftpsrvOnRetrieveFile;
  end;
  Result.OnDeleteFile := ftpsrvOnDeleteFile;
  Result.OnGetFileDate := ftpsrvOnGetFileDate;
  Result.OnFileExistCheck := ftpsrvOnFileExistCheck;
  Result.OnSetModifiedTime := ftpsrvOnSetModFileDate;
  Result.OnSetCreationTime := ftpsrvOnSetCreationFileDate;
  Result.OnSiteUTIME := ftpsrvOnSiteUTIME;
  Result.OnGetFileSize := ftpsrvOnGetFileSize;
  Result.OnMLST := ftpsrvOnMLST;
end;

function TFTPServerApp.SetupIOHandler(AIni: TIniFile)
  : TTaurusTLSServerIOHandler;
begin
  Result := TTaurusTLSServerIOHandler.Create(nil);
  Result.SSLOptions.MinTLSVersion := TLSv1_2;
  Result.SSLOptions.CertFile := AIni.ReadString('Certificate',
    'CertificateFile', GetCurrentDir + '\localhost.crt');
  Result.SSLOptions.KeyFile := AIni.ReadString('Certificate', 'KeyFile',
    GetCurrentDir + '\localhost.key');
  Result.SSLOptions.RootCertFile := AIni.ReadString('Certificate',
    'RootCertFile', '');
  Result.SSLOptions.DHParamsFile := AIni.ReadString('Certificate',
    'DH_Parameters', '');
  Result.OnGetPassword := ioOnGetPasswordEx;
end;

constructor TFTPServerApp.Create;
var
  Lini: TIniFile;
begin
  inherited Create;
  if not FileExists(GetCurrentDir + '\server.ini') then
  begin

    Lini := TIniFile.Create(GetCurrentDir + '\server.ini');
    try
      Lini.WriteString('Certificate', 'CertificateFile',
        GetCurrentDir + '\ssl-cert.pem');
      Lini.WriteString('Certificate', 'KeyFile',
        GetCurrentDir + '\ssl-key.pem');
      Lini.WriteString('Certificate', 'RootCertFile', '');
      Lini.WriteString('Certificate', 'DH_Parameters', '');
      Lini.WriteString('Certificate', 'Password', '');

      Lini.WriteInteger('Server', 'PASV_Bound_Port_Minimum', 0);
      Lini.WriteInteger('Server', 'PASV_Bound_Port_Maximum', 0);

      Lini.WriteInteger('Server', 'Password_Attempts',
        DEF_FTP_PASSWORDATTEMPTS);
      Lini.WriteInteger('Server', 'Delay_On_Failed_Password_Attempt',
        DEF_FTP_INVALIDPASS_DELAY);
      Lini.WriteBool('Server', 'No_PORT_Requests_To_Ports_In_Reserved_Range',
        DEF_FTP_NO_RESERVED_PORTS);
      Lini.WriteBool('Server', 'Do_Not_Accept_PORT_Transfers',
        DEF_FTP_BLOCK_ALL_PORTS);
      Lini.WriteBool('Server', 'Disable_SYST_Command', DEF_FTP_DISABLE_SYST);
      Lini.WriteBool('Server', 'Disable_STAT_Command', DEF_FTP_DISABLE_STAT);
      Lini.WriteBool('Server', 'Reqiore_PORT_Connection_From_Same_IP_Address',
        DEF_FTP_PORT_SAME_IP);
      Lini.WriteBool('Server', 'Require_PASV_Connection_From_Same_IP_Address',
        DEF_FTP_PASV_SAME_IP);
      Lini.WriteBool('Server', 'Permit_CCC_Clear_Command_Connection_In_TLS_FTP',
        DEF_FTP_PERMIT_CCC);

      Lini.WriteBool('Server', 'Allow_Anonymous_FTP', false);
      Lini.WriteBool('Server', 'Allow_Compression', True);
      Lini.WriteBool('Server', 'Allow_File_Checksums', True);
      Lini.WriteBool('Server', 'Requre_TLS', True);
      Lini.WriteBool('Server', 'SupportXAUTH', false);
      Lini.WriteBool('Server', 'Unix_Emulation', True);
      Lini.WriteBool('Server', 'ImplicitSSL', True);
    finally
      FreeAndNil(Lini);
    end;
  end;

  Lini := TIniFile.Create(GetCurrentDir + '\server.ini');
  try
    if Lini.ReadBool('Server', 'Allow_Compression', True) then
    begin
      FCompressor := TIdCompressorZLib.Create(nil);
    end
    else
    begin
      FCompressor := nil;
    end;

    //--handle explicit FTPS server.
    FFTPServExplicit := SetupFTPServer(Lini);
    FIOExplicit := SetupIOHandler(Lini);
    FFTPServExplicit.IOHandler := FIOExplicit;
    if Lini.ReadBool('Server', 'Requre_TLS', True) then
    begin
      FFTPServExplicit.UseTLS := utUseRequireTLS;
    end
    else
    begin
      FFTPServExplicit.UseTLS := utUseExplicitTLS;
    end;
    FFTPServExplicit.Active := True;
    WriteLn('FTP Default Data Port: ' + IntToStr(FFTPServExplicit.DefaultPort));

    //--handle implicit FTPS server.
    FFTPServImplicit := nil;
    if Lini.ReadBool('Server', 'ImplicitSSL', True) then
    begin
      FFTPServImplicit := SetupFTPServer(Lini);
      FIOImplicit := SetupIOHandler(Lini);
      FFTPServImplicit.IOHandler := FIOImplicit;
      FFTPServImplicit.DefaultPort := 990;
      FFTPServImplicit.UseTLS := utUseImplicitTLS;
      FFTPServImplicit.Active := True;
      WriteLn('Implicit FTPS Default Data Port: ' +
        IntToStr(FFTPServImplicit.DefaultPort));
    end;
  finally
    FreeAndNil(Lini)
  end;
end;

destructor TFTPServerApp.Destroy;
begin
  FreeAndNil(FFTPServImplicit);
  FreeAndNil(FIOImplicit);
  FreeAndNil(FFTPServExplicit);
  FreeAndNil(FIOExplicit);
  FreeAndNil(FFTPServImplicit);
  FreeAndNil(FIOImplicit);
  FreeAndNil(FCompressor);
  inherited;
end;

procedure TFTPServerApp.ftpsrvOnClient(ASender: TIdFTPServerContext;
  const AID: String);
begin

end;

procedure TFTPServerApp.ftpsrvOnCWD(ASender: TIdFTPServerContext;
  var VDirectory: TIdFTPFileName);
begin
  if not DirectoryExists(FTPPathToLocalPath(VDirectory,
    ASender.UserType = utAnonymousUser)) then
  begin
    FileNotFound(VDirectory);
  end;
end;

procedure TFTPServerApp.ftpsrvOnDeleteFile(ASender: TIdFTPServerContext;
  const APathName: TIdFTPFileName);
begin
  if ASender.UserType = utAnonymousUser then
  begin
    PermissionDenied;
  end;

  if not System.SysUtils.DeleteFile(FTPPathToLocalPath(APathName,
    ASender.UserType = utAnonymousUser)) then
  begin
    FileNotFound(APathName);
  end;
end;

procedure TFTPServerApp.ftpsrvOnMakeDirectory(ASender: TIdFTPServerContext;
  var VDirectory: TIdFTPFileName);
begin
  if ASender.UserType = utAnonymousUser then
  begin
    PermissionDenied;
  end;
  if not CreateDir(FTPPathToLocalPath(VDirectory,
    ASender.UserType = utAnonymousUser)) then
  begin
    Raise Exception.Create('Can not create ' + VDirectory);
  end;
end;

procedure TFTPServerApp.ftpsrvOnRemoveDirectory(ASender: TIdFTPServerContext;
  var VDirectory: TIdFTPFileName);
begin
  if ASender.UserType = utAnonymousUser then
  begin
    PermissionDenied;
  end;
  if not System.SysUtils.RemoveDir(FTPPathToLocalPath(VDirectory,
    ASender.UserType = utAnonymousUser)) then
  begin
    FileNotFound(VDirectory);
  end;
end;

procedure TFTPServerApp.ftpsrvOnFileExistCheck(ASender: TIdFTPServerContext;
  const APathName: TIdFTPFileName; var VExist: Boolean);
begin
  VExist := FileExists(FTPPathToLocalPath(APathName,
    ASender.UserType = utAnonymousUser), false);
end;

procedure TFTPServerApp.ftpsrvOnGetFileDate(ASender: TIdFTPServerContext;
  const AFileName: TIdFTPFileName; var VFileDate: TDateTime);
begin
  if not GetFileLastModifiedDateTime(FTPPathToLocalPath(AFileName,
    ASender.UserType = utAnonymousUser), VFileDate) then
  begin
    FileNotFound(AFileName);
  end;

end;

procedure TFTPServerApp.ftpsrvOnGetFileSize(ASender: TIdFTPServerContext;
  const AFileName: TIdFTPFileName; var VFileSize: Int64);
var
  LFileEntry: TSearchRec;
begin
  if FindFirst(FTPPathToLocalPath(AFileName,
    ASender.UserType = utAnonymousUser), faAnyFile, LFileEntry) = 0 then
  begin
    VFileSize := LFileEntry.Size;
    System.SysUtils.FindClose(LFileEntry);
  end
  else
  begin
    FileNotFound(AFileName);
  end;
end;

procedure TFTPServerApp.ftpsrvOnHostCheck(ASender: TIdFTPServerContext;
  const AHost: String; var VAccepted: Boolean);
begin
  VAccepted := (AHost = GStack.HostName);
  if not VAccepted then
  begin
    VAccepted := (GStack.LocalAddresses.IndexOf(AHost) > -1);
  end;
end;

procedure TSearchRecToFTPListItem(ARec: TSearchRec;
  var AFTPItem: TIdFTPListOutputItem; const AAnonymous: Boolean); inline;
var
  LUnixPerm: String;
  LMSLTPerm: String;
begin
  AFTPItem.FileName := ARec.Name;
  if (ARec.Attr and faDirectory) = faDirectory then
  begin
    AFTPItem.ItemType := ditDirectory;
    AFTPItem.SizeAvail := false;
  end
  else
  begin
    AFTPItem.ItemType := ditFile;
  end;

  if AAnonymous then
  begin
    LMSLTPerm := 'elr';
  end
  else
  begin
    LMSLTPerm := 'acdeflmprw';
  end;
  if ARec.Attr and faReadOnly = faReadOnly then
  begin
    LUnixPerm := 'r-';
    LMSLTPerm := StringReplace(LMSLTPerm, 'a', '', [rfReplaceAll]);
    // file may be APPE'd
    LMSLTPerm := StringReplace(LMSLTPerm, 'w', '', [rfReplaceAll]);
    // file may be STOR'ed
    LMSLTPerm := StringReplace(LMSLTPerm, 'p', '', [rfReplaceAll]);
    // dir may be RMD'ed
    LMSLTPerm := StringReplace(LMSLTPerm, 'm', '', [rfReplaceAll]);
    // dir may be MKD'ed
    LMSLTPerm := StringReplace(LMSLTPerm, 'f', '', [rfReplaceAll]);
    // file or dir may be RNFR'ed
    LMSLTPerm := StringReplace(LMSLTPerm, 'd', '', [rfReplaceAll]);
    // dir or file may be RMD'ed
    LMSLTPerm := StringReplace(LMSLTPerm, 'c', '', [rfReplaceAll]);
    // dir may be STOU'ed
    LMSLTPerm := StringReplace(LMSLTPerm, 'p', '', [rfReplaceAll]);
    // dir may be RMD'ed
  end
  else
  begin
    if AAnonymous then
    begin
      LUnixPerm := 'r-';
    end
    else
    begin
      LUnixPerm := 'rw';
    end;
  end;
  // x - execute bit - for directories, means that you can access it.
  if (ARec.Attr and faDirectory) = faDirectory then
  begin
    LUnixPerm := LUnixPerm + 'x';
    LMSLTPerm := StringReplace(LMSLTPerm, 'a', '', [rfReplaceAll]);
    // file may be APPE'd
    LMSLTPerm := StringReplace(LMSLTPerm, 'r', '', [rfReplaceAll]);
    // file may be RETR'ed
    LMSLTPerm := StringReplace(LMSLTPerm, 'w', '', [rfReplaceAll]);
    // file may be STOR'ed
  end
  else
  begin
    LUnixPerm := LUnixPerm + '-';
    LMSLTPerm := StringReplace(LMSLTPerm, 'e', '', [rfReplaceAll]);
    // dir may be CWD'ed
    LMSLTPerm := StringReplace(LMSLTPerm, 'l', '', [rfReplaceAll]);
    // dir may be LIST'ed
    LMSLTPerm := StringReplace(LMSLTPerm, 'm', '', [rfReplaceAll]);
    // dir may be MKD'ed
    LMSLTPerm := StringReplace(LMSLTPerm, 'p', '', [rfReplaceAll]);
    // dir may be RMD'ed
  end;
  AFTPItem.MLISTPermissions := LMSLTPerm;
  AFTPItem.UnixOwnerPermissions := LUnixPerm;
  AFTPItem.UnixGroupPermissions := LUnixPerm;
  AFTPItem.UnixOtherPermissions := LUnixPerm;
  AFTPItem.ModifiedDate := ARec.TimeStamp;
  AFTPItem.LastAccessDate := ARec.LastAccessTime;
  AFTPItem.CreationDate := ARec.CreationTime;
  AFTPItem.Size := ARec.Size;
  AFTPItem.WinAttribs := ARec.Attr;
end;

procedure TFTPServerApp.ftpsrvOnList(ASender: TIdFTPServerContext;
  const APath: TIdFTPFileName; ADirectoryListing: TIdFTPListOutput;
  const ACmd, ASwitches: String);
var
  LFTPFile: TIdFTPListOutputItem;
  LFileEntry: TSearchRec;

begin
  if FindFirst(FTPPathToLocalPath(APath + '*.*',
    ASender.UserType = utAnonymousUser), faAnyFile, LFileEntry) = 0 then
  begin
    repeat
      LFTPFile := ADirectoryListing.Add;
      TSearchRecToFTPListItem(LFileEntry, LFTPFile,
        ASender.UserType = utAnonymousUser);
    until FindNext(LFileEntry) <> 0;
    System.SysUtils.FindClose(LFileEntry);
  end
  else
  begin
    if FindFirst(FTPPathToLocalPath(APath, ASender.UserType = utAnonymousUser),
      faAnyFile, LFileEntry) = 0 then
    begin
      LFTPFile := ADirectoryListing.Add;
      TSearchRecToFTPListItem(LFileEntry, LFTPFile,
        ASender.UserType = utAnonymousUser);
      System.SysUtils.FindClose(LFileEntry);
    end
    else
    begin
      FileNotFound(APath);
    end;
  end;
end;

procedure TFTPServerApp.ftpsrvOnMLST(ASender: TIdFTPServerContext;
  const APath: TIdFTPFileName; ADirectoryListing: TIdFTPListOutput);
var
  LFTPFile: TIdFTPListOutputItem;
  LFileEntry: TSearchRec;
begin
  // Get info about a file
  if FindFirst(FTPPathToLocalPath(APath, ASender.UserType = utAnonymousUser),
    faAnyFile, LFileEntry) = 0 then
  begin
    LFTPFile := ADirectoryListing.Add;
    TSearchRecToFTPListItem(LFileEntry, LFTPFile,
      ASender.UserType = utAnonymousUser);
    System.SysUtils.FindClose(LFileEntry);
  end
  else
  begin
    FileNotFound(APath);
  end;
end;

procedure TFTPServerApp.ftpsrvOnRenameFile(ASender: TIdFTPServerContext;
  const ARenameFromFile, ARenameToFile: TIdFTPFileName);
var
  LFromFile, LToFile: String;
begin
  if ASender.UserType = utAnonymousUser then
  begin
    PermissionDenied;
  end;
  LFromFile := FTPPathToLocalPath(ARenameFromFile,
    ASender.UserType = utAnonymousUser);
  LToFile := FTPPathToLocalPath(ARenameToFile,
    ASender.UserType = utAnonymousUser);
  if not RenameFile(LFromFile, LToFile) then
  begin
    raise Exception.Create('Can not rename ' + ARenameFromFile + ' to ' +
      ARenameToFile);
  end;
end;

procedure TFTPServerApp.ftpsrvOnRetrieveFile(ASender: TIdFTPServerContext;
  const AFileName: TIdFTPFileName; var VStream: TStream);
begin
  try
    VStream := TFileStream.Create(FTPPathToLocalPath(AFileName,
      ASender.UserType = utAnonymousUser), fmOpenRead);
  except
    FileNotFound(AFileName);
  end;
end;

procedure TFTPServerApp.ftpsrvOnSetModFileDate(ASender: TIdFTPServerContext;
  const AFileName: TIdFTPFileName; var AFileTime: TDateTime);
begin
  if ASender.UserType = utAnonymousUser then
  begin
    PermissionDenied;
  end;
  if not SetFileLastModifiedDateTime(FTPPathToLocalPath(AFileName,
    ASender.UserType = utAnonymousUser), DateTimeToFileDate(AFileTime)) then
  begin
    FileNotFound(AFileName);
  end;
end;

procedure TFTPServerApp.ftpsrvOnSiteUTIME(ASender: TIdFTPServerContext;
  const AFileName: TIdFTPFileName; var VLastAccessTime, VLastModTime,
  VCreateDate: TDateTime; var VAUth: Boolean);
var
  LPath: String;
begin
  if ASender.UserType = utAnonymousUser then
  begin
    PermissionDenied;
  end;
  LPath := FTPPathToLocalPath(AFileName, ASender.UserType = utAnonymousUser);
  if VLastAccessTime <> 0 then
  begin
    if not SetFileLastAccessDateTime(LPath, VLastAccessTime) then
    begin
      FileNotFound(AFileName);
    end;
  end;
  if VLastModTime <> 0 then
  begin
    if not SetFileLastModifiedDateTime(LPath, VLastModTime) then
    begin
      FileNotFound(AFileName);
    end;
  end;
  if VCreateDate <> 0 then
  begin
    if not SetFileCreationDateTime(LPath, VCreateDate) then
    begin
      FileNotFound(AFileName);
    end;
  end;
end;

procedure TFTPServerApp.ftpsrvOnSetCreationFileDate
  (ASender: TIdFTPServerContext; const AFileName: TIdFTPFileName;
  var AFileTime: TDateTime);
begin
  if ASender.UserType = utAnonymousUser then
  begin
    PermissionDenied;
  end;
  if not SetFileCreationDateTime(FTPPathToLocalPath(AFileName,
    ASender.UserType = utAnonymousUser), AFileTime) then
  begin
    FileNotFound(AFileName);
  end;
end;

procedure TFTPServerApp.ftpsrvOnStoreFile(ASender: TIdFTPServerContext;
  const AFileName: TIdFTPFileName; AAppend: Boolean; var VStream: TStream);
begin
  if ASender.UserType = utAnonymousUser then
  begin
    PermissionDenied;
  end;
  try
    if AAppend then
    begin
      VStream := TFileStream.Create(FTPPathToLocalPath(AFileName,
        ASender.UserType = utAnonymousUser), fmOpenReadWrite);
      VStream.Seek(0, soFromEnd);
    end
    else
    begin
      VStream := TFileStream.Create(FTPPathToLocalPath(AFileName,
        ASender.UserType = utAnonymousUser), fmCreate);
    end;
  except
    raise Exception.Create('Can not upload ' + AFileName);
  end;
end;

procedure TFTPServerApp.ioOnGetPasswordEx(ASender: TObject;
  var VPassword: String; const AIsWrite: Boolean; var VOk: Boolean);
var
  Lini: TIniFile;
begin
  Lini := TIniFile.Create(GetCurrentDir + '\server.ini');
  try
    VPassword := Lini.ReadString('Certificate', 'Password', 'testinfg');
    VOk := VPassword <> '';
  finally
    FreeAndNil(Lini);
  end;
end;

procedure TFTPServerApp.ftpsrvOnLogin(ASender: TIdFTPServerContext;
  const AUsername, APassword: string; var AAuthenticated: Boolean);
{ var
  Lini: TIniFile; }
begin
  if ASender.UserType = utNormalUser then
  begin
    AAuthenticated := ConnectAs(AUsername, APassword);
  end
  else
  begin
    AAuthenticated := True;
  end;
end;

begin
  app := nil;
  try
    try
      app := TFTPServerApp.Create;
      WriteLn(OpenSSLVersion);
      WriteLn('FTP Server App');
    except
      on E: Exception do
        WriteLn(E.ClassName, ': ', E.Message);
    end;
    ReadLn;
  finally
    FreeAndNil(app);
  end;

end.

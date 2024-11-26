unit taurusftp_unit;

{$I TaurusTLSCompilerDefines.inc}

interface

uses
{$IFDEF UNIX}
{$IFDEF FPC}
  cthreads,
{$ENDIF}
{$ENDIF}
  Classes,
  SysUtils,
{$IFDEF FPC}
  CustApp,
{$ENDIF}
  {you can add units after this}
  IdCompressorZLib,
  IdExplicitTLSClientServerBase,
  IdFTP,
  IdFTPCommon,
  IdGlobal,
  IdLogEvent,
  IdZLibHeaders,
  TaurusTLS;

type

  { TFTPApplication }

{$IFDEF FPC}
  TFTPApplication = class(TCustomApplication)
{$ELSE}
  TFTPApplication = class(TObject)
{$ENDIF}
  protected
    FFTP: TIdFTP;
    FComp: TIdCompressorZLib;
    FIO: TTaurusTLSIOHandlerSocket;
    FLog: TIdLogEvent;
    // log events
    procedure OnReceived(ASender: TComponent; const AText, AData: string);
    procedure OnSent(ASender: TComponent; const AText, AData: string);
    procedure OnSSLNegotiated(ASender: TTaurusTLSIOHandlerSocket);

    procedure Open;
    procedure CmdOpen(const ACmd: string);
    procedure CmdDir(const ACmd: string);
    procedure CmdPwd;
    procedure CmdCd(const ACmd: string);
    procedure CmdCdUp;
    procedure CmdPassive(const ACmd: string);
    procedure CmdGet(const ACmd: string);
    procedure CmdPut(const ACmd: string);
    procedure CmdRename(const ACmd: string);
    procedure CmdDelete(const ACmd: string);
    procedure CmdRmdir(const ACmd: string);
    procedure CmdMkdir(const ACmd: string);
    procedure CmdLPwd;
    procedure CmdLCd(const ACmd: string);
    procedure CmdLDir(const ACmd: string);
    procedure CmdClose;
    procedure CmdHelp(const ACmd: string);
    procedure CmdStatus;
    procedure DoCommands;
{$IFDEF FPC}
    procedure DoRun; override;
{$ELSE}
    procedure DoRun;
{$ENDIF}
  public
{$IFDEF FPC}
    constructor Create(TheOwner: TComponent); override;
{$ELSE}
    constructor Create;
{$ENDIF}
    destructor Destroy; override;
{$IFDEF FPC}
    procedure WriteHelp; virtual;
{$ENDIF}
  end;

implementation

const
  Prog_Cmds: array of string = ['exit', 'quit',
    'open',
    'dir',
    'pwd',
    'cd', 'cwd',
    'cdup',
    'passive',
    'put',
    'get',
    'rename', 'ren',
    'delete', 'del',
    'md', 'mkdir',
    'rd','rmdir',
    'lpwd',
    'lcd',
    'ldir',
    'close',
    'help', '?',
    'status'];

  { TFTPApplication }

procedure TFTPApplication.OnReceived(ASender: TComponent;
  const AText, AData: string);
begin
  WriteLn(TrimRight(AData));
end;

procedure TFTPApplication.OnSent(ASender: TComponent;
  const AText, AData: string);
begin
  if IndyPos('PASS ', AData) > 0 then
  begin
    WriteLn('PASS ***');
  end
  else
  begin
    WriteLn(TrimRight(AData));
  end;
end;

procedure TFTPApplication.OnSSLNegotiated(ASender: TTaurusTLSIOHandlerSocket);
{$IFNDEF USE_INLINE_VAR}
var
  LStr: string;
{$ENDIF}
begin
  if Assigned(ASender.SSLSocket) then
  begin
{$IFDEF USE_INLINE_VAR}
    var
      LStr: string;
{$ENDIF}
    LStr := ASender.SSLSocket.SSLProtocolVersionStr;
    if LStr <> '' then
    begin
      WriteLn('       TLS Version: ' + LStr);
    end;
    if Assigned(ASender.SSLSocket.Cipher) then
    begin
      LStr := ASender.SSLSocket.Cipher.Name;
      if LStr <> '' then
      begin
        WriteLn('       Cipher Name: ' + LStr);
      end;
      LStr := ASender.SSLSocket.Cipher.Description;
      if LStr <> '' then
      begin
        WriteLn('Cipher Description: ' + Trim(LStr));
      end;
      LStr := ASender.SSLSocket.Cipher.Version;
      if LStr <> '' then
      begin
        WriteLn('    Cipher Version: ' + LStr);
      end;
      if ASender.SSLSocket.Cipher.Bits > 0 then
      begin
        WriteLn('       Cipher Bits: ' +
          IntToStr(ASender.SSLSocket.Cipher.Bits));
      end;
    end;
  end;
end;

procedure TFTPApplication.Open;
begin
  FFTP.Connect;
  if FFTP.IsCompressionSupported and FComp.IsReady then
  begin
    FFTP.TransferMode(dmDeflate);
  end;
end;

procedure TFTPApplication.CmdOpen(const ACmd: string);
{$IFNDEF USE_INLINE_VAR}
var
  LCommand, LSubcommand: string;
{$ENDIF}
begin
{$IFDEF USE_INLINE_VAR}
  var
    LCommand, LSubcommand: string;
{$ENDIF}
  LCommand := ACmd;
  LSubcommand := Fetch(LCommand);
  if LSubcommand <> '' then
  begin
    case IdGlobal.PosInStrArray(LSubcommand, ['ftp', 'ftps', 'ftpsi']) of
      0:
        begin
          FFTP.UseTLS := utNoTLSSupport;
          FFTP.Host := Fetch(LCommand);
          FFTP.Username := Fetch(LCommand);
          FFTP.Password := Fetch(LCommand);
          Open;
        end;
      1:
        begin
          FFTP.UseTLS := utUseExplicitTLS;
          FFTP.DataPortProtection := ftpdpsPrivate;
          FFTP.Host := Fetch(LCommand);
          FFTP.Username := Fetch(LCommand);
          FFTP.Password := Fetch(LCommand);
          Open;
        end;
      2:
        begin
          FFTP.UseTLS := utUseImplicitTLS;
          FFTP.DataPortProtection := ftpdpsPrivate;
          FFTP.Host := Fetch(LCommand);
          FFTP.Username := Fetch(LCommand);
          FFTP.Password := Fetch(LCommand);
          Open;
        end
    else
      begin
        FFTP.UseTLS := utNoTLSSupport;
        FFTP.Host := LSubcommand;
        FFTP.Username := Fetch(LCommand);
        FFTP.Password := Fetch(LCommand);
        Open;
      end;
    end;
  end;
end;

procedure TFTPApplication.CmdDir(const ACmd: string);
var
  i: integer;
begin
  if FFTP.Connected then
  begin
    if Trim(ACmd) <> '' then
    begin
      FFTP.List(Trim(ACmd));
    end
    else
    begin
      FFTP.List;
    end;
    for i := 0 to FFTP.ListResult.Count - 1 do
    begin
      WriteLn(FFTP.ListResult[i]);
    end;
  end
  else
  begin
    WriteLn('Must be connected to use this command');
  end;
end;

procedure TFTPApplication.CmdPwd;
begin
  if FFTP.Connected then
  begin
    FFTP.RetrieveCurrentDir;
  end
  else
  begin
    WriteLn('Must be connected to use this command');
  end;
end;

procedure TFTPApplication.CmdCd(const ACmd: string);
begin
  if FFTP.Connected then
  begin
    FFTP.ChangeDir(Trim(ACmd));
  end
  else
  begin
    WriteLn('Must be connected to use this command');
  end;
end;

procedure TFTPApplication.CmdCdUp;
begin
  if FFTP.Connected then
  begin
    FFTP.ChangeDirUp;
  end
  else
  begin
    WriteLn('Must be connected to use this command');
  end;
end;

procedure TFTPApplication.CmdPassive(const ACmd: string);
{$IFNDEF USE_INLINE_VAR}
var
  LSubcommand: string;
{$ENDIF}
begin
{$IFDEF USE_INLINE_VAR}
  var
    LSubcommand: String;
{$ENDIF}
  LSubcommand := Trim(ACmd);
  LSubcommand := Fetch(LSubcommand);
  case PosInStrArray(LSubcommand, ['on', 'true', 'off', 'false']) of
    0, 1:
      FFTP.Passive := True;
    2, 3:
      FFTP.Passive := False;
  else
    begin
      FFTP.Passive := not FFTP.Passive;
    end;
  end;
  if FFTP.Passive then
  begin
    WriteLn('Passive: True');
  end
  else
  begin
    WriteLn('Passive: False');
  end;
end;

procedure TFTPApplication.CmdGet(const ACmd: string);
var
{$IFNDEF USE_INLINE_VAR}
  LPath: string;
{$ENDIF}
  LDestFile: TStream;
begin
{$IFDEF USE_INLINE_VAR}
  var
    LPath: String;
{$ENDIF}
  LPath := Trim(ACmd);
  try
    FFTP.TransferType := ftBinary;
    LDestFile := TFileStream.Create(LPath, fmCreate);
    try
      FFTP.Get(ExtractFileName(LPath), LDestFile);
    finally
      FreeAndNil(LDestFile);
    end;
    FileSetDate(LPath,
      DateTimeToFileDate(FFTP.FileDate(ExtractFileName(LPath))));
  except
  end;
end;

function LeftJustify(const AText: String; ALen: integer): string;
begin
  Result := '';
  if ALen > Length(AText) then
  begin
    Result := AText + StringOfChar(' ', ALen - Length(AText));
  end
  else
  begin
    Result := AText;
  end;
end;

procedure TFTPApplication.CmdPut(const ACmd: string);
var
{$IFNDEF USE_INLINE_VAR}
  LPath: string;
{$ENDIF}
  LSrcFile: TStream;
{$IFNDEF FPC}
  LDateTime: TDateTime;
{$ENDIF}
begin
{$IFDEF USE_INLINE_VAR}
  var
    LPath: string;
{$ENDIF}
  LPath := Trim(ACmd);
  try
    FFTP.TransferType := ftBinary;
    LSrcFile := TFileStream.Create(LPath, fmOpenRead);
    try
      FFTP.Put(LSrcFile, ExtractFileName(LPath));
    finally
      FreeAndNil(LSrcFile);
    end;
{$IFDEF FPC}
    FFTP.SetModTime(ExtractFileName(LPath), FileDateToDateTime(FileAge(LPath)));
{$ELSE}
    if FileAge(LPath, LDateTime) then
    begin
      FFTP.SetModTime(ExtractFileName(LPath), LDateTime);
    end;
{$ENDIF}
  except
  end;
end;

procedure TFTPApplication.CmdRename(const ACmd: string);
{$IFNDEF USE_INLINE_VAR}
var
  LOldName, LNewName, LSubcommand: String;
{$ENDIF}
begin
{$IFDEF USE_INLINE_VAR}
  var
    LOldName, LNewName, LSubcommand: String;
{$ENDIF}
  LSubcommand := Trim(ACmd);
  LOldName := Fetch(LSubcommand);
  LNewName := Fetch(LSubcommand);
  FFTP.Rename(LOldName, LNewName);
end;

procedure TFTPApplication.CmdDelete(const ACmd: string);
begin
  FFTP.delete(Trim(ACmd));
end;

procedure TFTPApplication.CmdRmdir(const ACmd: string);
begin
  FFTP.RemoveDir(Trim(ACmd));
end;

procedure TFTPApplication.CmdStatus;
var LStr : TStrings;
begin
  LStr := TStringList.Create;
  try
    FFTP.Status(LStr);
    WriteLn(LStr.Text);
  finally
    FreeAndNil(LStr);
  end;
end;

procedure TFTPApplication.CmdMkdir(const ACmd: string);
begin
  FFTP.makedir(Trim(ACmd));
end;

procedure TFTPApplication.CmdLPwd;
begin
  WriteLn('Local directory is ' + GetCurrentDir);
end;

procedure TFTPApplication.CmdLCd(const ACmd: string);
begin
  if Trim(ACmd) <> '' then
  begin
    SetCurrentDir(Trim(ACmd));
    WriteLn('Local directory now ' + GetCurrentDir);
  end;
end;

procedure TFTPApplication.CmdLDir(const ACmd: string);
var
  LRec: TSearchRec;
{$IFNDEF USE_INLINE_VAR}
  LSize: string;
{$ENDIF}
begin
  if FindFirst(Trim(ACmd) + '*.*', faAnyFile, LRec) = 0 then
  begin
{$IFDEF USE_INLINE_VAR}
    var
      LSize: string;
{$ENDIF}
    repeat
      if LRec.Attr and faDirectory <> 0 then
      begin
        LSize := '<DIR>';
      end
      else
      begin
        LSize := IntToStr(LRec.Size);
      end;
      WriteLn(Format('%10s %10s %20s %s', [TimeToStr(LRec.TimeStamp),
        TimeToStr(LRec.TimeStamp), LSize, LRec.Name]));
    until FindNext(LRec) <> 0;
    FindClose(LRec);
  end;
end;

procedure TFTPApplication.CmdClose;
begin
  FFTP.Disconnect;
end;

procedure PrintCmdHelp(const ACmd: array of string;
  const AHelpDescription: string; ASyntaxRef: string = '');
var
  i: integer;
{$IFNDEF USE_INLINE_VAR}
  LCmds: string;
{$ENDIF}
begin
{$IFDEF USE_INLINE_VAR}
  var
    LCmds: string;
{$ENDIF}
  for i := 0 to High(ACmd) do
  begin
    LCmds := LCmds + ' ' + ACmd[i];
  end;
  LCmds := TrimLeft(LCmds);
  WriteLn(LeftJustify(LCmds, 20) + ' - ' + AHelpDescription);
  if ASyntaxRef <> '' then
  begin
    WriteLn('');
    WriteLn('Command Syntax:');
    WriteLn('');
    WriteLn(ASyntaxRef);
  end;
end;

procedure TFTPApplication.CmdHelp(const ACmd: string);
{$IFNDEF USE_INLINE_VAR}
var
  LCmd, LSubcommand: String;
{$ENDIF}
begin
{$IFDEF USE_INLINE_VAR}
  var
    LCmd, LSubcommand: String;
{$ENDIF}
  LCmd := Trim(ACmd);
  if LCmd = '' then
  begin
    PrintCmdHelp(['?', 'help'], 'Prints help screen or command syntax');
    PrintCmdHelp(['cd', 'cwd'], 'Change remote directory');
    PrintCmdHelp(['cdup'], 'Change remote directory up a level');
    PrintCmdHelp(['close'], 'Terminate ftp session');
    PrintCmdHelp(['del', 'delete'], 'Delete remote file');
    PrintCmdHelp(['dir'], 'List contents of remote directory');
    PrintCmdHelp(['exit', 'quit'], 'Terminate ftp session and exit');
    PrintCmdHelp(['get'], 'Receive file');
    PrintCmdHelp(['lcd'], 'Change local working directory');
    PrintCmdHelp(['ldir'], 'List contents of local directory');
    PrintCmdHelp(['lpwd'], 'Print local working directory');
    PrintCmdHelp(['mkdir'],'Make directory on the remote machine');
    PrintCmdHelp(['open'],'Connect to remote ftp');
    PrintCmdHelp(['passive'],'Toggle use of passive transfer mode');
    PrintCmdHelp(['put'],'Send one file');
    PrintCmdHelp(['pwd'],'Print working directory on remote machine');
    PrintCmdHelp(['rd','rmdir'],'Remove directory on the remote machine');
    PrintCmdHelp(['rename','ren'],'Rename remote file');
    PrintCmdHelp(['status'],'Show current status');
  end
  else
  begin
    LSubcommand := Fetch(LCmd);
    case IdGlobal.PosInStrArray(Fetch(LSubcommand), Prog_Cmds) of
      0, 1:
        begin
          PrintCmdHelp(['exit', 'quit'],
            'Terminate ftp session and exit', 'exit');
        end;
      2:
        begin
          PrintCmdHelp(['open'],'Connect to remote ftp','open [protocol] host username password');
          WriteLn('');
          WriteLn('the protocol value may be:');
          WriteLn('');
          WriteLn('ftp   - File Transfer Protocol');
          WriteLn('ftps  - File Transfer Protocol with TLS');
          WriteLn('ftpsi - File Transfer Protocol with Implicit TLS');
        end;
      3:
        begin
          PrintCmdHelp(['dir'], 'List contents of remote directory',
            'dir [remote_path]');
        end;
      4:
        begin
          PrintCmdHelp(['pwd'],'Print working directory on remote machine','pwd');
        end;
      5:
        begin
          PrintCmdHelp(['cd', 'cwd'], 'Change remote directory',
            'cd remote_path');
        end;
      7:
        begin
          PrintCmdHelp(['cdup'], 'Change remote directory up a level', 'cdup')
        end;
      8:
        begin
          PrintCmdHelp(['passive'],'Toggle use of passive transfer mode','passive [state]');
          WriteLn('');
          WriteLn('The state value may be one of these:');
          WriteLn('');
          WriteLn('on    - Passive mode on (use PASV/EPSV data transfers)');
          WriteLn('off   - Passive mode off (use PORT/EPRT data transfers)');
          WriteLn('true  - Passive mode on (use PASV/EPSV data transfers)');
          WriteLn('false - Passive mode off (use PORT/EPRT data transfers)');
        end;
      9:
        begin
          PrintCmdHelp(['put'],'Send one file','put local_filename');
        end;
      10:
        begin
          PrintCmdHelp(['get'], 'Receive file', 'get local_filename');
        end;
      11, 12:
        begin
          PrintCmdHelp(['rename','ren'],'Rename remote file','rename old_filename new_filename');
        end;
      13, 14:
        begin
          PrintCmdHelp(['del', 'delete'], 'Delete remote file',
            'delete remote_filename');
        end;
      15, 16:
        begin
          PrintCmdHelp(['md','mkdir'],'Make directory on the remote machine','mkdir remote_dirname');
        end;
      17, 18:
        begin
          PrintCmdHelp(['rmdir','rd'],'Remove directory on the remote machine','rmdir remote_dirname');
        end;
      19:
        begin
          PrintCmdHelp(['lpwd'], 'Print local working directory','lpwd');
        end;
      20:
        begin
          PrintCmdHelp(['lcd'], 'Change local working directory',
            'lcd local_dirname');
        end;
      21:
        begin
          PrintCmdHelp(['ldir'],'List contents of local directory','ldir [local_path]');
        end;
      22:
        begin
          PrintCmdHelp(['close'], 'Terminate ftp session', 'close');
        end;
      23, 24:
        begin
          PrintCmdHelp(['?', 'help'], 'Prints help screen or command syntax',
            'help [command]');
        end;
      25 : begin
        PrintCmdHelp(['status'],'Show current status','status');
      end;
    end;
  end;
end;

procedure TFTPApplication.DoCommands;
{$IFNDEF USE_INLINE_VAR}
var
  LCmd: string;
{$ENDIF}
begin
{$IFDEF USE_INLINE_VAR}
  var
    LCmd: string;
{$ENDIF}
  repeat
    Write('ftp: ');
    ReadLn(LCmd);
    case IdGlobal.PosInStrArray(Fetch(LCmd), Prog_Cmds) of
      // 'exit', 'quit'
      0,1: break;
      // 'open',
      2: CmdOpen(LCmd);
      // 'dir',
      3: CmdDir(LCmd);
      // 'pwd',
      4: CmdPwd;
      // 'cd', 'cwd',
      5, 6 : CmdCd(LCmd);
      //'cdup',
      7 : CmdCdUp;
      // 'passive',
      8 : CmdPassive(LCmd);
      // 'put',
      9 : CmdPut(LCmd);
      // 'get',
      10 : CmdGet(LCmd);
      // 'rename', 'ren',
      11, 12 : CmdRename(LCmd);
      // 'delete', 'del',
      13, 14 : CmdDelete(LCmd);
      // 'md', 'mkdir',
      15, 16 : CmdMkdir(LCmd);
      // 'rd','rmdir',
      17, 18 : CmdRmdir(LCmd);
      // 'lpwd',
      19 : CmdLPwd;
      //'lcd',
      20 : CmdLCd(LCmd);
      //'ldir',
      21 : CmdLDir(LCmd);
      //'close',
      22 : CmdClose;
      //'help', '?'];
      23, 24:
      CmdHelp(LCmd);
      //'status'
      25 :
      CmdStatus;
    else
      WriteLn('Bad Command');
    end;
  until False;
end;

procedure TFTPApplication.DoRun;
{$IFDEF FPC}
var
  ErrorMsg: string;

begin
  // quick check parameters
  ErrorMsg := CheckOptions('h', 'help');
  if ErrorMsg <> '' then
  begin
    ShowException(Exception.Create(ErrorMsg));
    Terminate;
    Exit;
  end;

  // parse parameters
  if HasOption('h', 'help') then
  begin
    WriteHelp;
    Terminate;
    Exit;
  end;
{$ELSE}

begin
{$ENDIF}
  { add your program here }
  WriteLn('TaurusFTP Console Demo');
  WriteLn('Copyright (c) 2024 TaurusTLS Developers');
  WriteLn(' OpenSSL Version: ' + OpenSSLVersion);
  WriteLn('    ZLib Version: ' + zlibVersion());
  DoCommands;
{$IFDEF FPC}
  // stop program loop
  Terminate;
{$ENDIF}
end;

{$IFDEF FPC}

constructor TFTPApplication.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
{$ELSE}

constructor TFTPApplication.Create;
begin
{$ENDIF}
  FFTP := TIdFTP.Create(nil);
  FComp := TIdCompressorZLib.Create(nil);
  FFTP.Compressor := FComp;
  FIO := TTaurusTLSIOHandlerSocket.Create(nil);
  FIO.OnSSLNegotiated := OnSSLNegotiated;
  FFTP.IOHandler := FIO;
  FFTP.Passive := True;
  FLog := TIdLogEvent.Create(nil);
  FLog.LogTime := False;
  FLog.ReplaceCRLF := False;
  FLog.OnReceived := OnReceived;
  FLog.OnSent := OnSent;
  FLog.Active := True;
  FIO.Intercept := FLog;
{$IFDEF FPC}
  StopOnException := True;
{$ENDIF}
end;

destructor TFTPApplication.Destroy;
begin
  if FFTP.Connected then
  begin
    FFTP.Disconnect;
  end;
  FreeAndNil(FLog);
  FreeAndNil(FIO);
  FreeAndNil(FComp);
  FreeAndNil(FFTP);
  inherited Destroy;
end;

{$IFDEF FPC}

procedure TFTPApplication.WriteHelp;
begin
  { add your help code here }
  WriteLn('Usage: ', ExeName, ' -h');
end;
{$ENDIF}

var
  Application: TFTPApplication;

initialization

{$IFDEF FPC}
  Application := TFTPApplication.Create(nil);
Application.Title := 'TaurusFTP Console';
Application.Run;
{$ELSE}
  Application := TFTPApplication.Create;
try

  Application.DoRun;
except
  on E: Exception do
  begin
    WriteLn(E.Message);
    ReadLn;
  end;
end;
{$ENDIF}
Application.Free;

end.

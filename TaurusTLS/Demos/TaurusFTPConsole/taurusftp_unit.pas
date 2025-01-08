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
  IdCTypes,
  IdCompressorZLib,
  IdExplicitTLSClientServerBase,
  IdFTP,
  IdFTPCommon,
  IdGlobal,
  IdLogEvent,
  IdZLibHeaders,
  TaurusTLS,
  TaurusTLSHeaders_ossl_typ;

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
    procedure OnDebugMsg(ASender: TObject; const AWrite: Boolean;
      AVersion: TTaurusMsgCBVer; AContentType: TIdC_INT; buf: TIdBytes;
      SSL: PSSL);
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
    procedure CmdDebugInfo;
    procedure CmdAbout;
    procedure CmdQuote(const ACmd: string);
    procedure CmdDebugTrace(const ACmd: string);
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

uses
  TaurusTLSHeaders_ssl3;

const
  Prog_Cmds: array of string = ['exit', 'quit', 'open', 'dir', 'pwd', 'cd',
    'cwd', 'cdup', 'passive', 'put', 'get', 'rename', 'ren', 'delete', 'del',
    'md', 'mkdir', 'rd', 'rmdir', 'lpwd', 'lcd', 'ldir', 'close', 'help', '?',
    'status', 'debug-info', 'about', 'quote', 'debug-trace'];

procedure ParseArgs(const AArgs: String; AStrings: TStrings);
var
{$IFNDEF USE_INLINE_VAR}
  LBuf, LArg: String;
{$ENDIF}
  LOpenQuote: Integer;
begin
  AStrings.BeginUpdate;
  try
    AStrings.Clear;
{$IFDEF USE_INLINE_VAR}
    var
      LBuf, LArg: String;
{$ENDIF}
    LBuf := AArgs;
    repeat
      LBuf := TrimLeft(LBuf);
      if LBuf = '' then
      begin
        Break;
      end;
      LOpenQuote := IndyPos('"', LBuf);
      if (LOpenQuote = 1) then
      begin
        Fetch(LBuf, '"');
        LArg := Fetch(LBuf, '"');
      end
      else
      begin
        LArg := TrimLeft(Fetch(LBuf));
      end;
      AStrings.Add(LArg);
    until False;
  finally
    AStrings.EndUpdate;
  end;
end;

{ TFTPApplication }

procedure TFTPApplication.OnDebugMsg(ASender: TObject; const AWrite: Boolean;
  AVersion: TTaurusMsgCBVer; AContentType: TIdC_INT; buf: TIdBytes; SSL: PSSL);
{$IFNDEF USE_INLINE_VAR}
LOutput:
String;
{$ENDIF}
begin
{$IFDEF USE_INLINE_VAR}
  var
    LOutput: String;
{$ENDIF}
  if AWrite then
  begin
    LOutput := 'Read  - ';
  end
  else
  begin
    LOutput := 'Write - ';
  end;
  case AVersion of
    verSSL3Header:
      LOutput := LOutput + 'SSL3     - ';
    verTLS1:
      LOutput := LOutput + 'TLS1     - ';
    verTLS1_1:
      LOutput := LOutput + 'TLS1.1   - ';
    verTLS1_2:
      LOutput := LOutput + 'TLS1.2   - ';
    verTLS1_3:
      LOutput := LOutput + 'TLS1.3   - ';
    verDTLS1:
      LOutput := LOutput + 'DTLS1.1  - ';
    verDTLS1_2:
      LOutput := LOutput + 'DTLS1.2  - ';
    verDTLSBadVer:
      LOutput := LOutput + 'Bad DTLS - ';
    verQUIC:
      LOutput := LOutput + 'QUIC     - ';
    verTLSAny:
      LOutput := LOutput + 'Any TLS  - ';
  end;
  case AContentType of
    SSL3_RT_CHANGE_CIPHER_SPEC:
      LOutput := LOutput + 'Change Cipher Spec    - ';
    SSL3_RT_ALERT:
      LOutput := LOutput + 'Alert                 - ';
    SSL3_RT_HANDSHAKE:
      LOutput := LOutput + 'Handshake             - ';
    SSL3_RT_APPLICATION_DATA:
      LOutput := LOutput + 'Application Data      - ';
    DTLS1_RT_HEARTBEAT:
      LOutput := LOutput + 'Heartbeat             - ';
    (* Pseudo content types to indicate additional parameters *)
    TLS1_RT_CRYPTO:
      LOutput := LOutput + 'Crypto                - ';
    TLS1_RT_CRYPTO_PREMASTER:
      LOutput := LOutput + 'Crypto Premaster      - ';
    TLS1_RT_CRYPTO_CLIENT_RANDOM:
      LOutput := LOutput + 'Crypto Client Random  - ';
    TLS1_RT_CRYPTO_SERVER_RANDOM:
      LOutput := LOutput + 'Crypto Server Random  - ';
    TLS1_RT_CRYPTO_MASTER:
      LOutput := LOutput + 'Crypto Master         - ';
//    TLS1_RT_CRYPTO_READ:
//      LOutput := LOutput + 'Crypto Read         - ';
//    TLS1_RT_CRYPTO_WRITE:
//      LOutput := LOutput + 'Crypto Write        - ';
    TLS1_RT_CRYPTO_MAC:
      LOutput := LOutput + 'Crypto MAC            - ';
    TLS1_RT_CRYPTO_KEY:
      LOutput := LOutput + 'Crypto Key            - ';
    TLS1_RT_CRYPTO_IV:
      LOutput := LOutput + 'Crypto IV             - ';
    TLS1_RT_CRYPTO_FIXED_IV:
      LOutput := LOutput + 'Crypto Fixed IV       - ';

    (* Pseudo content types for SSL/TLS header info *)
    SSL3_RT_HEADER:
      LOutput := LOutput + 'Header                - ';
    SSL3_RT_INNER_CONTENT_TYPE:
      LOutput := LOutput + 'Inner Content Type ' + IntToHex(buf[0]) + ' - ';

    // * Pseudo content types for QUIC */
    SSL3_RT_QUIC_DATAGRAM:
      LOutput := LOutput + 'QUIC Datagram          - ';
    SSL3_RT_QUIC_PACKET:
      LOutput := LOutput + 'QUIC Packet            - ';
    SSL3_RT_QUIC_FRAME_FULL:
      LOutput := LOutput + 'QUIC Frame Full        - ';
    SSL3_RT_QUIC_FRAME_HEADER:
      LOutput := LOutput + 'QUIC Frame Header      - ';
    SSL3_RT_QUIC_FRAME_PADDING:
      LOutput := LOutput + 'QUIC Frame Padding     - ';
  end;
  LOutput := LOutput + IntToStr(Length(Buf));
  WriteLn(LOutput);
end;

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
var
  LCmdParams: TStrings;
begin
  LCmdParams := TStringList.Create;
  try
    ParseArgs(ACmd, LCmdParams);
    if LCmdParams.Count >= 3 then
    begin
      case IdGlobal.PosInStrArray(LCmdParams[0],
        ['ftp', 'ftps', 'ftpsi'], False) of
        0:
          begin
            FFTP.UseTLS := utNoTLSSupport;
            if LCmdParams.Count > 3 then
            begin
              FFTP.Host := LCmdParams[1];
              FFTP.Username := LCmdParams[2];
              FFTP.Password := LCmdParams[3];
              Open;
            end
            else
            begin
              WriteLn('Syntax Error');
            end;
          end;
        1:
          begin
            FFTP.UseTLS := utUseExplicitTLS;
            FFTP.DataPortProtection := ftpdpsPrivate;
            if LCmdParams.Count > 3 then
            begin
              FFTP.Host := LCmdParams[1];
              FFTP.Username := LCmdParams[2];
              FFTP.Password := LCmdParams[3];
              Open;
            end
            else
            begin
              WriteLn('Syntax Error');
            end;
          end;
        2:
          begin
            FFTP.UseTLS := utUseImplicitTLS;
            FFTP.DataPortProtection := ftpdpsPrivate;
            if LCmdParams.Count > 3 then
            begin
              FFTP.Host := LCmdParams[1];
              FFTP.Username := LCmdParams[2];
              FFTP.Password := LCmdParams[3];
              Open;
            end
            else
            begin
              WriteLn('Syntax Error');
            end;
          end
      else
        begin
          FFTP.UseTLS := utNoTLSSupport;
          FFTP.Host := LCmdParams[0];
          FFTP.Username := LCmdParams[1];
          FFTP.Password := LCmdParams[2];
          Open;
        end;
      end;
    end
    else
    begin
      WriteLn('Syntax Error');
    end;
  finally
    FreeAndNil(LCmdParams);
  end;
end;

procedure TFTPApplication.CmdDir(const ACmd: string);
var
  i: Integer;
  LDir: TStringList;
begin
  LDir := TStringList.Create;
  try
    ParseArgs(Trim(ACmd), LDir);
    if FFTP.Connected then
    begin
      if LDir.Count > 0 then
      begin
        FFTP.List(LDir[0]);
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
  finally
    FreeAndNil(LDir);
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

procedure TFTPApplication.CmdQuote(const ACmd: string);
begin
  if TrimLeft(ACmd) <> '' then
  begin
    if FFTP.Connected then
    begin
      FFTP.Quote(TrimLeft(ACmd));
    end
    else
    begin
      WriteLn('Must be connected to use this command');
    end;
  end
  else
  begin
    WriteLn('Syntax Error');
  end;
end;

procedure TFTPApplication.CmdAbout;
begin
  WriteLn('TaurusFTP Console Demo');
  WriteLn('Copyright (c) 2024 TaurusTLS Developers');
end;

procedure TFTPApplication.CmdCd(const ACmd: string);
var
  LDir: TStringList;
begin
  LDir := TStringList.Create;
  try
    ParseArgs(Trim(ACmd), LDir);
    if LDir.Count > 0 then
    begin
      if FFTP.Connected then
      begin
        FFTP.ChangeDir(LDir[0]);
      end
      else
      begin
        WriteLn('Must be connected to use this command');
      end;
    end
    else
    begin
      WriteLn('Syntax Error');
    end;
  finally
    FreeAndNil(LDir);
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
var
  LCmdParams: TStrings;
begin
  LCmdParams := TStringList.Create;
  try
    ParseArgs(ACmd, LCmdParams);
    if LCmdParams.Count > 0 then
    begin
      case PosInStrArray(LCmdParams[0], ['on', 'true', 'off', 'false'],
        False) of
        0, 1:
          FFTP.Passive := True;
        2, 3:
          FFTP.Passive := False;
      else
        begin
          FFTP.Passive := not FFTP.Passive;
        end;
      end;
    end
    else
    begin
      FFTP.Passive := not FFTP.Passive;
    end;
    if FFTP.Passive then
    begin
      WriteLn('Passive: True');
    end
    else
    begin
      WriteLn('Passive: False');
    end;
  finally
    FreeAndNil(LCmdParams);
  end;
end;

procedure TFTPApplication.CmdGet(const ACmd: string);
var
  LCmdParams: TStrings;
  LDestFile: TStream;
begin
  LCmdParams := TStringList.Create;
  try
    ParseArgs(ACmd, LCmdParams);
    if LCmdParams.Count > 0 then
    begin

      FFTP.TransferType := ftBinary;
      LDestFile := TFileStream.Create(LCmdParams[0], fmCreate);
      try
        FFTP.Get(ExtractFileName(LCmdParams[0]), LDestFile);
      finally
        FreeAndNil(LDestFile);
      end;
      FileSetDate(LCmdParams[0],
        DateTimeToFileDate(FFTP.FileDate(ExtractFileName(LCmdParams[0]))));
    end
    else
    begin
      WriteLn('Syntax Error');
    end;
  finally
    FreeAndNil(LCmdParams);
  end;
end;

function LeftJustify(const AText: String; ALen: Integer): string;
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
  LSrcFile: TStream;
{$IFNDEF FPC}
  LDateTime: TDateTime;
{$ENDIF}
  LCmdParams: TStrings;
begin
  LCmdParams := TStringList.Create;
  try
    ParseArgs(ACmd, LCmdParams);
    if LCmdParams.Count > 0 then
    begin

      FFTP.TransferType := ftBinary;
      LSrcFile := TFileStream.Create(LCmdParams[0], fmOpenRead);
      try
        FFTP.Put(LSrcFile, ExtractFileName(LCmdParams[0]));
      finally
        FreeAndNil(LSrcFile);
      end;
{$IFDEF FPC}
      FFTP.SetModTime(ExtractFileName(LCmdParams[0]),
        FileDateToDateTime(FileAge(LCmdParams[0])));
{$ELSE}
      if FileAge(LCmdParams[0], LDateTime) then
      begin
        FFTP.SetModTime(ExtractFileName(LCmdParams[0]), LDateTime);
      end;
{$ENDIF}
    end;
  finally
    FreeAndNil(LCmdParams);
  end;
end;

procedure TFTPApplication.CmdRename(const ACmd: string);
var
  LCmdParams: TStrings;
begin
  LCmdParams := TStringList.Create;
  try
    ParseArgs(ACmd, LCmdParams);
    if LCmdParams.Count > 1 then
    begin
      FFTP.Rename(LCmdParams[0], LCmdParams[1]);
    end
    else
    begin
      WriteLn('Syntax Error');
    end;
  finally
    FreeAndNil(LCmdParams);
  end;
end;

procedure TFTPApplication.CmdDebugInfo;
begin
{$IFNDEF FPC}
  WriteLn('Operating System: ' + TOSVersion.ToString);
  WriteLn('     RTL Version: ' + IntToStr(Hi(GetRTLVersion)) + '.' +
    IntToStr(Lo(GetRTLVersion)));
{$ENDIF}
  WriteLn('    Indy Version: ' + gsIdVersion);
  WriteLn(' OpenSSL Version: ' + OpenSSLVersion);
  if IdZLibHeaders.Load then
  begin
    WriteLn('    ZLib Version: ' + zlibVersion());
  end;
end;

procedure TFTPApplication.CmdDebugTrace(const ACmd: string);
var
  LCmdParams: TStrings;
begin
  LCmdParams := TStringList.Create;
  try
    ParseArgs(ACmd, LCmdParams);
    if LCmdParams.Count > 0 then
    begin
      case PosInStrArray(LCmdParams[0], ['on', 'true', 'off', 'false'],
        False) of
        0, 1:
          FIO.OnDebugMessage := OnDebugMsg;

        2, 3:
          FIO.OnDebugMessage := nil;
      else
        begin
          if Assigned(FIO.OnDebugMessage) then
          begin
            FIO.OnDebugMessage := nil
          end
          else
          begin
            FIO.OnDebugMessage := OnDebugMsg;
          end;
        end;
      end;
    end
    else
    begin
      if Assigned(FIO.OnDebugMessage) then
      begin
        FIO.OnDebugMessage := nil
      end
      else
      begin
        FIO.OnDebugMessage := OnDebugMsg;
      end;
    end;
    if Assigned(FIO.OnDebugMessage) then
    begin
      WriteLn('Debug-trace: True');
    end
    else
    begin
      WriteLn('Debug-trace: False');
    end;
  finally
    FreeAndNil(LCmdParams);
  end;

end;

procedure TFTPApplication.CmdDelete(const ACmd: string);
var
  LCmdParams: TStrings;
begin
  LCmdParams := TStringList.Create;
  try
    ParseArgs(ACmd, LCmdParams);
    if LCmdParams.Count > 0 then
    begin
      FFTP.delete(LCmdParams[0]);
    end
    else
    begin
      WriteLn('Syntax Error');
    end;
  finally
    FreeAndNil(LCmdParams);
  end;
end;

procedure TFTPApplication.CmdRmdir(const ACmd: string);
var
  LCmdParams: TStrings;
begin
  LCmdParams := TStringList.Create;
  try
    ParseArgs(ACmd, LCmdParams);
    if LCmdParams.Count > 0 then
    begin
      FFTP.RemoveDir(LCmdParams[0]);
    end
    else
    begin
      WriteLn('Syntax Error');
    end;
  finally
    FreeAndNil(LCmdParams);
  end;
end;

procedure TFTPApplication.CmdStatus;
var
  LStr: TStrings;
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
var
  LCmdParams: TStrings;
begin
  LCmdParams := TStringList.Create;
  try
    ParseArgs(ACmd, LCmdParams);
    if LCmdParams.Count > 0 then
    begin
      FFTP.makedir(LCmdParams[0]);
    end
    else
    begin
      WriteLn('Syntax Error');
    end;
  finally
    FreeAndNil(LCmdParams);
  end;
end;

procedure TFTPApplication.CmdLPwd;
begin
  WriteLn('Local directory is ' + GetCurrentDir);
end;

procedure TFTPApplication.CmdLCd(const ACmd: string);
var
  LCmdParams: TStrings;
begin
  LCmdParams := TStringList.Create;
  try
    ParseArgs(ACmd, LCmdParams);
    if LCmdParams.Count > 0 then
    begin
      SetCurrentDir(LCmdParams[0]);
      WriteLn('Local directory now ' + GetCurrentDir);
    end
    else
    begin
      WriteLn('Syntax Error');
    end;
  finally
    FreeAndNil(LCmdParams);
  end;
end;

procedure TFTPApplication.CmdLDir(const ACmd: string);
var
  LRec: TSearchRec;
{$IFNDEF USE_INLINE_VAR}
  LSize: string;
  LMask: String;
{$ENDIF}
var
  LCmdParams: TStrings;
begin
  LCmdParams := TStringList.Create;
  try
    ParseArgs(ACmd, LCmdParams);
{$IFDEF USE_INLINE_VAR}
    var
      LMask: string;
{$ENDIF}
    if LCmdParams.Count > 0 then
    begin
      LMask := LCmdParams[0] + '*.*';
    end
    else
    begin
      LMask := '*.*';
    end;

    if FindFirst(LMask, faAnyFile, LRec) = 0 then
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
  finally
    FreeAndNil(LCmdParams);
  end;
end;

procedure TFTPApplication.CmdClose;
begin
  FFTP.Disconnect;
end;

procedure PrintCmdHelp(const ACmd: array of string;
  const AHelpDescription: string; ASyntaxRef: string = '');
var
  i: Integer;
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
    PrintCmdHelp(['about'], 'Show Information about this program');
    PrintCmdHelp(['cd', 'cwd'], 'Change remote directory');
    PrintCmdHelp(['cdup'], 'Change remote directory up a level');
    PrintCmdHelp(['close'], 'Terminate ftp session');
    PrintCmdHelp(['debug-info'], 'Show debugging information');
    PrintCmdHelp(['del', 'delete'], 'Delete remote file');
    PrintCmdHelp(['dir'], 'List contents of remote directory');
    PrintCmdHelp(['exit', 'quit'], 'Terminate ftp session and exit');
    PrintCmdHelp(['get'], 'Receive file');
    PrintCmdHelp(['lcd'], 'Change local working directory');
    PrintCmdHelp(['ldir'], 'List contents of local directory');
    PrintCmdHelp(['lpwd'], 'Print local working directory');
    PrintCmdHelp(['mkdir'], 'Make directory on the remote machine');
    PrintCmdHelp(['open'], 'Connect to remote ftp');
    PrintCmdHelp(['passive'], 'Toggle use of passive transfer mode');
    PrintCmdHelp(['put'], 'Send one file');
    PrintCmdHelp(['pwd'], 'Print working directory on remote machine');
    PrintCmdHelp(['rd', 'rmdir'], 'Remove directory on the remote machine');
    PrintCmdHelp(['rename', 'ren'], 'Rename remote file');
    PrintCmdHelp(['status'], 'Show current status');
    PrintCmdHelp(['quote'], 'Send arbitrary ftp command');
    PrintCmdHelp(['debug-trace'], 'Show Debug TLS trace information');
  end
  else
  begin
    LSubcommand := Fetch(LCmd);
    case IdGlobal.PosInStrArray(Fetch(LSubcommand), Prog_Cmds, False) of
      0, 1:
        begin
          PrintCmdHelp(['exit', 'quit'],
            'Terminate ftp session and exit', 'exit');
        end;
      2:
        begin
          PrintCmdHelp(['open'], 'Connect to remote ftp',
            'open [protocol] host username password');
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
          PrintCmdHelp(['pwd'],
            'Print working directory on remote machine', 'pwd');
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
          PrintCmdHelp(['passive'], 'Toggle use of passive transfer mode',
            'passive [state]');
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
          PrintCmdHelp(['put'], 'Send one file', 'put local_filename');
        end;
      10:
        begin
          PrintCmdHelp(['get'], 'Receive file', 'get local_filename');
        end;
      11, 12:
        begin
          PrintCmdHelp(['rename', 'ren'], 'Rename remote file',
            'rename old_filename new_filename');
        end;
      13, 14:
        begin
          PrintCmdHelp(['del', 'delete'], 'Delete remote file',
            'delete remote_filename');
        end;
      15, 16:
        begin
          PrintCmdHelp(['md', 'mkdir'], 'Make directory on the remote machine',
            'mkdir remote_dirname');
        end;
      17, 18:
        begin
          PrintCmdHelp(['rmdir', 'rd'],
            'Remove directory on the remote machine', 'rmdir remote_dirname');
        end;
      19:
        begin
          PrintCmdHelp(['lpwd'], 'Print local working directory', 'lpwd');
        end;
      20:
        begin
          PrintCmdHelp(['lcd'], 'Change local working directory',
            'lcd local_dirname');
        end;
      21:
        begin
          PrintCmdHelp(['ldir'], 'List contents of local directory',
            'ldir [local_path]');
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
      25:
        begin
          PrintCmdHelp(['status'], 'Show current status', 'status');
        end;
      26:
        begin
          PrintCmdHelp(['debug-info'], 'Show debugging information',
            'debug-info');
        end;
      27:
        begin
          PrintCmdHelp(['about'],
            'Show Information about this program', 'about');
        end;
      28:
        begin
          PrintCmdHelp(['quote'], 'Send arbitrary ftp command',
            'quote command');
        end;
      29:
        begin
          PrintCmdHelp(['debug-trace'], 'Show debug TLS trace information',
            'debug-trace [state]');
          WriteLn('');
          WriteLn('The state value may be one of these:');
          WriteLn('');
          WriteLn('on    - Turn on TLS debug trace information (extremely verbose)');
          WriteLn('off   - Turn off TLS debug trace information');
          WriteLn('true  - Turn on TLS debug trace information (extremely verbose)');
          WriteLn('false - Turn off TLS debug trace information');

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
    try
      case IdGlobal.PosInStrArray(Fetch(LCmd), Prog_Cmds, False) of
        0, 1:
          // 'exit', 'quit'
          Break;
        2:
          // 'open',
          CmdOpen(LCmd);
        3:
          // 'dir',
          CmdDir(LCmd);
        4:
          // 'pwd',
          CmdPwd;
        5, 6:
          // 'cd', 'cwd',
          CmdCd(LCmd);
        7:
          // 'cdup',
          CmdCdUp;
        8:
          // 'passive',
          CmdPassive(LCmd);
        9:
          // 'put',
          CmdPut(LCmd);
        10:
          // 'get',
          CmdGet(LCmd);
        11, 12:
          // 'rename', 'ren',
          CmdRename(LCmd);
        13, 14:
          // 'delete', 'del',
          CmdDelete(LCmd);
        15, 16:
          // 'md', 'mkdir',
          CmdMkdir(LCmd);
        17, 18:
          // 'rd','rmdir',
          CmdRmdir(LCmd);
        19:
          // 'lpwd',
          CmdLPwd;
        20:
          // 'lcd',
          CmdLCd(LCmd);
        21:
          // 'ldir',
          CmdLDir(LCmd);
        22:
          // 'close',
          CmdClose;
        23, 24:
          // 'help', '?'];
          CmdHelp(LCmd);
        25:
          // 'status'
          CmdStatus;
        26:
          // 'debug-info'
          CmdDebugInfo;
        27:
          // 'about'
          CmdAbout;
        28:
          CmdQuote(LCmd);
        29:
          CmdDebugTrace(LCmd);
      else
        WriteLn('Bad Command');
      end;
    except
      On E: Exception do
        WriteLn(E.Message);
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
  CmdAbout;
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

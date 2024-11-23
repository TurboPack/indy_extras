unit taurusftp_unit;

{$ifdef fpc}{$mode objfpc}{$H+}{$else}{$APPTYPE CONSOLE}{$endif}
interface
uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes,
  SysUtils,
  {$IFDEF FPC}
  CustApp,
  {$ENDIF}
  { you can add units after this }
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
    //log events
    procedure OnReceived(ASender: TComponent; const AText, AData: string);
    procedure OnSent(ASender: TComponent; const AText, AData: string);
    procedure OnSSLNegotiated(ASender: TTaurusTLSIOHandlerSocket);

    procedure Open;
    procedure CmdOpen(var VCmd: string);
    procedure CmdDir(var VCmd: string);
    procedure CmdPwd;
    procedure CmdCd(var VCmd: string);
    procedure CmdCdUp;
    procedure CmdPassive(var VCmd: string);
    procedure CmdGet(var VCmd: string);
    procedure CmdPut(var VCmd: string);
    procedure CmdRename(var VCmd: string);
    procedure CmdDelete(var VCmd: string);
    procedure CmdRmdir(var VCmd: string);
    procedure CmdMkdir(var VCmd: string);
    procedure CmdLPwd;
    procedure CmdLCd(var VCmd: string);
    procedure CmdLDir(var VCmd: string);
    procedure CmdClose;
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

  { TFTPApplication }

  procedure TFTPApplication.OnReceived(ASender: TComponent; const AText, AData: string);
  begin
    WriteLn(TrimRight(AData));
  end;

  procedure TFTPApplication.OnSent(ASender: TComponent; const AText, AData: string);
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
  var
    LStr: string;
    LNo: integer;
  begin
    if Assigned(ASender.SSLSocket) then
    begin
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
        LNo := ASender.SSLSocket.Cipher.Bits;
        if LNo > 0 then
        begin
          WriteLn('       Cipher Bits: ' + IntToStr(LNo));
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

  procedure TFTPApplication.CmdOpen(var VCmd: string);
  var
    LSubcommand: string;
  begin
    LSubcommand := Fetch(VCmd);
    if LSubcommand <> '' then
    begin
      case IdGlobal.PosInStrArray(LSubcommand, ['ftp', 'ftps']) of
        0: begin
          FFTP.UseTLS := utNoTLSSupport;
          FFTP.Host := Fetch(VCmd);
          FFTP.Username := Fetch(VCmd);
          FFTP.Password := Fetch(VCmd);
          Open;
        end;
        1: begin
          FFTP.UseTLS := utUseExplicitTLS;
          FFTP.DataPortProtection := ftpdpsPrivate;
          FFTP.Host := Fetch(VCmd);
          FFTP.Username := Fetch(VCmd);
          FFTP.Password := Fetch(VCmd);
          Open;
        end;
        else
        begin
          FFTP.UseTLS := utNoTLSSupport;
          FFTP.Host := LSubcommand;
          FFTP.Username := Fetch(VCmd);
          FFTP.Password := Fetch(VCmd);
          Open;
        end;
      end;
    end;
  end;

  procedure TFTPApplication.CmdDir(var VCmd: string);
  var
    LPath: string;
    i: integer;
  begin
    if FFTP.Connected then
    begin
      LPath := Trim(VCmd);
      if LPath <> '' then
      begin
        FFTP.List(LPath);
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

  procedure TFTPApplication.CmdCd(var VCmd: string);
  begin
    if FFTP.Connected then
    begin
      FFTP.ChangeDir(Trim(VCmd));
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

  procedure TFTPApplication.CmdPassive(var VCmd: string);
  var
    LSubcommand: string;
  begin
    LSubcommand := Trim(Fetch(VCmd));
    case PosInStrArray(LSubcommand, ['on', 'true', 'off', 'false']) of
      0, 1: FFTP.Passive := True;
      2, 3: FFTP.Passive := False;
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

  procedure TFTPApplication.CmdGet(var VCmd: string);
  var
    LPath: string;
    LDestFile: TStream;
  begin
    LPath := Trim(VCmd);
    try
      FFTP.TransferType := ftBinary;
      LDestFile := TFileStream.Create(LPath, fmCreate);
      try
        FFTP.Get(ExtractFileName(LPath), LDestFile);
      finally
        FreeAndNil(LDestFile);
      end;
      FileSetDate(LPath, DateTimeToFileDate(FFTP.FileDate(ExtractFileName(LPath))));
    except
    end;
  end;

  procedure TFTPApplication.CmdPut(var VCmd: string);
  var
    LPath: string;
    LSrcFile: TStream;
    {$IFNDEF FPC}
    LDateTime : TDateTime;
    {$ENDIF}
  begin
    LPath := Trim(VCmd);
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
      if FileAge(LPath,LDateTime) then
      begin
        FFTP.SetModTime(ExtractFileName(LPath), LDateTime);
      end;
      {$ENDIF}
    except
    end;
  end;

  procedure TFTPApplication.CmdRename(var VCmd: string);
  var
    LOldName,
    LNewName :string;
  begin
    LOldName := Fetch(VCmd);
    LNewName := Fetch(VCmd);
    FFTP.Rename(LOldName,LNewName);
  end;

  procedure TFTPApplication.CmdDelete(var VCmd: string);
  var LPath : String;
  begin
    LPath := VCmd;
    FFTP.delete(LPath);
  end;

  procedure TFTPApplication.CmdRmdir(var VCmd: string);
  var
    LPath : string;
  begin
    LPath := VCmd;
    FFTP.RemoveDir(LPath);
  end;

  procedure TFTPApplication.CmdMkdir(var VCmd: string);
  var
    LPath : string;
  begin
      LPath := VCmd;
    FFTP.makedir(LPath);
  end;

  procedure TFTPApplication.CmdLPwd;
  begin
    WriteLn('Local directory is '+GetCurrentDir);
  end;

  procedure TFTPApplication.CmdLCd(var VCmd: string);
  begin
    SetCurrentDir(VCmd);
    WriteLn('Local directory now '+GetCurrentDir);
  end;

  procedure TFTPApplication.CmdLDir(var VCmd: string);
  var
    LRec : TSearchRec;
    LSize, LTime, LDate : string;
  begin
    if FindFirst(VCmd+'*.*',faAnyFile,LRec) = 0 then
    begin
      repeat
        {$IFDEF FPC}
        LTime := TimeToStr( FileDateToDateTime(LRec.Time) );
        LDate := DateToStr( FileDateToDateTime(LRec.Time) );
        {$ELSE}
        LTime := TimeToStr( LRec.TimeStamp  );
        LDate := TimeToStr( LRec.TimeStamp );
        {$ENDIF}
        if LRec.Attr and faDirectory <> 0 then
        begin
          LSize := '<DIR>';
        end
        else
        begin
          LSize := IntToStr(LRec.Size);
        end;
        WriteLn(Format('%10s %10s %20s %s',[LTime,LDate, LSize, LRec.Name]));
      until FindNext(LRec) <> 0;
      FindClose(LRec);
    end;
  end;

  procedure TFTPApplication.CmdClose;
  begin
    FFTP.Disconnect;
  end;

  procedure TFTPApplication.DoCommands;
  var
    LCmd: string;
  begin
    repeat
      Write('ftp: ');
      ReadLn(LCmd);
      case IdGlobal.PosInStrArray(Fetch(LCmd),
          ['exit', 'quit', 'open', 'dir',
           'pwd', 'cd', 'cdup', 'passive',
           'put', 'get', 'rename', 'ren',
           'delete', 'del', 'mkdir', 'rmdir',
           'lpwd', 'lcd','ldir','close']) of
        0, 1: break;
        2: CmdOpen(LCmd);
        3: CmdDir(LCmd);
        4: CmdPwd;
        5: CmdCd(LCmd);
        6: CmdCdUp;
        7: cmdPassive(LCmd);
        8: cmdPut(LCmd);
        9: cmdGet(LCmd);
        10, 11: cmdRename(LCmd);
        12, 13 : cmdDelete(LCmd);
        14: cmdMkdir(LCmd);
        15: cmdRmdir(LCmd);
        16: cmdLPwd;
        17: cmdLCd(LCmd);
        18: cmdLDir(LCmd);
        19: cmdClose;
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
    FIO.OnSSLNegotiated := {$IFDEF FPC}@{$ENDIF}OnSSLNegotiated;
    FFTP.IOHandler := FIO;
    FFTP.Passive := True;
    FLog := TIdLogEvent.Create(nil);
    FLog.LogTime := False;
    FLog.ReplaceCRLF := False;
    FLog.OnReceived := {$IFDEF FPC}@{$ENDIF}OnReceived;
    FLog.OnSent := {$IFDEF FPC}@{$ENDIF}OnSent;
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
    writeln('Usage: ', ExeName, ' -h');
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
  Application.DoRun;
{$ENDIF}
  Application.Free;
end.

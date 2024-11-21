program taurusftp;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes,
  SysUtils,
  CustApp,
  { you can add units after this }
  IdCompressorZLib,
  IdExplicitTLSClientServerBase,
  IdFTP,
  IdFTPCommon,
  IdGlobal,
  IdLogEvent,
  TaurusTLS;

type

  { TFTPApplication }

  TFTPApplication = class(TCustomApplication)
  protected
    FFTP: TIdFTP;
    FComp : TIdCompressorZLib;
    FIO: TTaurusTLSIOHandlerSocket;
    FLog: TIdLogEvent;
    //log events
    procedure OnReceived(ASender: TComponent; const AText, AData: string);
    procedure OnSent(ASender: TComponent; const AText, AData: string);
    procedure OnSSLNegotiated(ASender: TTaurusTLSIOHandlerSocket);
    //
    procedure Open;
    procedure CmdOpen(var VCmd: string);
    procedure CmdDir(var VCmd: string);
    procedure CmdPwd;
    procedure CmdCd(var VCmd: string);
    procedure CmdCdUp;
    procedure CmdPassive(var VCmd: string);
    procedure CmdGet(var VCmd : string);
    procedure CmdPut(var VCmd : string);
    procedure DoCommands;
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
  end;

  { TFTPApplication }

  procedure TFTPApplication.OnReceived(ASender: TComponent; const AText, AData: string);
  begin
    WriteLn(Trim(AData));
  end;

  procedure TFTPApplication.OnSent(ASender: TComponent; const AText, AData: string);
  begin
    if IndyPos('PASS ', AData) > 0 then
    begin
      WriteLn('PASS ***');
    end
    else
    begin
      WriteLn(Trim(AData));
    end;
  end;

  procedure TFTPApplication.OnSSLNegotiated(ASender: TTaurusTLSIOHandlerSocket);
  var
    LStr : String;
    LNo : Integer;
  begin
    if Assigned(ASender.SSLSocket) then
    begin
      LStr := ASender.SSLSocket.SSLProtocolVersionStr;
      if LStr <> '' then
      begin
        WriteLn('       TLS Version: '+LStr);
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
    LPath : String;
    i : Integer;
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
      for i := 0 to FFTP.ListResult.Count -1 do
      begin
        WriteLn( FFTP.ListResult[i] );
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
  var LSubcommand : String;
  begin
    LSubcommand := Trim(Fetch(VCmd));
    case PosInStrArray(LSubcommand,['on','true','off','false']) of
      0, 1 : FFTP.Passive := True;
      2, 3 : FFTP.Passive := False;
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
  var LPath : string;
    LDestFile : TStream;
  begin
    LPath := Trim(VCmd);
    try
      LDestFile := TFileStream.Create(LPath,fmCreate);
      try
        FFTP.Get(ExtractFileName(LPath),LDestFile);
      finally
         FreeAndNil(LDestFile);
      end;
      FileSetDate(LPath, DateTimeToFileDate(FFTP.FileDate(ExtractFileName(LPath))));
    except
    end;
  end;

  procedure TFTPApplication.CmdPut(var VCmd: string);
  var
    LPath : string;
    LSrcFile : TStream;
  begin
    LPath := Trim(VCmd);
    try
      LSrcFile := TFileStream.Create(LPath,fmOpenRead);
      try
        FFTP.Put(LSrcFile,ExtractFileName(LPath));
      finally
         FreeAndNil(LSrcFile);
      end;
      FFTP.SetModTime(LPath, FileDateToDateTime(FileAge(LPath)));
    except
    end;
  end;

  procedure TFTPApplication.DoCommands;
  var
    LCmd: string;
  begin
    repeat
      Write('ftp: ');
      ReadLn(LCmd);
      case IdGlobal.PosInStrArray(Fetch(LCmd), ['exit', 'quit',
        'open','dir','pwd','cd','cdup',
        'passive','put','get', 'rename',
        'delete','mkdir', 'rmdir']) of
        0,1: break;
        2: CmdOpen(LCmd);
        3: CmdDir(LCmd);
        4: CmdPwd;
        5: CmdCd(LCmd);
        6: CmdCdUp;
        7: cmdPassive(LCmd);
        8: cmdPut(LCmd);
        9: cmdGet(LCmd);
      else
        WriteLn('Bad Command');
      end;
    until False;
  end;

  procedure TFTPApplication.DoRun;
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

    { add your program here }
    DoCommands;
    // stop program loop
    Terminate;
  end;

  constructor TFTPApplication.Create(TheOwner: TComponent);
  begin
    inherited Create(TheOwner);
    FFTP := TIdFTP.Create(nil);
    FComp := TIdCompressorZLib.Create(nil);
    FFTP.Compressor := FComp;
    FIO := TTaurusTLSIOHandlerSocket.Create(nil);
    FIO.OnSSLNegotiated := @OnSSLNegotiated;
    FFTP.IOHandler := FIO;
    FFTP.Passive := true;
    FLog := TIdLogEvent.Create(nil);
    FLog.LogTime := False;
    FLog.ReplaceCRLF := False;
    FLog.OnReceived := @OnReceived;
    FLog.OnSent := @OnSent;
    FLog.Active := True;
    FIO.Intercept := FLog;
    StopOnException := True;
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

  procedure TFTPApplication.WriteHelp;
  begin
    { add your help code here }
    writeln('Usage: ', ExeName, ' -h');
  end;

var
  Application: TFTPApplication;
begin
  Application := TFTPApplication.Create(nil);
  Application.Title := 'TaurusFTP Console';
  Application.Run;
  Application.Free;
end.

unit TaurusTLS_Unicode_Log;

{$I TaurusTLSCompilerDefines.inc}

interface

uses
  Classes,
  IdIntercept, IdGlobal, IdBaseComponent;

type
  TTaurusTLSUnicodeLogStatusEvent = procedure(ASender: TComponent; const AText: string) of object;
  TTaurusTLSUnicodeLogDataEvent = procedure(ASender: TComponent; const AData: string) of object;
  TTaurusTLSUnicodeLog = class(TIdConnectionIntercept)
  protected
    FActive: Boolean;
    FOnStatus : TTaurusTLSUnicodeLogStatusEvent;
    FOnReceived : TTaurusTLSUnicodeLogDataEvent;
    FOnSent :  TTaurusTLSUnicodeLogDataEvent;
    procedure InitComponent; override;
    procedure LogStatus(const AData: string);
    procedure LogReceivedData(const AData: string);
    procedure LogSentData(const AData: string);
    procedure SetActive(const Value: Boolean);
  public
    procedure Connect(AConnection: TComponent); override;
    procedure Disconnect; override;
    procedure Receive(var ABuffer: TIdBytes); override;
    procedure Send(var ABuffer: TIdBytes); override;
  published
    property Active: Boolean read FActive write SetActive default False;
    property OnReceived : TTaurusTLSUnicodeLogDataEvent read FOnReceived write FOnReceived;
    property OnSent :  TTaurusTLSUnicodeLogDataEvent read FOnSent write FOnSent;
    property OnStatus : TTaurusTLSUnicodeLogStatusEvent read FOnStatus write FOnStatus;
  end;

implementation
uses
  IdResourceStringsCore, SysUtils;


{ TTaurusTLSUnicodeLog }

procedure TTaurusTLSUnicodeLog.Connect(AConnection: TComponent);
begin
  inherited Connect(AConnection);
  if FActive then begin
    LogStatus(RSLogConnected);
  end;
end;

procedure TTaurusTLSUnicodeLog.Disconnect;
begin
  if FActive then begin
    LogStatus(RSLogDisconnected);
  end;
  inherited Disconnect;
end;

procedure TTaurusTLSUnicodeLog.InitComponent;
begin
  inherited;
  FActive := False;
end;

procedure TTaurusTLSUnicodeLog.LogReceivedData(const AData: string);
begin
  if Assigned(OnReceived) then begin
    OnReceived(Self, AData);
  end;
end;

procedure TTaurusTLSUnicodeLog.LogSentData(const AData: string);
begin
  if Assigned(OnSent) then begin
    OnSent(Self, AData);
  end;
end;

procedure TTaurusTLSUnicodeLog.LogStatus(const AData: string);
begin
  if Assigned(OnStatus) then begin
    OnStatus(Self, AData);
  end;
end;

procedure TTaurusTLSUnicodeLog.Receive(var ABuffer: TIdBytes);
{$IFNDEF USE_INLINE_VAR}
var s : String;
{$ENDIF}
begin
  inherited Receive(ABuffer);
  if FActive then begin
    {$IFDEF USE_INLINE_VAR}
    var s : String;
    {$ENDIF}
    s := BytesToString(ABuffer,IndyTextEncoding_UTF8);
    LogReceivedData(s);
  end;
end;

procedure TTaurusTLSUnicodeLog.Send(var ABuffer: TIdBytes);
{$IFNDEF USE_INLINE_VAR}
var s : String;
{$ENDIF}
begin
  inherited Send(ABuffer);
  if FActive then begin
    {$IFDEF USE_INLINE_VAR}
    var s : String;
    {$ENDIF}
    s := BytesToString(ABuffer,IndyTextEncoding_UTF8);
    LogSentData(s);
  end;
end;

procedure TTaurusTLSUnicodeLog.SetActive(const Value: Boolean);
begin
  FActive := Value;
end;

end.

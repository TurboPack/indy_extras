unit taurusHTTPServer_unit;

{$i TaurusTLSCompilerDefines.inc}

interface

uses
  Classes, SysUtils,
  IdHTTPServer,
  TaurusTLS;

type
  THTTPServer = class(TObject)
    FHTTP: TIdHTTPServer;
    FIO: TTaurusTLSServerIOHandler;
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{$IFNDEF FPC}

uses System.Types;
{$ENDIF}
{ THTTPServer }

constructor THTTPServer.Create;
begin
  inherited Create;
  FHTTP := TIdHTTPServer.Create(nil);
  FIO := TTaurusTLSServerIOHandler.Create(nil);
  FIO.SSLOptions.CertFile := 'domain.crt';
  FIO.SSLOptions.KeyFile := 'domain.key';
  FHTTP.IOHandler := FIO;
  FHTTP.DefaultPort := 443;
  FHTTP.Active := True;
end;

destructor THTTPServer.Destroy;
begin
  FreeAndNil(FIO);
  FreeAndNil(FHTTP);
  inherited;
end;

procedure RunProgram;
var
  LHTTP: THTTPServer;
begin
  TaurusTLS.LoadOpenSSLLibrary;
  try
    LHTTP := THTTPServer.Create;
    try
      WriteLn('TaurusHTTPServer');
      WriteLn('Press enter to terminate.');
      ReadLn;
    finally
      FreeAndNil(LHTTP);
    end;
  except
    on E: Exception do
    begin
      WriteLn(E.Message);
      ReadLn;
    end;
  end;
end;

initialization
  RunProgram;
end.
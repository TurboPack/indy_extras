/// <exclude />
{******************************************************************************}
{*  TaurusTLS                                                                 *}
{*           https://github.com/JPeterMugaas/TaurusTLS                        *}
{*                                                                            *}
{*  Copyright (c) 2025 TaurusTLS Developers, All Rights Reserved              *}
{*                                                                            *}
{* Portions of this software are Copyright (c) 1993 – 2018,                   *}
{* Chad Z. Hower (Kudzu) and the Indy Pit Crew – http://www.IndyProject.org/  *}
{******************************************************************************}
unit TaurusTLSHeaders_quic;

interface
// Headers for OpenSSL 3.2.0
// ssl.h
{$i TaurusTLSCompilerDefines.inc}
{$i TaurusTLSLinkDefines.inc}
{$IFNDEF USE_OPENSSL}
  { error Should not compile if USE_OPENSSL is not defined!!!}
{$ENDIF}
uses
  IdCTypes,
  IdGlobal,
  TaurusTLSHeaders_ssl;

{$MINENUMSIZE 4}
const
  OSSL_QUIC_ERR_NO_ERROR                  = $00;
  OSSL_QUIC_ERR_INTERNAL_ERROR            = $01;
  OSSL_QUIC_ERR_CONNECTION_REFUSED        = $02;
  OSSL_QUIC_ERR_FLOW_CONTROL_ERROR        = $03;
  OSSL_QUIC_ERR_STREAM_LIMIT_ERROR        = $04;
  OSSL_QUIC_ERR_STREAM_STATE_ERROR        = $05;
  OSSL_QUIC_ERR_FINAL_SIZE_ERROR          = $06;
  OSSL_QUIC_ERR_FRAME_ENCODING_ERROR      = $07;
  OSSL_QUIC_ERR_TRANSPORT_PARAMETER_ERROR = $08;
  OSSL_QUIC_ERR_CONNECTION_ID_LIMIT_ERROR = $09;
  OSSL_QUIC_ERR_PROTOCOL_VIOLATION        = $0A;
  OSSL_QUIC_ERR_INVALID_TOKEN             = $0B;
  OSSL_QUIC_ERR_APPLICATION_ERROR         = $0C;
  OSSL_QUIC_ERR_CRYPTO_BUFFER_EXCEEDED    = $0D;
  OSSL_QUIC_ERR_KEY_UPDATE_ERROR          = $0E;
  OSSL_QUIC_ERR_AEAD_LIMIT_REACHED        = $0F;
  OSSL_QUIC_ERR_NO_VIABLE_PATH            = $10;

  OSSL_QUIC_ERR_CRYPTO_ERR_BEGIN          = $0100;
  OSSL_QUIC_ERR_CRYPTO_ERR_END            = $01FF;

  OSSL_QUIC_LOCAL_ERR_IDLE_TIMEOUT        = TIdC_UINT64($FFFFFFFFFFFFFFFF);

{$IFNDEF OPENSSL_STATIC_LINK_MODEL}
var
  OSSL_QUIC_client_method : function : PSSL_METHOD; cdecl = nil; {introduced 3.2.0}
  OSSL_QUIC_client_thread_method  : function : PSSL_METHOD; cdecl = nil; {introduced 3.2.0}
  OSSL_QUIC_server_method : function  : PSSL_METHOD; cdecl = nil; {introduced 3.5.0}
{$ELSE}
  function OSSL_QUIC_client_method : PSSL_METHOD cdecl; external LibSSL; {introduced 3.2.0}
  function OSSL_QUIC_client_thread_method : PSSL_METHOD cdecl; external LibSSL; {introduced 3.2.0}
  function OSSL_QUIC_server_method : PSSL_METHOD cdecl; external CLibSSL; {introduced 3.5.0}
{$ENDIF}

implementation
  uses
    classes,
    TaurusTLSExceptionHandlers
  {$IFNDEF OPENSSL_STATIC_LINK_MODEL}
    ,TaurusTLSLoader
  {$ENDIF};

{$IFNDEF OPENSSL_STATIC_LINK_MODEL}
const
  OSSL_QUIC_client_method_introduced =  (byte(3) shl 8 or byte(2)) shl 8 or byte(0);
  OSSL_QUIC_client_thread_method_introduced  = (byte(3) shl 8 or byte(2)) shl 8 or byte(0);
  OSSL_QUIC_server_method_introduced =  (byte(3) shl 8 or byte(5)) shl 8 or byte(0);

const
  OSSL_QUIC_client_method_procname = 'OSSL_QUIC_client_method';
  OSSL_QUIC_client_thread_method_procname = 'OSSL_QUIC_client_thread_method(';
  OSSL_QUIC_server_method_procname = 'OSSL_QUIC_server_method';

  {$i TaurusTLSNoRetValOff.inc}

{introduced 3.2.0}
function ERR_OSSL_QUIC_client_method : PSSL_METHOD;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(OSSL_QUIC_client_method_procname);
end;

{introduced 3.2.0}
function ERR_OSSL_QUIC_client_thread_method : PSSL_METHOD;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(OSSL_QUIC_client_thread_method_procname);
end;

 {introduced 3.5.0}
function ERR_OSSL_QUIC_server_method : PSSL_METHOD;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(OSSL_QUIC_server_method_procname);
end;

  {$i TaurusTLSNoRetValOn.inc} 

procedure Load(const ADllHandle: TIdLibHandle; LibVersion: TIdC_UINT; const AFailed: TStringList);
var FuncLoadError: boolean;

begin
  OSSL_QUIC_client_method := LoadLibFunction(ADllHandle, OSSL_QUIC_client_method_procname);
  FuncLoadError := not assigned(OSSL_QUIC_client_method);
  if FuncLoadError then
  begin
    {$if not defined(OSSL_QUIC_client_method_allownil)}
    OSSL_QUIC_client_method := @ERR_OSSL_QUIC_client_method;
    {$ifend}
    {$if declared(OSSL_QUIC_client_method_introduced)}
    if LibVersion < OSSL_QUIC_client_method_introduced then
    begin
      {$if declared(FC_OSSL_QUIC_client_method)}
      OSSL_QUIC_client_method := @FC_OSSL_QUIC_client_method;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(OSSL_QUIC_client_method_removed)}
    if OSSL_QUIC_client_method_removed <= LibVersion then
    begin
      {$if declared(_OSSL_QUIC_client_method)}
      OSSL_QUIC_client_method := @_OSSL_QUIC_client_method;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(OSSL_QUIC_client_method_allownil)}
    if FuncLoadError then
      AFailed.Add('OSSL_QUIC_client_method');
    {$ifend}
  end;

  OSSL_QUIC_client_thread_method := LoadLibFunction(ADllHandle, OSSL_QUIC_client_thread_method_procname);
  FuncLoadError := not assigned(OSSL_QUIC_client_thread_method);
  if FuncLoadError then
  begin
    {$if not defined(OSSL_QUIC_client_thread_method_allownil)}
    OSSL_QUIC_client_thread_method := @ERR_OSSL_QUIC_client_thread_method;
    {$ifend}
    {$if declared(OSSL_QUIC_client_thread_method_introduced)}
    if LibVersion < OSSL_QUIC_client_thread_method_introduced then
    begin
      {$if declared(FC_OSSL_QUIC_client_thread_method)}
      OSSL_QUIC_client_thread_method := @FC_OSSL_QUIC_client_thread_method;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(OSSL_QUIC_client_thread_method_removed)}
    if OSSL_QUIC_client_thread_method_removed <= LibVersion then
    begin
      {$if declared(_OSSL_QUIC_client_thread_method)}
      OSSL_QUIC_client_thread_method := @_OSSL_QUIC_client_thread_method;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(OSSL_QUIC_client_thread_method_allownil)}
    if FuncLoadError then
      AFailed.Add('OSSL_QUIC_client_thread_method');
    {$ifend}
  end;

  OSSL_QUIC_server_method := LoadLibFunction(ADllHandle, OSSL_QUIC_server_method_procname);
  FuncLoadError := not assigned(OSSL_QUIC_server_method);
  if FuncLoadError then
  begin
    {$if not defined(OSSL_QUIC_server_method_allownil)}
    OSSL_QUIC_server_method := @ERR_OSSL_QUIC_server_method;
    {$ifend}
    {$if declared(OSSL_QUIC_server_method_introduced)}
    if LibVersion < OSSL_QUIC_server_method_introduced then
    begin
      {$if declared(FC_OSSL_QUIC_server_method)}
      OSSL_QUIC_server_method := @FC_OSSL_QUIC_server_method;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(OSSL_QUIC_server_method_removed)}
    if OSSL_QUIC_server_method_removed <= LibVersion then
    begin
      {$if declared(_OSSL_QUIC_server_method)}
      OSSL_QUIC_server_method := @_OSSL_QUIC_server_method;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(OSSL_QUIC_server_method_allownil)}
    if FuncLoadError then
      AFailed.Add('OSSL_QUIC_server_method');
    {$ifend}
  end;
end;

procedure Unload;
begin
  OSSL_QUIC_client_method := nil;
  OSSL_QUIC_client_thread_method := nil;
  OSSL_QUIC_server_method := nil;
end;

initialization
  Register_SSLLoader(@Load,'LibSSL');
  Register_SSLUnloader(@Unload);
{$ENDIF}
end.

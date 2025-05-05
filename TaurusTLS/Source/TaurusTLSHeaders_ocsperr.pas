/// <exclude />
  (* This unit was generated using the script genTaurusTLSHdrs.sh from the source file TaurusTLSHeaders_ocsperr.h2pas
     It should not be modified directly. All changes should be made to TaurusTLSHeaders_ocsperr.h2pas
     and this file regenerated. TaurusTLSHeaders_ocsperr.h2pas is distributed with the full Indy
     Distribution.
   *)
   
{$i TaurusTLSCompilerDefines.inc} 
{$i TaurusTLSLinkDefines.inc} 
{$IFNDEF USE_OPENSSL}
  { error Should not compile if USE_OPENSSL is not defined!!!}
{$ENDIF}
{******************************************************************************}
{*  TaurusTLS                                                                 *}
{*           https://github.com/JPeterMugaas/TaurusTLS                        *}
{*                                                                            *}
{*  Copyright (c) 2024 TaurusTLS Developers, All Rights Reserved              *}
{*                                                                            *}
{* Portions of this software are Copyright (c) 1993 – 2018,                   *}
{* Chad Z. Hower (Kudzu) and the Indy Pit Crew – http://www.IndyProject.org/  *}
{******************************************************************************}

unit TaurusTLSHeaders_ocsperr;

interface

// Headers for OpenSSL 1.1.1
// ocsperr.h


uses
  IdCTypes,
  IdGlobal
  {$IFDEF OPENSSL_USE_SHARED_LIBRARY}
  , TaurusTLSConsts
  {$ENDIF};

const
  (*
   * OCSP function codes.
   *)
  OCSP_F_D2I_OCSP_NONCE = 102;
  OCSP_F_OCSP_BASIC_ADD1_STATUS = 103;
  OCSP_F_OCSP_BASIC_SIGN = 104;
  OCSP_F_OCSP_BASIC_SIGN_CTX = 119;
  OCSP_F_OCSP_BASIC_VERIFY = 105;
  OCSP_F_OCSP_CERT_ID_NEW = 101;
  OCSP_F_OCSP_CHECK_DELEGATED = 106;
  OCSP_F_OCSP_CHECK_IDS = 107;
  OCSP_F_OCSP_CHECK_ISSUER = 108;
  OCSP_F_OCSP_CHECK_VALIDITY = 115;
  OCSP_F_OCSP_MATCH_ISSUERID = 109;
  OCSP_F_OCSP_PARSE_URL = 114;
  OCSP_F_OCSP_REQUEST_SIGN = 110;
  OCSP_F_OCSP_REQUEST_VERIFY = 116;
  OCSP_F_OCSP_RESPONSE_GET1_BASIC = 111;
  OCSP_F_PARSE_HTTP_LINE1 = 118;

  (*
   * OCSP reason codes.
   *)
  OCSP_R_CERTIFICATE_VERIFY_ERROR = 101;
  OCSP_R_DIGEST_ERR = 102;
  OCSP_R_ERROR_IN_NEXTUPDATE_FIELD = 122;
  OCSP_R_ERROR_IN_THISUPDATE_FIELD = 123;
  OCSP_R_ERROR_PARSING_URL = 121;
  OCSP_R_MISSING_OCSPSIGNING_USAGE = 103;
  OCSP_R_NEXTUPDATE_BEFORE_THISUPDATE = 124;
  OCSP_R_NOT_BASIC_RESPONSE = 104;
  OCSP_R_NO_CERTIFICATES_IN_CHAIN = 105;
  OCSP_R_NO_RESPONSE_DATA = 108;
  OCSP_R_NO_REVOKED_TIME = 109;
  OCSP_R_NO_SIGNER_KEY = 130;
  OCSP_R_PRIVATE_KEY_DOES_NOT_MATCH_CERTIFICATE = 110;
  OCSP_R_REQUEST_NOT_SIGNED = 128;
  OCSP_R_RESPONSE_CONTAINS_NO_REVOCATION_DATA = 111;
  OCSP_R_ROOT_CA_NOT_TRUSTED = 112;
  OCSP_R_SERVER_RESPONSE_ERROR = 114;
  OCSP_R_SERVER_RESPONSE_PARSE_ERROR = 115;
  OCSP_R_SIGNATURE_FAILURE = 117;
  OCSP_R_SIGNER_CERTIFICATE_NOT_FOUND = 118;
  OCSP_R_STATUS_EXPIRED = 125;
  OCSP_R_STATUS_NOT_YET_VALID = 126;
  OCSP_R_STATUS_TOO_OLD = 127;
  OCSP_R_UNKNOWN_MESSAGE_DIGEST = 119;
  OCSP_R_UNKNOWN_NID = 120;
  OCSP_R_UNSUPPORTED_REQUESTORNAME_TYPE = 129;

    { The EXTERNALSYM directive is ignored by FPC, however, it is used by Delphi as follows:
		
  	  The EXTERNALSYM directive prevents the specified Delphi symbol from appearing in header 
	  files generated for C++. }
	  
  {$EXTERNALSYM ERR_load_OCSP_strings}

{$IFNDEF OPENSSL_STATIC_LINK_MODEL}
var
  ERR_load_OCSP_strings: function : TIdC_INT; cdecl = nil;

{$ELSE}
  function ERR_load_OCSP_strings: TIdC_INT cdecl; external CLibCrypto;

{$ENDIF}

implementation

  uses
    classes, 
    TaurusTLSExceptionHandlers
  {$IFNDEF OPENSSL_STATIC_LINK_MODEL}
    , TaurusTLSLoader
  {$ENDIF};
  

{$IFNDEF OPENSSL_STATIC_LINK_MODEL}
const
  ERR_load_OCSP_strings_procname = 'ERR_load_OCSP_strings';


  {$i TaurusTLSNoRetValOff.inc} 
function  ERR_ERR_load_OCSP_strings: TIdC_INT; 
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(ERR_load_OCSP_strings_procname);
end;



  {$i TaurusTLSNoRetValOn.inc} 

procedure Load(const ADllHandle: TIdLibHandle; LibVersion: TIdC_UINT; const AFailed: TStringList);

var FuncLoadError: boolean;

begin
  ERR_load_OCSP_strings := LoadLibFunction(ADllHandle, ERR_load_OCSP_strings_procname);
  FuncLoadError := not assigned(ERR_load_OCSP_strings);
  if FuncLoadError then
  begin
    {$if not defined(ERR_load_OCSP_strings_allownil)}
    ERR_load_OCSP_strings := @ERR_ERR_load_OCSP_strings;
    {$ifend}
    {$if declared(ERR_load_OCSP_strings_introduced)}
    if LibVersion < ERR_load_OCSP_strings_introduced then
    begin
      {$if declared(FC_ERR_load_OCSP_strings)}
      ERR_load_OCSP_strings := @FC_ERR_load_OCSP_strings;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(ERR_load_OCSP_strings_removed)}
    if ERR_load_OCSP_strings_removed <= LibVersion then
    begin
      {$if declared(_ERR_load_OCSP_strings)}
      ERR_load_OCSP_strings := @_ERR_load_OCSP_strings;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(ERR_load_OCSP_strings_allownil)}
    if FuncLoadError then
      AFailed.Add('ERR_load_OCSP_strings');
    {$ifend}
  end;


end;

procedure Unload;
begin
  ERR_load_OCSP_strings := nil;
end;
{$ELSE}
{$ENDIF}

{$IFNDEF OPENSSL_STATIC_LINK_MODEL}
initialization
  Register_SSLLoader(@Load,'LibCrypto');
  Register_SSLUnloader(@Unload);
{$ENDIF}
end.

/// <exclude />
  (* This unit was generated using the script genTaurusTLSHdrs.sh from the source file TaurusTLSHeaders_tserr.h2pas
     It should not be modified directly. All changes should be made to TaurusTLSHeaders_tserr.h2pas
     and this file regenerated. TaurusTLSHeaders_tserr.h2pas is distributed with the full Indy
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
{* Portions of this software are Copyright (c) 1993 � 2018,                   *}
{* Chad Z. Hower (Kudzu) and the Indy Pit Crew � http://www.IndyProject.org/  *}
{******************************************************************************}
unit TaurusTLSHeaders_tserr;

interface

// Headers for OpenSSL 1.1.1
// tserr.h


uses
  IdCTypes,
  IdGlobal
  {$IFDEF OPENSSL_STATIC_LINK_MODEL}
  , TaurusTLSConsts
  {$ENDIF};

const
  (*
   * TS function codes.
   *)
  TS_F_DEF_SERIAL_CB = 110;
  TS_F_DEF_TIME_CB = 111;
  TS_F_ESS_ADD_SIGNING_CERT = 112;
  TS_F_ESS_ADD_SIGNING_CERT_V2 = 147;
  TS_F_ESS_CERT_ID_NEW_INIT = 113;
  TS_F_ESS_CERT_ID_V2_NEW_INIT = 156;
  TS_F_ESS_SIGNING_CERT_NEW_INIT = 114;
  TS_F_ESS_SIGNING_CERT_V2_NEW_INIT = 157;
  TS_F_INT_TS_RESP_VERIFY_TOKEN = 149;
  TS_F_PKCS7_TO_TS_TST_INFO = 148;
  TS_F_TS_ACCURACY_SET_MICROS = 115;
  TS_F_TS_ACCURACY_SET_MILLIS = 116;
  TS_F_TS_ACCURACY_SET_SECONDS = 117;
  TS_F_TS_CHECK_IMPRINTS = 100;
  TS_F_TS_CHECK_NONCES = 101;
  TS_F_TS_CHECK_POLICY = 102;
  TS_F_TS_CHECK_SIGNING_CERTS = 103;
  TS_F_TS_CHECK_STATUS_INFO = 104;
  TS_F_TS_COMPUTE_IMPRINT = 145;
  TS_F_TS_CONF_INVALID = 151;
  TS_F_TS_CONF_LOAD_CERT = 153;
  TS_F_TS_CONF_LOAD_CERTS = 154;
  TS_F_TS_CONF_LOAD_KEY = 155;
  TS_F_TS_CONF_LOOKUP_FAIL = 152;
  TS_F_TS_CONF_SET_DEFAULT_ENGINE = 146;
  TS_F_TS_GET_STATUS_TEXT = 105;
  TS_F_TS_MSG_IMPRINT_SET_ALGO = 118;
  TS_F_TS_REQ_SET_MSG_IMPRINT = 119;
  TS_F_TS_REQ_SET_NONCE = 120;
  TS_F_TS_REQ_SET_POLICY_ID = 121;
  TS_F_TS_RESP_CREATE_RESPONSE = 122;
  TS_F_TS_RESP_CREATE_TST_INFO = 123;
  TS_F_TS_RESP_CTX_ADD_FAILURE_INFO = 124;
  TS_F_TS_RESP_CTX_ADD_MD = 125;
  TS_F_TS_RESP_CTX_ADD_POLICY = 126;
  TS_F_TS_RESP_CTX_NEW = 127;
  TS_F_TS_RESP_CTX_SET_ACCURACY = 128;
  TS_F_TS_RESP_CTX_SET_CERTS = 129;
  TS_F_TS_RESP_CTX_SET_DEF_POLICY = 130;
  TS_F_TS_RESP_CTX_SET_SIGNER_CERT = 131;
  TS_F_TS_RESP_CTX_SET_STATUS_INFO = 132;
  TS_F_TS_RESP_GET_POLICY = 133;
  TS_F_TS_RESP_SET_GENTIME_WITH_PRECISION = 134;
  TS_F_TS_RESP_SET_STATUS_INFO = 135;
  TS_F_TS_RESP_SET_TST_INFO = 150;
  TS_F_TS_RESP_SIGN = 136;
  TS_F_TS_RESP_VERIFY_SIGNATURE = 106;
  TS_F_TS_TST_INFO_SET_ACCURACY = 137;
  TS_F_TS_TST_INFO_SET_MSG_IMPRINT = 138;
  TS_F_TS_TST_INFO_SET_NONCE = 139;
  TS_F_TS_TST_INFO_SET_POLICY_ID = 140;
  TS_F_TS_TST_INFO_SET_SERIAL = 141;
  TS_F_TS_TST_INFO_SET_TIME = 142;
  TS_F_TS_TST_INFO_SET_TSA = 143;
  TS_F_TS_VERIFY = 108;
  TS_F_TS_VERIFY_CERT = 109;
  TS_F_TS_VERIFY_CTX_NEW = 144;

  (*
   * TS reason codes.
   *)
  TS_R_BAD_PKCS7_TYPE = 132;
  TS_R_BAD_TYPE = 133;
  TS_R_CANNOT_LOAD_CERT = 137;
  TS_R_CANNOT_LOAD_KEY = 138;
  TS_R_CERTIFICATE_VERIFY_ERROR = 100;
  TS_R_COULD_NOT_SET_ENGINE = 127;
  TS_R_COULD_NOT_SET_TIME = 115;
  TS_R_DETACHED_CONTENT = 134;
  TS_R_ESS_ADD_SIGNING_CERT_ERROR = 116;
  TS_R_ESS_ADD_SIGNING_CERT_V2_ERROR = 139;
  TS_R_ESS_SIGNING_CERTIFICATE_ERROR = 101;
  TS_R_INVALID_NULL_POINTER = 102;
  TS_R_INVALID_SIGNER_CERTIFICATE_PURPOSE = 117;
  TS_R_MESSAGE_IMPRINT_MISMATCH = 103;
  TS_R_NONCE_MISMATCH = 104;
  TS_R_NONCE_NOT_RETURNED = 105;
  TS_R_NO_CONTENT = 106;
  TS_R_NO_TIME_STAMP_TOKEN = 107;
  TS_R_PKCS7_ADD_SIGNATURE_ERROR = 118;
  TS_R_PKCS7_ADD_SIGNED_ATTR_ERROR = 119;
  TS_R_PKCS7_TO_TS_TST_INFO_FAILED = 129;
  TS_R_POLICY_MISMATCH = 108;
  TS_R_PRIVATE_KEY_DOES_NOT_MATCH_CERTIFICATE = 120;
  TS_R_RESPONSE_SETUP_ERROR = 121;
  TS_R_SIGNATURE_FAILURE = 109;
  TS_R_THERE_MUST_BE_ONE_SIGNER = 110;
  TS_R_TIME_SYSCALL_ERROR = 122;
  TS_R_TOKEN_NOT_PRESENT = 130;
  TS_R_TOKEN_PRESENT = 131;
  TS_R_TSA_NAME_MISMATCH = 111;
  TS_R_TSA_UNTRUSTED = 112;
  TS_R_TST_INFO_SETUP_ERROR = 123;
  TS_R_TS_DATASIGN = 124;
  TS_R_UNACCEPTABLE_POLICY = 125;
  TS_R_UNSUPPORTED_MD_ALGORITHM = 126;
  TS_R_UNSUPPORTED_VERSION = 113;
  TS_R_VAR_BAD_VALUE = 135;
  TS_R_VAR_LOOKUP_FAILURE = 136;
  TS_R_WRONG_CONTENT_TYPE = 114;

    { The EXTERNALSYM directive is ignored by FPC, however, it is used by Delphi as follows:
		
  	  The EXTERNALSYM directive prevents the specified Delphi symbol from appearing in header 
	  files generated for C++. }
	  
  {$EXTERNALSYM ERR_load_TS_strings}

{$IFNDEF OPENSSL_STATIC_LINK_MODEL}
var
  ERR_load_TS_strings: function : TIdC_INT; cdecl = nil;

{$ELSE}
  function ERR_load_TS_strings: TIdC_INT cdecl; external CLibCrypto;

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
  ERR_load_TS_strings_procname = 'ERR_load_TS_strings';


  {$i TaurusTLSNoRetValOff.inc} 
function  ERR_ERR_load_TS_strings: TIdC_INT; 
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(ERR_load_TS_strings_procname);
end;



  {$i TaurusTLSNoRetValOn.inc} 
  {$i TaurusTLSUnusedParamOff.inc}
procedure Load(const ADllHandle: TIdLibHandle; LibVersion: TIdC_UINT; const AFailed: TStringList);

var FuncLoadError: boolean;

begin
  ERR_load_TS_strings := LoadLibFunction(ADllHandle, ERR_load_TS_strings_procname);
  FuncLoadError := not assigned(ERR_load_TS_strings);
  if FuncLoadError then
  begin
    {$if not defined(ERR_load_TS_strings_allownil)}
    ERR_load_TS_strings := @ERR_ERR_load_TS_strings;
    {$ifend}
    {$if declared(ERR_load_TS_strings_introduced)}
    if LibVersion < ERR_load_TS_strings_introduced then
    begin
      {$if declared(FC_ERR_load_TS_strings)}
      ERR_load_TS_strings := @FC_ERR_load_TS_strings;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(ERR_load_TS_strings_removed)}
    if ERR_load_TS_strings_removed <= LibVersion then
    begin
      {$if declared(_ERR_load_TS_strings)}
      ERR_load_TS_strings := @_ERR_load_TS_strings;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(ERR_load_TS_strings_allownil)}
    if FuncLoadError then
      AFailed.Add('ERR_load_TS_strings');
    {$ifend}
  end;


end;

procedure Unload;
begin
  ERR_load_TS_strings := nil;
end;
  {$i TaurusTLSUnusedParamOff.inc}
{$ENDIF}

{$IFNDEF OPENSSL_STATIC_LINK_MODEL}
initialization
  Register_SSLLoader(@Load,'LibCrypto');
  Register_SSLUnloader(@Unload);
{$ENDIF}
end.

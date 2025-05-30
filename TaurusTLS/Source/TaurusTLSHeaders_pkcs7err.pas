/// <exclude />
  (* This unit was generated using the script genTaurusTLSHdrs.sh from the source file TaurusTLSHeaders_pkcs7err.h2pas
     It should not be modified directly. All changes should be made to TaurusTLSHeaders_pkcs7err.h2pas
     and this file regenerated. TaurusTLSHeaders_pkcs7err.h2pas is distributed with the full Indy
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
unit TaurusTLSHeaders_pkcs7err;

interface

// Headers for OpenSSL 1.1.1
// pkcs7err.h


uses
  IdCTypes,
  IdGlobal
   {$IFDEF OPENSSL_STATIC_LINK_MODEL}
  , TaurusTLSConsts
  {$ENDIF};

const
  (*
   * PKCS7 function codes.
   *)
  PKCS7_F_DO_PKCS7_SIGNED_ATTRIB                     = 136;
  PKCS7_F_PKCS7_ADD0_ATTRIB_SIGNING_TIME             = 135;
  PKCS7_F_PKCS7_ADD_ATTRIB_SMIMECAP                  = 118;
  PKCS7_F_PKCS7_ADD_CERTIFICATE                      = 100;
  PKCS7_F_PKCS7_ADD_CRL                              = 101;
  PKCS7_F_PKCS7_ADD_RECIPIENT_INFO                   = 102;
  PKCS7_F_PKCS7_ADD_SIGNATURE                        = 131;
  PKCS7_F_PKCS7_ADD_SIGNER                           = 103;
  PKCS7_F_PKCS7_BIO_ADD_DIGEST                       = 125;
  PKCS7_F_PKCS7_COPY_EXISTING_DIGEST                 = 138;
  PKCS7_F_PKCS7_CTRL                                 = 104;
  PKCS7_F_PKCS7_DATADECODE                           = 112;
  PKCS7_F_PKCS7_DATAFINAL                            = 128;
  PKCS7_F_PKCS7_DATAINIT                             = 105;
  PKCS7_F_PKCS7_DATAVERIFY                           = 107;
  PKCS7_F_PKCS7_DECRYPT                              = 114;
  PKCS7_F_PKCS7_DECRYPT_RINFO                        = 133;
  PKCS7_F_PKCS7_ENCODE_RINFO                         = 132;
  PKCS7_F_PKCS7_ENCRYPT                              = 115;
  PKCS7_F_PKCS7_FINAL                                = 134;
  PKCS7_F_PKCS7_FIND_DIGEST                          = 127;
  PKCS7_F_PKCS7_GET0_SIGNERS                         = 124;
  PKCS7_F_PKCS7_RECIP_INFO_SET                       = 130;
  PKCS7_F_PKCS7_SET_CIPHER                           = 108;
  PKCS7_F_PKCS7_SET_CONTENT                          = 109;
  PKCS7_F_PKCS7_SET_DIGEST                           = 126;
  PKCS7_F_PKCS7_SET_TYPE                             = 110;
  PKCS7_F_PKCS7_SIGN                                 = 116;
  PKCS7_F_PKCS7_SIGNATUREVERIFY                      = 113;
  PKCS7_F_PKCS7_SIGNER_INFO_SET                      = 129;
  PKCS7_F_PKCS7_SIGNER_INFO_SIGN                     = 139;
  PKCS7_F_PKCS7_SIGN_ADD_SIGNER                      = 137;
  PKCS7_F_PKCS7_SIMPLE_SMIMECAP                      = 119;
  PKCS7_F_PKCS7_VERIFY                               = 117;

  (*
   * PKCS7 reason codes.
   *)
  PKCS7_R_CERTIFICATE_VERIFY_ERROR                   = 117;
  PKCS7_R_CIPHER_HAS_NO_OBJECT_IDENTIFIER            = 144;
  PKCS7_R_CIPHER_NOT_INITIALIZED                     = 116;
  PKCS7_R_CONTENT_AND_DATA_PRESENT                   = 118;
  PKCS7_R_CTRL_ERROR                                 = 152;
  PKCS7_R_DECRYPT_ERROR                              = 119;
  PKCS7_R_DIGEST_FAILURE                             = 101;
  PKCS7_R_ENCRYPTION_CTRL_FAILURE                    = 149;
  PKCS7_R_ENCRYPTION_NOT_SUPPORTED_FOR_THIS_KEY_TYPE = 150;
  PKCS7_R_ERROR_ADDING_RECIPIENT                     = 120;
  PKCS7_R_ERROR_SETTING_CIPHER                       = 121;
  PKCS7_R_INVALID_NULL_POINTER                       = 143;
  PKCS7_R_INVALID_SIGNED_DATA_TYPE                   = 155;
  PKCS7_R_NO_CONTENT                                 = 122;
  PKCS7_R_NO_DEFAULT_DIGEST                          = 151;
  PKCS7_R_NO_MATCHING_DIGEST_TYPE_FOUND              = 154;
  PKCS7_R_NO_RECIPIENT_MATCHES_CERTIFICATE           = 115;
  PKCS7_R_NO_SIGNATURES_ON_DATA                      = 123;
  PKCS7_R_NO_SIGNERS                                 = 142;
  PKCS7_R_OPERATION_NOT_SUPPORTED_ON_THIS_TYPE       = 104;
  PKCS7_R_PKCS7_ADD_SIGNATURE_ERROR                  = 124;
  PKCS7_R_PKCS7_ADD_SIGNER_ERROR                     = 153;
  PKCS7_R_PKCS7_DATASIGN                             = 145;
  PKCS7_R_PRIVATE_KEY_DOES_NOT_MATCH_CERTIFICATE     = 127;
  PKCS7_R_SIGNATURE_FAILURE                          = 105;
  PKCS7_R_SIGNER_CERTIFICATE_NOT_FOUND               = 128;
  PKCS7_R_SIGNING_CTRL_FAILURE                       = 147;
  PKCS7_R_SIGNING_NOT_SUPPORTED_FOR_THIS_KEY_TYPE    = 148;
  PKCS7_R_SMIME_TEXT_ERROR                           = 129;
  PKCS7_R_UNABLE_TO_FIND_CERTIFICATE                 = 106;
  PKCS7_R_UNABLE_TO_FIND_MEM_BIO                     = 107;
  PKCS7_R_UNABLE_TO_FIND_MESSAGE_DIGEST              = 108;
  PKCS7_R_UNKNOWN_DIGEST_TYPE                        = 109;
  PKCS7_R_UNKNOWN_OPERATION                          = 110;
  PKCS7_R_UNSUPPORTED_CIPHER_TYPE                    = 111;
  PKCS7_R_UNSUPPORTED_CONTENT_TYPE                   = 112;
  PKCS7_R_WRONG_CONTENT_TYPE                         = 113;
  PKCS7_R_WRONG_PKCS7_TYPE                           = 114;

    { The EXTERNALSYM directive is ignored by FPC, however, it is used by Delphi as follows:
		
  	  The EXTERNALSYM directive prevents the specified Delphi symbol from appearing in header 
	  files generated for C++. }
	  
  {$EXTERNALSYM ERR_load_PKCS7_strings}

{$IFNDEF OPENSSL_STATIC_LINK_MODEL}
var
  ERR_load_PKCS7_strings: function : TIdC_INT; cdecl = nil;

{$ELSE}
  function ERR_load_PKCS7_strings: TIdC_INT cdecl; external CLibCrypto;

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
  ERR_load_PKCS7_strings_procname = 'ERR_load_PKCS7_strings';


  {$i TaurusTLSNoRetValOff.inc} 
function  ERR_ERR_load_PKCS7_strings: TIdC_INT; 
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(ERR_load_PKCS7_strings_procname);
end;



  {$i TaurusTLSNoRetValOn.inc} 
  {$i TaurusTLSUnusedParamOff.inc}
procedure Load(const ADllHandle: TIdLibHandle; LibVersion: TIdC_UINT; const AFailed: TStringList);

var FuncLoadError: boolean;

begin
  ERR_load_PKCS7_strings := LoadLibFunction(ADllHandle, ERR_load_PKCS7_strings_procname);
  FuncLoadError := not assigned(ERR_load_PKCS7_strings);
  if FuncLoadError then
  begin
    {$if not defined(ERR_load_PKCS7_strings_allownil)}
    ERR_load_PKCS7_strings := @ERR_ERR_load_PKCS7_strings;
    {$ifend}
    {$if declared(ERR_load_PKCS7_strings_introduced)}
    if LibVersion < ERR_load_PKCS7_strings_introduced then
    begin
      {$if declared(FC_ERR_load_PKCS7_strings)}
      ERR_load_PKCS7_strings := @FC_ERR_load_PKCS7_strings;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(ERR_load_PKCS7_strings_removed)}
    if ERR_load_PKCS7_strings_removed <= LibVersion then
    begin
      {$if declared(_ERR_load_PKCS7_strings)}
      ERR_load_PKCS7_strings := @_ERR_load_PKCS7_strings;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(ERR_load_PKCS7_strings_allownil)}
    if FuncLoadError then
      AFailed.Add('ERR_load_PKCS7_strings');
    {$ifend}
  end;
end;
  {$i TaurusTLSUnusedParamOn.inc}
procedure Unload;
begin
  ERR_load_PKCS7_strings := nil;
end;
{$ENDIF}

{$IFNDEF OPENSSL_STATIC_LINK_MODEL}
initialization
  Register_SSLLoader(@Load,'LibCrypto');
  Register_SSLUnloader(@Unload);
{$ENDIF}
end.

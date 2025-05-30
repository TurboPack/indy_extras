/// <exclude />
  (* This unit was generated using the script genTaurusTLSHdrs.sh from the source file TaurusTLSHeaders_engineerr.h2pas
     It should not be modified directly. All changes should be made to TaurusTLSHeaders_engineerr.h2pas
     and this file regenerated. TaurusTLSHeaders_engineerr.h2pas is distributed with the full Indy
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
unit TaurusTLSHeaders_engineerr;

interface

// Headers for OpenSSL 1.1.1
// engineerr.h


uses
  IdCTypes,
  IdGlobal
  {$IFDEF OPENSSL_STATIC_LINK_MODEL}
  , TaurusTLSConsts
  {$ENDIF};

const
  (*
   * ENGINE function codes.
   *)
  ENGINE_F_DIGEST_UPDATE = 198;
  ENGINE_F_DYNAMIC_CTRL = 180;
  ENGINE_F_DYNAMIC_GET_DATA_CTX = 181;
  ENGINE_F_DYNAMIC_LOAD = 182;
  ENGINE_F_DYNAMIC_SET_DATA_CTX = 183;
  ENGINE_F_ENGINE_ADD = 105;
  ENGINE_F_ENGINE_BY_ID = 106;
  ENGINE_F_ENGINE_CMD_IS_EXECUTABLE = 170;
  ENGINE_F_ENGINE_CTRL = 142;
  ENGINE_F_ENGINE_CTRL_CMD = 178;
  ENGINE_F_ENGINE_CTRL_CMD_STRING = 171;
  ENGINE_F_ENGINE_FINISH = 107;
  ENGINE_F_ENGINE_GET_CIPHER = 185;
  ENGINE_F_ENGINE_GET_DIGEST = 186;
  ENGINE_F_ENGINE_GET_FIRST = 195;
  ENGINE_F_ENGINE_GET_LAST = 196;
  ENGINE_F_ENGINE_GET_NEXT = 115;
  ENGINE_F_ENGINE_GET_PKEY_ASN1_METH = 193;
  ENGINE_F_ENGINE_GET_PKEY_METH = 192;
  ENGINE_F_ENGINE_GET_PREV = 116;
  ENGINE_F_ENGINE_INIT = 119;
  ENGINE_F_ENGINE_LIST_ADD = 120;
  ENGINE_F_ENGINE_LIST_REMOVE = 121;
  ENGINE_F_ENGINE_LOAD_PRIVATE_KEY = 150;
  ENGINE_F_ENGINE_LOAD_PUBLIC_KEY = 151;
  ENGINE_F_ENGINE_LOAD_SSL_CLIENT_CERT = 194;
  ENGINE_F_ENGINE_NEW = 122;
  ENGINE_F_ENGINE_PKEY_ASN1_FIND_STR = 197;
  ENGINE_F_ENGINE_REMOVE = 123;
  ENGINE_F_ENGINE_SET_DEFAULT_STRING = 189;
  ENGINE_F_ENGINE_SET_ID = 129;
  ENGINE_F_ENGINE_SET_NAME = 130;
  ENGINE_F_ENGINE_TABLE_REGISTER = 184;
  ENGINE_F_ENGINE_UNLOCKED_FINISH = 191;
  ENGINE_F_ENGINE_UP_REF = 190;
  ENGINE_F_INT_CLEANUP_ITEM = 199;
  ENGINE_F_INT_CTRL_HELPER = 172;
  ENGINE_F_INT_ENGINE_CONFIGURE = 188;
  ENGINE_F_INT_ENGINE_MODULE_INIT = 187;
  ENGINE_F_OSSL_HMAC_INIT = 200;

  (*
   * ENGINE reason codes.
   *)
  ENGINE_R_ALREADY_LOADED = 100;
  ENGINE_R_ARGUMENT_IS_NOT_A_NUMBER = 133;
  ENGINE_R_CMD_NOT_EXECUTABLE = 134;
  ENGINE_R_COMMAND_TAKES_INPUT = 135;
  ENGINE_R_COMMAND_TAKES_NO_INPUT = 136;
  ENGINE_R_CONFLICTING_ENGINE_ID = 103;
  ENGINE_R_CTRL_COMMAND_NOT_IMPLEMENTED = 119;
  ENGINE_R_DSO_FAILURE = 104;
  ENGINE_R_DSO_NOT_FOUND = 132;
  ENGINE_R_ENGINES_SECTION_ERROR = 148;
  ENGINE_R_ENGINE_CONFIGURATION_ERROR = 102;
  ENGINE_R_ENGINE_IS_NOT_IN_LIST = 105;
  ENGINE_R_ENGINE_SECTION_ERROR = 149;
  ENGINE_R_FAILED_LOADING_PRIVATE_KEY = 128;
  ENGINE_R_FAILED_LOADING_PUBLIC_KEY = 129;
  ENGINE_R_FINISH_FAILED = 106;
  ENGINE_R_ID_OR_NAME_MISSING = 108;
  ENGINE_R_INIT_FAILED = 109;
  ENGINE_R_INTERNAL_LIST_ERROR = 110;
  ENGINE_R_INVALID_ARGUMENT = 143;
  ENGINE_R_INVALID_CMD_NAME = 137;
  ENGINE_R_INVALID_CMD_NUMBER = 138;
  ENGINE_R_INVALID_INIT_VALUE = 151;
  ENGINE_R_INVALID_STRING = 150;
  ENGINE_R_NOT_INITIALISED = 117;
  ENGINE_R_NOT_LOADED = 112;
  ENGINE_R_NO_CONTROL_FUNCTION = 120;
  ENGINE_R_NO_INDEX = 144;
  ENGINE_R_NO_LOAD_FUNCTION = 125;
  ENGINE_R_NO_REFERENCE = 130;
  ENGINE_R_NO_SUCH_ENGINE = 116;
  ENGINE_R_UNIMPLEMENTED_CIPHER = 146;
  ENGINE_R_UNIMPLEMENTED_DIGEST = 147;
  ENGINE_R_UNIMPLEMENTED_PUBLIC_KEY_METHOD = 101;
  ENGINE_R_VERSION_INCOMPATIBILITY = 145;

    { The EXTERNALSYM directive is ignored by FPC, however, it is used by Delphi as follows:
		
  	  The EXTERNALSYM directive prevents the specified Delphi symbol from appearing in header 
	  files generated for C++. }
	  
  {$EXTERNALSYM ERR_load_ENGINE_strings}

{$IFNDEF OPENSSL_STATIC_LINK_MODEL}
var
  ERR_load_ENGINE_strings: function : TIdC_INT; cdecl = nil;

{$ELSE}
  function ERR_load_ENGINE_strings: TIdC_INT cdecl; external CLibCrypto;

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
  ERR_load_ENGINE_strings_procname = 'ERR_load_ENGINE_strings';


  {$i TaurusTLSNoRetValOff.inc} 
function  ERR_ERR_load_ENGINE_strings: TIdC_INT; 
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(ERR_load_ENGINE_strings_procname);
end;



  {$i TaurusTLSNoRetValOn.inc} 
  {$i TaurusTLSUnusedParamOff.inc}
procedure Load(const ADllHandle: TIdLibHandle; LibVersion: TIdC_UINT; const AFailed: TStringList);

var FuncLoadError: boolean;

begin
  ERR_load_ENGINE_strings := LoadLibFunction(ADllHandle, ERR_load_ENGINE_strings_procname);
  FuncLoadError := not assigned(ERR_load_ENGINE_strings);
  if FuncLoadError then
  begin
    {$if not defined(ERR_load_ENGINE_strings_allownil)}
    ERR_load_ENGINE_strings := @ERR_ERR_load_ENGINE_strings;
    {$ifend}
    {$if declared(ERR_load_ENGINE_strings_introduced)}
    if LibVersion < ERR_load_ENGINE_strings_introduced then
    begin
      {$if declared(FC_ERR_load_ENGINE_strings)}
      ERR_load_ENGINE_strings := @FC_ERR_load_ENGINE_strings;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(ERR_load_ENGINE_strings_removed)}
    if ERR_load_ENGINE_strings_removed <= LibVersion then
    begin
      {$if declared(_ERR_load_ENGINE_strings)}
      ERR_load_ENGINE_strings := @_ERR_load_ENGINE_strings;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(ERR_load_ENGINE_strings_allownil)}
    if FuncLoadError then
      AFailed.Add('ERR_load_ENGINE_strings');
    {$ifend}
  end;
end;
 {$i TaurusTLSUnusedParamOn.inc}

procedure Unload;
begin
  ERR_load_ENGINE_strings := nil;
end;
{$ENDIF}

{$IFNDEF OPENSSL_STATIC_LINK_MODEL}
initialization
  Register_SSLLoader(@Load,'LibCrypto');
  Register_SSLUnloader(@Unload);
{$ENDIF}
end.

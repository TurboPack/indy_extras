/// <exclude />
(* This unit was generated using the script genTaurusTLSHdrs.sh from the source file TaurusTLSHeaders_conferr.h2pas
  It should not be modified directly. All changes should be made to TaurusTLSHeaders_conferr.h2pas
  and this file regenerated. TaurusTLSHeaders_conferr.h2pas is distributed with the full Indy
  Distribution.
*)

{$I TaurusTLSCompilerDefines.inc}
{$I TaurusTLSLinkDefines.inc}
{$IFNDEF USE_OPENSSL}
{ error Should not compile if USE_OPENSSL is not defined!!! }
{$ENDIF}
{ ****************************************************************************** }
{ *  TaurusTLS                                                                 * }
{ *           https://github.com/JPeterMugaas/TaurusTLS                        * }
{ *                                                                            * }
{ *  Copyright (c) 2024 TaurusTLS Developers, All Rights Reserved              * }
{ *                                                                            * }
{ * Portions of this software are Copyright (c) 1993 – 2018,                   * }
{ * Chad Z. Hower (Kudzu) and the Indy Pit Crew – http://www.IndyProject.org/  * }
{ ****************************************************************************** }

unit TaurusTLSHeaders_conferr;

interface

// Headers for OpenSSL 1.1.1
// conferr.h

uses
  IdCTypes,
  IdGlobal;

const
  /// *
  // * CONF function codes.
  // */
  CONF_F_CONF_DUMP_FP = 104;
  CONF_F_CONF_LOAD = 100;
  CONF_F_CONF_LOAD_FP = 103;
  CONF_F_CONF_PARSE_LIST = 119;
  CONF_F_DEF_LOAD = 120;
  CONF_F_DEF_LOAD_BIO = 121;
  CONF_F_GET_NEXT_FILE = 107;
  CONF_F_MODULE_ADD = 122;
  CONF_F_MODULE_INIT = 115;
  CONF_F_MODULE_LOAD_DSO = 117;
  CONF_F_MODULE_RUN = 118;
  CONF_F_NCONF_DUMP_BIO = 105;
  CONF_F_NCONF_DUMP_FP = 106;
  CONF_F_NCONF_GET_NUMBER_E = 112;
  CONF_F_NCONF_GET_SECTION = 108;
  CONF_F_NCONF_GET_STRING = 109;
  CONF_F_NCONF_LOAD = 113;
  CONF_F_NCONF_LOAD_BIO = 110;
  CONF_F_NCONF_LOAD_FP = 114;
  CONF_F_NCONF_NEW = 111;
  CONF_F_PROCESS_INCLUDE = 116;
  CONF_F_SSL_MODULE_INIT = 123;
  CONF_F_STR_COPY = 101;

  /// *
  // * CONF reason codes.
  // */
  CONF_R_ERROR_LOADING_DSO = 110;
  CONF_R_LIST_CANNOT_BE_NULL = 115;
  CONF_R_MISSING_CLOSE_SQUARE_BRACKET = 100;
  CONF_R_MISSING_EQUAL_SIGN = 101;
  CONF_R_MISSING_INIT_FUNCTION = 112;
  CONF_R_MODULE_INITIALIZATION_ERROR = 109;
  CONF_R_NO_CLOSE_BRACE = 102;
  CONF_R_NO_CONF = 105;
  CONF_R_NO_CONF_OR_ENVIRONMENT_VARIABLE = 106;
  CONF_R_NO_SECTION = 107;
  CONF_R_NO_SUCH_FILE = 114;
  CONF_R_NO_VALUE = 108;
  CONF_R_NUMBER_TOO_LARGE = 121;
  CONF_R_RECURSIVE_DIRECTORY_INCLUDE = 111;
  CONF_R_SSL_COMMAND_SECTION_EMPTY = 117;
  CONF_R_SSL_COMMAND_SECTION_NOT_FOUND = 118;
  CONF_R_SSL_SECTION_EMPTY = 119;
  CONF_R_SSL_SECTION_NOT_FOUND = 120;
  CONF_R_UNABLE_TO_CREATE_NEW_SECTION = 103;
  CONF_R_UNKNOWN_MODULE_NAME = 113;
  CONF_R_VARIABLE_EXPANSION_TOO_LONG = 116;
  CONF_R_VARIABLE_HAS_NO_VALUE = 104;

  { The EXTERNALSYM directive is ignored by FPC, however, it is used by Delphi as follows:

    The EXTERNALSYM directive prevents the specified Delphi symbol from appearing in header
    files generated for C++. }

{$EXTERNALSYM ERR_load_CONF_strings}
{$IFNDEF OPENSSL_STATIC_LINK_MODEL}

var
  ERR_load_CONF_strings: function: TIdC_INT;
cdecl = nil;

{$ELSE}
function ERR_load_CONF_strings: TIdC_INT cdecl; external CLibCrypto;

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
  ERR_load_CONF_strings_procname = 'ERR_load_CONF_strings';

  {$i TaurusTLSNoRetValOff.inc} 

function ERR_ERR_load_CONF_strings: TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(ERR_load_CONF_strings_procname);
end;

  {$i TaurusTLSNoRetValOn.inc} 

procedure Load(const ADllHandle: TIdLibHandle; LibVersion: TIdC_UINT;
  const AFailed: TStringList);

var
  FuncLoadError: boolean;

begin
  ERR_load_CONF_strings := LoadLibFunction(ADllHandle,
    ERR_load_CONF_strings_procname);
  FuncLoadError := not assigned(ERR_load_CONF_strings);
  if FuncLoadError then
  begin
{$IF not defined(ERR_load_CONF_strings_allownil)}
    ERR_load_CONF_strings := @ERR_ERR_load_CONF_strings;
{$IFEND}
{$IF declared(ERR_load_CONF_strings_introduced)}
    if LibVersion < ERR_load_CONF_strings_introduced then
    begin
{$IF declared(FC_ERR_load_CONF_strings)}
      ERR_load_CONF_strings := @FC_ERR_load_CONF_strings;
{$IFEND}
      FuncLoadError := false;
    end;
{$IFEND}
{$IF declared(ERR_load_CONF_strings_removed)}
    if ERR_load_CONF_strings_removed <= LibVersion then
    begin
{$IF declared(_ERR_load_CONF_strings)}
      ERR_load_CONF_strings := @_ERR_load_CONF_strings;
{$IFEND}
      FuncLoadError := false;
    end;
{$IFEND}
{$IF not defined(ERR_load_CONF_strings_allownil)}
    if FuncLoadError then
      AFailed.Add('ERR_load_CONF_strings');
{$IFEND}
  end;

end;

procedure Unload;
begin
  ERR_load_CONF_strings := nil;
end;
{$ELSE}
{$ENDIF}
{$IFNDEF OPENSSL_STATIC_LINK_MODEL}

initialization

Register_SSLLoader(@Load, 'LibCrypto');
Register_SSLUnloader(@Unload);
{$ENDIF}

end.

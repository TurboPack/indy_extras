/// <exclude />
  (* This unit was generated using the script genTaurusTLSHdrs.sh from the source file TaurusTLSHeaders_uierr.h2pas
     It should not be modified directly. All changes should be made to TaurusTLSHeaders_uierr.h2pas
     and this file regenerated. TaurusTLSHeaders_uierr.h2pas is distributed with the full Indy
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
unit TaurusTLSHeaders_uierr;

interface

// Headers for OpenSSL 1.1.1
// uierr.h


uses
  IdCTypes,
  IdGlobal
  {$IFDEF OPENSSL_STATIC_LINK_MODEL}
  , TaurusTLSConsts
  {$ENDIF};

const
  (*
   * UI function codes.
   *)
  UI_F_CLOSE_CONSOLE = 115;
  UI_F_ECHO_CONSOLE = 116;
  UI_F_GENERAL_ALLOCATE_BOOLEAN = 108;
  UI_F_GENERAL_ALLOCATE_PROMPT = 109;
  UI_F_NOECHO_CONSOLE = 117;
  UI_F_OPEN_CONSOLE = 114;
  UI_F_UI_CONSTRUCT_PROMPT = 121;
  UI_F_UI_CREATE_METHOD = 112;
  UI_F_UI_CTRL = 111;
  UI_F_UI_DUP_ERROR_STRING = 101;
  UI_F_UI_DUP_INFO_STRING = 102;
  UI_F_UI_DUP_INPUT_BOOLEAN = 110;
  UI_F_UI_DUP_INPUT_STRING = 103;
  UI_F_UI_DUP_USER_DATA = 118;
  UI_F_UI_DUP_VERIFY_STRING = 106;
  UI_F_UI_GET0_RESULT = 107;
  UI_F_UI_GET_RESULT_LENGTH = 119;
  UI_F_UI_NEW_METHOD = 104;
  UI_F_UI_PROCESS = 113;
  UI_F_UI_SET_RESULT = 105;
  UI_F_UI_SET_RESULT_EX = 120;

  (*
   * UI reason codes.
   *)
  UI_R_COMMON_OK_AND_CANCEL_CHARACTERS = 104;
  UI_R_INDEX_TOO_LARGE = 102;
  UI_R_INDEX_TOO_SMALL = 103;
  UI_R_NO_RESULT_BUFFER = 105;
  UI_R_PROCESSING_ERROR = 107;
  UI_R_RESULT_TOO_LARGE = 100;
  UI_R_RESULT_TOO_SMALL = 101;
  UI_R_SYSASSIGN_ERROR = 109;
  UI_R_SYSDASSGN_ERROR = 110;
  UI_R_SYSQIOW_ERROR = 111;
  UI_R_UNKNOWN_CONTROL_COMMAND = 106;
  UI_R_UNKNOWN_TTYGET_ERRNO_VALUE = 108;
  UI_R_USER_DATA_DUPLICATION_UNSUPPORTED = 112;

    { The EXTERNALSYM directive is ignored by FPC, however, it is used by Delphi as follows:
		
  	  The EXTERNALSYM directive prevents the specified Delphi symbol from appearing in header 
	  files generated for C++. }
	  
  {$EXTERNALSYM ERR_load_UI_strings}

{$IFNDEF OPENSSL_STATIC_LINK_MODEL}
var
  ERR_load_UI_strings: function : TIdC_INT; cdecl = nil;

{$ELSE}
  function ERR_load_UI_strings: TIdC_INT cdecl; external CLibCrypto;

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
  ERR_load_UI_strings_procname = 'ERR_load_UI_strings';


  {$i TaurusTLSNoRetValOff.inc} 
function  ERR_ERR_load_UI_strings: TIdC_INT; 
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(ERR_load_UI_strings_procname);
end;



  {$i TaurusTLSNoRetValOn.inc} 
  {$i TaurusTLSUnusedParamOff.inc}
procedure Load(const ADllHandle: TIdLibHandle; LibVersion: TIdC_UINT; const AFailed: TStringList);

var FuncLoadError: boolean;

begin
  ERR_load_UI_strings := LoadLibFunction(ADllHandle, ERR_load_UI_strings_procname);
  FuncLoadError := not assigned(ERR_load_UI_strings);
  if FuncLoadError then
  begin
    {$if not defined(ERR_load_UI_strings_allownil)}
    ERR_load_UI_strings := @ERR_ERR_load_UI_strings;
    {$ifend}
    {$if declared(ERR_load_UI_strings_introduced)}
    if LibVersion < ERR_load_UI_strings_introduced then
    begin
      {$if declared(FC_ERR_load_UI_strings)}
      ERR_load_UI_strings := @FC_ERR_load_UI_strings;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(ERR_load_UI_strings_removed)}
    if ERR_load_UI_strings_removed <= LibVersion then
    begin
      {$if declared(_ERR_load_UI_strings)}
      ERR_load_UI_strings := @_ERR_load_UI_strings;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(ERR_load_UI_strings_allownil)}
    if FuncLoadError then
      AFailed.Add('ERR_load_UI_strings');
    {$ifend}
  end;
end;
  {$i TaurusTLSUnusedParamOn.inc}

procedure Unload;
begin
  ERR_load_UI_strings := nil;
end;
{$ENDIF}

{$IFNDEF OPENSSL_STATIC_LINK_MODEL}
initialization
  Register_SSLLoader(@Load,'LibCrypto');
  Register_SSLUnloader(@Unload);
{$ENDIF}
end.

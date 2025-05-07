/// <exclude />
  (* This unit was generated using the script genTaurusTLSHdrs.sh from the source file TaurusTLSHeaders_asyncerr.h2pas
     It should not be modified directly. All changes should be made to TaurusTLSHeaders_asyncerr.h2pas
     and this file regenerated. TaurusTLSHeaders_asyncerr.h2pas is distributed with the full Indy
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
unit TaurusTLSHeaders_asyncerr;

interface

// Headers for OpenSSL 1.1.1
// asyncerr.h


uses
  IdCTypes,
  IdGlobal
  {$IFDEF OPENSSL_STATIC_LINK_MODEL}
  , TaurusTLSConsts
  {$ENDIF};

const
  //
  // ASYNC function codes.
  //
  ASYNC_F_ASYNC_CTX_NEW                            = 100;
  ASYNC_F_ASYNC_INIT_THREAD                        = 101;
  ASYNC_F_ASYNC_JOB_NEW                            = 102;
  ASYNC_F_ASYNC_PAUSE_JOB                          = 103;
  ASYNC_F_ASYNC_START_FUNC                         = 104;
  ASYNC_F_ASYNC_START_JOB                          = 105;
  ASYNC_F_ASYNC_WAIT_CTX_SET_WAIT_FD               = 106;

  //
  // ASYNC reason codes.
  //
  ASYNC_R_FAILED_TO_SET_POOL                       = 101;
  ASYNC_R_FAILED_TO_SWAP_CONTEXT                   = 102;
  ASYNC_R_INIT_FAILED                              = 105;
  ASYNC_R_INVALID_POOL_SIZE                        = 103;

    { The EXTERNALSYM directive is ignored by FPC, however, it is used by Delphi as follows:
		
  	  The EXTERNALSYM directive prevents the specified Delphi symbol from appearing in header 
	  files generated for C++. }
	  
  {$EXTERNALSYM ERR_load_ASYNC_strings}

{$IFNDEF OPENSSL_STATIC_LINK_MODEL}
var
  ERR_load_ASYNC_strings: function : TIdC_INT; cdecl = nil;

{$ELSE}
  function ERR_load_ASYNC_strings: TIdC_INT cdecl; external CLibCrypto;

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
  ERR_load_ASYNC_strings_procname = 'ERR_load_ASYNC_strings';


  {$i TaurusTLSNoRetValOff.inc} 
function  ERR_ERR_load_ASYNC_strings: TIdC_INT; 
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(ERR_load_ASYNC_strings_procname);
end;



  {$i TaurusTLSNoRetValOn.inc} 
  {$i TaurusTLSUnusedParamOff.inc}
procedure Load(const ADllHandle: TIdLibHandle; LibVersion: TIdC_UINT; const AFailed: TStringList);

var FuncLoadError: boolean;

begin
  ERR_load_ASYNC_strings := LoadLibFunction(ADllHandle, ERR_load_ASYNC_strings_procname);
  FuncLoadError := not assigned(ERR_load_ASYNC_strings);
  if FuncLoadError then
  begin
    {$if not defined(ERR_load_ASYNC_strings_allownil)}
    ERR_load_ASYNC_strings := @ERR_ERR_load_ASYNC_strings;
    {$ifend}
    {$if declared(ERR_load_ASYNC_strings_introduced)}
    if LibVersion < ERR_load_ASYNC_strings_introduced then
    begin
      {$if declared(FC_ERR_load_ASYNC_strings)}
      ERR_load_ASYNC_strings := @FC_ERR_load_ASYNC_strings;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(ERR_load_ASYNC_strings_removed)}
    if ERR_load_ASYNC_strings_removed <= LibVersion then
    begin
      {$if declared(_ERR_load_ASYNC_strings)}
      ERR_load_ASYNC_strings := @_ERR_load_ASYNC_strings;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(ERR_load_ASYNC_strings_allownil)}
    if FuncLoadError then
      AFailed.Add('ERR_load_ASYNC_strings');
    {$ifend}
  end;
end;

  {$i TaurusTLSUnusedParamOn.inc}
procedure Unload;
begin
  ERR_load_ASYNC_strings := nil;
end;
{$ENDIF}

{$IFNDEF OPENSSL_STATIC_LINK_MODEL}
initialization
  Register_SSLLoader(@Load,'LibCrypto');
  Register_SSLUnloader(@Unload);
{$ENDIF}
end.

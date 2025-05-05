/// <exclude />
  (* This unit was generated using the script genTaurusTLSHdrs.sh from the source file TaurusTLSHeaders_comperr.h2pas
     It should not be modified directly. All changes should be made to TaurusTLSHeaders_comperr.h2pas
     and this file regenerated. TaurusTLSHeaders_comperr.h2pas is distributed with the full Indy
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
unit TaurusTLSHeaders_comperr;

interface

// Headers for OpenSSL 1.1.1
// comperr.h


uses
  IdCTypes,
  IdGlobal
  {$IFDEF OPENSSL_USE_SHARED_LIBRARY}
  , TaurusTLSConsts
  {$ENDIF};

const
///*
// * COMP function codes.
// */
  COMP_F_BIO_ZLIB_FLUSH =      99;
  COMP_F_BIO_ZLIB_NEW =        100;
  COMP_F_BIO_ZLIB_READ =       101;
  COMP_F_BIO_ZLIB_WRITE =      102;
  COMP_F_COMP_CTX_NEW =        103;

///*
// * COMP reason codes.
// */
  COMP_R_ZLIB_DEFLATE_ERROR =  99;
  COMP_R_ZLIB_INFLATE_ERROR =  100;
  COMP_R_ZLIB_NOT_SUPPORTED =  101;

    { The EXTERNALSYM directive is ignored by FPC, however, it is used by Delphi as follows:
		
  	  The EXTERNALSYM directive prevents the specified Delphi symbol from appearing in header 
	  files generated for C++. }
	  
  {$EXTERNALSYM ERR_load_COMP_strings}

{$IFNDEF OPENSSL_STATIC_LINK_MODEL}
var
  ERR_load_COMP_strings: function : TIdC_INT; cdecl = nil;

{$ELSE}
  function ERR_load_COMP_strings: TIdC_INT cdecl; external CLibCrypto;

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
  ERR_load_COMP_strings_procname = 'ERR_load_COMP_strings';


  {$i TaurusTLSNoRetValOff.inc} 
function  ERR_ERR_load_COMP_strings: TIdC_INT; 
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(ERR_load_COMP_strings_procname);
end;



  {$i TaurusTLSNoRetValOn.inc} 

procedure Load(const ADllHandle: TIdLibHandle; LibVersion: TIdC_UINT; const AFailed: TStringList);

var FuncLoadError: boolean;

begin
  ERR_load_COMP_strings := LoadLibFunction(ADllHandle, ERR_load_COMP_strings_procname);
  FuncLoadError := not assigned(ERR_load_COMP_strings);
  if FuncLoadError then
  begin
    {$if not defined(ERR_load_COMP_strings_allownil)}
    ERR_load_COMP_strings := @ERR_ERR_load_COMP_strings;
    {$ifend}
    {$if declared(ERR_load_COMP_strings_introduced)}
    if LibVersion < ERR_load_COMP_strings_introduced then
    begin
      {$if declared(FC_ERR_load_COMP_strings)}
      ERR_load_COMP_strings := @FC_ERR_load_COMP_strings;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(ERR_load_COMP_strings_removed)}
    if ERR_load_COMP_strings_removed <= LibVersion then
    begin
      {$if declared(_ERR_load_COMP_strings)}
      ERR_load_COMP_strings := @_ERR_load_COMP_strings;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(ERR_load_COMP_strings_allownil)}
    if FuncLoadError then
      AFailed.Add('ERR_load_COMP_strings');
    {$ifend}
  end;


end;

procedure Unload;
begin
  ERR_load_COMP_strings := nil;
end;
{$ELSE}
{$ENDIF}

{$IFNDEF OPENSSL_STATIC_LINK_MODEL}
initialization
  Register_SSLLoader(@Load,'LibCrypto');
  Register_SSLUnloader(@Unload);
{$ENDIF}
end.

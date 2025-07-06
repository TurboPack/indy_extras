/// <exclude />
(* This unit was generated using the script genTaurusTLSHdrs.sh from the source file TaurusTLSHeaders_asyncerr.h2pas
  It should not be modified directly. All changes should be made to TaurusTLSHeaders_asyncerr.h2pas
  and this file regenerated. TaurusTLSHeaders_asyncerr.h2pas is distributed with the full Indy
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
unit TaurusTLSHeaders_openssl_encoder;

interface

uses
  IdCTypes,
  IdGlobal,
{$IFDEF OPENSSL_STATIC_LINK_MODEL}
  TaurusTLSConsts,
{$ENDIF}
  TaurusTLSHeaders_types;

{$IFNDEF OPENSSL_STATIC_LINK_MODEL}

type
  OSSL_ENCODER_do_all_provided_fn = procedure(encoder: POSSL_ENCODER;
    arg: Pointer); cdecl;
  OSSL_ENCODER_names_do_all_fn = procedure(name: PIdAnsiChar;
    data: Pointer); cdecl;

var
  OSSL_ENCODER_fetch: function(libctx: POSSL_LIB_CTX; name: PIdAnsiChar;
    properties: PIdAnsiChar): POSSL_ENCODER; cdecl = nil;
  OSSL_ENCODER_up_ref: function(encoder: POSSL_ENCODER): TIdC_INT;  cdecl = nil;
  OSSL_ENCODER_free: procedure(encoder: POSSL_ENCODER);  cdecl = nil;

  OSSL_ENCODER_get0_provider:  function(encoder: POSSL_ENCODER): POSSL_PROVIDER;
    cdecl = nil;
  OSSL_ENCODER_get0_properties:  function(encoder: POSSL_ENCODER): PIdAnsiChar;
    cdecl = nil;
  OSSL_ENCODER_get0_name: function(kdf: POSSL_ENCODER): PIdAnsiChar;
    cdecl = nil;
  OSSL_ENCODER_get0_description: function(kdf: POSSL_ENCODER): PIdAnsiChar;
    cdecl = nil;
  OSSL_ENCODER_is_a: function(encoder: POSSL_ENCODER; name: PIdAnsiChar): TIdC_INT;
    cdecl = nil;

  OSSL_ENCODER_do_all_provided:  procedure(libctx: POSSL_LIB_CTX;
    fn: OSSL_ENCODER_do_all_provided_fn; arg: Pointer);  cdecl = nil;
  OSSL_ENCODER_names_do_all:  function(encoder: POSSL_ENCODER;
    fn: OSSL_ENCODER_names_do_all_fn; data: Pointer): TIdC_INT;  cdecl = nil;
  OSSL_ENCODER_gettable_params:  function(encoder: POSSL_ENCODER): POSSL_PARAM;
    cdecl = nil;
  OSSL_ENCODER_get_params: function(encoder: POSSL_ENCODER;
     params: Array of OSSL_PARAM): TIdC_INT; cdecl = nil;

{$ELSE}
function OSSL_ENCODER_fetch(libctx: POSSL_LIB_CTX; name: PIdAnsiChar;
  properties: PIdAnsiChar): POSSL_ENCODER cdecl; external CLibCrypto;
function OSSL_ENCODER_up_ref(encoder: POSSL_ENCODER): TIdC_INT cdecl;
  external CLibCrypto;
procedure OSSL_ENCODER_free(encoder: POSSL_ENCODER)cdecl; external CLibCrypto;

function OSSL_ENCODER_get0_provider(encoder: POSSL_ENCODER)
  : POSSL_PROVIDER cdecl; external CLibCrypto;
function OSSL_ENCODER_get0_properties(encoder: POSSL_ENCODER)
  : PIdAnsiChar cdecl; external CLibCrypto;
function OSSL_ENCODER_get0_name(kdf: POSSL_ENCODER): PIdAnsiChar cdecl;
  external CLibCrypto;
function OSSL_ENCODER_get0_description(kdf: POSSL_ENCODER): PIdAnsiChar cdecl;
  external CLibCrypto;
function OSSL_ENCODER_is_a(encoder: POSSL_ENCODER; name: PIdAnsiChar)
  : TIdC_INT cdecl; external CLibCrypto;;

procedure OSSL_ENCODER_do_all_provided(libctx: POSSL_LIB_CTX;
  fn: OSSL_ENCODER_do_all_provided_fn; arg: Pointer)cdecl; external CLibCrypto;
function OSSL_ENCODER_names_do_all(encoder: POSSL_ENCODER;
  fn: OSSL_ENCODER_names_do_all_fn; data: Pointer): TIdC_INT cdecl;
  external CLibCrypto;
function OSSL_ENCODER_gettable_params(encoder: POSSL_ENCODER)
  : POSSL_PARAM cdecl; external CLibCrypto;
function OSSL_ENCODER_get_params(encoder: POSSL_ENCODER;
  params: Array of OSSL_PARAM): TIdC_INT cdecl; external CLibCrypto;

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
  OSSL_ENCODER_fetch_introduced = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  OSSL_ENCODER_up_ref_introduced = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  OSSL_ENCODER_free_introduced = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);

  OSSL_ENCODER_get0_provider_introduced = (byte(3) shl 8 or byte(0))
    shl 8 or byte(0);
  OSSL_ENCODER_get0_properties_introduced = (byte(3) shl 8 or byte(0))
    shl 8 or byte(0);
  OSSL_ENCODER_get0_name_introduced = (byte(3) shl 8 or byte(0))
    shl 8 or byte(0);
  OSSL_ENCODER_get0_description_introduced = (byte(3) shl 8 or byte(0))
    shl 8 or byte(0);
  OSSL_ENCODER_is_a_introduced = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  OSSL_ENCODER_do_all_provided_introduced = (byte(3) shl 8 or byte(0))
    shl 8 or byte(0);
  OSSL_ENCODER_names_do_all_introduced = (byte(3) shl 8 or byte(0))
    shl 8 or byte(0);
  OSSL_ENCODER_gettable_params_introduced = (byte(3) shl 8 or byte(0))
    shl 8 or byte(0);
  OSSL_ENCODER_get_params_introduced = (byte(3) shl 8 or byte(0))
    shl 8 or byte(0);

const
  OSSL_ENCODER_fetch_procname = 'OSSL_ENCODER_fetch';
  OSSL_ENCODER_up_ref_procname = 'OSSL_ENCODER_up_ref';
  OSSL_ENCODER_free_procname = 'OSSL_ENCODER_free';

  OSSL_ENCODER_get0_provider_procname = 'OSSL_ENCODER_get0_provider';
  OSSL_ENCODER_get0_properties_procname = 'OSSL_ENCODER_get0_properties';
  OSSL_ENCODER_get0_name_procname = 'OSSL_ENCODER_get0_name';
  OSSL_ENCODER_get0_description_procname = 'OSSL_ENCODER_get0_description';
  OSSL_ENCODER_is_a_procname = 'OSSL_ENCODER_is_a';

  OSSL_ENCODER_do_all_provided_procname = 'OSSL_ENCODER_do_all_provided';
  OSSL_ENCODER_names_do_all_procname = 'OSSL_ENCODER_names_do_all';
  OSSL_ENCODER_gettable_params_procname = 'OSSL_ENCODER_gettable_params';
  OSSL_ENCODER_get_params_procname = 'OSSL_ENCODER_get_params';

{$I TaurusTLSNoRetValOff.inc}

function ERR_OSSL_ENCODER_fetch(libctx: POSSL_LIB_CTX; name: PIdAnsiChar;
  properties: PIdAnsiChar): POSSL_ENCODER;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(OSSL_ENCODER_fetch_procname);
end;

function ERR_OSSL_ENCODER_up_ref(encoder: POSSL_ENCODER): TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(OSSL_ENCODER_up_ref_procname);
end;

procedure ERR_OSSL_ENCODER_free(encoder: POSSL_ENCODER);
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(OSSL_ENCODER_free_procname);
end;

function ERR_OSSL_ENCODER_get0_provider(encoder: POSSL_ENCODER): POSSL_PROVIDER;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException
    (OSSL_ENCODER_get0_provider_procname);
end;

function ERR_OSSL_ENCODER_get0_properties(encoder: POSSL_ENCODER): PIdAnsiChar;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException
    (OSSL_ENCODER_get0_properties_procname);
end;

function ERR_OSSL_ENCODER_get0_name(kdf: POSSL_ENCODER): PIdAnsiChar;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException
    (OSSL_ENCODER_get0_name_procname);
end;

function ERR_OSSL_ENCODER_get0_description(kdf: POSSL_ENCODER): PIdAnsiChar;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException
    (OSSL_ENCODER_get0_description_procname);
end;

function ERR_OSSL_ENCODER_is_a(encoder: POSSL_ENCODER; name: PIdAnsiChar)
  : TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(OSSL_ENCODER_is_a_procname);
end;

procedure ERR_OSSL_ENCODER_do_all_provided(libctx: POSSL_LIB_CTX;
  fn: OSSL_ENCODER_do_all_provided_fn; arg: Pointer);
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException
    (OSSL_ENCODER_do_all_provided_procname);
end;

function ERR_OSSL_ENCODER_names_do_all(encoder: POSSL_ENCODER;
  fn: OSSL_ENCODER_names_do_all_fn; data: Pointer): TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException
    (OSSL_ENCODER_names_do_all_procname);
end;

function ERR_OSSL_ENCODER_gettable_params(encoder: POSSL_ENCODER): POSSL_PARAM;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException
    (OSSL_ENCODER_gettable_params_procname);
end;

function ERR_OSSL_ENCODER_get_params(encoder: POSSL_ENCODER;
  params: Array of OSSL_PARAM): TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException
    (OSSL_ENCODER_get_params_procname);
end;

{$I TaurusTLSNoRetValOn.inc}
{$I TaurusTLSUnusedParamOff.inc}

procedure Load(const ADllHandle: TIdLibHandle; LibVersion: TIdC_UINT;
  const AFailed: TStringList);

var
  FuncLoadError: boolean;

begin
  OSSL_ENCODER_fetch := LoadLibFunction(ADllHandle,
    OSSL_ENCODER_fetch_procname);
  FuncLoadError := not assigned(OSSL_ENCODER_fetch);
  if FuncLoadError then
  begin
{$IF not defined(OSSL_ENCODER_fetch_allownil)}
    OSSL_ENCODER_fetch := @ERR_OSSL_ENCODER_fetch;
{$IFEND}
{$IF declared(OSSL_ENCODER_fetch_introduced)}
    if LibVersion < OSSL_ENCODER_fetch_introduced then
    begin
{$IF declared(FC_OSSL_ENCODER_fetch)}
      OSSL_ENCODER_fetch := @FC_OSSL_ENCODER_fetch;
{$IFEND}
      FuncLoadError := false;
    end;
{$IFEND}
{$IF declared(OSSL_ENCODER_fetch_removed)}
    if OSSL_ENCODER_fetch_removed <= LibVersion then
    begin
{$IF declared(_OSSL_ENCODER_fetch)}
      OSSL_ENCODER_fetch := @_OSSL_ENCODER_fetch;
{$IFEND}
      FuncLoadError := false;
    end;
{$IFEND}
{$IF not defined(OSSL_ENCODER_fetch_allownil)}
    if FuncLoadError then
      AFailed.Add('OSSL_ENCODER_fetch');
{$IFEND}
  end;

  OSSL_ENCODER_up_ref := LoadLibFunction(ADllHandle,
    OSSL_ENCODER_up_ref_procname);
  FuncLoadError := not assigned(OSSL_ENCODER_up_ref);
  if FuncLoadError then
  begin
{$IF not defined(OSSL_ENCODER_up_ref_allownil)}
    OSSL_ENCODER_up_ref := @ERR_OSSL_ENCODER_up_ref;
{$IFEND}
{$IF declared(OSSL_ENCODER_up_ref_introduced)}
    if LibVersion < OSSL_ENCODER_up_ref_introduced then
    begin
{$IF declared(FC_OSSL_ENCODER_up_ref)}
      OSSL_ENCODER_up_ref := @FC_OSSL_ENCODER_up_ref;
{$IFEND}
      FuncLoadError := false;
    end;
{$IFEND}
{$IF declared(OSSL_ENCODER_up_ref_removed)}
    if OSSL_ENCODER_up_ref_removed <= LibVersion then
    begin
{$IF declared(_OSSL_ENCODER_up_ref)}
      OSSL_ENCODER_up_ref := @_OSSL_ENCODER_up_ref;
{$IFEND}
      FuncLoadError := false;
    end;
{$IFEND}
{$IF not defined(OSSL_ENCODER_up_ref_allownil)}
    if FuncLoadError then
      AFailed.Add('OSSL_ENCODER_up_ref');
{$IFEND}
  end;

  OSSL_ENCODER_free := LoadLibFunction(ADllHandle, OSSL_ENCODER_free_procname);
  FuncLoadError := not assigned(OSSL_ENCODER_free);
  if FuncLoadError then
  begin
{$IF not defined(OSSL_ENCODER_free_allownil)}
    OSSL_ENCODER_free := @ERR_OSSL_ENCODER_free;
{$IFEND}
{$IF declared(OSSL_ENCODER_free_introduced)}
    if LibVersion < OSSL_ENCODER_free_introduced then
    begin
{$IF declared(FC_OSSL_ENCODER_free)}
      OSSL_ENCODER_free := @FC_OSSL_ENCODER_free;
{$IFEND}
      FuncLoadError := false;
    end;
{$IFEND}
{$IF declared(OSSL_ENCODER_free_removed)}
    if OSSL_ENCODER_free_removed <= LibVersion then
    begin
{$IF declared(_OSSL_ENCODER_free)}
      OSSL_ENCODER_free := @_OSSL_ENCODER_free;
{$IFEND}
      FuncLoadError := false;
    end;
{$IFEND}
{$IF not defined(OSSL_ENCODER_free_allownil)}
    if FuncLoadError then
      AFailed.Add('OSSL_ENCODER_free');
{$IFEND}
  end;

  OSSL_ENCODER_get0_provider := LoadLibFunction(ADllHandle,
    OSSL_ENCODER_get0_provider_procname);
  FuncLoadError := not assigned(OSSL_ENCODER_get0_provider);
  if FuncLoadError then
  begin
{$IF not defined(OSSL_ENCODER_get0_provider_allownil)}
    OSSL_ENCODER_get0_provider := @ERR_OSSL_ENCODER_get0_provider;
{$IFEND}
{$IF declared(OSSL_ENCODER_get0_provider_introduced)}
    if LibVersion < OSSL_ENCODER_get0_provider_introduced then
    begin
{$IF declared(FC_OSSL_ENCODER_get0_provider)}
      OSSL_ENCODER_get0_provider := @FC_OSSL_ENCODER_get0_provider;
{$IFEND}
      FuncLoadError := false;
    end;
{$IFEND}
{$IF declared(OSSL_ENCODER_get0_provider_removed)}
    if OSSL_ENCODER_get0_provider_removed <= LibVersion then
    begin
{$IF declared(_OSSL_ENCODER_get0_provider)}
      OSSL_ENCODER_get0_provider := @_OSSL_ENCODER_get0_provider;
{$IFEND}
      FuncLoadError := false;
    end;
{$IFEND}
{$IF not defined(OSSL_ENCODER_get0_provider_allownil)}
    if FuncLoadError then
      AFailed.Add('OSSL_ENCODER_get0_provider');
{$IFEND}
  end;

  OSSL_ENCODER_get0_properties := LoadLibFunction(ADllHandle,
    OSSL_ENCODER_get0_properties_procname);
  FuncLoadError := not assigned(OSSL_ENCODER_get0_properties);
  if FuncLoadError then
  begin
{$IF not defined(OSSL_ENCODER_get0_properties_allownil)}
    OSSL_ENCODER_get0_properties := @ERR_OSSL_ENCODER_get0_properties;
{$IFEND}
{$IF declared(OSSL_ENCODER_get0_properties_introduced)}
    if LibVersion < OSSL_ENCODER_get0_properties_introduced then
    begin
{$IF declared(FC_OSSL_ENCODER_get0_properties)}
      OSSL_ENCODER_get0_properties := @FC_OSSL_ENCODER_get0_properties;
{$IFEND}
      FuncLoadError := false;
    end;
{$IFEND}
{$IF declared(OSSL_ENCODER_get0_properties_removed)}
    if OSSL_ENCODER_get0_properties_removed <= LibVersion then
    begin
{$IF declared(_OSSL_ENCODER_get0_properties)}
      OSSL_ENCODER_get0_properties := @_OSSL_ENCODER_get0_properties;
{$IFEND}
      FuncLoadError := false;
    end;
{$IFEND}
{$IF not defined(OSSL_ENCODER_get0_properties_allownil)}
    if FuncLoadError then
      AFailed.Add('OSSL_ENCODER_get0_properties');
{$IFEND}
  end;

  OSSL_ENCODER_get0_name := LoadLibFunction(ADllHandle,
    OSSL_ENCODER_get0_name_procname);
  FuncLoadError := not assigned(OSSL_ENCODER_get0_name);
  if FuncLoadError then
  begin
{$IF not defined(OSSL_ENCODER_get0_name_allownil)}
    OSSL_ENCODER_get0_name := @ERR_OSSL_ENCODER_get0_name;
{$IFEND}
{$IF declared(OSSL_ENCODER_get0_name_introduced)}
    if LibVersion < OSSL_ENCODER_get0_name_introduced then
    begin
{$IF declared(FC_OSSL_ENCODER_get0_name)}
      OSSL_ENCODER_get0_name := @FC_OSSL_ENCODER_get0_name;
{$IFEND}
      FuncLoadError := false;
    end;
{$IFEND}
{$IF declared(OSSL_ENCODER_get0_name_removed)}
    if OSSL_ENCODER_get0_name_removed <= LibVersion then
    begin
{$IF declared(_OSSL_ENCODER_get0_name)}
      OSSL_ENCODER_get0_name := @_OSSL_ENCODER_get0_name;
{$IFEND}
      FuncLoadError := false;
    end;
{$IFEND}
{$IF not defined(OSSL_ENCODER_get0_name_allownil)}
    if FuncLoadError then
      AFailed.Add('OSSL_ENCODER_get0_name');
{$IFEND}
  end;

  OSSL_ENCODER_get0_description := LoadLibFunction(ADllHandle,
    OSSL_ENCODER_get0_description_procname);
  FuncLoadError := not assigned(OSSL_ENCODER_get0_description);
  if FuncLoadError then
  begin
{$IF not defined(OSSL_ENCODER_get0_description_allownil)}
    OSSL_ENCODER_get0_description := @ERR_OSSL_ENCODER_get0_description;
{$IFEND}
{$IF declared(OSSL_ENCODER_get0_description_introduced)}
    if LibVersion < OSSL_ENCODER_get0_description_introduced then
    begin
{$IF declared(FC_OSSL_ENCODER_get0_description)}
      OSSL_ENCODER_get0_description := @FC_OSSL_ENCODER_get0_description;
{$IFEND}
      FuncLoadError := false;
    end;
{$IFEND}
{$IF declared(OSSL_ENCODER_get0_description_removed)}
    if OSSL_ENCODER_get0_description_removed <= LibVersion then
    begin
{$IF declared(_OSSL_ENCODER_get0_description)}
      OSSL_ENCODER_get0_description := @_OSSL_ENCODER_get0_description;
{$IFEND}
      FuncLoadError := false;
    end;
{$IFEND}
{$IF not defined(OSSL_ENCODER_get0_description_allownil)}
    if FuncLoadError then
      AFailed.Add('OSSL_ENCODER_get0_description');
{$IFEND}
  end;

  OSSL_ENCODER_is_a := LoadLibFunction(ADllHandle, OSSL_ENCODER_is_a_procname);
  FuncLoadError := not assigned(OSSL_ENCODER_is_a);
  if FuncLoadError then
  begin
{$IF not defined(OSSL_ENCODER_is_a_allownil)}
    OSSL_ENCODER_is_a := @ERR_OSSL_ENCODER_is_a;
{$IFEND}
{$IF declared(OSSL_ENCODER_is_a_introduced)}
    if LibVersion < OSSL_ENCODER_is_a_introduced then
    begin
{$IF declared(FC_OSSL_ENCODER_is_a)}
      OSSL_ENCODER_is_a := @FC_OSSL_ENCODER_is_a;
{$IFEND}
      FuncLoadError := false;
    end;
{$IFEND}
{$IF declared(OSSL_ENCODER_is_a_removed)}
    if OSSL_ENCODER_is_a_removed <= LibVersion then
    begin
{$IF declared(_OSSL_ENCODER_is_a)}
      OSSL_ENCODER_is_a := @_OSSL_ENCODER_is_a;
{$IFEND}
      FuncLoadError := false;
    end;
{$IFEND}
{$IF not defined(OSSL_ENCODER_is_a_allownil)}
    if FuncLoadError then
      AFailed.Add('OSSL_ENCODER_is_a');
{$IFEND}
  end;

  OSSL_ENCODER_do_all_provided := LoadLibFunction(ADllHandle,
    OSSL_ENCODER_do_all_provided_procname);
  FuncLoadError := not assigned(OSSL_ENCODER_do_all_provided);
  if FuncLoadError then
  begin
{$IF not defined(OSSL_ENCODER_do_all_provided_allownil)}
    OSSL_ENCODER_do_all_provided := @ERR_OSSL_ENCODER_do_all_provided;
{$IFEND}
{$IF declared(OSSL_ENCODER_do_all_provided_introduced)}
    if LibVersion < OSSL_ENCODER_do_all_provided_introduced then
    begin
{$IF declared(FC_OSSL_ENCODER_do_all_provided)}
      OSSL_ENCODER_do_all_provided := @FC_OSSL_ENCODER_do_all_provided;
{$IFEND}
      FuncLoadError := false;
    end;
{$IFEND}
{$IF declared(OSSL_ENCODER_do_all_provided_removed)}
    if OSSL_ENCODER_do_all_provided_removed <= LibVersion then
    begin
{$IF declared(_OSSL_ENCODER_do_all_provided)}
      OSSL_ENCODER_do_all_provided := @_OSSL_ENCODER_do_all_provided;
{$IFEND}
      FuncLoadError := false;
    end;
{$IFEND}
{$IF not defined(OSSL_ENCODER_do_all_provided_allownil)}
    if FuncLoadError then
      AFailed.Add('OSSL_ENCODER_do_all_provided');
{$IFEND}
  end;

  OSSL_ENCODER_names_do_all := LoadLibFunction(ADllHandle,
    OSSL_ENCODER_names_do_all_procname);
  FuncLoadError := not assigned(OSSL_ENCODER_names_do_all);
  if FuncLoadError then
  begin
{$IF not defined(OSSL_ENCODER_names_do_all_allownil)}
    OSSL_ENCODER_names_do_all := @ERR_OSSL_ENCODER_names_do_all;
{$IFEND}
{$IF declared(OSSL_ENCODER_names_do_all_introduced)}
    if LibVersion < OSSL_ENCODER_names_do_all_introduced then
    begin
{$IF declared(FC_OSSL_ENCODER_names_do_all)}
      OSSL_ENCODER_names_do_all := @FC_OSSL_ENCODER_names_do_all;
{$IFEND}
      FuncLoadError := false;
    end;
{$IFEND}
{$IF declared(OSSL_ENCODER_names_do_all_removed)}
    if OSSL_ENCODER_names_do_all_removed <= LibVersion then
    begin
{$IF declared(_OSSL_ENCODER_names_do_all)}
      OSSL_ENCODER_names_do_all := @_OSSL_ENCODER_names_do_all;
{$IFEND}
      FuncLoadError := false;
    end;
{$IFEND}
{$IF not defined(OSSL_ENCODER_names_do_all_allownil)}
    if FuncLoadError then
      AFailed.Add('OSSL_ENCODER_names_do_all');
{$IFEND}
  end;

  OSSL_ENCODER_gettable_params := LoadLibFunction(ADllHandle,
    OSSL_ENCODER_gettable_params_procname);
  FuncLoadError := not assigned(OSSL_ENCODER_gettable_params);
  if FuncLoadError then
  begin
{$IF not defined(OSSL_ENCODER_gettable_params_allownil)}
    OSSL_ENCODER_gettable_params := @ERR_OSSL_ENCODER_gettable_params;
{$IFEND}
{$IF declared(OSSL_ENCODER_gettable_params_introduced)}
    if LibVersion < OSSL_ENCODER_gettable_params_introduced then
    begin
{$IF declared(FC_OSSL_ENCODER_gettable_params)}
      OSSL_ENCODER_gettable_params := @FC_OSSL_ENCODER_gettable_params;
{$IFEND}
      FuncLoadError := false;
    end;
{$IFEND}
{$IF declared(OSSL_ENCODER_gettable_params_removed)}
    if OSSL_ENCODER_gettable_params_removed <= LibVersion then
    begin
{$IF declared(_OSSL_ENCODER_gettable_params)}
      OSSL_ENCODER_gettable_params := @_OSSL_ENCODER_gettable_params;
{$IFEND}
      FuncLoadError := false;
    end;
{$IFEND}
{$IF not defined(OSSL_ENCODER_gettable_params_allownil)}
    if FuncLoadError then
      AFailed.Add('OSSL_ENCODER_gettable_params');
{$IFEND}
  end;

  OSSL_ENCODER_get_params := LoadLibFunction(ADllHandle,
    OSSL_ENCODER_get_params_procname);
  FuncLoadError := not assigned(OSSL_ENCODER_get_params);
  if FuncLoadError then
  begin
{$IF not defined(OSSL_ENCODER_get_params_allownil)}
    OSSL_ENCODER_get_params := @ERR_OSSL_ENCODER_get_params;
{$IFEND}
{$IF declared(OSSL_ENCODER_get_params_introduced)}
    if LibVersion < OSSL_ENCODER_get_params_introduced then
    begin
{$IF declared(FC_OSSL_ENCODER_get_params)}
      OSSL_ENCODER_get_params := @FC_OSSL_ENCODER_get_params;
{$IFEND}
      FuncLoadError := false;
    end;
{$IFEND}
{$IF declared(OSSL_ENCODER_get_params_removed)}
    if OSSL_ENCODER_get_params_removed <= LibVersion then
    begin
{$IF declared(_OSSL_ENCODER_get_params)}
      OSSL_ENCODER_get_params := @_OSSL_ENCODER_get_params;
{$IFEND}
      FuncLoadError := false;
    end;
{$IFEND}
{$IF not defined(OSSL_ENCODER_get_params_allownil)}
    if FuncLoadError then
      AFailed.Add('OSSL_ENCODER_get_params');
{$IFEND}
  end;
end;

{$I TaurusTLSUnusedParamOn.inc}

procedure Unload;
begin
  OSSL_ENCODER_fetch := nil;
  OSSL_ENCODER_up_ref := nil;
  OSSL_ENCODER_free := nil;

  OSSL_ENCODER_get0_provider := nil;
  OSSL_ENCODER_get0_properties := nil;
  OSSL_ENCODER_get0_name := nil;
  OSSL_ENCODER_get0_description := nil;
  OSSL_ENCODER_is_a := nil;

  OSSL_ENCODER_do_all_provided := nil;
  OSSL_ENCODER_names_do_all := nil;
  OSSL_ENCODER_gettable_params := nil;
  OSSL_ENCODER_get_params := nil;
end;
{$ENDIF}
{$IFNDEF OPENSSL_STATIC_LINK_MODEL}

initialization

Register_SSLLoader(@Load, 'LibCrypto');
Register_SSLUnloader(@Unload);
{$ENDIF}

end.

unit TaurusTLSHeaders_ct;

{$i TaurusTLSCompilerDefines.inc}
{$i TaurusTLSLinkDefines.inc}
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

interface

uses
  IdCTypes,
  IdGlobal,
  TaurusTLSHeaders_ossl_typ,
  TaurusTLSHeaders_sha,
  TaurusTLSHeaders_stack,
  TaurusTLSHeaders_x509;

const
//* Minimum RSA key size, from RFC6962 */
   SCT_MIN_RSA_BITS = 2048;

//* All hashes are SHA256 in v1 of Certificate Transparency */
   CT_V1_HASHLEN = SHA256_DIGEST_LENGTH;

type
  PSTACK_OF_SCT = type pointer;
  PSTACK_OF_CTLOG = type pointer;
  ct_log_entry_type_t = (CT_LOG_ENTRY_TYPE_NOT_SET = -1,
    CT_LOG_ENTRY_TYPE_X509 = 0, CT_LOG_ENTRY_TYPE_PRECERT = 1);
  sct_version_t = (SCT_VERSION_NOT_SET = -1, SCT_VERSION_V1 = 0);
  sct_source_t = (SCT_SOURCE_UNKNOWN, SCT_SOURCE_TLS_EXTENSION,
    SCT_SOURCE_X509V3_EXTENSION, SCT_SOURCE_OCSP_STAPLED_RESPONSE);
  sct_validation_status_t = (SCT_VALIDATION_STATUS_NOT_SET,
    SCT_VALIDATION_STATUS_UNKNOWN_LOG, SCT_VALIDATION_STATUS_VALID,
    SCT_VALIDATION_STATUS_INVALID, SCT_VALIDATION_STATUS_UNVERIFIED,
    SCT_VALIDATION_STATUS_UNKNOWN_VERSION);

{$IFNDEF OPENSSL_STATIC_LINK_MODEL}

var
  CT_POLICY_EVAL_CTX_new: function(): PCT_POLICY_EVAL_CTX; cdecl = nil;
  CT_POLICY_EVAL_CTX_free: procedure(ctx: PCT_POLICY_EVAL_CTX); cdecl = nil;
  CT_POLICY_EVAL_CTX_get0_cert: function(const ctx : PCT_POLICY_EVAL_CTX): PX509; cdecl = nil;
  CT_POLICY_EVAL_CTX_set1_cert: function(ctx : PCT_POLICY_EVAL_CTX; cert : PX509) : TIdC_INT; cdecl = nil;
  CT_POLICY_EVAL_CTX_get0_issuer: function(const ctx : PCT_POLICY_EVAL_CTX) : PX509; cdecl = nil;
  CT_POLICY_EVAL_CTX_set1_issuer: function(ctx : PCT_POLICY_EVAL_CTX; issuer : PX509) : TIdC_INT; cdecl = nil;
  CT_POLICY_EVAL_CTX_get0_log_store: function(const ctx : PCT_POLICY_EVAL_CTX) : PCTLOG_STORE; cdecl = nil;
  CT_POLICY_EVAL_CTX_set_shared_CTLOG_STORE : procedure(ctx : PCT_POLICY_EVAL_CTX;
                                                        log_store : PCTLOG_STORE); cdecl = nil;
  CT_POLICY_EVAL_CTX_get_time : function(const ctx : PCT_POLICY_EVAL_CTX) : TIdC_UINT64; cdecl = nil;
  CT_POLICY_EVAL_CTX_set_time : procedure(ctx : PCT_POLICY_EVAL_CTX; time_in_ms : TIdC_UINT64); cdecl = nil;
{$ELSE}
function CT_POLICY_EVAL_CTX_new(): PCT_POLICY_EVAL_CTX cdecl; external CLibCrypto;
procedure CT_POLICY_EVAL_CTX_free(ctx: PCT_POLICY_EVAL_CTX) cdeckl; external CLibCrypto;
function CT_POLICY_EVAL_CTX_get0_cert(const ctx : PCT_POLICY_EVAL_CTX) : PX509 cdecl; external CLibCrypto;
function CT_POLICY_EVAL_CTX_set1_cert(ctx PCT_POLICY_EVAL_CTX; cert : PX509) : TIdC_INT cdecl; external CLibCrypto;
function CT_POLICY_EVAL_CTX_get0_issuer(const ctx : PCT_POLICY_EVAL_CTX) : PX509 cdecl; external CLibCrypto;
function CT_POLICY_EVAL_CTX_set1_issuer(ctx : PCT_POLICY_EVAL_CTX; issuer : PX509) : TIdC_INT cdecl; external CLibCrypto;
function CT_POLICY_EVAL_CTX_get0_log_store(const ctx : PCT_POLICY_EVAL_CTX) : PCTLOG_STORE cdecl; external CLibCrypto;
procedure CT_POLICY_EVAL_CTX_set_shared_CTLOG_STORE(ctx : PCT_POLICY_EVAL_CTX;
                                                    log_store : PCTLOG_STORE) cdecl; external CLibCrypto;
function CT_POLICY_EVAL_CTX_get_time(const ctx : PCT_POLICY_EVAL_CTX) : TIdC_UINT64 cdecl; external CLibCrypto;
procedure CT_POLICY_EVAL_CTX_set_time(ctx : PCT_POLICY_EVAL_CTX; time_in_ms : TIdC_UINT64) cdecl; external CLibCrypto;
{$ENDIF}

{$IFNDEF OPENSSL_STATIC_LINK_MODEL}
type
  Tsk_SCT_new = function(cmp: TOPENSSL_sk_compfunc): PSTACK_OF_SCT cdecl;
  Tsk_SCT_new_null = function: PSTACK_OF_SCT cdecl;
  Tsk_SCT_free = procedure(st: PSTACK_OF_SCT) cdecl;
  Tsk_SCT_num = function(const sk: PSTACK_OF_SCT): TIdC_INT cdecl;
  Tsk_SCT_value = function(const sk: PSTACK_OF_SCT; i: TIdC_INT): PSCT cdecl;
  Tsk_SCT_push = function(sk: PSTACK_OF_SCT; st: PSCT): TIdC_INT cdecl;
  Tsk_SCT_dup = function(sk: PSTACK_OF_SCT): PSTACK_OF_SCT cdecl;
  Tsk_SCT_find = function(sk: PSTACK_OF_SCT; _val: PSCT): TIdC_INT cdecl;
  Tsk_SCT_pop_free = procedure(sk: PSTACK_OF_SCT; func: TOPENSSL_sk_freefunc)cdecl;

  Tsk_CTLOG_new = function(cmp: TOPENSSL_sk_compfunc): PSTACK_OF_CTLOG cdecl;
  Tsk_CTLOG_new_null = function: PSTACK_OF_CTLOG cdecl;
  Tsk_CTLOG_free = procedure(st: PSTACK_OF_CTLOG) cdecl;
  Tsk_CTLOG_num = function(const sk: PSTACK_OF_CTLOG): TIdC_INT cdecl;
  Tsk_CTLOG_value = function(const sk: PSTACK_OF_CTLOG; i: TIdC_INT): PCTLOG cdecl;
  Tsk_CTLOG_push = function(sk: PSTACK_OF_CTLOG; st: PCTLOG): TIdC_INT cdecl;
  Tsk_CTLOG_dup = function(sk: PSTACK_OF_CTLOG): PSTACK_OF_CTLOG cdecl;
  Tsk_CTLOG_find = function(sk: PSTACK_OF_CTLOG; _val: PCTLOG): TIdC_INT cdecl;
  Tsk_CTLOG_pop_free = procedure(sk: PSTACK_OF_CTLOG; func: TOPENSSL_sk_freefunc)cdecl;

var
  sk_SCT_new: Tsk_SCT_new absolute sk_new;
  sk_SCT_new_null: Tsk_SCT_new_null absolute sk_new_null;
  sk_SCT_free: Tsk_SCT_free absolute sk_free;
  sk_SCT_num: Tsk_SCT_num absolute sk_num;
  sk_SCT_value: Tsk_SCT_value absolute sk_value;
  sk_SCT_push: Tsk_SCT_push absolute sk_push;
  sk_SCT_dup: Tsk_SCT_dup absolute sk_dup;
  sk_SCT_find: Tsk_SCT_find absolute sk_find;
  sk_SCT_pop_free: Tsk_SCT_pop_free absolute sk_pop_free;

  sk_CTLOG_new: Tsk_CTLOG_new absolute sk_new;
  sk_CTLOG_new_null: Tsk_CTLOG_new_null absolute sk_new_null;
  sk_CTLOG_free: Tsk_CTLOG_free absolute sk_free;
  sk_CTLOG_num: Tsk_CTLOG_num absolute sk_num;
  sk_CTLOG_value: Tsk_CTLOG_value absolute sk_value;
  sk_CTLOG_push: Tsk_CTLOG_push absolute sk_push;
  sk_CTLOG_dup: Tsk_CTLOG_dup absolute sk_dup;
  sk_CTLOG_find: Tsk_CTLOG_find absolute sk_find;
  sk_CTLOG_pop_free: Tsk_CTLOG_pop_free absolute sk_pop_free;

{$ELSE}
function sk_SCT_new(cmp: Tsk_new_cmp): PSTACK_OF_SCT cdecl; external CLibCrypto name 'OPENSSL_sk_new';
function sk_SCT_new_null: PSTACK_OF_SCT cdecl; external CLibCrypto name 'OPENSSL_sk_new_null';
procedure sk_SCT_free(st: PSTACK_OF_SCT)cdecl; external CLibCrypto name 'OPENSSL_sk_free';
function sk_SCT_num(const sk: PSTACK_OF_SCT): TIdC_INT cdecl; external CLibCrypto name 'OPENSSL_sk_num';
function sk_SCT_value(const sk: PSTACK_OF_SCT; i: TIdC_INT): PSCT cdecl; external CLibCrypto name 'OPENSSL_sk_value';
function sk_SCT_push(sk: PSTACK_OF_SCT; st: PSCT): TIdC_INT cdecl; external CLibCrypto name 'OPENSSL_sk_push';
function sk_SCT_dup(sk: PSTACK_OF_SCT): PSTACK_OF_SCT cdecl; external CLibCrypto name 'OPENSSL_sk_dup';
function sk_SCT_find(sk: PSTACK_OF_SCT; val: PSCT): TIdC_INT cdecl; external CLibCrypto name 'OPENSSL_sk_find';
procedure sk_SCT_pop_free(sk: PSTACK_OF_SCT; func: Tsk_pop_free_func)cdecl; external CLibCrypto name 'OPENSSL_sk_pop_free';

function sk_CTLOG_new(cmp: Tsk_new_cmp): PSTACK_OF_CTLOG cdecl; external CLibCrypto name 'OPENSSL_sk_new';
function sk_CTLOG_new_null: PSTACK_OF_CTLOG cdecl; external CLibCrypto name 'OPENSSL_sk_new_null';
procedure sk_CTLOG_free(st: PSTACK_OF_CTLOG) cdecl; external CLibCrypto name 'OPENSSL_sk_free';
function sk_CTLOG_num(const sk: PSTACK_OF_CTLOG): TIdC_INT cdecl; external CLibCrypto name 'OPENSSL_sk_num';
function sk_CTLOG_value(const sk: PSTACK_OF_CTLOG; i: TIdC_INT): PCTLOG cdecl; external CLibCrypto name 'OPENSSL_sk_value';
function sk_CTLOG_push(sk: PSTACK_OF_CTLOG; st: PCTLOG): TIdC_INT cdecl; external CLibCrypto name 'OPENSSL_sk_push';
function sk_CTLOG_dup(sk: PSTACK_OF_CTLOG): PSTACK_OF_CTLOG cdecl; external CLibCrypto name 'OPENSSL_sk_dup';
function sk_CTLOG_find(sk: PSTACK_OF_CTLOG; val: PCTLOG): TIdC_INT cdecl; external CLibCrypto name 'OPENSSL_sk_find';
procedure sk_CTLOG_pop_free(sk: PSTACK_OF_CTLOG; func: Tsk_pop_free_func) cdecl; external CLibCrypto name 'OPENSSL_sk_pop_free';

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
  CT_POLICY_EVAL_CTX_new_procname = 'CT_POLICY_EVAL_CTX_new';
  CT_POLICY_EVAL_CTX_free_procname = 'CT_POLICY_EVAL_CTX_free';
  CT_POLICY_EVAL_CTX_get0_cert_procname = 'CT_POLICY_EVAL_CTX_get0_cert';
  CT_POLICY_EVAL_CTX_set1_cert_procname = 'CT_POLICY_EVAL_CTX_set1_cert';
  CT_POLICY_EVAL_CTX_get0_issuer_procname = 'CT_POLICY_EVAL_CTX_get0_issuer';
  CT_POLICY_EVAL_CTX_set1_issuer_procname = 'CT_POLICY_EVAL_CTX_set1_issuer';
  CT_POLICY_EVAL_CTX_get0_log_store_procname = 'CT_POLICY_EVAL_CTX_get0_log_store';
  CT_POLICY_EVAL_CTX_set_shared_CTLOG_STORE_procname = 'CT_POLICY_EVAL_CTX_set_shared_CTLOG_STORE';
  CT_POLICY_EVAL_CTX_get_time_procname = 'CT_POLICY_EVAL_CTX_get_time';
  CT_POLICY_EVAL_CTX_set_time_procname = 'CT_POLICY_EVAL_CTX_set_time';

{$WARN  NO_RETVAL OFF}

function ERR_CT_POLICY_EVAL_CTX_new(): PCT_POLICY_EVAL_CTX;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException
    (CT_POLICY_EVAL_CTX_new_procname);
end;

procedure ERR_CT_POLICY_EVAL_CTX_free(ctx: PCT_POLICY_EVAL_CTX);
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException
    (CT_POLICY_EVAL_CTX_free_procname);
end;

function ERR_CT_POLICY_EVAL_CTX_get0_cert(const ctx : PCT_POLICY_EVAL_CTX)
  : PX509;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(CT_POLICY_EVAL_CTX_get0_cert_procname);
end;

function ERR_CT_POLICY_EVAL_CTX_set1_cert(ctx : PCT_POLICY_EVAL_CTX; cert : PX509) : TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(CT_POLICY_EVAL_CTX_set1_cert_procname);
end;

function ERR_CT_POLICY_EVAL_CTX_get0_issuer(const ctx : PCT_POLICY_EVAL_CTX) : PX509;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(CT_POLICY_EVAL_CTX_get0_issuer_procname);
end;

function ERR_CT_POLICY_EVAL_CTX_set1_issuer(ctx : PCT_POLICY_EVAL_CTX; issuer : PX509) : TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(CT_POLICY_EVAL_CTX_set1_issuer_procname);
end;

function ERR_CT_POLICY_EVAL_CTX_get0_log_store(const ctx : PCT_POLICY_EVAL_CTX) : PCTLOG_STORE;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(CT_POLICY_EVAL_CTX_get0_log_store_procname);
end;

procedure ERR_CT_POLICY_EVAL_CTX_set_shared_CTLOG_STORE(ctx : PCT_POLICY_EVAL_CTX;
                                                    log_store : PCTLOG_STORE);
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(CT_POLICY_EVAL_CTX_set_shared_CTLOG_STORE_procname);
end;

function ERR_CT_POLICY_EVAL_CTX_get_time(const ctx : PCT_POLICY_EVAL_CTX) : TIdC_UINT64;
begin
   ETaurusTLSAPIFunctionNotPresent.RaiseException(CT_POLICY_EVAL_CTX_get_time_procname);
end;

procedure ERR_CT_POLICY_EVAL_CTX_set_time(ctx : PCT_POLICY_EVAL_CTX; time_in_ms : TIdC_UINT64);
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(CT_POLICY_EVAL_CTX_set_time_procname);
end;

{$WARN  NO_RETVAL ON}

procedure Load(const ADllHandle: TIdLibHandle; LibVersion: TIdC_UINT;
  const AFailed: TStringList);
var
  FuncLoadError: boolean;

begin
  CT_POLICY_EVAL_CTX_new := LoadLibFunction(ADllHandle,
    CT_POLICY_EVAL_CTX_new_procname);
  FuncLoadError := not assigned(CT_POLICY_EVAL_CTX_new);
  if FuncLoadError then
  begin
{$IF not defined(CT_POLICY_EVAL_CTX_new_allownil)}
    CT_POLICY_EVAL_CTX_new := @ERR_CT_POLICY_EVAL_CTX_new;
{$IFEND}
{$IF declared(CT_POLICY_EVAL_CTX_new_introduced)}
    if LibVersion < CT_POLICY_EVAL_CTX_new_introduced then
    begin
{$IF declared(FC_CT_POLICY_EVAL_CTX_new)}
      CT_POLICY_EVAL_CTX_new := @FC_CT_POLICY_EVAL_CTX_new;
{$IFEND}
      FuncLoadError := false;
    end;
{$IFEND}
{$IF declared(CT_POLICY_EVAL_CTX_new_removed)}
    if CT_POLICY_EVAL_CTX_new_removed <= LibVersion then
    begin
{$IF declared(_CT_POLICY_EVAL_CTX_new)}
      CT_POLICY_EVAL_CTX_new := @_CT_POLICY_EVAL_CTX_new;
{$IFEND}
      FuncLoadError := false;
    end;
{$IFEND}
{$IF not defined(CT_POLICY_EVAL_CTX_new_allownil)}
    if FuncLoadError then
      AFailed.Add('CT_POLICY_EVAL_CTX_new');
{$IFEND}
  end;

  CT_POLICY_EVAL_CTX_free := LoadLibFunction(ADllHandle,
    CT_POLICY_EVAL_CTX_free_procname);
  FuncLoadError := not assigned(CT_POLICY_EVAL_CTX_free);
  if FuncLoadError then
  begin
{$IF not defined(CT_POLICY_EVAL_CTX_free_allownil)}
    CT_POLICY_EVAL_CTX_free := @ERR_CT_POLICY_EVAL_CTX_free;
{$IFEND}
{$IF declared(CT_POLICY_EVAL_CTX_free_introduced)}
    if LibVersion < CT_POLICY_EVAL_CTX_free_introduced then
    begin
{$IF declared(FC_CT_POLICY_EVAL_CTX_free)}
      CT_POLICY_EVAL_CTX_free := @FC_CT_POLICY_EVAL_CTX_free;
{$IFEND}
      FuncLoadError := false;
    end;
{$IFEND}
{$IF declared(CT_POLICY_EVAL_CTX_free_removed)}
    if CT_POLICY_EVAL_CTX_free_removed <= LibVersion then
    begin
{$IF declared(_CT_POLICY_EVAL_CTX_free)}
      CT_POLICY_EVAL_CTX_free := @_CT_POLICY_EVAL_CTX_free;
{$IFEND}
      FuncLoadError := false;
    end;
{$IFEND}
{$IF not defined(CT_POLICY_EVAL_CTX_free_allownil)}
    if FuncLoadError then
      AFailed.Add('CT_POLICY_EVAL_CTX_free');
{$IFEND}
  end;

  CT_POLICY_EVAL_CTX_get0_cert := LoadLibFunction(ADllHandle,
    CT_POLICY_EVAL_CTX_get0_cert_procname);
  FuncLoadError := not assigned(CT_POLICY_EVAL_CTX_get0_cert);
  if FuncLoadError then
  begin
{$IF not defined(CT_POLICY_EVAL_CTX_get0_cert_allownil)}
    CT_POLICY_EVAL_CTX_get0_cert := @ERR_CT_POLICY_EVAL_CTX_get0_cert;
{$IFEND}
{$IF declared(CT_POLICY_EVAL_CTX_get0_cert_introduced)}
    if LibVersion < CT_POLICY_EVAL_CTX_get0_cert_introduced then
    begin
{$IF declared(FC_CT_POLICY_EVAL_CTX_get0_cert)}
      CT_POLICY_EVAL_CTX_get0_cert := @FC_CT_POLICY_EVAL_CTX_get0_cert;
{$IFEND}
      FuncLoadError := false;
    end;
{$IFEND}
{$IF declared(CT_POLICY_EVAL_CTX_get0_cert_removed)}
    if CT_POLICY_EVAL_CTX_get0_cert_removed <= LibVersion then
    begin
{$IF declared(_CT_POLICY_EVAL_CTX_get0_cert)}
      CT_POLICY_EVAL_CTX_get0_cert := @_CT_POLICY_EVAL_CTX_get0_cert;
{$IFEND}
      FuncLoadError := false;
    end;
{$IFEND}
{$IF not defined(CT_POLICY_EVAL_CTX_get0_cert_allownil)}
    if FuncLoadError then
      AFailed.Add('CT_POLICY_EVAL_CTX_get0_cert');
{$IFEND}
  end;

  CT_POLICY_EVAL_CTX_set1_cert := LoadLibFunction(ADllHandle,
    CT_POLICY_EVAL_CTX_set1_cert_procname);
  FuncLoadError := not Assigned(CT_POLICY_EVAL_CTX_set1_cert);
  if FuncLoadError then
  begin
{$IF not defined(CT_POLICY_EVAL_CTX_set1_cert_allownil)}
    CT_POLICY_EVAL_CTX_set1_cert := @ERR_CT_POLICY_EVAL_CTX_set1_cert;
{$IFEND}
{$IF declared(CT_POLICY_EVAL_CTX_set1_cert_introduced)}
    if LibVersion < CT_POLICY_EVAL_CTX_set1_cert_introduced then
    begin
{$IF declared(FC_CT_POLICY_EVAL_CTX_set1_cert)}
      CT_POLICY_EVAL_CTX_set1_cert := @FC_CT_POLICY_EVAL_CTX_set1_cert;
{$IFEND}
      FuncLoadError := false;
    end;
{$IFEND}
{$IF declared(CT_POLICY_EVAL_CTX_set1_cert_removed)}
    if CT_POLICY_EVAL_CTX_set1_cert_removed <= LibVersion then
    begin
{$IF declared(_CT_POLICY_EVAL_CTX_set1_cert)}
      CT_POLICY_EVAL_CTX_set1_cert := @_CT_POLICY_EVAL_CTX_set1_cert;
{$IFEND}
      FuncLoadError := false;
    end;
{$IFEND}
{$IF not defined(CT_POLICY_EVAL_CTX_set1_cert_allownil)}
    if FuncLoadError then
      AFailed.Add('CT_POLICY_EVAL_CTX_set1_cert');
{$IFEND}
  end;

  CT_POLICY_EVAL_CTX_get0_issuer := LoadLibFunction(ADllHandle,
    CT_POLICY_EVAL_CTX_get0_issuer_procname);
  FuncLoadError := not Assigned(CT_POLICY_EVAL_CTX_get0_issuer);
  if FuncLoadError then
  begin
{$IF not defined(CT_POLICY_EVAL_CTX_get0_issuer_allownil)}
    CT_POLICY_EVAL_CTX_get0_issuer := @ERR_CT_POLICY_EVAL_CTX_get0_issuer;
{$IFEND}
{$IF declared(CT_POLICY_EVAL_CTX_get0_issuer_introduced)}
    if LibVersion < CT_POLICY_EVAL_CTX_get0_issuer_introduced then
    begin
{$IF declared(FC_CT_POLICY_EVAL_CTX_get0_issuer)}
      CT_POLICY_EVAL_CTX_get0_issuer := @FC_CT_POLICY_EVAL_CTX_get0_issuer;
{$IFEND}
      FuncLoadError := false;
    end;
{$IFEND}
{$IF declared(CT_POLICY_EVAL_CTX_get0_issuer_removed)}
    if CT_POLICY_EVAL_CTX_get0_issuer_removed <= LibVersion then
    begin
{$IF declared(_CT_POLICY_EVAL_CTX_get0_issuer)}
      CT_POLICY_EVAL_CTX_get0_issuer := @_CT_POLICY_EVAL_CTX_get0_issuer;
{$IFEND}
      FuncLoadError := false;
    end;
{$IFEND}
{$IF not defined(CT_POLICY_EVAL_CTX_get0_issuer_allownil)}
    if FuncLoadError then
      AFailed.Add('CT_POLICY_EVAL_CTX_get0_issuer');
{$IFEND}
  end;

  CT_POLICY_EVAL_CTX_set1_issuer := LoadLibFunction(ADllHandle,
    CT_POLICY_EVAL_CTX_set1_issuer_procname);
  FuncLoadError := not Assigned(CT_POLICY_EVAL_CTX_set1_issuer);
  if FuncLoadError then
  begin
{$IF not defined(CT_POLICY_EVAL_CTX_set1_issuer_allownil)}
    CT_POLICY_EVAL_CTX_set1_issuer := @ERR_CT_POLICY_EVAL_CTX_set1_issuer;
{$IFEND}
{$IF declared(CT_POLICY_EVAL_CTX_set1_issuer_introduced)}
    if LibVersion < CT_POLICY_EVAL_CTX_set1_issuer_introduced then
    begin
{$IF declared(FC_CT_POLICY_EVAL_CTX_set1_issuer)}
      CT_POLICY_EVAL_CTX_set1_issuer := @FC_CT_POLICY_EVAL_CTX_set1_issuer;
{$IFEND}
      FuncLoadError := false;
    end;
{$IFEND}
{$IF declared(CT_POLICY_EVAL_CTX_set1_issuer_removed)}
    if CT_POLICY_EVAL_CTX_set1_issuer_removed <= LibVersion then
    begin
{$IF declared(_CT_POLICY_EVAL_CTX_set1_issuer)}
      CT_POLICY_EVAL_CTX_set1_issuer := @_CT_POLICY_EVAL_CTX_set1_issuer;
{$IFEND}
      FuncLoadError := false;
    end;
{$IFEND}
{$IF not defined(CT_POLICY_EVAL_CTX_set1_issuer_allownil)}
    if FuncLoadError then
      AFailed.Add('CT_POLICY_EVAL_CTX_set1_issuer');
{$IFEND}
  end;

  CT_POLICY_EVAL_CTX_get0_log_store := LoadLibFunction(ADllHandle,
    CT_POLICY_EVAL_CTX_get0_log_store_procname);
  FuncLoadError := not Assigned(CT_POLICY_EVAL_CTX_get0_log_store);
  if FuncLoadError then
  begin
{$IF not defined(CT_POLICY_EVAL_CTX_get0_log_store_allownil)}
    CT_POLICY_EVAL_CTX_get0_log_store := @ERR_CT_POLICY_EVAL_CTX_get0_log_store;
{$IFEND}
{$IF declared(CT_POLICY_EVAL_CTX_get0_log_store_introduced)}
    if LibVersion < CT_POLICY_EVAL_CTX_get0_log_store_introduced then
    begin
{$IF declared(FC_CT_POLICY_EVAL_CTX_get0_log_store)}
      CT_POLICY_EVAL_CTX_get0_log_store := @FC_CT_POLICY_EVAL_CTX_get0_log_store;
{$IFEND}
      FuncLoadError := false;
    end;
{$IFEND}
{$IF declared(CT_POLICY_EVAL_CTX_get0_log_store_removed)}
    if CT_POLICY_EVAL_CTX_get0_log_store_removed <= LibVersion then
    begin
{$IF declared(_CT_POLICY_EVAL_CTX_get0_log_store)}
      CT_POLICY_EVAL_CTX_get0_log_store := @_CT_POLICY_EVAL_CTX_get0_log_store;
{$IFEND}
      FuncLoadError := false;
    end;
{$IFEND}
{$IF not defined(CT_POLICY_EVAL_CTX_get0_log_store_allownil)}
    if FuncLoadError then
      AFailed.Add('CT_POLICY_EVAL_CTX_get0_log_store');
{$IFEND}
  end;

  CT_POLICY_EVAL_CTX_set_shared_CTLOG_STORE := LoadLibFunction(ADllHandle,
    CT_POLICY_EVAL_CTX_set_shared_CTLOG_STORE_procname);
  FuncLoadError := not Assigned(CT_POLICY_EVAL_CTX_set_shared_CTLOG_STORE);
  if FuncLoadError then
  begin
{$IF not defined(CT_POLICY_EVAL_CTX_set_shared_CTLOG_STORE_allownil)}
    CT_POLICY_EVAL_CTX_set_shared_CTLOG_STORE := @ERR_CT_POLICY_EVAL_CTX_set_shared_CTLOG_STORE;
{$IFEND}
{$IF declared(CT_POLICY_EVAL_CTX_set_shared_CTLOG_STORE_introduced)}
    if LibVersion < CT_POLICY_EVAL_CTX_set_shared_CTLOG_STORE_introduced then
    begin
{$IF declared(FC_CT_POLICY_EVAL_CTX_set_shared_CTLOG_STORE)}
      CT_POLICY_EVAL_CTX_set_shared_CTLOG_STORE := @FC_CT_POLICY_EVAL_CTX_set_shared_CTLOG_STORE;
{$IFEND}
      FuncLoadError := false;
    end;
{$IFEND}
{$IF declared(CT_POLICY_EVAL_CTX_set_shared_CTLOG_STORE_removed)}
    if CT_POLICY_EVAL_CTX_set_shared_CTLOG_STORE_removed <= LibVersion then
    begin
{$IF declared(_CT_POLICY_EVAL_CTX_set_shared_CTLOG_STORE)}
      CT_POLICY_EVAL_CTX_set_shared_CTLOG_STORE := @_CT_POLICY_EVAL_CTX_set_shared_CTLOG_STORE;
{$IFEND}
      FuncLoadError := false;
    end;
{$IFEND}
{$IF not defined(CT_POLICY_EVAL_CTX_set_shared_CTLOG_STORE_allownil)}
    if FuncLoadError then
      AFailed.Add('CT_POLICY_EVAL_CTX_set_shared_CTLOG_STORE');
{$IFEND}
  end;

  CT_POLICY_EVAL_CTX_get_time := LoadLibFunction(ADllHandle, CT_POLICY_EVAL_CTX_get_time_procname);
  FuncLoadError := not assigned(CT_POLICY_EVAL_CTX_get_time);
  if FuncLoadError then
  begin
    {$if not defined(CT_POLICY_EVAL_CTX_get_time_allownil)}
    CT_POLICY_EVAL_CTX_get_time := @ERR_CT_POLICY_EVAL_CTX_get_time;
    {$ifend}
    {$if declared(CT_POLICY_EVAL_CTX_get_time_introduced)}
    if LibVersion < CT_POLICY_EVAL_CTX_get_time_introduced then
    begin
      {$if declared(FC_CT_POLICY_EVAL_CTX_get_time)}
      CT_POLICY_EVAL_CTX_get_time := @FC_CT_POLICY_EVAL_CTX_get_time;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(CT_POLICY_EVAL_CTX_get_time_removed)}
    if CT_POLICY_EVAL_CTX_get_time_removed <= LibVersion then
    begin
      {$if declared(_CT_POLICY_EVAL_CTX_get_time)}
      CT_POLICY_EVAL_CTX_get_time := @_CT_POLICY_EVAL_CTX_get_time;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(CT_POLICY_EVAL_CTX_get_time_allownil)}
    if FuncLoadError then
      AFailed.Add('CT_POLICY_EVAL_CTX_get_time');
    {$ifend}
  end;

  CT_POLICY_EVAL_CTX_set_time := LoadLibFunction(ADllHandle, CT_POLICY_EVAL_CTX_set_time_procname);
  FuncLoadError := not assigned(CT_POLICY_EVAL_CTX_set_time);
  if FuncLoadError then
  begin
    {$if not defined(CT_POLICY_EVAL_CTX_set_time_allownil)}
    CT_POLICY_EVAL_CTX_set_time := @ERR_CT_POLICY_EVAL_CTX_set_time;
    {$ifend}
    {$if declared(CT_POLICY_EVAL_CTX_set_time_introduced)}
    if LibVersion < CT_POLICY_EVAL_CTX_set_time_introduced then
    begin
      {$if declared(FC_CT_POLICY_EVAL_CTX_set_time)}
      CT_POLICY_EVAL_CTX_set_time := @FC_CT_POLICY_EVAL_CTX_set_time;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(CT_POLICY_EVAL_CTX_set_time_removed)}
    if CT_POLICY_EVAL_CTX_set_time_removed <= LibVersion then
    begin
      {$if declared(_CT_POLICY_EVAL_CTX_set_time)}
      CT_POLICY_EVAL_CTX_set_time := @_CT_POLICY_EVAL_CTX_set_time;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(CT_POLICY_EVAL_CTX_set_time_allownil)}
    if FuncLoadError then
      AFailed.Add('CT_POLICY_EVAL_CTX_set_time');
    {$ifend}
  end;

end;

procedure Unload;
begin
  CT_POLICY_EVAL_CTX_new := nil;
  CT_POLICY_EVAL_CTX_free := nil;
  CT_POLICY_EVAL_CTX_get0_cert := nil;
  CT_POLICY_EVAL_CTX_set1_cert := nil;
  CT_POLICY_EVAL_CTX_get0_issuer := nil;
  CT_POLICY_EVAL_CTX_set1_issuer := nil;
  CT_POLICY_EVAL_CTX_get0_log_store := nil;
  CT_POLICY_EVAL_CTX_set_shared_CTLOG_STORE := nil;
  CT_POLICY_EVAL_CTX_get_time := nil;
  CT_POLICY_EVAL_CTX_set_time := nil;
end;
{$ENDIF}
{$IFNDEF OPENSSL_STATIC_LINK_MODEL}

initialization

Register_SSLLoader(@Load, 'LibCrypto');
Register_SSLUnloader(@Unload);
{$ENDIF}

end.

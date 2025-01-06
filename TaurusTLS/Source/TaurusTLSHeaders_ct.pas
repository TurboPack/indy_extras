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

  CT_F_CTLOG_NEW                                  = 117;
  CT_F_CTLOG_NEW_FROM_BASE64                      = 118;
  CT_F_CTLOG_NEW_FROM_CONF                        = 119;
  CT_F_CTLOG_STORE_LOAD_CTX_NEW                   = 122;
  CT_F_CTLOG_STORE_LOAD_FILE                      = 123;
  CT_F_CTLOG_STORE_LOAD_LOG                       = 130;
  CT_F_CTLOG_STORE_NEW                            = 131;
  CT_F_CT_BASE64_DECODE                           = 124;
  CT_F_CT_POLICY_EVAL_CTX_NEW                     = 133;
  CT_F_CT_V1_LOG_ID_FROM_PKEY                     = 125;
  CT_F_I2O_SCT                                    = 107;
  CT_F_I2O_SCT_LIST                               = 108;
  CT_F_I2O_SCT_SIGNATURE                          = 109;
  CT_F_O2I_SCT                                    = 110;
  CT_F_O2I_SCT_LIST                               = 111;
  CT_F_O2I_SCT_SIGNATURE                          = 112;
  CT_F_SCT_CTX_NEW                                = 126;
  CT_F_SCT_CTX_VERIFY                             = 128;
  CT_F_SCT_NEW                                    = 100;
  CT_F_SCT_NEW_FROM_BASE64                        = 127;
  CT_F_SCT_SET0_LOG_ID                            = 101;
  CT_F_SCT_SET1_EXTENSIONS                        = 114;
  CT_F_SCT_SET1_LOG_ID                            = 115;
  CT_F_SCT_SET1_SIGNATURE                         = 116;
  CT_F_SCT_SET_LOG_ENTRY_TYPE                     = 102;
  CT_F_SCT_SET_SIGNATURE_NID                      = 103;
  CT_F_SCT_SET_VERSION                            = 104;

//* Reason codes. */
  CT_R_BASE64_DECODE_ERROR                        = 108;
  CT_R_INVALID_LOG_ID_LENGTH                      = 100;
  CT_R_LOG_CONF_INVALID                           = 109;
  CT_R_LOG_CONF_INVALID_KEY                       = 110;
  CT_R_LOG_CONF_MISSING_DESCRIPTION               = 111;
  CT_R_LOG_CONF_MISSING_KEY                       = 112;
  CT_R_LOG_KEY_INVALID                            = 113;
  CT_R_SCT_FUTURE_TIMESTAMP                       = 116;
  CT_R_SCT_INVALID                                = 104;
  CT_R_SCT_INVALID_SIGNATURE                      = 107;
  CT_R_SCT_LIST_INVALID                           = 105;
  CT_R_SCT_LOG_ID_MISMATCH                        = 114;
  CT_R_SCT_NOT_SET                                = 106;
  CT_R_SCT_UNSUPPORTED_VERSION                    = 115;
  CT_R_UNRECOGNIZED_SIGNATURE_NID                 = 101;
  CT_R_UNSUPPORTED_ENTRY_TYPE                     = 102;
  CT_R_UNSUPPORTED_VERSION                        = 103;

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

  SCT_new : function : PSCT; cdecl = nil;
  SCT_new_from_base64 : function(version : TIdAnsiChar;
                                 logid_base64 : PIdAnsiChar;
                                 entry_type : ct_log_entry_type_t;
                                 timestamp : TIdC_UINT64;
                                 extensions_base64,
                                 signature_base64 : PIdAnsiChar) : PSCT; cdecl = nil;
  SCT_free : procedure(sct : PSCT); cdecl = nil;
  SCT_LIST_free : procedure(a : PSTACK_OF_SCT); cdecl = nil;
  SCT_get_version : function(const sct : PSCT) : sct_version_t; cdecl = nil;
  SCT_set_version : function(sct : PSCT;  version : sct_version_t) : TIdC_INT; cdecl = nil;
  SCT_get_log_entry_type : function(const sct : PSCT) : ct_log_entry_type_t; cdecl = nil;
  SCT_set_log_entry_type : function(sct : PSCT; entry_type : ct_log_entry_type_t) : TIdC_INT; cdecl = nil;
  SCT_get0_log_id : function(const sct : PSCT; log_id : PPIdAnsiChar) : TIdC_SIZET; cdecl = nil;
  SCT_set0_log_id : function(sct : PSCT; log_id : PIdAnsiChar; log_id_len : TIdC_SIZET) : TIdC_INT; cdecl = nil;
  SCT_set1_log_id : function(sct : PSCT; const log_id : PIdAnsiChar;
                             log_id_len : TIdC_SIZET) : TIdC_INT; cdecl = nil;
  SCT_get_timestamp : function(const sct : PSCT) : TIdC_UINT64; cdecl = nil;
  SCT_set_timestamp : procedure(sct : PSCT; timestamp : TIdC_UINT64); cdecl = nil;
  SCT_get_signature_nid : function(const sct : PSCT) : TIdC_INT; cdecl = nil;
  SCT_set_signature_nid : function(sct : PSCT; nid : TIdC_INT) : TIdC_INT; cdecl = nil;
  SCT_get0_extensions : function(const sct : PSCT; ext : PPIdAnsiChar) : TIdC_SIZET; cdecl = nil;
  SCT_set0_extensions : procedure(sct : PSCT; ext : PIdAnsiChar; ext_len : TIdC_SIZET); cdecl = nil;
  SCT_set1_extensions : function(sct : PSCT; const ext : PIdAnsiChar; ext_len : TIdC_SIZET) : TIdC_INT; cdecl = nil;
  SCT_get0_signature : function(const sct : PSCT; sig : PPIdAnsiChar) : TIdC_SIZET; cdecl = nil;
  SCT_set0_signature : procedure(sct : PSCT; sig : PIdAnsiChar; sig_len : TIdC_SIZET); cdecl = nil;
  SCT_set1_signature : function(sct : PSCT; const sig : PIdAnsiChar; sig_len : TIdC_SIZET) : TIdC_INT; cdecl = nil;
  SCT_get_source : function(const sct : PSCT) : sct_source_t; cdecl = nil;
  SCT_set_source : function(sct : PSCT; source : sct_source_t) : TIdC_INT; cdecl = nil;
  SCT_validation_status_string : function(const sct : PSCT) : PIdAnsiChar; cdecl = nil;
  SCT_print : procedure(const sct : PSCT; _out : PBIO; indent : TIdC_INT; const logs : PCTLOG_STORE); cdecl = nil;
  SCT_LIST_print : procedure(const sct_list : PSTACK_OF_SCT; _out : PBIO; indent : TIdC_INT;
                    const separator : PIdAnsiChar; const logs : PCTLOG_STORE); cdecl = nil;
   SCT_get_validation_status : function(const sct : PSCT) : sct_validation_status_t; cdecl = nil;
   SCT_validate : function(sct : PSCT; const ctx : PCT_POLICY_EVAL_CTX) : TIdC_INT; cdecl = nil;
   SCT_LIST_validate : function(const scts : PSTACK_OF_SCT; ctx : PCT_POLICY_EVAL_CTX) : TIdC_INT; cdecl = nil;

   CTLOG_STORE_new : function : PCTLOG_STORE; cdecl = nil;
   CTLOG_STORE_free : procedure(store : PCTLOG_STORE); cdecl = nil;
   CTLOG_STORE_get0_log_by_id : function(const store : PCTLOG_STORE;
                                         const log_id : PIdAnsiChar;
                                         log_id_len : TIdC_SIZET) : PCTLOG;
   CTLOG_STORE_load_file : function(store : PCTLOG_STORE; const _file : PIdAnsiChar) : TIdC_INT; cdecl = nil;
   CTLOG_STORE_load_default_file : function(store : PCTLOG_STORE) : TIdC_INT; cdecl = nil;

   ERR_load_CT_strings : function : TIdC_INT; cdecl = nil;
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

function SCT_new(void) : PSCT cdecl; external CLibCrypto;
function SCT_new_from_base64(version : TIdAnsiChar;
                             logid_base64 : PIdAnsiChar;
                             entry_type : ct_log_entry_type_t;
                             timestamp : TIdC_UINT64;
                             extensions_base64,
                             signature_base64 : PIdAnsiChar) : PSCT cdecl; external CLibCrypto;
procedure SCT_free(sct : PSCT) cdecl; external CLibCrypto;
procedure SCT_LIST_free(a : PSTACK_OF_SCT) cdecl; external CLibCrypto;
function SCT_get_version(const sct : PSCT) : sct_version_t cdecl; external CLibCrypto;
function SCT_set_version(sct : PSCT; version : sct_version_t) : TIdC_INT cdecl; external CLibCrypto;
function SCT_get_log_entry_type(const sct : PSCT) : ct_log_entry_type_t cdecl; external CLibCrypto;
function SCT_set_log_entry_type(sct : PSCT; entry_type : ct_log_entry_type_t) : TIdC_INT cdecl; external CLibCrypto;
function SCT_get0_log_id(const sct : PSCT; log_id : PPIdAnsiChar) : TIdC_SIZET cdecl; external CLibCrypto;
function SCT_set0_log_id(sct : PSCT; log_id : PIdAnsiChar; log_id_len : TIdC_SIZET) : TIdC_INT cdecl; external CLibCrypto;
function SCT_set1_log_id(sct : PSCT; const log_id : PIdAnsiChar;
                         log_id_len : TIdC_SIZET) : TIdC_INT cdecl; external CLibCrypto;
function SCT_get_timestamp(const sct : PSCT) : TIdC_UINT64 cdecl; external CLibCrypto;
procedure SCT_set_timestamp(sct : PSCT; timestamp : TIdC_UINT64) cdecl; external CLibCrypto;
function SCT_get_signature_nid(const sct : PSCT) : TIdC_INT cdecl; external CLibCrypto;
function SCT_set_signature_nid(sct : PSCT; nid : TIdC_INT) : TIdC_INT cdecl; external CLibCrypto;
function SCT_get0_extensions(const sct : PSCT; ext : PPIdAnsiChar) : TIdC_SIZET cdecl; external CLibCrypto;
procedure SCT_set0_extensions(sct : PSCT; ext : PIdAnsiChar; ext_len : TIdC_SIZET) cdecl; external CLibCrypto;
function SCT_set1_extensions(sct : PSCT; const ext : PIdAnsiChar;  ext_len : TIdC_SIZET) : TIdC_INT cdecl; external CLibCrypto;
function SCT_get0_signature(const sct : PSCT; sig : PPIdAnsiChar) : TIdC_SIZET cdecl; external CLibCrypto;
procedure SCT_set0_signature(sct : PSCT; sig : PIdAnsiChar; sig_len : TIdC_SIZET) cdecl; external CLibCrypto;
function SCT_set1_signature(sct : PSCT; const sig : PIdAnsiChar; sig_len : TIdC_SIZET) : TIdC_INT cdecl; external CLibCrypto;
function SCT_get_source(const sct : PSCT) : sct_source_t cdecl; external CLibCrypto;
function SCT_set_source(sct : PSCT;  source : sct_source_t) : TIdC_INT cdecl; external CLibCrypto;
function SCT_validation_status_string(const sct : PSCT) : PIdAnsiChar cdecl; external CLibCrypto;
procedure SCT_print(const sct : PSCT; _out : PBIO; indent : TIdC_INT; const logs : PCTLOG_STORE)  cdecl; external CLibCrypto;
procedure SCT_LIST_print(const sct_list : PSTACK_OF_SCT; _out : PBIO; indent : TIdC_INT;
                         separator : PIdAnsiChar; const logs : PCTLOG_STORE) cdecl; external CLibCrypto;
function SCT_get_validation_status(const sct : PSCT) : sct_validation_status_t cdecl; external CLibCrypto;
function SCT_validate(sct : PSCT; const ctx : PCT_POLICY_EVAL_CTX) : TIdC_INT cdecl; external CLibCrypto;
function SCT_LIST_validate(const scts : PSTACK_OF_SCT; ctx : PCT_POLICY_EVAL_CTX) : TIdC_INT cdecl; external CLibCrypto;

function CTLOG_STORE_new : PCTLOG_STORE cdecl; external CLibCrypto;
procedure CTLOG_STORE_free(store : PCTLOG_STORE) cdecl; external CLibCrypto;
function CTLOG_STORE_get0_log_by_id(const store : PCTLOG_STORE;
                                    const log_id : PIdAnsiChar;
                                    log_id_len : TIdC_SIZET) : PCTLOG  cdecl; external CLibCrypto;
function CTLOG_STORE_load_file(store : PCTLOG_STORE; const _file : PIdAnsiChar) : TIdC_INT cdecl; external CLibCrypto;
function CTLOG_STORE_load_default_file(store : PCTLOG_STORE) : TIdC_INT cdecl; external CLibCrypto;

function ERR_load_CT_strings : TIdC_INT cdecl; external CLibCrypto;
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

  SCT_new_procname = 'SCT_new';
  SCT_new_from_base64_procname = 'SCT_new_from_base64';
  SCT_free_procname = 'SCT_free';
  SCT_LIST_free_procname = 'SCT_LIST_free';
  SCT_get_version_procname = 'SCT_get_version';
  SCT_set_version_procname = 'SCT_set_version';
  SCT_get_log_entry_type_procname = 'SCT_get_log_entry_type';
  SCT_set_log_entry_type_procname = 'SCT_set_log_entry_type';
  SCT_get0_log_id_procname = 'SCT_get0_log_id';
  SCT_set0_log_id_procname = 'SCT_set0_log_id';
  SCT_set1_log_id_procname = 'SCT_set1_log_id';
  SCT_get_timestamp_procname = 'SCT_get_timestamp';
  SCT_set_timestamp_procname = 'SCT_set_timestamp';
  SCT_get_signature_nid_procname = 'SCT_get_signature_nid';
  SCT_set_signature_nid_procname = 'SCT_set_signature_nid';
  SCT_get0_extensions_procname = 'SCT_get0_extensions';
  SCT_set0_extensions_procname = 'SCT_set0_extensions';
  SCT_set1_extensions_procname = 'SCT_set1_extensions';
  SCT_get0_signature_procname = 'SCT_get0_signature';
  SCT_set0_signature_procname = 'SCT_set0_signature';
  SCT_set1_signature_procname = 'SCT_set1_signature';
  SCT_get_source_procname = 'SCT_get_source';
  SCT_set_source_procname = 'SCT_set_source';
  SCT_validation_status_string_procname = 'SCT_validation_status_string';
  SCT_print_procname = 'SCT_print';
  SCT_LIST_print_procname = 'SCT_LIST_print';
  SCT_get_validation_status_procname = 'SCT_get_validation_status';
  SCT_validate_procname = 'SCT_validate';
  SCT_LIST_validate_procname = 'SCT_LIST_validate';

  CTLOG_STORE_new_procname = 'CTLOG_STORE_new';
  CTLOG_STORE_free_procname = 'CTLOG_STORE_free';
  CTLOG_STORE_get0_log_by_id_procname = 'CTLOG_STORE_get0_log_by_id';
  CTLOG_STORE_load_file_procname = 'CTLOG_STORE_load_file';
  CTLOG_STORE_load_default_file_procname = 'CTLOG_STORE_load_default_file';

  ERR_load_CT_strings_procname = 'ERR_load_CT_strings';
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

function ERR_SCT_new : PSCT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(SCT_new_procname);
end;

function ERR_SCT_new_from_base64(version : TIdAnsiChar;
                             logid_base64 : PIdAnsiChar;
                             entry_type : ct_log_entry_type_t;
                             timestamp : TIdC_UINT64;
                             extensions_base64,
                             signature_base64 : PIdAnsiChar) : PSCT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(SCT_new_from_base64_procname);
end;

procedure ERR_SCT_free(sct : PSCT);
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(SCT_free_procname);
end;

procedure ERR_SCT_LIST_free(a : PSTACK_OF_SCT);
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( SCT_LIST_free_procname );
end;

function ERR_SCT_get_version(const sct : PSCT) : sct_version_t;
begin
   ETaurusTLSAPIFunctionNotPresent.RaiseException(SCT_get_version_procname);
end;

function ERR_SCT_set_version(sct : PSCT; version : sct_version_t) : TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(SCT_set_version_procname);
end;

function ERR_SCT_get_log_entry_type(const sct : PSCT) : ct_log_entry_type_t;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(SCT_get_log_entry_type_procname);
end;

function ERR_SCT_set_log_entry_type(sct : PSCT; entry_type : ct_log_entry_type_t) : TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(SCT_set_log_entry_type_procname);
end;

function ERR_SCT_get0_log_id(const sct : PSCT; log_id : PPIdAnsiChar) : TIdC_SIZET;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(SCT_get0_log_id_procname);
end;

function ERR_SCT_set0_log_id(sct : PSCT; log_id : PIdAnsiChar; log_id_len : TIdC_SIZET) : TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(SCT_set0_log_id_procname);
end;

function ERR_SCT_set1_log_id(sct : PSCT; const log_id : PIdAnsiChar;
                         log_id_len : TIdC_SIZET) : TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(SCT_set1_log_id_procname);
end;

function ERR_SCT_get_timestamp(const sct : PSCT) : TIdC_UINT64;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( SCT_get_timestamp_procname);
end;

procedure ERR_SCT_set_timestamp(sct : PSCT; timestamp : TIdC_UINT64);
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( SCT_set_timestamp_procname);
end;

function ERR_SCT_get_signature_nid(const sct : PSCT) : TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( SCT_get_signature_nid_procname);
end;

function ERR_SCT_set_signature_nid(sct : PSCT; nid : TIdC_INT) : TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(SCT_set_signature_nid_procname);
end;

function ERR_SCT_get0_extensions(const sct : PSCT; ext : PPIdAnsiChar) : TIdC_SIZET;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( SCT_get0_extensions_procname);
end;

procedure ERR_SCT_set0_extensions(sct : PSCT; ext : PIdAnsiChar; ext_len : TIdC_SIZET);
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( SCT_set0_extensions_procname);
end;

function ERR_SCT_set1_extensions(sct : PSCT; const ext : PIdAnsiChar;  ext_len : TIdC_SIZET) : TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(SCT_set1_extensions_procname);
end;

function ERR_SCT_get0_signature(const sct : PSCT; sig : PPIdAnsiChar) : TIdC_SIZET;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( SCT_get0_signature_procname);
end;

procedure ERR_SCT_set0_signature(sct : PSCT; sig : PIdAnsiChar; sig_len : TIdC_SIZET);
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( SCT_set0_signature_procname);
end;

function ERR_SCT_set1_signature(sct : PSCT; const sig : PIdAnsiChar; sig_len : TIdC_SIZET) : TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( SCT_set1_signature_procname);
end;

function ERR_SCT_get_source(const sct : PSCT) : sct_source_t;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(SCT_get_source_procname);
end;

function ERR_SCT_set_source(sct : PSCT;  source : sct_source_t) : TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(SCT_set_source_procname);
end;

function ERR_SCT_validation_status_string(const sct : PSCT) : PIdAnsiChar;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( SCT_validation_status_string_procname);
end;

procedure ERR_SCT_print(const sct : PSCT; _out : PBIO; indent : TIdC_INT; const logs : PCTLOG_STORE);
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( SCT_print_procname );
end;

procedure ERR_SCT_LIST_print(const sct_list : PSTACK_OF_SCT; _out : PBIO; indent : TIdC_INT;
                         separator : PIdAnsiChar; const logs : PCTLOG_STORE);
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(SCT_LIST_print_procname);
end;

function ERR_SCT_get_validation_status(const sct : PSCT) : sct_validation_status_t;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(SCT_get_validation_status_procname);
end;

function ERR_SCT_validate(sct : PSCT; const ctx : PCT_POLICY_EVAL_CTX) : TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(SCT_validate_procname);
end;

function ERR_SCT_LIST_validate(const scts : PSTACK_OF_SCT; ctx : PCT_POLICY_EVAL_CTX) : TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( SCT_LIST_validate_procname);
end;

function ERR_CTLOG_STORE_new : PCTLOG_STORE;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( CTLOG_STORE_new_procname);
end;

procedure ERR_CTLOG_STORE_free(store : PCTLOG_STORE);
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( CTLOG_STORE_free_procname);
end;

function ERR_CTLOG_STORE_get0_log_by_id(const store : PCTLOG_STORE;
                                    const log_id : PIdAnsiChar;
                                    log_id_len : TIdC_SIZET) : PCTLOG;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( CTLOG_STORE_get0_log_by_id_procname);
end;

function ERR_CTLOG_STORE_load_file(store : PCTLOG_STORE; const _file : PIdAnsiChar) : TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( CTLOG_STORE_load_file_procname);
end;

function ERR_CTLOG_STORE_load_default_file(store : PCTLOG_STORE) : TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(CTLOG_STORE_load_default_file_procname);
end;

function ERR_ERR_load_CT_strings : TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(ERR_load_CT_strings_procname);
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

  SCT_new := LoadLibFunction(ADllHandle, SCT_new_procname);
  FuncLoadError := not assigned(SCT_new);
  if FuncLoadError then
  begin
    {$if not defined(SCT_new_allownil)}
    SCT_new := @ERR_SCT_new;
    {$ifend}
    {$if declared(SCT_new_introduced)}
    if LibVersion < SCT_new_introduced then
    begin
      {$if declared(FC_SCT_new)}
      SCT_new := @FC_SCT_new;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(SCT_new_removed)}
    if SCT_new_removed <= LibVersion then
    begin
      {$if declared(_SCT_new)}
      SCT_new := @_SCT_new;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(SCT_new_allownil)}
    if FuncLoadError then
      AFailed.Add('SCT_new');
    {$ifend}
  end;

  SCT_new_from_base64 := LoadLibFunction(ADllHandle, SCT_new_from_base64_procname);
  FuncLoadError := not assigned(SCT_new_from_base64);
  if FuncLoadError then
  begin
    {$if not defined(SCT_new_from_base64_allownil)}
    SCT_new_from_base64 := @ERR_SCT_new_from_base64;
    {$ifend}
    {$if declared(SCT_new_from_base64_introduced)}
    if LibVersion < SCT_new_from_base64_introduced then
    begin
      {$if declared(FC_SCT_new_from_base64)}
      SCT_new_from_base64 := @FC_SCT_new_from_base64;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(SCT_new_from_base64_removed)}
    if SCT_new_from_base64_removed <= LibVersion then
    begin
      {$if declared(_SCT_new_from_base64)}
      SCT_new_from_base64 := @_SCT_new_from_base64;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(SCT_new_from_base64_allownil)}
    if FuncLoadError then
      AFailed.Add('SCT_new_from_base64');
    {$ifend}
  end;

  SCT_free := LoadLibFunction(ADllHandle, SCT_free_procname);
  FuncLoadError := not assigned(SCT_free);
  if FuncLoadError then
  begin
    {$if not defined(SCT_free_allownil)}
    SCT_free := @ERR_SCT_free;
    {$ifend}
    {$if declared(SCT_free_introduced)}
    if LibVersion < SCT_free_introduced then
    begin
      {$if declared(FC_SCT_free)}
      SCT_free := @FC_SCT_free;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(SCT_free_removed)}
    if SCT_free_removed <= LibVersion then
    begin
      {$if declared(_SCT_free)}
      SCT_free := @_SCT_free;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(SCT_free_allownil)}
    if FuncLoadError then
      AFailed.Add('SCT_free');
    {$ifend}
  end;

  SCT_LIST_free := LoadLibFunction(ADllHandle, SCT_LIST_free_procname);
  FuncLoadError := not assigned(SCT_LIST_free);
  if FuncLoadError then
  begin
    {$if not defined(SCT_LIST_free_allownil)}
    SCT_LIST_free := @ERR_SCT_LIST_free;
    {$ifend}
    {$if declared(SCT_LIST_free_introduced)}
    if LibVersion < SCT_LIST_free_introduced then
    begin
      {$if declared(FC_SCT_LIST_free)}
      SCT_LIST_free := @FC_SCT_LIST_free;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(SCT_LIST_free_removed)}
    if SCT_LIST_free_removed <= LibVersion then
    begin
      {$if declared(_SCT_LIST_free)}
      SCT_LIST_free := @_SCT_LIST_free;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(SCT_LIST_free_allownil)}
    if FuncLoadError then
      AFailed.Add('SCT_LIST_free');
    {$ifend}
  end;

  SCT_get_version := LoadLibFunction(ADllHandle, SCT_get_version_procname);
  FuncLoadError := not assigned(SCT_get_version);
  if FuncLoadError then
  begin
    {$if not defined(SCT_get_version_allownil)}
    SCT_get_version := @ERR_SCT_get_version;
    {$ifend}
    {$if declared(SCT_get_version_introduced)}
    if LibVersion < SCT_get_version_introduced then
    begin
      {$if declared(FC_SCT_get_version)}
      SCT_get_version := @FC_SCT_get_version;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(SCT_get_version_removed)}
    if SCT_get_version_removed <= LibVersion then
    begin
      {$if declared(_SCT_get_version)}
      SCT_get_version := @_SCT_get_version;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(SCT_get_version_allownil)}
    if FuncLoadError then
      AFailed.Add('SCT_get_version');
    {$ifend}
  end;

  SCT_set_version := LoadLibFunction(ADllHandle, SCT_set_version_procname);
  FuncLoadError := not assigned(SCT_set_version);
  if FuncLoadError then
  begin
    {$if not defined(SCT_set_version_allownil)}
    SCT_set_version := @ERR_SCT_set_version;
    {$ifend}
    {$if declared(SCT_set_version_introduced)}
    if LibVersion < SCT_set_version_introduced then
    begin
      {$if declared(FC_SCT_set_version)}
      SCT_set_version := @FC_SCT_set_version;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(SCT_set_version_removed)}
    if SCT_set_version_removed <= LibVersion then
    begin
      {$if declared(_SCT_set_version)}
      SCT_set_version := @_SCT_set_version;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(SCT_set_version_allownil)}
    if FuncLoadError then
      AFailed.Add('SCT_set_version');
    {$ifend}
  end;

  SCT_get_log_entry_type := LoadLibFunction(ADllHandle, SCT_get_log_entry_type_procname);
  FuncLoadError := not assigned(SCT_get_log_entry_type);
  if FuncLoadError then
  begin
    {$if not defined(SCT_get_log_entry_type_allownil)}
    SCT_get_log_entry_type := @ERR_SCT_get_log_entry_type;
    {$ifend}
    {$if declared(SCT_get_log_entry_type_introduced)}
    if LibVersion < SCT_get_log_entry_type_introduced then
    begin
      {$if declared(FC_SCT_get_log_entry_type)}
      SCT_get_log_entry_type := @FC_SCT_get_log_entry_type;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(SCT_get_log_entry_type_removed)}
    if SCT_get_log_entry_type_removed <= LibVersion then
    begin
      {$if declared(_SCT_get_log_entry_type)}
      SCT_get_log_entry_type := @_SCT_get_log_entry_type;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(SCT_get_log_entry_type_allownil)}
    if FuncLoadError then
      AFailed.Add('SCT_get_log_entry_type');
    {$ifend}
  end;

  SCT_set_log_entry_type := LoadLibFunction(ADllHandle, SCT_set_log_entry_type_procname);
  FuncLoadError := not assigned(SCT_set_log_entry_type);
  if FuncLoadError then
  begin
    {$if not defined(SCT_set_log_entry_type_allownil)}
    SCT_set_log_entry_type := @ERR_SCT_set_log_entry_type;
    {$ifend}
    {$if declared(SCT_set_log_entry_type_introduced)}
    if LibVersion < SCT_set_log_entry_type_introduced then
    begin
      {$if declared(FC_SCT_set_log_entry_type)}
      SCT_set_log_entry_type := @FC_SCT_set_log_entry_type;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(SCT_set_log_entry_type_removed)}
    if SCT_set_log_entry_type_removed <= LibVersion then
    begin
      {$if declared(_SCT_set_log_entry_type)}
      SCT_set_log_entry_type := @_SCT_set_log_entry_type;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(SCT_set_log_entry_type_allownil)}
    if FuncLoadError then
      AFailed.Add('SCT_set_log_entry_type');
    {$ifend}
  end;

  SCT_get0_log_id := LoadLibFunction(ADllHandle, SCT_get0_log_id_procname);
  FuncLoadError := not assigned(SCT_get0_log_id);
  if FuncLoadError then
  begin
    {$if not defined(SCT_get0_log_id_allownil)}
    SCT_get0_log_id := @ERR_SCT_get0_log_id;
    {$ifend}
    {$if declared(SCT_get0_log_id_introduced)}
    if LibVersion < SCT_get0_log_id_introduced then
    begin
      {$if declared(FC_SCT_get0_log_id)}
      SCT_get0_log_id := @FC_SCT_get0_log_id;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(SCT_get0_log_id_removed)}
    if SCT_get0_log_id_removed <= LibVersion then
    begin
      {$if declared(_SCT_get0_log_id)}
      SCT_get0_log_id := @_SCT_get0_log_id;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(SCT_get0_log_id_allownil)}
    if FuncLoadError then
      AFailed.Add('SCT_get0_log_id');
    {$ifend}
  end;

  SCT_set0_log_id := LoadLibFunction(ADllHandle, SCT_set0_log_id_procname);
  FuncLoadError := not assigned(SCT_set0_log_id);
  if FuncLoadError then
  begin
    {$if not defined(SCT_set0_log_id_allownil)}
    SCT_set0_log_id := @ERR_SCT_set0_log_id;
    {$ifend}
    {$if declared(SCT_set0_log_id_introduced)}
    if LibVersion < SCT_set0_log_id_introduced then
    begin
      {$if declared(FC_SCT_set0_log_id)}
      SCT_set0_log_id := @FC_SCT_set0_log_id;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(SCT_set0_log_id_removed)}
    if SCT_set0_log_id_removed <= LibVersion then
    begin
      {$if declared(_SCT_set0_log_id)}
      SCT_set0_log_id := @_SCT_set0_log_id;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(SCT_set0_log_id_allownil)}
    if FuncLoadError then
      AFailed.Add('SCT_set0_log_id');
    {$ifend}
  end;

  SCT_set1_log_id := LoadLibFunction(ADllHandle, SCT_set1_log_id_procname);
  FuncLoadError := not assigned(SCT_set1_log_id);
  if FuncLoadError then
  begin
    {$if not defined(SCT_set1_log_id_allownil)}
    SCT_set1_log_id := @ERR_SCT_set1_log_id;
    {$ifend}
    {$if declared(SCT_set1_log_id_introduced)}
    if LibVersion < SCT_set1_log_id_introduced then
    begin
      {$if declared(FC_SCT_set1_log_id)}
      SCT_set1_log_id := @FC_SCT_set1_log_id;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(SCT_set1_log_id_removed)}
    if SCT_set1_log_id_removed <= LibVersion then
    begin
      {$if declared(_SCT_set1_log_id)}
      SCT_set1_log_id := @_SCT_set1_log_id;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(SCT_set1_log_id_allownil)}
    if FuncLoadError then
      AFailed.Add('SCT_set1_log_id');
    {$ifend}
  end;
  SCT_get_timestamp := LoadLibFunction(ADllHandle, SCT_get_timestamp_procname);
  FuncLoadError := not assigned(SCT_get_timestamp);
  if FuncLoadError then
  begin
    {$if not defined(SCT_get_timestamp_allownil)}
    SCT_get_timestamp := @ERR_SCT_get_timestamp;
    {$ifend}
    {$if declared(SCT_get_timestamp_introduced)}
    if LibVersion < SCT_get_timestamp_introduced then
    begin
      {$if declared(FC_SCT_get_timestamp)}
      SCT_get_timestamp := @FC_SCT_get_timestamp;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(SCT_get_timestamp_removed)}
    if SCT_get_timestamp_removed <= LibVersion then
    begin
      {$if declared(_SCT_get_timestamp)}
      SCT_get_timestamp := @_SCT_get_timestamp;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(SCT_get_timestamp_allownil)}
    if FuncLoadError then
      AFailed.Add('SCT_get_timestamp');
    {$ifend}
  end;

  SCT_set_timestamp := LoadLibFunction(ADllHandle, SCT_set_timestamp_procname);
  FuncLoadError := not assigned(SCT_set_timestamp);
  if FuncLoadError then
  begin
    {$if not defined(SCT_set_timestamp_allownil)}
    SCT_set_timestamp := @ERR_SCT_set_timestamp;
    {$ifend}
    {$if declared(SCT_set_timestamp_introduced)}
    if LibVersion < SCT_set_timestamp_introduced then
    begin
      {$if declared(FC_SCT_set_timestamp)}
      SCT_set_timestamp := @FC_SCT_set_timestamp;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(SCT_set_timestamp_removed)}
    if SCT_set_timestamp_removed <= LibVersion then
    begin
      {$if declared(_SCT_set_timestamp)}
      SCT_set_timestamp := @_SCT_set_timestamp;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(SCT_set_timestamp_allownil)}
    if FuncLoadError then
      AFailed.Add('SCT_set_timestamp');
    {$ifend}
  end;

  SCT_get_signature_nid := LoadLibFunction(ADllHandle, SCT_get_signature_nid_procname);
  FuncLoadError := not assigned(SCT_get_signature_nid);
  if FuncLoadError then
  begin
    {$if not defined(SCT_get_signature_nid_allownil)}
    SCT_get_signature_nid := @ERR_SCT_get_signature_nid;
    {$ifend}
    {$if declared(SCT_get_signature_nid_introduced)}
    if LibVersion < SCT_get_signature_nid_introduced then
    begin
      {$if declared(FC_SCT_get_signature_nid)}
      SCT_get_signature_nid := @FC_SCT_get_signature_nid;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(SCT_get_signature_nid_removed)}
    if SCT_get_signature_nid_removed <= LibVersion then
    begin
      {$if declared(_SCT_get_signature_nid)}
      SCT_get_signature_nid := @_SCT_get_signature_nid;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(SCT_get_signature_nid_allownil)}
    if FuncLoadError then
      AFailed.Add('SCT_get_signature_nid');
    {$ifend}
  end;

  SCT_set_signature_nid := LoadLibFunction(ADllHandle, SCT_set_signature_nid_procname);
  FuncLoadError := not assigned(SCT_set_signature_nid);
  if FuncLoadError then
  begin
    {$if not defined(SCT_set_signature_nid_allownil)}
    SCT_set_signature_nid := @ERR_SCT_set_signature_nid;
    {$ifend}
    {$if declared(SCT_set_signature_nid_introduced)}
    if LibVersion < SCT_set_signature_nid_introduced then
    begin
      {$if declared(FC_SCT_set_signature_nid)}
      SCT_set_signature_nid := @FC_SCT_set_signature_nid;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(SCT_set_signature_nid_removed)}
    if SCT_set_signature_nid_removed <= LibVersion then
    begin
      {$if declared(_SCT_set_signature_nid)}
      SCT_set_signature_nid := @_SCT_set_signature_nid;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(SCT_set_signature_nid_allownil)}
    if FuncLoadError then
      AFailed.Add('SCT_set_signature_nid');
    {$ifend}
  end;

  SCT_get0_extensions := LoadLibFunction(ADllHandle, SCT_get0_extensions_procname);
  FuncLoadError := not assigned(SCT_get0_extensions);
  if FuncLoadError then
  begin
    {$if not defined(SCT_get0_extensions_allownil)}
    SCT_get0_extensions := @ERR_SCT_get0_extensions;
    {$ifend}
    {$if declared(SCT_get0_extensions_introduced)}
    if LibVersion < SCT_get0_extensions_introduced then
    begin
      {$if declared(FC_SCT_get0_extensions)}
      SCT_get0_extensions := @FC_SCT_get0_extensions;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(SCT_get0_extensions_removed)}
    if SCT_get0_extensions_removed <= LibVersion then
    begin
      {$if declared(_SCT_get0_extensions)}
      SCT_get0_extensions := @_SCT_get0_extensions;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(SCT_get0_extensions_allownil)}
    if FuncLoadError then
      AFailed.Add('SCT_get0_extensions');
    {$ifend}
  end;
  SCT_set0_extensions := LoadLibFunction(ADllHandle, SCT_set0_extensions_procname);
  FuncLoadError := not assigned(SCT_set0_extensions);
  if FuncLoadError then
  begin
    {$if not defined(SCT_set0_extensions_allownil)}
    SCT_set0_extensions := @ERR_SCT_set0_extensions;
    {$ifend}
    {$if declared(SCT_set0_extensions_introduced)}
    if LibVersion < SCT_set0_extensions_introduced then
    begin
      {$if declared(FC_SCT_set0_extensions)}
      SCT_set0_extensions := @FC_SCT_set0_extensions;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(SCT_set0_extensions_removed)}
    if SCT_set0_extensions_removed <= LibVersion then
    begin
      {$if declared(_SCT_set0_extensions)}
      SCT_set0_extensions := @_SCT_set0_extensions;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(SCT_set0_extensions_allownil)}
    if FuncLoadError then
      AFailed.Add('SCT_set0_extensions');
    {$ifend}
  end;
  SCT_set1_extensions := LoadLibFunction(ADllHandle, SCT_set1_extensions_procname);
  FuncLoadError := not assigned(SCT_set1_extensions);
  if FuncLoadError then
  begin
    {$if not defined(SCT_set1_extensions_allownil)}
    SCT_set1_extensions := @ERR_SCT_set1_extensions;
    {$ifend}
    {$if declared(SCT_set1_extensions_introduced)}
    if LibVersion < SCT_set1_extensions_introduced then
    begin
      {$if declared(FC_SCT_set1_extensions)}
      SCT_set1_extensions := @FC_SCT_set1_extensions;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(SCT_set1_extensions_removed)}
    if SCT_set1_extensions_removed <= LibVersion then
    begin
      {$if declared(_SCT_set1_extensions)}
      SCT_set1_extensions := @_SCT_set1_extensions;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(SCT_set1_extensions_allownil)}
    if FuncLoadError then
      AFailed.Add('SCT_set1_extensions');
    {$ifend}
  end;
  SCT_get0_signature := LoadLibFunction(ADllHandle, SCT_get0_signature_procname);
  FuncLoadError := not assigned(SCT_get0_signature);
  if FuncLoadError then
  begin
    {$if not defined(SCT_get0_signature_allownil)}
    SCT_get0_signature := @ERR_SCT_get0_signature;
    {$ifend}
    {$if declared(SCT_get0_signature_introduced)}
    if LibVersion < SCT_get0_signature_introduced then
    begin
      {$if declared(FC_SCT_get0_signature)}
      SCT_get0_signature := @FC_SCT_get0_signature;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(SCT_get0_signature_removed)}
    if SCT_get0_signature_removed <= LibVersion then
    begin
      {$if declared(_SCT_get0_signature)}
      SCT_get0_signature := @_SCT_get0_signature;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(SCT_get0_signature_allownil)}
    if FuncLoadError then
      AFailed.Add('SCT_get0_signature');
    {$ifend}
  end;
  SCT_set0_signature := LoadLibFunction(ADllHandle, SCT_set0_signature_procname);
  FuncLoadError := not assigned(SCT_set0_signature);
  if FuncLoadError then
  begin
    {$if not defined(SCT_set0_signature_allownil)}
    SCT_set0_signature := @ERR_SCT_set0_signature;
    {$ifend}
    {$if declared(SCT_set0_signature_introduced)}
    if LibVersion < SCT_set0_signature_introduced then
    begin
      {$if declared(FC_SCT_set0_signature)}
      SCT_set0_signature := @FC_SCT_set0_signature;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(SCT_set0_signature_removed)}
    if SCT_set0_signature_removed <= LibVersion then
    begin
      {$if declared(_SCT_set0_signature)}
      SCT_set0_signature := @_SCT_set0_signature;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(SCT_set0_signature_allownil)}
    if FuncLoadError then
      AFailed.Add('SCT_set0_signature');
    {$ifend}
  end;
  SCT_set1_signature := LoadLibFunction(ADllHandle, SCT_set1_signature_procname);
  FuncLoadError := not assigned(SCT_set1_signature);
  if FuncLoadError then
  begin
    {$if not defined(SCT_set1_signature_allownil)}
    SCT_set1_signature := @ERR_SCT_set1_signature;
    {$ifend}
    {$if declared(SCT_set1_signature_introduced)}
    if LibVersion < SCT_set1_signature_introduced then
    begin
      {$if declared(FC_SCT_set1_signature)}
      SCT_set1_signature := @FC_SCT_set1_signature;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(SCT_set1_signature_removed)}
    if SCT_set1_signature_removed <= LibVersion then
    begin
      {$if declared(_SCT_set1_signature)}
      SCT_set1_signature := @_SCT_set1_signature;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(SCT_set1_signature_allownil)}
    if FuncLoadError then
      AFailed.Add('SCT_set1_signature');
    {$ifend}
  end;

  SCT_get_source := LoadLibFunction(ADllHandle, SCT_get_source_procname);
  FuncLoadError := not assigned(SCT_get_source);
  if FuncLoadError then
  begin
    {$if not defined(SCT_get_source_allownil)}
    SCT_get_source := @ERR_SCT_get_source;
    {$ifend}
    {$if declared(SCT_get_source_introduced)}
    if LibVersion < SCT_get_source_introduced then
    begin
      {$if declared(FC_SCT_get_source)}
      SCT_get_source := @FC_SCT_get_source;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(SCT_get_source_removed)}
    if SCT_get_source_removed <= LibVersion then
    begin
      {$if declared(_SCT_get_source)}
      SCT_get_source := @_SCT_get_source;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(SCT_get_source_allownil)}
    if FuncLoadError then
      AFailed.Add('SCT_get_source');
    {$ifend}
  end;
  SCT_set_source := LoadLibFunction(ADllHandle, SCT_set_source_procname);
  FuncLoadError := not assigned(SCT_set_source);
  if FuncLoadError then
  begin
    {$if not defined(SCT_set_source_allownil)}
    SCT_set_source := @ERR_SCT_set_source;
    {$ifend}
    {$if declared(SCT_set_source_introduced)}
    if LibVersion < SCT_set_source_introduced then
    begin
      {$if declared(FC_SCT_set_source)}
      SCT_set_source := @FC_SCT_set_source;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(SCT_set_source_removed)}
    if SCT_set_source_removed <= LibVersion then
    begin
      {$if declared(_SCT_set_source)}
      SCT_set_source := @_SCT_set_source;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(SCT_set_source_allownil)}
    if FuncLoadError then
      AFailed.Add('SCT_set_source');
    {$ifend}
  end;

  SCT_validation_status_string := LoadLibFunction(ADllHandle, SCT_validation_status_string_procname);
  FuncLoadError := not assigned(SCT_validation_status_string);
  if FuncLoadError then
  begin
    {$if not defined(SCT_validation_status_string_allownil)}
    SCT_validation_status_string := @ERR_SCT_validation_status_string;
    {$ifend}
    {$if declared(SCT_validation_status_string_introduced)}
    if LibVersion < SCT_validation_status_string_introduced then
    begin
      {$if declared(FC_SCT_validation_status_string)}
      SCT_validation_status_string := @FC_SCT_validation_status_string;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(SCT_validation_status_string_removed)}
    if SCT_validation_status_string_removed <= LibVersion then
    begin
      {$if declared(_SCT_validation_status_string)}
      SCT_validation_status_string := @_SCT_validation_status_string;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(SCT_validation_status_string_allownil)}
    if FuncLoadError then
      AFailed.Add('SCT_validation_status_string');
    {$ifend}
  end;
  SCT_print := LoadLibFunction(ADllHandle, SCT_print_procname);
  FuncLoadError := not assigned(SCT_print);
  if FuncLoadError then
  begin
    {$if not defined(SCT_print_allownil)}
    SCT_print := @ERR_SCT_print;
    {$ifend}
    {$if declared(SCT_print_introduced)}
    if LibVersion < SCT_print_introduced then
    begin
      {$if declared(FC_SCT_print)}
      SCT_print := @FC_SCT_print;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(SCT_print_removed)}
    if SCT_print_removed <= LibVersion then
    begin
      {$if declared(_SCT_print)}
      SCT_print := @_SCT_print;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(SCT_print_allownil)}
    if FuncLoadError then
      AFailed.Add('SCT_print');
    {$ifend}
  end;

  SCT_LIST_print := LoadLibFunction(ADllHandle, SCT_LIST_print_procname);
  FuncLoadError := not assigned(SCT_LIST_print);
  if FuncLoadError then
  begin
    {$if not defined(SCT_LIST_print_allownil)}
    SCT_LIST_print := @ERR_SCT_LIST_print;
    {$ifend}
    {$if declared(SCT_LIST_print_introduced)}
    if LibVersion < SCT_LIST_print_introduced then
    begin
      {$if declared(FC_SCT_LIST_print)}
      SCT_LIST_print := @FC_SCT_LIST_print;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(SCT_LIST_print_removed)}
    if SCT_LIST_print_removed <= LibVersion then
    begin
      {$if declared(_SCT_LIST_print)}
      SCT_LIST_print := @_SCT_LIST_print;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(SCT_LIST_print_allownil)}
    if FuncLoadError then
      AFailed.Add('SCT_LIST_print');
    {$ifend}
  end;
  SCT_get_validation_status := LoadLibFunction(ADllHandle, SCT_get_validation_status_procname);
  FuncLoadError := not assigned(SCT_get_validation_status);
  if FuncLoadError then
  begin
    {$if not defined(SCT_get_validation_status_allownil)}
    SCT_get_validation_status := @ERR_SCT_get_validation_status;
    {$ifend}
    {$if declared(SCT_get_validation_status_introduced)}
    if LibVersion < SCT_get_validation_status_introduced then
    begin
      {$if declared(FC_SCT_get_validation_status)}
      SCT_get_validation_status := @FC_SCT_get_validation_status;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(SCT_get_validation_status_removed)}
    if SCT_get_validation_status_removed <= LibVersion then
    begin
      {$if declared(_SCT_get_validation_status)}
      SCT_get_validation_status := @_SCT_get_validation_status;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(SCT_get_validation_status_allownil)}
    if FuncLoadError then
      AFailed.Add('SCT_get_validation_status');
    {$ifend}
  end;
  SCT_validate := LoadLibFunction(ADllHandle, SCT_validate_procname);
  FuncLoadError := not assigned(SCT_validate);
  if FuncLoadError then
  begin
    {$if not defined(SCT_validate_allownil)}
    SCT_validate := @ERR_SCT_validate;
    {$ifend}
    {$if declared(SCT_validate_introduced)}
    if LibVersion < SCT_validate_introduced then
    begin
      {$if declared(FC_SCT_validate)}
      SCT_validate := @FC_SCT_validate;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(SCT_validate_removed)}
    if SCT_validate_removed <= LibVersion then
    begin
      {$if declared(_SCT_validate)}
      SCT_validate := @_SCT_validate;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(SCT_validate_allownil)}
    if FuncLoadError then
      AFailed.Add('SCT_validate');
    {$ifend}
  end;

  SCT_LIST_validate := LoadLibFunction(ADllHandle, SCT_LIST_validate_procname);
  FuncLoadError := not assigned(SCT_LIST_validate);
  if FuncLoadError then
  begin
    {$if not defined(SCT_LIST_validate_allownil)}
    SCT_LIST_validate := @ERR_SCT_LIST_validate;
    {$ifend}
    {$if declared(SCT_LIST_validate_introduced)}
    if LibVersion < SCT_LIST_validate_introduced then
    begin
      {$if declared(FC_SCT_LIST_validate)}
      SCT_LIST_validate := @FC_SCT_LIST_validate;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(SCT_LIST_validate_removed)}
    if SCT_LIST_validate_removed <= LibVersion then
    begin
      {$if declared(_SCT_LIST_validate)}
      SCT_LIST_validate := @_SCT_LIST_validate;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(SCT_LIST_validate_allownil)}
    if FuncLoadError then
      AFailed.Add('SCT_LIST_validate');
    {$ifend}
  end;
  CTLOG_STORE_new := LoadLibFunction(ADllHandle, CTLOG_STORE_new_procname);
  FuncLoadError := not assigned(CTLOG_STORE_new);
  if FuncLoadError then
  begin
    {$if not defined(CTLOG_STORE_new_allownil)}
    CTLOG_STORE_new := @ERR_CTLOG_STORE_new;
    {$ifend}
    {$if declared(CTLOG_STORE_new_introduced)}
    if LibVersion < CTLOG_STORE_new_introduced then
    begin
      {$if declared(FC_CTLOG_STORE_new)}
      CTLOG_STORE_new := @FC_CTLOG_STORE_new;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(CTLOG_STORE_new_removed)}
    if CTLOG_STORE_new_removed <= LibVersion then
    begin
      {$if declared(_CTLOG_STORE_new)}
      CTLOG_STORE_new := @_CTLOG_STORE_new;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(CTLOG_STORE_new_allownil)}
    if FuncLoadError then
      AFailed.Add('CTLOG_STORE_new');
    {$ifend}
  end;
  CTLOG_STORE_free := LoadLibFunction(ADllHandle, CTLOG_STORE_free_procname);
  FuncLoadError := not assigned(CTLOG_STORE_free);
  if FuncLoadError then
  begin
    {$if not defined(CTLOG_STORE_free_allownil)}
    CTLOG_STORE_free := @ERR_CTLOG_STORE_free;
    {$ifend}
    {$if declared(CTLOG_STORE_free_introduced)}
    if LibVersion < CTLOG_STORE_free_introduced then
    begin
      {$if declared(FC_CTLOG_STORE_free)}
      CTLOG_STORE_free := @FC_CTLOG_STORE_free;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(CTLOG_STORE_free_removed)}
    if CTLOG_STORE_free_removed <= LibVersion then
    begin
      {$if declared(_CTLOG_STORE_free)}
      CTLOG_STORE_free := @_CTLOG_STORE_free;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(CTLOG_STORE_free_allownil)}
    if FuncLoadError then
      AFailed.Add('CTLOG_STORE_free');
    {$ifend}
  end;
  CTLOG_STORE_get0_log_by_id := LoadLibFunction(ADllHandle, CTLOG_STORE_get0_log_by_id_procname);
  FuncLoadError := not assigned(CTLOG_STORE_get0_log_by_id);
  if FuncLoadError then
  begin
    {$if not defined(CTLOG_STORE_get0_log_by_id_allownil)}
    CTLOG_STORE_get0_log_by_id := @ERR_CTLOG_STORE_get0_log_by_id;
    {$ifend}
    {$if declared(CTLOG_STORE_get0_log_by_id_introduced)}
    if LibVersion < CTLOG_STORE_get0_log_by_id_introduced then
    begin
      {$if declared(FC_CTLOG_STORE_get0_log_by_id)}
      CTLOG_STORE_get0_log_by_id := @FC_CTLOG_STORE_get0_log_by_id;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(CTLOG_STORE_get0_log_by_id_removed)}
    if CTLOG_STORE_get0_log_by_id_removed <= LibVersion then
    begin
      {$if declared(_CTLOG_STORE_get0_log_by_id)}
      CTLOG_STORE_get0_log_by_id := @_CTLOG_STORE_get0_log_by_id;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(CTLOG_STORE_get0_log_by_id_allownil)}
    if FuncLoadError then
      AFailed.Add('CTLOG_STORE_get0_log_by_id');
    {$ifend}
  end;
  CTLOG_STORE_load_file := LoadLibFunction(ADllHandle, CTLOG_STORE_load_file_procname);
  FuncLoadError := not assigned(CTLOG_STORE_load_file);
  if FuncLoadError then
  begin
    {$if not defined(CTLOG_STORE_load_file_allownil)}
    CTLOG_STORE_load_file := @ERR_CTLOG_STORE_load_file;
    {$ifend}
    {$if declared(CTLOG_STORE_load_file_introduced)}
    if LibVersion < CTLOG_STORE_load_file_introduced then
    begin
      {$if declared(FC_CTLOG_STORE_load_file)}
      CTLOG_STORE_load_file := @FC_CTLOG_STORE_load_file;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(CTLOG_STORE_load_file_removed)}
    if CTLOG_STORE_load_file_removed <= LibVersion then
    begin
      {$if declared(_CTLOG_STORE_load_file)}
      CTLOG_STORE_load_file := @_CTLOG_STORE_load_file;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(CTLOG_STORE_load_file_allownil)}
    if FuncLoadError then
      AFailed.Add('CTLOG_STORE_load_file');
    {$ifend}
  end;
  CTLOG_STORE_load_default_file := LoadLibFunction(ADllHandle, CTLOG_STORE_load_default_file_procname);
  FuncLoadError := not assigned(CTLOG_STORE_load_default_file);
  if FuncLoadError then
  begin
    {$if not defined(CTLOG_STORE_load_default_file_allownil)}
    CTLOG_STORE_load_default_file := @ERR_CTLOG_STORE_load_default_file;
    {$ifend}
    {$if declared(CTLOG_STORE_load_default_file_introduced)}
    if LibVersion < CTLOG_STORE_load_default_file_introduced then
    begin
      {$if declared(FC_CTLOG_STORE_load_default_file)}
      CTLOG_STORE_load_default_file := @FC_CTLOG_STORE_load_default_file;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(CTLOG_STORE_load_default_file_removed)}
    if CTLOG_STORE_load_default_file_removed <= LibVersion then
    begin
      {$if declared(_CTLOG_STORE_load_default_file)}
      CTLOG_STORE_load_default_file := @_CTLOG_STORE_load_default_file;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(CTLOG_STORE_load_default_file_allownil)}
    if FuncLoadError then
      AFailed.Add('CTLOG_STORE_load_default_file');
    {$ifend}
  end;
  ERR_load_CT_strings := LoadLibFunction(ADllHandle, ERR_load_CT_strings_procname);
  FuncLoadError := not assigned(ERR_load_CT_strings);
  if FuncLoadError then
  begin
    {$if not defined(ERR_load_CT_strings_allownil)}
    ERR_load_CT_strings := @ERR_ERR_load_CT_strings;
    {$ifend}
    {$if declared(ERR_load_CT_strings_introduced)}
    if LibVersion < ERR_load_CT_strings_introduced then
    begin
      {$if declared(FC_ERR_load_CT_strings)}
      ERR_load_CT_strings := @FC_ERR_load_CT_strings;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(ERR_load_CT_strings_removed)}
    if ERR_load_CT_strings_removed <= LibVersion then
    begin
      {$if declared(_ERR_load_CT_strings)}
      ERR_load_CT_strings := @_ERR_load_CT_strings;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(ERR_load_CT_strings_allownil)}
    if FuncLoadError then
      AFailed.Add('ERR_load_CT_strings');
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

  SCT_new := nil;
  SCT_new_from_base64 := nil;
  SCT_free := nil;
  SCT_LIST_free := nil;
  SCT_get_version := nil;
  SCT_set_version := nil;
  SCT_get_log_entry_type := nil;
  SCT_set_log_entry_type := nil;
  SCT_get0_log_id := nil;
  SCT_set0_log_id := nil;
  SCT_set1_log_id := nil;
  SCT_get_timestamp := nil;
  SCT_set_timestamp := nil;
  SCT_get_signature_nid := nil;
  SCT_set_signature_nid := nil;
  SCT_get0_extensions := nil;
  SCT_set0_extensions := nil;
  SCT_set1_extensions := nil;
  SCT_get0_signature := nil;
  SCT_set0_signature := nil;
  SCT_set1_signature := nil;
  SCT_get_source := nil;
  SCT_set_source := nil;
  SCT_validation_status_string := nil;
  SCT_print := nil;
  SCT_LIST_print := nil;
  SCT_get_validation_status := nil;
  SCT_validate := nil;
  SCT_LIST_validate := nil;

  CTLOG_STORE_new := nil;
  CTLOG_STORE_free := nil;
  CTLOG_STORE_get0_log_by_id := nil;
  CTLOG_STORE_load_file := nil;
  CTLOG_STORE_load_default_file := nil;

  ERR_load_CT_strings := nil;
end;
{$ENDIF}
{$IFNDEF OPENSSL_STATIC_LINK_MODEL}

initialization

Register_SSLLoader(@Load, 'LibCrypto');
Register_SSLUnloader(@Unload);
{$ENDIF}

end.

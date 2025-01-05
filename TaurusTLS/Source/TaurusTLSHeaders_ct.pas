unit TaurusTLSHeaders_ct;

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

interface

uses
  IdCTypes,
  TaurusTLSHeaders_ossl_typ,
  TaurusTLSHeaders_stack;

type
  PSTACK_OF_SCT = type pointer;
  PSTACK_OF_CTLOG = type pointer;

 {$IFNDEF OPENSSL_STATIC_LINK_MODEL}
type
  Tsk_SCT_new = function(cmp: TOPENSSL_sk_compfunc)
    : PSTACK_OF_SCT cdecl;
  Tsk_SCT_new_null = function: PSTACK_OF_SCT cdecl;
  Tsk_SCT_free = procedure(st: PSTACK_OF_SCT)cdecl;
  Tsk_SCT_num = function(const sk: PSTACK_OF_SCT): TIdC_INT cdecl;
  Tsk_SCT_value = function(const sk: PSTACK_OF_SCT; i: TIdC_INT)
    : PSCT cdecl;
  Tsk_SCT_push = function(sk: PSTACK_OF_SCT; st: PSCT)
    : TIdC_INT cdecl;
  Tsk_SCT_dup = function(sk: PSTACK_OF_SCT)
    : PSTACK_OF_SCT cdecl;
  Tsk_SCT_find = function(sk: PSTACK_OF_SCT; _val: PSCT)
    : TIdC_INT cdecl;
  Tsk_SCT_pop_free = procedure(sk: PSTACK_OF_SCT;
    func: TOPENSSL_sk_freefunc)cdecl;

  Tsk_CTLOG_new = function(cmp: TOPENSSL_sk_compfunc)
    : PSTACK_OF_CTLOG cdecl;
  Tsk_CTLOG_new_null = function: PSTACK_OF_CTLOG cdecl;
  Tsk_CTLOG_free = procedure(st: PSTACK_OF_CTLOG)cdecl;
  Tsk_CTLOG_num = function(const sk: PSTACK_OF_CTLOG): TIdC_INT cdecl;
  Tsk_CTLOG_value = function(const sk: PSTACK_OF_CTLOG; i: TIdC_INT)
    : PCTLOG cdecl;
  Tsk_CTLOG_push = function(sk: PSTACK_OF_CTLOG; st: PCTLOG)
    : TIdC_INT cdecl;
  Tsk_CTLOG_dup = function(sk: PSTACK_OF_CTLOG)
    : PSTACK_OF_CTLOG cdecl;
  Tsk_CTLOG_find = function(sk: PSTACK_OF_CTLOG; _val: PCTLOG)
    : TIdC_INT cdecl;
  Tsk_CTLOG_pop_free = procedure(sk: PSTACK_OF_CTLOG;
    func: TOPENSSL_sk_freefunc)cdecl;

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
function sk_SCT_new(cmp: Tsk_new_cmp): PSTACK_OF_SCT cdecl;
  external CLibCrypto name 'OPENSSL_sk_new';
function sk_SCT_new_null: PSTACK_OF_SCT cdecl;
  external CLibCrypto name 'OPENSSL_sk_new_null';
procedure sk_SCT_free(st: PSTACK_OF_SCT)cdecl;
  external CLibCrypto name 'OPENSSL_sk_free';
function sk_SCT_num(const sk: PSTACK_OF_SCT): TIdC_INT cdecl;
  external CLibCrypto name 'OPENSSL_sk_num';
function sk_SCT_value(const sk: PSTACK_OF_SCT; i: TIdC_INT)
  : PSCT cdecl; external CLibCrypto name 'OPENSSL_sk_value';
function sk_SCT_push(sk: PSTACK_OF_SCT; st: PSCT)
  : TIdC_INT cdecl; external CLibCrypto name 'OPENSSL_sk_push';
function sk_SCT_dup(sk: PSTACK_OF_SCT)
  : PSTACK_OF_SCT cdecl; external CLibCrypto name 'OPENSSL_sk_dup';
function sk_SCT_find(sk: PSTACK_OF_SCT; val: PSCT)
  : TIdC_INT cdecl; external CLibCrypto name 'OPENSSL_sk_find';
procedure sk_SCT_pop_free(sk: PSTACK_OF_SCT;
  func: Tsk_pop_free_func)cdecl; external CLibCrypto name 'OPENSSL_sk_pop_free';

function sk_CTLOG_new(cmp: Tsk_new_cmp): PSTACK_OF_CTLOG cdecl;
  external CLibCrypto name 'OPENSSL_sk_new';
function sk_CTLOG_new_null: PSTACK_OF_CTLOG cdecl;
  external CLibCrypto name 'OPENSSL_sk_new_null';
procedure sk_CTLOG_free(st: PSTACK_OF_CTLOG)cdecl;
  external CLibCrypto name 'OPENSSL_sk_free';
function sk_CTLOG_num(const sk: PSTACK_OF_CTLOG): TIdC_INT cdecl;
  external CLibCrypto name 'OPENSSL_sk_num';
function sk_CTLOG_value(const sk: PSTACK_OF_CTLOG; i: TIdC_INT)
  : PCTLOG cdecl; external CLibCrypto name 'OPENSSL_sk_value';
function sk_CTLOG_push(sk: PSTACK_OF_CTLOG; st: PCTLOG)
  : TIdC_INT cdecl; external CLibCrypto name 'OPENSSL_sk_push';
function sk_CTLOG_dup(sk: PSTACK_OF_CTLOG)
  : PSTACK_OF_CTLOG cdecl; external CLibCrypto name 'OPENSSL_sk_dup';
function sk_CTLOG_find(sk: PSTACK_OF_CTLOG; val: PCTLOG)
  : TIdC_INT cdecl; external CLibCrypto name 'OPENSSL_sk_find';
procedure sk_CTLOG_pop_free(sk: PSTACK_OF_CTLOG;
  func: Tsk_pop_free_func)cdecl; external CLibCrypto name 'OPENSSL_sk_pop_free';

{$ENDIF}

implementation

end.

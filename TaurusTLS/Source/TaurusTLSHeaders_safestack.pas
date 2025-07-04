/// <exclude />
unit TaurusTLSHeaders_safestack;

{$i TaurusTLSCompilerDefines.inc}
{$i TaurusTLSLinkDefines.inc}

{******************************************************************************}
{*  TaurusTLS                                                                 *}
{*           https://github.com/JPeterMugaas/TaurusTLS                        *}
{*                                                                            *}
{*  Copyright (c) 2024 TaurusTLS Developers, All Rights Reserved              *}
{*                                                                            *}
{* Portions of this software are Copyright (c) 1993 � 2018,                   *}
{* Chad Z. Hower (Kudzu) and the Indy Pit Crew � http://www.IndyProject.org/  *}
{******************************************************************************}
interface

uses
  IdCTypes,
  IdGlobal,
  TaurusTLSHeaders_stack;

type
  POPENSSL_STRING = PIdAnsiChar;

  PSTACK_OF_OPENSSL_STRING = pointer;
  Tsk_OPENSSL_STRING_compfunc = function(a: PPIdAnsiChar; b: PPIdAnsiChar): TIdC_INT cdecl;
  Tsk_OPENSSL_STRING_freefunc = procedure(a: PIdAnsiChar) cdecl;
  Tsk_OPENSSL_STRING_copyfunc = function(a: PIdAnsiChar): PIdAnsiChar cdecl;

function sk_OPENSSL_STRING_num(sk: PSTACK_OF_OPENSSL_STRING): TIdC_INT;
{$IFDEF USE_INLINE}inline; {$ENDIF}
function sk_OPENSSL_STRING_value(sk: PSTACK_OF_OPENSSL_STRING; idx: TIdC_INT)
  : PIdAnsiChar; {$IFDEF USE_INLINE}inline; {$ENDIF}
function sk_OPENSSL_STRING_new(compare: Tsk_OPENSSL_STRING_compfunc)
  : PSTACK_OF_OPENSSL_STRING; {$IFDEF USE_INLINE}inline; {$ENDIF}
function sk_OPENSSL_STRING_new_null: PSTACK_OF_OPENSSL_STRING;
{$IFDEF USE_INLINE}inline; {$ENDIF}
procedure sk_OPENSSL_STRING_free(sk: PSTACK_OF_OPENSSL_STRING);
{$IFDEF USE_INLINE}inline; {$ENDIF}
procedure sk_OPENSSL_STRING_zero(sk: PSTACK_OF_OPENSSL_STRING);
{$IFDEF USE_INLINE}inline; {$ENDIF}
function sk_OPENSSL_STRING_delete(sk: PSTACK_OF_OPENSSL_STRING; i: TIdC_INT)
  : PIdAnsiChar; {$IFDEF USE_INLINE}inline; {$ENDIF}
function sk_OPENSSL_STRING_delete_ptr(sk: PSTACK_OF_OPENSSL_STRING;
  _ptr: PIdAnsiChar): PIdAnsiChar; {$IFDEF USE_INLINE}inline; {$ENDIF}
function sk_OPENSSL_STRING_push(sk: PSTACK_OF_OPENSSL_STRING; _ptr: PIdAnsiChar)
  : TIdC_INT; {$IFDEF USE_INLINE}inline; {$ENDIF}
function sk_OPENSSL_STRING_unshift(sk: PSTACK_OF_OPENSSL_STRING; _ptr: PIdAnsiChar)
  : TIdC_INT; {$IFDEF USE_INLINE}inline; {$ENDIF}
function sk_OPENSSL_STRING_pop(sk: PSTACK_OF_OPENSSL_STRING): PIdAnsiChar;
{$IFDEF USE_INLINE}inline; {$ENDIF}
function sk_OPENSSL_STRING_shift(sk: PSTACK_OF_OPENSSL_STRING): PIdAnsiChar;
{$IFDEF USE_INLINE}inline; {$ENDIF}
procedure sk_OPENSSL_STRING_pop_free(sk: PSTACK_OF_OPENSSL_STRING;
  freefunc: Tsk_OPENSSL_STRING_freefunc); {$IFDEF USE_INLINE}inline; {$ENDIF}
function sk_OPENSSL_STRING_insert(sk: PSTACK_OF_OPENSSL_STRING; _ptr: PIdAnsiChar;
  idx: TIdC_INT): TIdC_INT; {$IFDEF USE_INLINE}inline; {$ENDIF}
function sk_OPENSSL_STRING_set(sk: PSTACK_OF_OPENSSL_STRING; idx: TIdC_INT;
  _ptr: PIdAnsiChar): PIdAnsiChar; {$IFDEF USE_INLINE}inline; {$ENDIF}
function sk_OPENSSL_STRING_find(sk: PSTACK_OF_OPENSSL_STRING; _ptr: PIdAnsiChar)
  : TIdC_INT; {$IFDEF USE_INLINE}inline; {$ENDIF}
function sk_OPENSSL_STRING_find_ex(sk: PSTACK_OF_OPENSSL_STRING; _ptr: PIdAnsiChar)
  : TIdC_INT; {$IFDEF USE_INLINE}inline; {$ENDIF}
procedure sk_OPENSSL_STRING_sort(sk: PSTACK_OF_OPENSSL_STRING);
{$IFDEF USE_INLINE}inline; {$ENDIF}
function sk_OPENSSL_STRING_is_sorted(sk: PSTACK_OF_OPENSSL_STRING): TIdC_INT;
{$IFDEF USE_INLINE}inline; {$ENDIF}
function sk_OPENSSL_STRING_dup(sk: PSTACK_OF_OPENSSL_STRING)
  : PSTACK_OF_OPENSSL_STRING; {$IFDEF USE_INLINE}inline; {$ENDIF}
function sk_OPENSSL_STRING_deep_copy(sk: PSTACK_OF_OPENSSL_STRING;
  copyfunc: Tsk_OPENSSL_STRING_copyfunc; freefunc: Tsk_OPENSSL_STRING_freefunc)
  : PSTACK_OF_OPENSSL_STRING;  {$IFDEF USE_INLINE}inline;{$ENDIF}
function sk_OPENSSL_STRING_set_cmp_func(sk: PSTACK_OF_OPENSSL_STRING;
  compare: Tsk_OPENSSL_STRING_compfunc): Tsk_OPENSSL_STRING_compfunc;   {$IFDEF USE_INLINE}inline;{$ENDIF}

implementation

function sk_OPENSSL_STRING_num(sk: PSTACK_OF_OPENSSL_STRING): TIdC_INT;
{$IFDEF USE_INLINE}inline; {$ENDIF}
begin
  Result := OPENSSL_sk_num(POPENSSL_STACK(sk));
end;

function sk_OPENSSL_STRING_value(sk: PSTACK_OF_OPENSSL_STRING; idx: TIdC_INT)
  : PIdAnsiChar; {$IFDEF USE_INLINE}inline; {$ENDIF}
begin
  Result := PIdAnsiChar(OPENSSL_sk_value(POPENSSL_STACK(sk), idx));
end;

function sk_OPENSSL_STRING_new(compare: Tsk_OPENSSL_STRING_compfunc)
  : PSTACK_OF_OPENSSL_STRING; {$IFDEF USE_INLINE}inline; {$ENDIF}
begin
  Result := PSTACK_OF_OPENSSL_STRING
    (OPENSSL_sk_new(TOPENSSL_sk_compfunc(compare)));
end;

function sk_OPENSSL_STRING_new_null: PSTACK_OF_OPENSSL_STRING;
{$IFDEF USE_INLINE}inline; {$ENDIF}
begin
  Result := PSTACK_OF_OPENSSL_STRING(OPENSSL_sk_new_null);
end;

procedure sk_OPENSSL_STRING_free(sk: PSTACK_OF_OPENSSL_STRING);
{$IFDEF USE_INLINE}inline; {$ENDIF}
begin
  OPENSSL_sk_free(POPENSSL_STACK(sk));
end;

procedure sk_OPENSSL_STRING_zero(sk: PSTACK_OF_OPENSSL_STRING);
{$IFDEF USE_INLINE}inline; {$ENDIF}
begin
  OPENSSL_sk_zero(POPENSSL_STACK(sk));
end;

function sk_OPENSSL_STRING_delete(sk: PSTACK_OF_OPENSSL_STRING; i: TIdC_INT)
  : PIdAnsiChar; {$IFDEF USE_INLINE}inline; {$ENDIF}
begin
  Result := PIdAnsiChar(OPENSSL_sk_delete(POPENSSL_STACK(sk), i));
end;

function sk_OPENSSL_STRING_delete_ptr(sk: PSTACK_OF_OPENSSL_STRING;
  _ptr: PIdAnsiChar): PIdAnsiChar; {$IFDEF USE_INLINE}inline; {$ENDIF}
begin
  Result := PIdAnsiChar(OPENSSL_sk_delete_ptr(POPENSSL_STACK(sk), pointer(_ptr)));
end;

function sk_OPENSSL_STRING_push(sk: PSTACK_OF_OPENSSL_STRING; _ptr: PIdAnsiChar)
  : TIdC_INT; {$IFDEF USE_INLINE}inline; {$ENDIF}
begin
  Result := OPENSSL_sk_push(POPENSSL_STACK(sk), pointer(_ptr));
end;

function sk_OPENSSL_STRING_unshift(sk: PSTACK_OF_OPENSSL_STRING; _ptr: PIdAnsiChar)
  : TIdC_INT; {$IFDEF USE_INLINE}inline; {$ENDIF}
begin
  Result := OPENSSL_sk_unshift(POPENSSL_STACK(sk), pointer(_ptr));
end;

function sk_OPENSSL_STRING_pop(sk: PSTACK_OF_OPENSSL_STRING): PIdAnsiChar;
{$IFDEF USE_INLINE}inline; {$ENDIF}
begin
  Result := PIdAnsiChar(OPENSSL_sk_pop(POPENSSL_STACK(sk)));
end;

function sk_OPENSSL_STRING_shift(sk: PSTACK_OF_OPENSSL_STRING): PIdAnsiChar;
{$IFDEF USE_INLINE}inline; {$ENDIF}
begin
  Result := PIdAnsiChar(OPENSSL_sk_shift(POPENSSL_STACK(sk)));
end;

procedure sk_OPENSSL_STRING_pop_free(sk: PSTACK_OF_OPENSSL_STRING;
  freefunc: Tsk_OPENSSL_STRING_freefunc); {$IFDEF USE_INLINE}inline; {$ENDIF}
begin
  OPENSSL_sk_pop_free(POPENSSL_STACK(sk), TOPENSSL_sk_freefunc(freefunc));
end;

function sk_OPENSSL_STRING_insert(sk: PSTACK_OF_OPENSSL_STRING; _ptr: PIdAnsiChar;
  idx: TIdC_INT): TIdC_INT; {$IFDEF USE_INLINE}inline; {$ENDIF}
begin
  Result := OPENSSL_sk_insert(POPENSSL_STACK(sk), pointer(_ptr), idx);
end;

function sk_OPENSSL_STRING_set(sk: PSTACK_OF_OPENSSL_STRING; idx: TIdC_INT;
  _ptr: PIdAnsiChar): PIdAnsiChar; {$IFDEF USE_INLINE}inline; {$ENDIF}
begin
  Result := PIdAnsiChar(OPENSSL_sk_set(POPENSSL_STACK(sk), idx, pointer(_ptr)));
end;

function sk_OPENSSL_STRING_find(sk: PSTACK_OF_OPENSSL_STRING; _ptr: PIdAnsiChar)
  : TIdC_INT; {$IFDEF USE_INLINE}inline; {$ENDIF}
begin
  Result := OPENSSL_sk_find(POPENSSL_STACK(sk), pointer(_ptr));
end;

function sk_OPENSSL_STRING_find_ex(sk: PSTACK_OF_OPENSSL_STRING; _ptr: PIdAnsiChar)
  : TIdC_INT; {$IFDEF USE_INLINE}inline; {$ENDIF}
begin
  Result := OPENSSL_sk_find_ex(POPENSSL_STACK(sk), pointer(_ptr));
end;

procedure sk_OPENSSL_STRING_sort(sk: PSTACK_OF_OPENSSL_STRING);
{$IFDEF USE_INLINE}inline; {$ENDIF}
begin
  OPENSSL_sk_sort(POPENSSL_STACK(sk));
end;

function sk_OPENSSL_STRING_is_sorted(sk: PSTACK_OF_OPENSSL_STRING): TIdC_INT;
{$IFDEF USE_INLINE}inline; {$ENDIF}
begin
  Result := OPENSSL_sk_is_sorted(POPENSSL_STACK(sk));
end;

function sk_OPENSSL_STRING_dup(sk: PSTACK_OF_OPENSSL_STRING)
  : PSTACK_OF_OPENSSL_STRING; {$IFDEF USE_INLINE}inline; {$ENDIF}
begin
  Result := PSTACK_OF_OPENSSL_STRING(OPENSSL_sk_dup(POPENSSL_STACK(sk)));
end;

function sk_OPENSSL_STRING_deep_copy(sk: PSTACK_OF_OPENSSL_STRING;
  copyfunc: Tsk_OPENSSL_STRING_copyfunc; freefunc: Tsk_OPENSSL_STRING_freefunc)
  : PSTACK_OF_OPENSSL_STRING;  {$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := PSTACK_OF_OPENSSL_STRING(OPENSSL_sk_deep_copy(POPENSSL_STACK(sk),
    TOPENSSL_sk_copyfunc(copyfunc), TOPENSSL_sk_freefunc(freefunc)));
end;

function sk_OPENSSL_STRING_set_cmp_func(sk: PSTACK_OF_OPENSSL_STRING;
  compare: Tsk_OPENSSL_STRING_compfunc): Tsk_OPENSSL_STRING_compfunc;   {$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := Tsk_OPENSSL_STRING_compfunc
    (OPENSSL_sk_set_cmp_func(sk,
    TOPENSSL_sk_compfunc(compare)));
end;

end.

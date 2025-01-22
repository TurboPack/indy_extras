{******************************************************************************}
{*  TaurusTLS                                                                 *}
{*           https://github.com/JPeterMugaas/TaurusTLS                        *}
{*                                                                            *}
{*  Copyright (c) 2024 TaurusTLS Developers, All Rights Reserved              *}
{*                                                                            *}
{* Portions of this software are Copyright (c) 1993 – 2018,                   *}
{* Chad Z. Hower (Kudzu) and the Indy Pit Crew – http://www.IndyProject.org/  *}
{******************************************************************************}

/// <summary>
/// Self-registrated NT LAN Manager (NTLM) Protocol Implementation for Indy -
/// Internet Direct.
/// </summary>
/// <remarks>
/// The NT LAN Manager (NTLM) Protocol is not considered secure.  It has been
/// depreciated even by Microsoft.
/// </remarks>
unit TaurusTLS_NTLM;

{$I TaurusTLSCompilerDefines.inc}

interface

implementation

uses
  IdGlobal, IdFIPS, IdHashMessageDigest,
  TaurusTLSLoader,
  TaurusTLSHeaders_des,
  SysUtils;

{$I TaurusTLSIndyVers.inc}

function LoadTaurusTLS: Boolean;
begin
  {$IFDEF OPENSSL_STATIC_LINK_MODEL}
  Result := true;
  {$ELSE}
  Result := GetOpenSSLLoader.Load;
  {$ENDIF}
end;

function IsNTLMFuncsAvail: Boolean;
begin
  {$IFDEF OPENSSL_STATIC_LINK_MODEL}
  Result := true;
  {$ELSE}
  Result := Assigned(DES_set_odd_parity) and
    Assigned(DES_set_key) and
    Assigned(DES_ecb_encrypt);
  {$ENDIF}
end;

type
  Pdes_key_schedule = ^des_key_schedule;

{/*
 * turns a 56 bit key into the 64 bit, odd parity key and sets the key.
 * The key schedule ks is also set.
 */}
procedure setup_des_key(const Akey_56: des_cblock; Var Vks: des_key_schedule);
Var
  Lkey: des_cblock;
begin
  Lkey[0] := Akey_56[0];

  Lkey[1] := ((Akey_56[0] SHL 7) and $FF) or (Akey_56[1] SHR 1);
  Lkey[2] := ((Akey_56[1] SHL 6) and $FF) or (Akey_56[2] SHR 2);
  Lkey[3] := ((Akey_56[2] SHL 5) and $FF) or (Akey_56[3] SHR 3);
  Lkey[4] := ((Akey_56[3] SHL 4) and $FF) or (Akey_56[4] SHR 4);
  Lkey[5] := ((Akey_56[4] SHL 3) and $FF) or (Akey_56[5] SHR 5);
  Lkey[6] := ((Akey_56[5] SHL 2) and $FF) or (Akey_56[6] SHR 6);
  Lkey[7] :=  (Akey_56[6] SHL 1) and $FF;

  DES_set_odd_parity(@Lkey);
  DES_set_key(@Lkey, Vks);
end;

{/*
 * takes a 21 byte array and treats it as 3 56-bit DES keys. The
 * 8 byte plaintext is encrypted with each key and the resulting 24
 * bytes are stored in the results array.
 */}
procedure calc_resp(Vkeys: PDES_cblock; const ANonce: TIdBytes; Vresults: Pdes_key_schedule);
Var
  Lks: DES_key_schedule;
  Lnonce: des_cblock;
begin
  setup_des_key(Vkeys^, Lks);
  Move(ANonce[0], Lnonce, 8);
  des_ecb_encrypt(@Lnonce, PDES_cblock(@Vresults^), @Lks, DES_ENCRYPT);

  setup_des_key(PDES_cblock(PtrUInt(Vkeys) + 7)^, Lks);
  des_ecb_encrypt(@Lnonce, PDES_cblock(PtrUInt(Vresults) + 8), @Lks, DES_ENCRYPT);

  setup_des_key(PDES_cblock(PtrUInt(Vkeys) + 14)^, Lks);
  des_ecb_encrypt(@Lnonce, PDES_cblock(PtrUInt(Vresults) + 16), @Lks, DES_ENCRYPT);
end;

Const
  Magic: des_cblock = ($4B, $47, $53, $21, $40, $23, $24, $25 );

//* setup LanManager password */
function SetupLanManagerPassword(const APassword: String; const ANonce: TIdBytes): TIdBytes;
var
  lm_hpw: array[0..20] of Byte;
  lm_pw: array[0..13] of Byte;
  idx, len : Integer;
  ks: des_key_schedule;
  lm_resp: array [0..23] of Byte;
  lPassword: {$IFDEF STRING_IS_UNICODE}TIdBytes{$ELSE}AnsiString{$ENDIF};
begin
  {$IFDEF STRING_IS_UNICODE}
  lPassword := IndyTextEncoding_OSDefault.GetBytes(UpperCase(APassword));
  {$ELSE}
  lPassword := UpperCase(APassword);
  {$ENDIF}

  len := Integer(IndyMin(Length(lPassword), 14));
  if len > 0 then begin
    Move(lPassword[{$IFDEF STRING_IS_UNICODE}0{$ELSE}1{$ENDIF}], lm_pw[0], len);
  end;
  if len < 14 then begin
    for idx := len to 13 do begin
      lm_pw[idx] := $0;
    end;
  end;

  //* create LanManager hashed password */

  setup_des_key(pdes_cblock(@lm_pw[0])^, ks);
  des_ecb_encrypt(@magic, PDES_cblock(@lm_hpw[0]), @ks, DES_ENCRYPT);

  setup_des_key(pdes_cblock(PtrUInt(@lm_pw[0]) + 7)^, ks);
  des_ecb_encrypt(@magic, PDES_cblock(PtrUInt(@lm_hpw[0]) + 8), @ks, DES_ENCRYPT);

  FillChar(lm_hpw[16], 5, 0);

  calc_resp(PDes_cblock(@lm_hpw[0]), ANonce, Pdes_key_schedule(@lm_resp[0]));

  SetLength(Result, SizeOf(lm_resp));
  Move(lm_resp[0], Result[0], SizeOf(lm_resp));
end;

//* create NT hashed password */
function CreateNTPassword(const APassword: String; const ANonce: TIdBytes): TIdBytes;
var
  Lnt_hpw: array [1..21] of Byte;
  Lnt_hpw128: TIdBytes;
  Lnt_resp: array [1..24] of Byte;
  LMD4: TIdHashMessageDigest4;
  {$IFNDEF STRING_IS_UNICODE}
  i: integer;
  LPwUnicode: TIdBytes;
  {$ENDIF}
begin
  CheckMD4Permitted;
  LMD4 := TIdHashMessageDigest4.Create;
  try
    {$IFDEF STRING_IS_UNICODE}
    Lnt_hpw128 := LMD4.HashString(APassword, IndyTextEncoding_UTF16LE);
    {$ELSE}
    // RLebeau: TODO - should this use UTF-16 as well?  This logic will
    // not produce a valid Unicode string if non-ASCII characters are present!
    SetLength(lPwUnicode, Length(APassword) * SizeOf(WideChar));
    for i := 0 to Length(APassword)-1 do begin
      LPwUnicode[i*2] := Byte(APassword[i+1]);
      LPwUnicode[(i*2)+1] := Byte(#0);
    end;
    Lnt_hpw128 := LMD4.HashBytes(lPwUnicode);
    {$ENDIF}
  finally
    LMD4.Free;
  end;

  Move(Lnt_hpw128[0], Lnt_hpw[1], 16);
  FillChar(Lnt_hpw[17], 5, 0);

  calc_resp(pdes_cblock(@Lnt_hpw[1]), ANonce, Pdes_key_schedule(@Lnt_resp[1]));

  SetLength(Result, SizeOf(Lnt_resp));
  Move(Lnt_resp[1], Result[0], SizeOf(Lnt_resp));
end;

initialization
{$IFDEF GETURIHOST_SUPPORTED}
  IdFIPS.LoadNTLMLibrary := @LoadTaurusTLS;
  IdFIPS.IsNTLMFuncsAvail := @IsNTLMFuncsAvail;
  IdFIPS.NTLMGetLmChallengeResponse := @SetupLanManagerPassword;
  IdFIPS.NTLMGetNtChallengeResponse := @CreateNTPassword;
{$ENDIF}
end.

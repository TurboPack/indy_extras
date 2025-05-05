/// <exclude />
  (* This unit was generated using the script genTaurusTLSHdrs.sh from the source file TaurusTLSHeaders_pkcs7.h2pas
     It should not be modified directly. All changes should be made to TaurusTLSHeaders_pkcs7.h2pas
     and this file regenerated. TaurusTLSHeaders_pkcs7.h2pas is distributed with the full Indy
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
unit TaurusTLSHeaders_pkcs7;

interface

// Headers for OpenSSL 1.1.1
// pkcs7.h


uses
  IdCTypes,
  IdGlobal,
  {$IFDEF OPENSSL_USE_SHARED_LIBRARY}
  TaurusTLSConsts,
  {$ENDIF}
  TaurusTLSHeaders_asn1,
  TaurusTLSHeaders_ossl_typ,
  TaurusTLSHeaders_stack,
  TaurusTLSHeaders_x509;

const
  PKCS7_S_HEADER = 0;
  PKCS7_S_BODY   = 1;
  PKCS7_S_TAIL   = 2;

  PKCS7_OP_SET_DETACHED_SIGNATURE = 1;
  PKCS7_OP_GET_DETACHED_SIGNATURE = 2;

  (* S/MIME related flags *)
  PKCS7_TEXT            =     $1;
  PKCS7_NOCERTS         =     $2;
  PKCS7_NOSIGS          =     $4;
  PKCS7_NOCHAIN         =     $8;
  PKCS7_NOINTERN        =    $10;
  PKCS7_NOVERIFY        =    $20;
  PKCS7_DETACHED        =    $40;
  PKCS7_BINARY          =    $80;
  PKCS7_NOATTR          =   $100;
  PKCS7_NOSMIMECAP      =   $200;
  PKCS7_NOOLDMIMETYPE   =   $400;
  PKCS7_CRLFEOL         =   $800;
  // Added '_CONST' to avoid name clashes
  PKCS7_STREAM_CONST    =  $1000;
  PKCS7_NOCRL           =  $2000;
  PKCS7_PARTIAL         =  $4000;
  PKCS7_REUSE_DIGEST    =  $8000;
  PKCS7_NO_DUAL_CONTENT = $10000;

  (* Flags: for compatibility with older code *)
  SMIME_TEXT      = PKCS7_TEXT;
  SMIME_NOCERTS   = PKCS7_NOCERTS;
  SMIME_NOSIGS    = PKCS7_NOSIGS;
  SMIME_NOCHAIN   = PKCS7_NOCHAIN;
  SMIME_NOINTERN  = PKCS7_NOINTERN;
  SMIME_NOVERIFY  = PKCS7_NOVERIFY;
  SMIME_DETACHED  = PKCS7_DETACHED;
  SMIME_BINARY    = PKCS7_BINARY;
  SMIME_NOATTR    = PKCS7_NOATTR;

  (* CRLF ASCII canonicalisation *)
  SMIME_ASCIICRLF = $80000;

type
  PPKCS7 = ^PKCS7;
  PPPKCS7 = ^PPKCS7;

  PSTACK_OF_PKCS7_SIGNER_INFO = type Pointer;
  PSTACK_OF_PKCS7_RECIP_INFO = type Pointer;

  PPKCS7_DIGEST = ^PKCS7_DIGEST;
  PPPKCS7_DIGEST = ^PPKCS7_DIGEST;

  pkcs7_issuer_and_serial_st = record
    issue: PX509_NAME;
    serial: PASN1_INTEGER;
  end;
  PKCS7_ISSUER_AND_SERIAL = pkcs7_issuer_and_serial_st;
  PPKCS7_ISSUER_AND_SERIAL = ^PKCS7_ISSUER_AND_SERIAL;
  PPPKCS7_ISSUER_AND_SERIAL = ^PPKCS7_ISSUER_AND_SERIAL;

  pkcs7_signer_info_st = record
    version: PASN1_INTEGER;
    issuer_and_serial: PPKCS7_ISSUER_AND_SERIAL;
    digest_alg: PX509_ALGOR;
    auth_attr: PSTACK_OF_X509_ATTRIBUTE;
    digest_enc_alg: PX509_ALGOR;
    enc_digest: PASN1_OCTET_STRING;
    unauth_attr: PSTACK_OF_X509_ATTRIBUTE;
    pkey: PEVP_PKEY;
  end;
  PKCS7_SIGNER_INFO = pkcs7_issuer_and_serial_st;
  PPKCS7_SIGNER_INFO = ^PKCS7_SIGNER_INFO;
  PPPKCS7_SIGNER_INFO = ^PPKCS7_SIGNER_INFO;

  pkcs7_recip_info_st = record
    version: PASN1_INTEGER;
    issuer_and_serial: PPKCS7_ISSUER_AND_SERIAL;
    key_enc_algor: PX509_ALGOR;
    enc_key: PASN1_OCTET_STRING;
    cert: PX509;
  end;
  PKCS7_RECIP_INFO = pkcs7_recip_info_st;
  PPKCS7_RECIP_INFO = ^PKCS7_RECIP_INFO;
  PPPKCS7_RECIP_INFO = ^PPKCS7_RECIP_INFO;

  pkcs7_signed_st = record
    version: PASN1_INTEGER;
    md_algs: PSTACK_OF_X509_ALGOR;
    cert: PSTACK_OF_X509;
    crl: PSTACK_OF_X509_CRL;
    signer_info: PSTACK_OF_PKCS7_SIGNER_INFO;
    contents: PPKCS7;
  end;
  PKCS7_SIGNED = pkcs7_signed_st;
  PPKCS7_SIGNED = ^PKCS7_SIGNED;
  PPPKCS7_SIGNED = ^PPKCS7_SIGNED;

  pkcs7_enc_content_st = record
    content_type: PASN1_OBJECT;
    algorithm: PX509_ALGOR;
    enc_data: PASN1_OCTET_STRING;
    cipher: PEVP_CIPHER;
  end;
  PKCS7_ENC_CONTENT = pkcs7_enc_content_st;
  PPKCS7_ENC_CONTENT = ^PKCS7_ENC_CONTENT;
  PPPKCS7_ENC_CONTENT = ^PPKCS7_ENC_CONTENT;

  pkcs7_enveloped_st = record
    version: PASN1_INTEGER;
    recipientinfo: PSTACK_OF_PKCS7_RECIP_INFO;
    enc_data: PPKCS7_ENC_CONTENT;
  end;
  PKCS7_ENVELOPE = pkcs7_enveloped_st;
  PPKCS7_ENVELOPE = ^PKCS7_ENVELOPE;
  PPPKCS7_ENVELOPE = ^PPKCS7_ENVELOPE;

  pkcs7_signedandenveloped_st = record
    version: PASN1_INTEGER;
    md_algs: PSTACK_OF_X509_ALGOR;
    cert: PSTACK_OF_X509;
    crl: PSTACK_OF_X509_CRL;
    signer_info: PSTACK_OF_PKCS7_SIGNER_INFO;
    enc_data: PPKCS7_ENC_CONTENT;
    recipientinfo: PSTACK_OF_PKCS7_RECIP_INFO;
  end;
  PKCS7_SIGN_ENVELOPE = pkcs7_signedandenveloped_st;
  PPKCS7_SIGN_ENVELOPE = ^PKCS7_SIGN_ENVELOPE;
  PPPKCS7_SIGN_ENVELOPE = ^PPKCS7_SIGN_ENVELOPE;

  pkcs7_encrypted_st = record
    version: PASN1_INTEGER;
    enc_data: PPKCS7_ENC_CONTENT;
  end;
  // Added '_STRUCT' to avoid name clashes
  PKCS7_ENCRYPT_STRUCT = pkcs7_encrypted_st;
  PPKCS7_ENCRYPT_STRUCT = ^PKCS7_ENCRYPT_STRUCT;
  PPPKCS7_ENCRYPT_STRUCT = ^PPKCS7_ENCRYPT_STRUCT;

  pkcs7_st_d = record
    case Integer of
    0: (_ptr: PIdAnsiChar);
    1: (data: PASN1_OCTET_STRING);
    2: (sign: PPKCS7_SIGNED);
    3: (enveloped: PPKCS7_ENVELOPE);
    4: (signed_and_enveloped: PPKCS7_SIGN_ENVELOPE);
    5: (digest: PPKCS7_DIGEST);
    6: (encrypted: PPKCS7_ENCRYPT_STRUCT);
    7: (other: PASN1_TYPE);
  end;
  pkcs7_st = record
    asn1: PByte;
    _length: TIdC_LONG;
    state: TIdC_INT;
    detached: TIdC_INT;
    type_: PASN1_OBJECT;
    d: pkcs7_st_d;
  end;
  PKCS7 = pkcs7_st;

  pkcs7_digest_st = record
    version: PASN1_INTEGER;
    md: PX509_ALGOR;
    contents: PPKCS7;
    digest: PASN1_OCTET_STRING;
  end;
  PKCS7_DIGEST = pkcs7_digest_st;

  //function PKCS7_ISSUER_AND_SERIAL_new: PPKCS7_ISSUER_AND_SERIAL;
  //procedure PKCS7_ISSUER_AND_SERIAL_free(a: PPKCS7_ISSUER_AND_SERIAL);
  //function d2i_PKCS7_ISSUER_AND_SERIAL(a: PPPKCS7_ISSUER_AND_SERIAL; const in_: PByte; len: TIdC_LONG): PPKCS7_ISSUER_AND_SERIAL;
  //function i2d_PKCS7_ISSUER_AND_SERIAL(const a: PPKCS7_ISSUER_AND_SERIAL; out_: PByte): TIdC_INT;
  //function PKCS7_ISSUER_AND_SERIAL_it: PASN1_ITEM;

    { The EXTERNALSYM directive is ignored by FPC, however, it is used by Delphi as follows:
		
  	  The EXTERNALSYM directive prevents the specified Delphi symbol from appearing in header 
	  files generated for C++. }
	  
  {$EXTERNALSYM PKCS7_ISSUER_AND_SERIAL_digest}
  {$EXTERNALSYM PKCS7_dup}
  {$EXTERNALSYM d2i_PKCS7_bio}
  {$EXTERNALSYM i2d_PKCS7_bio}
  {$EXTERNALSYM i2d_PKCS7_bio_stream}
  {$EXTERNALSYM PEM_write_bio_PKCS7_stream}
  {$EXTERNALSYM PKCS7_ctrl}
  {$EXTERNALSYM PKCS7_set_type}
  {$EXTERNALSYM PKCS7_set0_type_other}
  {$EXTERNALSYM PKCS7_set_content}
  {$EXTERNALSYM PKCS7_SIGNER_INFO_set}
  {$EXTERNALSYM PKCS7_SIGNER_INFO_sign}
  {$EXTERNALSYM PKCS7_add_signer}
  {$EXTERNALSYM PKCS7_add_certificate}
  {$EXTERNALSYM PKCS7_add_crl}
  {$EXTERNALSYM PKCS7_content_new}
  {$EXTERNALSYM PKCS7_dataVerify}
  {$EXTERNALSYM PKCS7_signatureVerify}
  {$EXTERNALSYM PKCS7_dataInit}
  {$EXTERNALSYM PKCS7_dataFinal}
  {$EXTERNALSYM PKCS7_dataDecode}
  {$EXTERNALSYM PKCS7_add_signature}
  {$EXTERNALSYM PKCS7_cert_from_signer_info}
  {$EXTERNALSYM PKCS7_set_digest}
  {$EXTERNALSYM PKCS7_get_signer_info}
  {$EXTERNALSYM PKCS7_add_recipient}
  {$EXTERNALSYM PKCS7_SIGNER_INFO_get0_algs}
  {$EXTERNALSYM PKCS7_RECIP_INFO_get0_alg}
  {$EXTERNALSYM PKCS7_add_recipient_info}
  {$EXTERNALSYM PKCS7_RECIP_INFO_set}
  {$EXTERNALSYM PKCS7_set_cipher}
  {$EXTERNALSYM PKCS7_stream}
  {$EXTERNALSYM PKCS7_get_issuer_and_serial}
  {$EXTERNALSYM PKCS7_digest_from_attributes}
  {$EXTERNALSYM PKCS7_add_signed_attribute}
  {$EXTERNALSYM PKCS7_add_attribute}
  {$EXTERNALSYM PKCS7_get_attribute}
  {$EXTERNALSYM PKCS7_get_signed_attribute}
  {$EXTERNALSYM PKCS7_sign_add_signer}
  {$EXTERNALSYM PKCS7_final}
  {$EXTERNALSYM PKCS7_decrypt}
  {$EXTERNALSYM PKCS7_add_attrib_content_type}
  {$EXTERNALSYM PKCS7_add0_attrib_signing_time}
  {$EXTERNALSYM PKCS7_add1_attrib_digest}
  {$EXTERNALSYM SMIME_write_PKCS7}
  {$EXTERNALSYM SMIME_read_PKCS7}
  {$EXTERNALSYM BIO_new_PKCS7}

{$IFNDEF OPENSSL_STATIC_LINK_MODEL}
var
  PKCS7_ISSUER_AND_SERIAL_digest: function (data: PPKCS7_ISSUER_AND_SERIAL; const type_: PEVP_MD; md: PByte; len: PIdC_UINT): TIdC_INT; cdecl = nil;

  PKCS7_dup: function (p7: PPKCS7): PPKCS7; cdecl = nil;
  d2i_PKCS7_bio: function (bp: PBIO; p7: PPPKCS7): PPKCS7; cdecl = nil;
  i2d_PKCS7_bio: function (bp: PBIO; p7: PPKCS7): TIdC_INT; cdecl = nil;
  i2d_PKCS7_bio_stream: function (out_: PBIO; p7: PPKCS7; in_: PBIO; flags: TIdC_INT): TIdC_INT; cdecl = nil;
  PEM_write_bio_PKCS7_stream: function (out_: PBIO; p7: PPKCS7; in_: PBIO; flags: TIdC_INT): TIdC_INT; cdecl = nil;

  PKCS7_SIGNER_INFO_new : function : PPKCS7_SIGNER_INFO; cdecl = nil;
  PKCS7_SIGNER_INFO_free : procedure(a: PPKCS7_SIGNER_INFO); cdecl = nil;
  d2i_PKCS7_SIGNER_INFO : function(a: PPPKCS7_SIGNER_INFO; const in_: PByte; len: TIdC_LONG): PPKCS7_SIGNER_INFO; cdecl = nil;
  i2d_PKCS7_SIGNER_INFO : function(const a: PPKCS7_SIGNER_INFO; out_: PByte): TIdC_INT; cdecl = nil;
  PKCS7_SIGNER_INFO_it : function : PASN1_ITEM; cdecl = nil;

  PKCS7_RECIP_INFO_new : function : PPKCS7_RECIP_INFO; cdecl = nil;
  PKCS7_RECIP_INFO_free : procedure(a: PPKCS7_RECIP_INFO); cdecl = nil;
  d2i_PKCS7_RECIP_INFO : function(a: PPPKCS7_RECIP_INFO; const in_: PByte; len: TIdC_LONG): PPKCS7_RECIP_INFO; cdecl = nil;
  i2d_PKCS7_RECIP_INFO : function(const a: PPKCS7_RECIP_INFO; out_: PByte): TIdC_INT; cdecl = nil;
  PKCS7_RECIP_INFO_it : function : PASN1_ITEM; cdecl = nil;

  PKCS7_SIGNED_new : function: PPKCS7_SIGNED; cdecl = nil;
  PKCS7_SIGNED_free : procedure(a: PPKCS7_SIGNED); cdecl = nil;
  d2i_PKCS7_SIGNED : function(a: PPPKCS7_SIGNED; const in_: PByte; len: TIdC_LONG): PPKCS7_SIGNED; cdecl = nil;
  i2d_PKCS7_SIGNED : function(const a: PPKCS7_SIGNED; out_: PByte): TIdC_INT; cdecl = nil;
  PKCS7_SIGNED_it : function: PASN1_ITEM; cdecl = nil;

  PKCS7_ENC_CONTENT_new : function : PPKCS7_ENC_CONTENT; cdecl = nil;
  PKCS7_ENC_CONTENT_free : procedure (a: PPKCS7_ENC_CONTENT); cdecl = nil;
  d2i_PKCS7_ENC_CONTENT : function(a: PPPKCS7_ENC_CONTENT; const in_: PByte; len: TIdC_LONG): PPKCS7_ENC_CONTENT; cdecl = nil;
  i2d_PKCS7_ENC_CONTENT : function(const a: PPKCS7_ENC_CONTENT; out_: PByte): TIdC_INT; cdecl = nil;
  PKCS7_ENC_CONTENT_it : function : PASN1_ITEM; cdecl = nil;

  PKCS7_ENVELOPE_new : function : PPKCS7_ENVELOPE; cdecl = nil;
  PKCS7_ENVELOPE_free : procedure(a: PPKCS7_ENVELOPE); cdecl = nil;
  d2i_PKCS7_ENVELOPE : function(a: PPPKCS7_ENVELOPE; const in_: PByte; len: TIdC_LONG): PPKCS7_ENVELOPE; cdecl = nil;
  i2d_PKCS7_ENVELOPE : function(const a: PPKCS7_ENVELOPE; out_: PByte): TIdC_INT; cdecl = nil;
  PKCS7_ENVELOPE_it : function : PASN1_ITEM;

  PKCS7_SIGN_ENVELOPE_new : function : PPKCS7_SIGN_ENVELOPE; cdecl = nil;
  PKCS7_SIGN_ENVELOPE_free : procedure (a: PPKCS7_SIGN_ENVELOPE); cdecl = nil;
  d2i_PKCS7_SIGN_ENVELOPE : function(a: PPPKCS7_SIGN_ENVELOPE; const in_: PByte; len: TIdC_LONG): PPKCS7_SIGN_ENVELOPE; cdecl = nil;
  i2d_PKCS7_SIGN_ENVELOPE : function(const a: PPKCS7_SIGN_ENVELOPE; out_: PByte): TIdC_INT; cdecl = nil;
  PKCS7_SIGN_ENVELOPE_it : function : PASN1_ITEM; cdecl = nil;

  PKCS7_DIGEST_new : function: PPKCS7_DIGEST; cdecl = nil;
  PKCS7_DIGEST_free : procedure(a: PPKCS7_DIGEST); cdecl = nil;
  d2i_PKCS7_DIGEST : function(a: PPPKCS7_DIGEST; const in_: PByte; len: TIdC_LONG): PPKCS7_DIGEST; cdecl = nil;
  i2d_PKCS7_DIGEST : function(const a: PPKCS7_DIGEST; out_: PByte): TIdC_INT; cdecl = nil;
  PKCS7_DIGEST_it : function : PASN1_ITEM; cdecl = nil;

  PKCS7_ENCRYPT_new : function : PPKCS7_ENCRYPT_STRUCT; cdecl = nil;
  PKCS7_ENCRYPT_free : procedure(a: PPKCS7_ENCRYPT_STRUCT); cdecl = nil;
  d2i_PKCS7_ENCRYPT : function(a: PPPKCS7_ENCRYPT_STRUCT; const in_: PByte; len: TIdC_LONG): PPKCS7_ENCRYPT_STRUCT; cdecl = nil;
  i2d_PKCS7_ENCRYPT : function(const a: PPKCS7_ENCRYPT_STRUCT; out_: PByte): TIdC_INT; cdecl = nil;
  PKCS7_ENCRYPT_it : function: PASN1_ITEM; cdecl = nil;

  PKCS7_new : function : PPKCS7; cdecl = nil;
  PKCS7_free : procedure(a: PPKCS7); cdecl = nil;
  d2i_PKCS7 : function(a: PPPKCS7; const in_: PByte; len: TIdC_LONG): PPKCS7; cdecl = nil;
  i2d_PKCS7 : function(const a: PPKCS7; out_: PByte): TIdC_INT; cdecl = nil;
  PKCS7_it : function: PASN1_ITEM; cdecl = nil;

  PKCS7_ATTR_SIGN_it : function : PASN1_ITEM; cdecl = nil;

  PKCS7_ATTR_VERIFY_it : function : PASN1_ITEM; cdecl = nil;

  i2d_PKCS7_NDEF : function(const a: PPKCS7; out_: PPByte): TIdC_INT; cdecl = nil;
  PKCS7_print_ctx : function(out_: PBIO; const x: PPKCS7; indent: TIdC_INT; const pctx: PASN1_PCTX): TIdC_INT; cdecl = nil;

  PKCS7_ctrl: function (p7: PPKCS7; cmd: TIdC_INT; larg: TIdC_LONG; parg: PIdAnsiChar): TIdC_LONG; cdecl = nil;

  PKCS7_set_type: function (p7: PPKCS7; type_: TIdC_INT): TIdC_INT; cdecl = nil;
  PKCS7_set0_type_other: function (p7: PPKCS7; type_: TIdC_INT; other: PASN1_TYPE): TIdC_INT; cdecl = nil;
  PKCS7_set_content: function (p7: PPKCS7; p7_data: PPKCS7): TIdC_INT; cdecl = nil;
  PKCS7_SIGNER_INFO_set: function (p7i: PPKCS7_SIGNER_INFO; x509: PX509; pkey: PEVP_PKEY; const dgst: PEVP_MD): TIdC_INT; cdecl = nil;
  PKCS7_SIGNER_INFO_sign: function (si: PPKCS7_SIGNER_INFO): TIdC_INT; cdecl = nil;
  PKCS7_add_signer: function (p7: PPKCS7; p7i: PPKCS7_SIGNER_INFO): TIdC_INT; cdecl = nil;
  PKCS7_add_certificate: function (p7: PPKCS7; x509: PX509): TIdC_INT; cdecl = nil;
  PKCS7_add_crl: function (p7: PPKCS7; x509: PX509_CRL): TIdC_INT; cdecl = nil;
  PKCS7_content_new: function (p7: PPKCS7; nid: TIdC_INT): TIdC_INT; cdecl = nil;
  PKCS7_dataVerify: function (cert_store: PX509_STORE; ctx: PX509_STORE_CTX; bio: PBIO; p7: PPKCS7; si: PPKCS7_SIGNER_INFO): TIdC_INT; cdecl = nil;
  PKCS7_signatureVerify: function (bio: PBIO; p7: PPKCS7; si: PPKCS7_SIGNER_INFO; x509: PX509): TIdC_INT; cdecl = nil;

  PKCS7_dataInit: function (p7: PPKCS7; bio: PBIO): PBIO; cdecl = nil;
  PKCS7_dataFinal: function (p7: PPKCS7; bio: PBIO): TIdC_INT; cdecl = nil;
  PKCS7_dataDecode: function (p7: PPKCS7; pkey: PEVP_PKEY; in_bio: PBIO; pcert: PX509): PBIO; cdecl = nil;

  PKCS7_add_signature: function (p7: PPKCS7; x509: PX509; pkey: PEVP_PKEY; const dgst: PEVP_MD): PPKCS7_SIGNER_INFO; cdecl = nil;
  PKCS7_cert_from_signer_info: function (p7: PPKCS7; si: PPKCS7_SIGNER_INFO): PX509; cdecl = nil;
  PKCS7_set_digest: function (p7: PPKCS7; const md: PEVP_MD): TIdC_INT; cdecl = nil;
  PKCS7_get_signer_info : function (p7: PPKCS7): PSTACK_OF_PKCS7_SIGNER_INFO;

  PKCS7_add_recipient: function (p7: PPKCS7; x509: PX509): PPKCS7_RECIP_INFO; cdecl = nil;
  PKCS7_SIGNER_INFO_get0_algs: procedure (si: PPKCS7_SIGNER_INFO; pk: PPEVP_PKEY; pdig: PPX509_ALGOR; psig: PPX509_ALGOR); cdecl = nil;
  PKCS7_RECIP_INFO_get0_alg: procedure (ri: PPKCS7_RECIP_INFO; penc: PPX509_ALGOR); cdecl = nil;
  PKCS7_add_recipient_info: function (p7: PPKCS7; ri: PPKCS7_RECIP_INFO): TIdC_INT; cdecl = nil;
  PKCS7_RECIP_INFO_set: function (p7i: PPKCS7_RECIP_INFO; x509: PX509): TIdC_INT; cdecl = nil;
  PKCS7_set_cipher: function (p7: PPKCS7; const cipher: PEVP_CIPHER): TIdC_INT; cdecl = nil;
  PKCS7_stream: function (boundary: PPPByte; p7: PPKCS7): TIdC_INT; cdecl = nil;

  PKCS7_get_issuer_and_serial: function (p7: PPKCS7; idx: TIdC_INT): PPKCS7_ISSUER_AND_SERIAL; cdecl = nil;
  PKCS7_digest_from_attributes : function(sk: PSTACK_OF_X509_ATTRIBUTE): PASN1_OCTET_STRING; cdecl = nil;
  PKCS7_add_signed_attribute: function (p7si: PPKCS7_SIGNER_INFO; nid: TIdC_INT; type_: TIdC_INT; data: Pointer): TIdC_INT; cdecl = nil;
  PKCS7_add_attribute: function (p7si: PPKCS7_SIGNER_INFO; nid: TIdC_INT; atrtype: TIdC_INT; value: Pointer): TIdC_INT; cdecl = nil;
  PKCS7_get_attribute: function (si: PPKCS7_SIGNER_INFO; nid: TIdC_INT): PASN1_TYPE; cdecl = nil;
  PKCS7_get_signed_attribute: function (si: PPKCS7_SIGNER_INFO; nid: TIdC_INT): PASN1_TYPE; cdecl = nil;
  PKCS7_set_signed_attributes : function(p7si: PPKCS7_SIGNER_INFO; sk: PSTACK_OF_X509): TIdC_INT;  cdecl = nil;
  PKCS7_set_attributes : function(p7si: PPKCS7_SIGNER_INFO; sk: PSTACK_OF_X509_ATTRIBUTE): TIdC_INT;  cdecl = nil;

  PKCS7_sign : function(signcert: PX509; pkey: PEVP_PKEY; certs: PSTACK_OF_X509; data: PBIO; flags: TIdC_INT): PPKCS7;  cdecl = nil;

  PKCS7_sign_add_signer: function (p7: PPKCS7; signcert: PX509; pkey: PEVP_PKEY; const md: PEVP_MD; flags: TIdC_INT): PPKCS7_SIGNER_INFO; cdecl = nil;

  PKCS7_final: function (p7: PPKCS7; data: PBIO; flags: TIdC_INT): TIdC_INT; cdecl = nil;
  PKCS7_verify : function (p7: PPKCS7; certs: PSTACK_OF_X509; store: PX509_STORE; indata: PBIO; out_: PBIO; flags: TIdC_INT): TIdC_INT; cdecl = nil;
  PKCS7_get0_signers : function(p7: PPKCS7; certs: PSTACK_OF_X509; flags: TIdC_INT): PSTACK_OF_X509; cdecl = nil;
  PKCS7_encrypt : function(certs: PSTACK_OF_X509; in_: PBIO; const cipher: PEVP_CIPHER; flags: TIdC_INT): PPKCS7; cdecl = nil;
  PKCS7_decrypt: function (p7: PPKCS7; pkey: PEVP_PKEY; cert: PX509; data: PBIO; flags: TIdC_INT): TIdC_INT; cdecl = nil;

  PKCS7_add_attrib_smimecap : function(si: PPKCS7_SIGNER_INFO; cap: PSTACK_OF_X509_ALGOR): TIdC_INT;   cdecl = nil;
  PKCS7_get_smimecap : function(si: PPKCS7_SIGNER_INFO): PSTACK_OF_X509_ALGOR;  cdecl = nil;
  PKCS7_simple_smimecap : function(sk: PSTACK_OF_X509_ALGOR; nid: TIdC_INT; arg: TIdC_INT): TIdC_INT;   cdecl = nil;

  PKCS7_add_attrib_content_type: function (si: PPKCS7_SIGNER_INFO; coid: PASN1_OBJECT): TIdC_INT; cdecl = nil;
  PKCS7_add0_attrib_signing_time: function (si: PPKCS7_SIGNER_INFO; t: PASN1_TIME): TIdC_INT; cdecl = nil;
  PKCS7_add1_attrib_digest: function (si: PPKCS7_SIGNER_INFO; const md: PByte; mdlen: TIdC_INT): TIdC_INT; cdecl = nil;

  SMIME_write_PKCS7: function (bio: PBIO; p7: PPKCS7; data: PBIO; flags: TIdC_INT): TIdC_INT; cdecl = nil;
  SMIME_read_PKCS7: function (bio: PBIO; bcont: PPBIO): PPKCS7; cdecl = nil;

  BIO_new_PKCS7: function (out_: PBIO; p7: PPKCS7): PBIO; cdecl = nil;

{$ELSE}
  function PKCS7_ISSUER_AND_SERIAL_digest(data: PPKCS7_ISSUER_AND_SERIAL; const type_: PEVP_MD; md: PByte; len: PIdC_UINT): TIdC_INT cdecl; external CLibCrypto;

  function PKCS7_dup(p7: PPKCS7): PPKCS7 cdecl; external CLibCrypto;
  function d2i_PKCS7_bio(bp: PBIO; p7: PPPKCS7): PPKCS7 cdecl; external CLibCrypto;
  function i2d_PKCS7_bio(bp: PBIO; p7: PPKCS7): TIdC_INT cdecl; external CLibCrypto;
  function i2d_PKCS7_bio_stream(out_: PBIO; p7: PPKCS7; in_: PBIO; flags: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function PEM_write_bio_PKCS7_stream(out_: PBIO; p7: PPKCS7; in_: PBIO; flags: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;

  function PKCS7_SIGNER_INFO_new: PPKCS7_SIGNER_INFO cdecl; external CLibCrypto;
  procedure PKCS7_SIGNER_INFO_free(a: PPKCS7_SIGNER_INFO) cdecl; external CLibCrypto;
  function d2i_PKCS7_SIGNER_INFO(a: PPPKCS7_SIGNER_INFO; const in_: PByte; len: TIdC_LONG): PPKCS7_SIGNER_INFO cdecl; external CLibCrypto;
  function i2d_PKCS7_SIGNER_INFO(const a: PPKCS7_SIGNER_INFO; out_: PByte): TIdC_INT cdecl; external CLibCrypto;
  function PKCS7_SIGNER_INFO_it: PASN1_ITEM cdecl; external CLibCrypto;

  function PKCS7_RECIP_INFO_new: PPKCS7_RECIP_INFO cdecl; external CLibCrypto;
  procedure PKCS7_RECIP_INFO_free(a: PPKCS7_RECIP_INFO) cdecl; external CLibCrypto;
  function d2i_PKCS7_RECIP_INFO(a: PPPKCS7_RECIP_INFO; const in_: PByte; len: TIdC_LONG): PPKCS7_RECIP_INFO cdecl; external CLibCrypto;
  function i2d_PKCS7_RECIP_INFO(const a: PPKCS7_RECIP_INFO; out_: PByte): TIdC_INT cdecl; external CLibCrypto;
  function PKCS7_RECIP_INFO_it: PASN1_ITEM cdecl; external CLibCrypto;

  function PKCS7_SIGNED_new: PPKCS7_SIGNED; cdecl; external CLibCrypto;
  procedure PKCS7_SIGNED_free(a: PPKCS7_SIGNED); cdecl; external CLibCrypto;
  function d2i_PKCS7_SIGNED(a: PPPKCS7_SIGNED; const in_: PByte; len: TIdC_LONG): PPKCS7_SIGNED; cdecl; external CLibCrypto;
  function i2d_PKCS7_SIGNED(const a: PPKCS7_SIGNED; out_: PByte): TIdC_INT; cdecl; external CLibCrypto;
  function PKCS7_SIGNED_it: PASN1_ITEM; cdecl; external CLibCrypto;

  function PKCS7_ENC_CONTENT_new: PPKCS7_ENC_CONTENT; cdecl; external CLibCrypto;
  procedure PKCS7_ENC_CONTENT_free(a: PPKCS7_ENC_CONTENT); cdecl; external CLibCrypto;
  function d2i_PKCS7_ENC_CONTENT(a: PPPKCS7_ENC_CONTENT; const in_: PByte; len: TIdC_LONG): PPKCS7_ENC_CONTENT; cdecl; external CLibCrypto;
  function i2d_PKCS7_ENC_CONTENT(const a: PPKCS7_ENC_CONTENT; out_: PByte): TIdC_INT; cdecl; external CLibCrypto;
  function PKCS7_ENC_CONTENT_it: PASN1_ITEM; cdecl; external CLibCrypto;

  function PKCS7_ENVELOPE_new: PPKCS7_ENVELOPE; cdecl; external CLibCrypto;
  procedure PKCS7_ENVELOPE_free(a: PPKCS7_ENVELOPE); cdecl; external CLibCrypto;
  function d2i_PKCS7_ENVELOPE(a: PPPKCS7_ENVELOPE; const in_: PByte; len: TIdC_LONG): PPKCS7_ENVELOPE; cdecl; external CLibCrypto;
  function i2d_PKCS7_ENVELOPE(const a: PPKCS7_ENVELOPE; out_: PByte): TIdC_INT; cdecl; external CLibCrypto;
  function PKCS7_ENVELOPE_it: PASN1_ITEM; cdecl; external CLibCrypto;

  function PKCS7_SIGN_ENVELOPE_new: PPKCS7_SIGN_ENVELOPE; cdecl; external CLibCrypto;
  procedure PKCS7_SIGN_ENVELOPE_free(a: PPKCS7_SIGN_ENVELOPE); cdecl; external CLibCrypto;
  function d2i_PKCS7_SIGN_ENVELOPE(a: PPPKCS7_SIGN_ENVELOPE; const in_: PByte; len: TIdC_LONG): PPKCS7_SIGN_ENVELOPE; cdecl; external CLibCrypto;
  function i2d_PKCS7_SIGN_ENVELOPE(const a: PPKCS7_SIGN_ENVELOPE; out_: PByte): TIdC_INT; cdecl; external CLibCrypto;
  function PKCS7_SIGN_ENVELOPE_it: PASN1_ITEM; cdecl; external CLibCrypto;

  function PKCS7_DIGEST_new: PPKCS7_DIGEST; cdecl; external CLibCrypto;
  procedure PKCS7_DIGEST_free(a: PPKCS7_DIGEST); cdecl; external CLibCrypto;
  function d2i_PKCS7_DIGEST(a: PPPKCS7_DIGEST; const in_: PByte; len: TIdC_LONG): PPKCS7_DIGEST; cdecl; external CLibCrypto;
  function i2d_PKCS7_DIGEST(const a: PPKCS7_DIGEST; out_: PByte): TIdC_INT; cdecl; external CLibCrypto;
  function PKCS7_DIGEST_it: PASN1_ITEM; cdecl; external CLibCrypto;

  function PKCS7_ENCRYPT_new: PPKCS7_ENCRYPT_STRUCT; cdecl; external CLibCrypto;
  procedure PKCS7_ENCRYPT_free(a: PPKCS7_ENCRYPT_STRUCT); cdecl; external CLibCrypto;
  function d2i_PKCS7_ENCRYPT(a: PPPKCS7_ENCRYPT_STRUCT; const in_: PByte; len: TIdC_LONG): PPKCS7_ENCRYPT_STRUCT; cdecl; external CLibCrypto;
  function i2d_PKCS7_ENCRYPT(const a: PPKCS7_ENCRYPT_STRUCT; out_: PByte): TIdC_INT; cdecl; external CLibCrypto;
  function PKCS7_ENCRYPT_it: PASN1_ITEM; cdecl; external CLibCrypto;

  function PKCS7_new: PPKCS7; cdecl; external CLibCrypto;
  procedure PKCS7_free(a: PPKCS7); cdecl; external CLibCrypto;
  function d2i_PKCS7(a: PPPKCS7; const in_: PByte; len: TIdC_LONG): PPKCS7; cdecl; external CLibCrypto;
  function i2d_PKCS7(const a: PPKCS7; out_: PByte): TIdC_INT; cdecl; external CLibCrypto;
  function PKCS7_it: PASN1_ITEM; cdecl; external CLibCrypto;

  function PKCS7_ATTR_SIGN_it: PASN1_ITEM; cdecl; external CLibCrypto;

  function PKCS7_ATTR_VERIFY_it: PASN1_ITEM; cdecl; external CLibCrypto;

  function i2d_PKCS7_NDEF(const a: PPKCS7; out_: PPByte): TIdC_INT; cdecl; external CLibCrypto;
  function PKCS7_print_ctx(out_: PBIO; const x: PPKCS7; indent: TIdC_INT; const pctx: PASN1_PCTX): TIdC_INT; cdecl; external CLibCrypto;

  function PKCS7_ctrl(p7: PPKCS7; cmd: TIdC_INT; larg: TIdC_LONG; parg: PIdAnsiChar): TIdC_LONG cdecl; external CLibCrypto;

  function PKCS7_set_type(p7: PPKCS7; type_: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function PKCS7_set0_type_other(p7: PPKCS7; type_: TIdC_INT; other: PASN1_TYPE): TIdC_INT cdecl; external CLibCrypto;
  function PKCS7_set_content(p7: PPKCS7; p7_data: PPKCS7): TIdC_INT cdecl; external CLibCrypto;
  function PKCS7_SIGNER_INFO_set(p7i: PPKCS7_SIGNER_INFO; x509: PX509; pkey: PEVP_PKEY; const dgst: PEVP_MD): TIdC_INT cdecl; external CLibCrypto;
  function PKCS7_SIGNER_INFO_sign(si: PPKCS7_SIGNER_INFO): TIdC_INT cdecl; external CLibCrypto;
  function PKCS7_add_signer(p7: PPKCS7; p7i: PPKCS7_SIGNER_INFO): TIdC_INT cdecl; external CLibCrypto;
  function PKCS7_add_certificate(p7: PPKCS7; x509: PX509): TIdC_INT cdecl; external CLibCrypto;
  function PKCS7_add_crl(p7: PPKCS7; x509: PX509_CRL): TIdC_INT cdecl; external CLibCrypto;
  function PKCS7_content_new(p7: PPKCS7; nid: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function PKCS7_dataVerify(cert_store: PX509_STORE; ctx: PX509_STORE_CTX; bio: PBIO; p7: PPKCS7; si: PPKCS7_SIGNER_INFO): TIdC_INT cdecl; external CLibCrypto;
  function PKCS7_signatureVerify(bio: PBIO; p7: PPKCS7; si: PPKCS7_SIGNER_INFO; x509: PX509): TIdC_INT cdecl; external CLibCrypto;

  function PKCS7_dataInit(p7: PPKCS7; bio: PBIO): PBIO cdecl; external CLibCrypto;
  function PKCS7_dataFinal(p7: PPKCS7; bio: PBIO): TIdC_INT cdecl; external CLibCrypto;
  function PKCS7_dataDecode(p7: PPKCS7; pkey: PEVP_PKEY; in_bio: PBIO; pcert: PX509): PBIO cdecl; external CLibCrypto;

  function PKCS7_add_signature(p7: PPKCS7; x509: PX509; pkey: PEVP_PKEY; const dgst: PEVP_MD): PPKCS7_SIGNER_INFO cdecl; external CLibCrypto;
  function PKCS7_cert_from_signer_info(p7: PPKCS7; si: PPKCS7_SIGNER_INFO): PX509 cdecl; external CLibCrypto;
  function PKCS7_set_digest(p7: PPKCS7; const md: PEVP_MD): TIdC_INT cdecl; external CLibCrypto;
  function PKCS7_get_signer_info(p7: PPKCS7): PSTACK_OF_PKCS7_SIGNER_INFO cdecl; external CLibCrypto;

  function PKCS7_add_recipient(p7: PPKCS7; x509: PX509): PPKCS7_RECIP_INFO cdecl; external CLibCrypto;
  procedure PKCS7_SIGNER_INFO_get0_algs(si: PPKCS7_SIGNER_INFO; pk: PPEVP_PKEY; pdig: PPX509_ALGOR; psig: PPX509_ALGOR) cdecl; external CLibCrypto;
  procedure PKCS7_RECIP_INFO_get0_alg(ri: PPKCS7_RECIP_INFO; penc: PPX509_ALGOR) cdecl; external CLibCrypto;
  function PKCS7_add_recipient_info(p7: PPKCS7; ri: PPKCS7_RECIP_INFO): TIdC_INT cdecl; external CLibCrypto;
  function PKCS7_RECIP_INFO_set(p7i: PPKCS7_RECIP_INFO; x509: PX509): TIdC_INT cdecl; external CLibCrypto;
  function PKCS7_set_cipher(p7: PPKCS7; const cipher: PEVP_CIPHER): TIdC_INT cdecl; external CLibCrypto;
  function PKCS7_stream(boundary: PPPByte; p7: PPKCS7): TIdC_INT cdecl; external CLibCrypto;

  function PKCS7_get_issuer_and_serial(p7: PPKCS7; idx: TIdC_INT): PPKCS7_ISSUER_AND_SERIAL cdecl; external CLibCrypto;
  function PKCS7_digest_from_attributes(sk: PSTACK_OF_X509_ATTRIBUTE): PASN1_OCTET_STRING; cdecl; external CLibCrypto;
  function PKCS7_add_signed_attribute(p7si: PPKCS7_SIGNER_INFO; nid: TIdC_INT; type_: TIdC_INT; data: Pointer): TIdC_INT cdecl; external CLibCrypto;
  function PKCS7_add_attribute(p7si: PPKCS7_SIGNER_INFO; nid: TIdC_INT; atrtype: TIdC_INT; value: Pointer): TIdC_INT cdecl; external CLibCrypto;
  function PKCS7_get_attribute(si: PPKCS7_SIGNER_INFO; nid: TIdC_INT): PASN1_TYPE cdecl; external CLibCrypto;
  function PKCS7_get_signed_attribute(si: PPKCS7_SIGNER_INFO; nid: TIdC_INT): PASN1_TYPE cdecl; external CLibCrypto;
  function PKCS7_set_signed_attributes(p7si: PPKCS7_SIGNER_INFO; sk: PSTACK_OF_X509): TIdC_INT cdecl; external CLibCrypto;
  function PKCS7_set_attributes(p7si: PPKCS7_SIGNER_INFO; sk: PSTACK_OF_X509_ATTRIBUTE): TIdC_INT cdecl; external CLibCrypto;

  function PKCS7_sign(signcert: PX509; pkey: PEVP_PKEY; certs: PSTACK_OF_X509; data: PBIO; flags: TIdC_INT): PPKCS7 cdecl; external CLibCrypto;

  function PKCS7_sign_add_signer(p7: PPKCS7; signcert: PX509; pkey: PEVP_PKEY; const md: PEVP_MD; flags: TIdC_INT): PPKCS7_SIGNER_INFO cdecl; external CLibCrypto;

  function PKCS7_final(p7: PPKCS7; data: PBIO; flags: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function PKCS7_verify(p7: PPKCS7; certs: PSTACK_OF_X509; store: PX509_STORE; indata: PBIO; out_: PBIO; flags: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function PKCS7_get0_signers(p7: PPKCS7; certs: PSTACK_OF_X509; flags: TIdC_INT): PSTACK_OF_X509 cdecl; external CLibCrypto;
  function PKCS7_encrypt(certs: PSTACK_OF_X509; in_: PBIO; const cipher: PEVP_CIPHER; flags: TIdC_INT): PPKCS7 cdecl; external CLibCrypto;
  function PKCS7_decrypt(p7: PPKCS7; pkey: PEVP_PKEY; cert: PX509; data: PBIO; flags: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;

  function PKCS7_add_attrib_smimecap(si: PPKCS7_SIGNER_INFO; cap: PSTACK_OF_X509_ALGOR): TIdC_INT cdecl; external CLibCrypto;
  function PKCS7_get_smimecap(si: PPKCS7_SIGNER_INFO): PSTACK_OF_X509_ALGOR cdecl; external CLibCrypto;
  function PKCS7_simple_smimecap(sk: PSTACK_OF_X509_ALGOR; nid: TIdC_INT; arg: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;

  function PKCS7_add_attrib_content_type(si: PPKCS7_SIGNER_INFO; coid: PASN1_OBJECT): TIdC_INT cdecl; external CLibCrypto;
  function PKCS7_add0_attrib_signing_time(si: PPKCS7_SIGNER_INFO; t: PASN1_TIME): TIdC_INT cdecl; external CLibCrypto;
  function PKCS7_add1_attrib_digest(si: PPKCS7_SIGNER_INFO; const md: PByte; mdlen: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;

  function SMIME_write_PKCS7(bio: PBIO; p7: PPKCS7; data: PBIO; flags: TIdC_INT): TIdC_INT cdecl; external CLibCrypto;
  function SMIME_read_PKCS7(bio: PBIO; bcont: PPBIO): PPKCS7 cdecl; external CLibCrypto;

  function BIO_new_PKCS7(out_: PBIO; p7: PPKCS7): PBIO cdecl; external CLibCrypto;

{$ENDIF}
 {$IFNDEF OPENSSL_STATIC_LINK_MODEL}
type
  Tsk_PKCS7_RECIP_INFO_new = function(cmp : TOPENSSL_sk_compfunc) : PSTACK_OF_PKCS7_RECIP_INFO cdecl;
  Tsk_PKCS7_RECIP_INFO_new_null = function : PSTACK_OF_PKCS7_RECIP_INFO cdecl;
  Tsk_PKCS7_RECIP_INFO_free = procedure(st : PSTACK_OF_PKCS7_RECIP_INFO) cdecl;
  Tsk_PKCS7_RECIP_INFO_num = function (const sk : PSTACK_OF_PKCS7_RECIP_INFO) : TIdC_INT cdecl;
  Tsk_PKCS7_RECIP_INFO_value = function (const sk : PSTACK_OF_PKCS7_RECIP_INFO; i : TIdC_INT) : PX509_CRL cdecl;
  Tsk_PKCS7_RECIP_INFO_push = function (sk : PSTACK_OF_PKCS7_RECIP_INFO; st : PPKCS7_RECIP_INFO) : TIdC_INT cdecl;
  Tsk_PKCS7_RECIP_INFO_dup = function (sk : PSTACK_OF_PKCS7_RECIP_INFO) : PSTACK_OF_PKCS7_RECIP_INFO cdecl;
  Tsk_PKCS7_RECIP_INFO_find = function (sk : PSTACK_OF_PKCS7_RECIP_INFO; _val : PPKCS7_RECIP_INFO) : TIdC_INT cdecl;
  Tsk_PKCS7_RECIP_INFO_pop_free = procedure (sk : PSTACK_OF_PKCS7_RECIP_INFO; func: TOPENSSL_sk_freefunc) cdecl;
  Tsk_PKCS7_SIGNER_INFO_new = function(cmp : TOPENSSL_sk_compfunc) : PSTACK_OF_PKCS7_SIGNER_INFO cdecl;
  Tsk_PKCS7_SIGNER_INFO_new_null = function : PSTACK_OF_PKCS7_SIGNER_INFO cdecl;
  Tsk_PKCS7_SIGNER_INFO_free = procedure(st : PSTACK_OF_PKCS7_SIGNER_INFO) cdecl;
  Tsk_PKCS7_SIGNER_INFO_num = function (const sk : PSTACK_OF_PKCS7_SIGNER_INFO) : TIdC_INT cdecl;
  Tsk_PKCS7_SIGNER_INFO_value = function (const sk : PSTACK_OF_PKCS7_SIGNER_INFO; i : TIdC_INT) : PPKCS7_SIGNER_INFO cdecl;
  Tsk_PKCS7_SIGNER_INFO_push = function (sk : PSTACK_OF_PKCS7_SIGNER_INFO; st : PX509_CRL) : TIdC_INT cdecl;
  Tsk_PKCS7_SIGNER_INFO_dup = function (sk : PSTACK_OF_PKCS7_SIGNER_INFO) : PSTACK_OF_PKCS7_SIGNER_INFO cdecl;
  Tsk_PKCS7_SIGNER_INFO_find = function (sk : PSTACK_OF_PKCS7_SIGNER_INFO; _val : PX509_CRL) : TIdC_INT cdecl;
  Tsk_PKCS7_SIGNER_INFO_pop_free = procedure (sk : PSTACK_OF_PKCS7_SIGNER_INFO; func: TOPENSSL_sk_freefunc) cdecl;

var
  sk_PKCS7_RECIP_INFO_new: Tsk_PKCS7_RECIP_INFO_new absolute sk_new;
  sk_PKCS7_RECIP_INFO_new_null : Tsk_PKCS7_RECIP_INFO_new_null absolute sk_new_null;
  sk_PKCS7_RECIP_INFO_free : Tsk_PKCS7_RECIP_INFO_free absolute sk_free;
  sk_PKCS7_RECIP_INFO_num : Tsk_PKCS7_RECIP_INFO_num absolute sk_num;
  sk_PKCS7_RECIP_INFO_value : Tsk_PKCS7_RECIP_INFO_value absolute sk_value;
  sk_PKCS7_RECIP_INFO_push : Tsk_PKCS7_RECIP_INFO_push absolute sk_push;
  sk_PKCS7_RECIP_INFO_dup : Tsk_PKCS7_RECIP_INFO_dup absolute sk_dup;
  sk_PKCS7_RECIP_INFO_find : Tsk_PKCS7_RECIP_INFO_find absolute sk_find;
  sk_PKCS7_RECIP_INFO_pop_free : Tsk_PKCS7_RECIP_INFO_pop_free absolute sk_pop_free;

  sk_PKCS7_SIGNER_INFO_new: Tsk_PKCS7_SIGNER_INFO_new absolute sk_new;
  sk_PKCS7_SIGNER_INFO_new_null : Tsk_PKCS7_SIGNER_INFO_new_null absolute sk_new_null;
  sk_PKCS7_SIGNER_INFO_free : Tsk_PKCS7_SIGNER_INFO_free absolute sk_free;
  sk_PKCS7_SIGNER_INFO_num : Tsk_PKCS7_SIGNER_INFO_num absolute sk_num;
  sk_PKCS7_SIGNER_INFO_value : Tsk_PKCS7_SIGNER_INFO_value absolute sk_value;
  sk_PKCS7_SIGNER_INFO_push : Tsk_PKCS7_SIGNER_INFO_push absolute sk_push;
  sk_PKCS7_SIGNER_INFO_dup : Tsk_PKCS7_SIGNER_INFO_dup absolute sk_dup;
  sk_PKCS7_SIGNER_INFO_find : Tsk_PKCS7_SIGNER_INFO_find absolute sk_find;
  sk_PKCS7_SIGNER_INFO_pop_free : Tsk_PKCS7_SIGNER_INFO_pop_free absolute sk_pop_free;
{$ELSE}
  function sk_PKCS7_RECIP_INFO_new(cmp : TOPENSSL_sk_compfunc) : PSTACK_OF_PKCS7_RECIP_INFO cdecl; external CLibCrypto name 'OPENSSL_sk_new';
  function sk_PKCS7_RECIP_INFO_new_null : PSTACK_OF_PKCS7_RECIP_INFO cdecl; external CLibCrypto name 'OPENSSL_sk_new_null';
  procedure sk_PKCS7_RECIP_INFO_free(st : PSTACK_OF_PKCS7_RECIP_INFO) cdecl; external CLibCrypto name 'OPENSSL_sk_free';
  function sk_PKCS7_RECIP_INFO_num (const sk : PSTACK_OF_PKCS7_RECIP_INFO) : TIdC_INT; external CLibCrypto name 'OPENSSL_sk_num';
  function sk_PKCS7_RECIP_INFO_value (const sk : PSTACK_OF_PKCS7_RECIP_INFO; i : TIdC_INT) : PPKCS7_RECIP_INFO cdecl; external CLibCrypto name 'OPENSSL_sk_value';
  function sk_PKCS7_RECIP_INFO_push (sk : PSTACK_OF_PKCS7_RECIP_INFO; st : PX509_CRL) : TIdC_INT cdecl; external CLibCrypto  name 'OPENSSL_sk_push';
  function sk_PKCS7_RECIP_INFO_dup (sk : PSTACK_OF_PKCS7_RECIP_INFO) : PSTACK_OF_PKCS7_RECIP_INFO cdecl; external CLibCrypto name 'OPENSSL_sk_dup';
  function sk_PKCS7_RECIP_INFO_find (sk : PSTACK_OF_PKCS7_RECIP_INFO; val : PX509_CRL) : TIdC_INT cdecl; external CLibCrypto name 'OPENSSL_sk_find';
  procedure sk_PKCS7_RECIP_INFO_pop_free (sk : PSTACK_OF_PKCS7_RECIP_INFO; func: TOPENSSL_sk_freefunc) cdecl; external CLibCrypto name 'OPENSSL_sk_pop_free';
  function sk_PKCS7_SIGNER_INFO_new(cmp : TOPENSSL_sk_compfunc) : PSTACK_OF_PKCS7_SIGNER_INFO cdecl; external CLibCrypto name 'OPENSSL_sk_new';
  function sk_PKCS7_SIGNER_INFO_new_null : PSTACK_OF_PKCS7_SIGNER_INFO cdecl; external CLibCrypto name 'OPENSSL_sk_new_null';
  procedure sk_PKCS7_SIGNER_INFO_free(st : PSTACK_OF_PKCS7_SIGNER_INFO) cdecl; external CLibCrypto name 'OPENSSL_sk_free';
  function sk_PKCS7_SIGNER_INFO_num (const sk : PSTACK_OF_PKCS7_SIGNER_INFO) : TIdC_INT; external CLibCrypto name 'OPENSSL_sk_num';
  function sk_PKCS7_SIGNER_INFO_value (const sk : PSTACK_OF_PKCS7_SIGNER_INFO; i : TIdC_INT) : PPKCS7_SIGNER_INFO cdecl; external CLibCrypto name 'OPENSSL_sk_value';
  function sk_PKCS7_SIGNER_INFO_push (sk : PSTACK_OF_PKCS7_SIGNER_INFO; st : PX509_CRL) : TIdC_INT cdecl; external CLibCrypto  name 'OPENSSL_sk_push';
  function sk_PKCS7_SIGNER_INFO_dup (sk : PSTACK_OF_PKCS7_SIGNER_INFO) : PSTACK_OF_PKCS7_SIGNER_INFO cdecl; external CLibCrypto name 'OPENSSL_sk_dup';
  function sk_PKCS7_SIGNER_INFO_find (sk : PSTACK_OF_PKCS7_SIGNER_INFO; val : PX509_CRL) : TIdC_INT cdecl; external CLibCrypto name 'OPENSSL_sk_find';
  procedure sk_PKCS7_SIGNER_INFO_pop_free (sk : PSTACK_OF_PKCS7_SIGNER_INFO; func: TOPENSSL_sk_freefunc) cdecl; external CLibCrypto name 'OPENSSL_sk_pop_free';
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
  PKCS7_ISSUER_AND_SERIAL_digest_procname = 'PKCS7_ISSUER_AND_SERIAL_digest';

  PKCS7_dup_procname = 'PKCS7_dup';
  d2i_PKCS7_bio_procname = 'd2i_PKCS7_bio';
  i2d_PKCS7_bio_procname = 'i2d_PKCS7_bio';
  i2d_PKCS7_bio_stream_procname = 'i2d_PKCS7_bio_stream';
  PEM_write_bio_PKCS7_stream_procname = 'PEM_write_bio_PKCS7_stream';

  PKCS7_SIGNER_INFO_new_procname = 'PKCS7_SIGNER_INFO_new';
  PKCS7_SIGNER_INFO_free_procname = 'PKCS7_SIGNER_INFO_free';
  d2i_PKCS7_SIGNER_INFO_procname = 'd2i_PKCS7_SIGNER_INFO';
  i2d_PKCS7_SIGNER_INFO_procname = 'i2d_PKCS7_SIGNER_INFO';
  PKCS7_SIGNER_INFO_it_procname = 'PKCS7_SIGNER_INFO_it';

  PKCS7_RECIP_INFO_new_procname = 'PKCS7_RECIP_INFO_new';
  PKCS7_RECIP_INFO_free_procname = 'PKCS7_RECIP_INFO_free';
  d2i_PKCS7_RECIP_INFO_procname = 'd2i_PKCS7_RECIP_INFO';
  i2d_PKCS7_RECIP_INFO_procname = 'i2d_PKCS7_RECIP_INFO';
  PKCS7_RECIP_INFO_it_procname = 'PKCS7_RECIP_INFO_it';

  PKCS7_SIGNED_new_procname = 'PKCS7_SIGNED_new';
  PKCS7_SIGNED_free_procname = 'PKCS7_SIGNED_free';
  d2i_PKCS7_SIGNED_procname = 'd2i_PKCS7_SIGNED';
  i2d_PKCS7_SIGNED_procname = 'i2d_PKCS7_SIGNED';
  PKCS7_SIGNED_it_procname = 'PKCS7_SIGNED_it';

  PKCS7_ENC_CONTENT_new_procname = 'PKCS7_ENC_CONTENT_new';
  PKCS7_ENC_CONTENT_free_procname = 'PKCS7_ENC_CONTENT_free';
  d2i_PKCS7_ENC_CONTENT_procname = 'd2i_PKCS7_ENC_CONTENT';
  i2d_PKCS7_ENC_CONTENT_procname = 'i2d_PKCS7_ENC_CONTENT';
  PKCS7_ENC_CONTENT_it_procname = 'PKCS7_ENC_CONTENT_it';

  PKCS7_ENVELOPE_new_procname = 'PKCS7_ENVELOPE_new';
  PKCS7_ENVELOPE_free_procname = 'PKCS7_ENVELOPE_free';
  d2i_PKCS7_ENVELOPE_procname = 'd2i_PKCS7_ENVELOPE';
  i2d_PKCS7_ENVELOPE_procname = 'i2d_PKCS7_ENVELOPE';
  PKCS7_ENVELOPE_it_procname = 'PKCS7_ENVELOPE_it';

  PKCS7_SIGN_ENVELOPE_new_procname = 'PKCS7_SIGN_ENVELOPE_new';
  PKCS7_SIGN_ENVELOPE_free_procname = 'PKCS7_SIGN_ENVELOPE_free';
  d2i_PKCS7_SIGN_ENVELOPE_procname = 'd2i_PKCS7_SIGN_ENVELOPE';
  i2d_PKCS7_SIGN_ENVELOPE_procname = 'i2d_PKCS7_SIGN_ENVELOPE';
  PKCS7_SIGN_ENVELOPE_it_procname = 'PKCS7_SIGN_ENVELOPE_it';

  PKCS7_DIGEST_new_procname = 'PKCS7_DIGEST_new';
  PKCS7_DIGEST_free_procname = 'PKCS7_DIGEST_free';
  d2i_PKCS7_DIGEST_procname = 'd2i_PKCS7_DIGEST';
  i2d_PKCS7_DIGEST_procname = 'i2d_PKCS7_DIGEST';
  PKCS7_DIGEST_it_procname = 'PKCS7_DIGEST_it';

  PKCS7_ENCRYPT_new_procname = 'PKCS7_ENCRYPT_new';
  PKCS7_ENCRYPT_free_procname = 'PKCS7_ENCRYPT_free';
  d2i_PKCS7_ENCRYPT_procname = 'd2i_PKCS7_ENCRYPT';
  i2d_PKCS7_ENCRYPT_procname = 'i2d_PKCS7_ENCRYPT';
  PKCS7_ENCRYPT_it_procname = 'PKCS7_ENCRYPT_it';

  PKCS7_new_procname = 'PKCS7_new';
  PKCS7_free_procname = 'PKCS7_free';
  d2i_PKCS7_procname = 'd2i_PKCS7';
  i2d_PKCS7_procname = 'i2d_PKCS7';
  PKCS7_it_procname = 'PKCS7_it';

  PKCS7_ATTR_SIGN_it_procname = 'PKCS7_ATTR_SIGN_it';

  PKCS7_ATTR_VERIFY_it_procname = 'PKCS7_ATTR_VERIFY_it';

  i2d_PKCS7_NDEF_procname = 'i2d_PKCS7_NDEF';
  PKCS7_print_ctx_procname = 'PKCS7_print_ctx';

  PKCS7_ctrl_procname = 'PKCS7_ctrl';

  PKCS7_set_type_procname = 'PKCS7_set_type';
  PKCS7_set0_type_other_procname = 'PKCS7_set0_type_other';
  PKCS7_set_content_procname = 'PKCS7_set_content';
  PKCS7_SIGNER_INFO_set_procname = 'PKCS7_SIGNER_INFO_set';
  PKCS7_SIGNER_INFO_sign_procname = 'PKCS7_SIGNER_INFO_sign';
  PKCS7_add_signer_procname = 'PKCS7_add_signer';
  PKCS7_add_certificate_procname = 'PKCS7_add_certificate';
  PKCS7_add_crl_procname = 'PKCS7_add_crl';
  PKCS7_content_new_procname = 'PKCS7_content_new';
  PKCS7_dataVerify_procname = 'PKCS7_dataVerify';
  PKCS7_signatureVerify_procname = 'PKCS7_signatureVerify';

  PKCS7_dataInit_procname = 'PKCS7_dataInit';
  PKCS7_dataFinal_procname = 'PKCS7_dataFinal';
  PKCS7_dataDecode_procname = 'PKCS7_dataDecode';

  PKCS7_add_signature_procname = 'PKCS7_add_signature';
  PKCS7_cert_from_signer_info_procname = 'PKCS7_cert_from_signer_info';
  PKCS7_set_digest_procname = 'PKCS7_set_digest';
  PKCS7_get_signer_info_procname = 'PKCS7_get_signer_info';

  PKCS7_add_recipient_procname = 'PKCS7_add_recipient';
  PKCS7_SIGNER_INFO_get0_algs_procname = 'PKCS7_SIGNER_INFO_get0_algs';
  PKCS7_RECIP_INFO_get0_alg_procname = 'PKCS7_RECIP_INFO_get0_alg';
  PKCS7_add_recipient_info_procname = 'PKCS7_add_recipient_info';
  PKCS7_RECIP_INFO_set_procname = 'PKCS7_RECIP_INFO_set';
  PKCS7_set_cipher_procname = 'PKCS7_set_cipher';
  PKCS7_stream_procname = 'PKCS7_stream';

  PKCS7_get_issuer_and_serial_procname = 'PKCS7_get_issuer_and_serial';
  PKCS7_digest_from_attributes_procname = 'PKCS7_digest_from_attributes';
  PKCS7_add_signed_attribute_procname = 'PKCS7_add_signed_attribute';
  PKCS7_add_attribute_procname = 'PKCS7_add_attribute';
  PKCS7_get_attribute_procname = 'PKCS7_get_attribute';
  PKCS7_get_signed_attribute_procname = 'PKCS7_get_signed_attribute';
  PKCS7_set_signed_attributes_procname = 'PKCS7_set_signed_attributes';
  PKCS7_set_attributes_procname = 'PKCS7_set_attributes';

  PKCS7_sign_procname = 'PKCS7_sign';

  PKCS7_sign_add_signer_procname = 'PKCS7_sign_add_signer';

  PKCS7_final_procname = 'PKCS7_final';
  PKCS7_verify_procname = 'PKCS7_verify';
  PKCS7_get0_signers_procname = 'PKCS7_get0_signers';
  PKCS7_encrypt_procname = 'PKCS7_encrypt';
  PKCS7_decrypt_procname = 'PKCS7_decrypt';

  PKCS7_add_attrib_smimecap_procname = 'PKCS7_add_attrib_smimecap';
  PKCS7_get_smimecap_procname = 'PKCS7_get_smimecap';
  PKCS7_simple_smimecap_procname = 'PKCS7_simple_smimecap';

  PKCS7_add_attrib_content_type_procname = 'PKCS7_add_attrib_content_type';
  PKCS7_add0_attrib_signing_time_procname = 'PKCS7_add0_attrib_signing_time';
  PKCS7_add1_attrib_digest_procname = 'PKCS7_add1_attrib_digest';

  SMIME_write_PKCS7_procname = 'SMIME_write_PKCS7';
  SMIME_read_PKCS7_procname = 'SMIME_read_PKCS7';

  BIO_new_PKCS7_procname = 'BIO_new_PKCS7';


  {$i TaurusTLSNoRetValOff.inc} 
function  ERR_PKCS7_ISSUER_AND_SERIAL_digest(data: PPKCS7_ISSUER_AND_SERIAL; const type_: PEVP_MD; md: PByte; len: PIdC_UINT): TIdC_INT; 
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_ISSUER_AND_SERIAL_digest_procname);
end;



function  ERR_PKCS7_dup(p7: PPKCS7): PPKCS7; 
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_dup_procname);
end;


function  ERR_d2i_PKCS7_bio(bp: PBIO; p7: PPPKCS7): PPKCS7; 
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(d2i_PKCS7_bio_procname);
end;


function  ERR_i2d_PKCS7_bio(bp: PBIO; p7: PPKCS7): TIdC_INT; 
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(i2d_PKCS7_bio_procname);
end;


function  ERR_i2d_PKCS7_bio_stream(out_: PBIO; p7: PPKCS7; in_: PBIO; flags: TIdC_INT): TIdC_INT; 
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(i2d_PKCS7_bio_stream_procname);
end;


function  ERR_PEM_write_bio_PKCS7_stream(out_: PBIO; p7: PPKCS7; in_: PBIO; flags: TIdC_INT): TIdC_INT; 
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PEM_write_bio_PKCS7_stream_procname);
end;


function ERR_PKCS7_SIGNER_INFO_new: PPKCS7_SIGNER_INFO;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( PKCS7_SIGNER_INFO_new_procname);
end;

procedure ERR_PKCS7_SIGNER_INFO_free(a: PPKCS7_SIGNER_INFO);
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( PKCS7_SIGNER_INFO_free_procname);
end;

function ERR_d2i_PKCS7_SIGNER_INFO(a: PPPKCS7_SIGNER_INFO; const in_: PByte; len: TIdC_LONG): PPKCS7_SIGNER_INFO;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( d2i_PKCS7_SIGNER_INFO_procname);
end;

function ERR_i2d_PKCS7_SIGNER_INFO(const a: PPKCS7_SIGNER_INFO; out_: PByte): TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( i2d_PKCS7_SIGNER_INFO_procname);
end;

function ERR_PKCS7_SIGNER_INFO_it: PASN1_ITEM;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( PKCS7_SIGNER_INFO_it_procname);
end;

function ERR_PKCS7_RECIP_INFO_new: PPKCS7_RECIP_INFO;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( PKCS7_RECIP_INFO_new_procname );
end;

procedure ERR_PKCS7_RECIP_INFO_free(a: PPKCS7_RECIP_INFO);
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( PKCS7_RECIP_INFO_free_procname);
end;

function ERR_d2i_PKCS7_RECIP_INFO(a: PPPKCS7_RECIP_INFO; const in_: PByte; len: TIdC_LONG): PPKCS7_RECIP_INFO;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( d2i_PKCS7_RECIP_INFO_procname );
end;

function ERR_i2d_PKCS7_RECIP_INFO(const a: PPKCS7_RECIP_INFO; out_: PByte): TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( i2d_PKCS7_RECIP_INFO_procname );
end;

function ERR_PKCS7_RECIP_INFO_it: PASN1_ITEM;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( PKCS7_RECIP_INFO_it_procname );
end;

function ERR_PKCS7_SIGNED_new: PPKCS7_SIGNED;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( PKCS7_SIGNED_new_procname);
end;

procedure ERR_PKCS7_SIGNED_free(a: PPKCS7_SIGNED);
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( PKCS7_SIGNED_free_procname);
end;

function ERR_d2i_PKCS7_SIGNED(a: PPPKCS7_SIGNED; const in_: PByte; len: TIdC_LONG): PPKCS7_SIGNED;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( d2i_PKCS7_SIGNED_procname );
end;

function ERR_i2d_PKCS7_SIGNED(const a: PPKCS7_SIGNED; out_: PByte): TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( i2d_PKCS7_SIGNED_procname );
end;

function ERR_PKCS7_SIGNED_it: PASN1_ITEM;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( PKCS7_SIGNED_it_procname );
end;

function ERR_PKCS7_ENC_CONTENT_new: PPKCS7_ENC_CONTENT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( PKCS7_ENC_CONTENT_new_procname );
end;

procedure ERR_PKCS7_ENC_CONTENT_free(a: PPKCS7_ENC_CONTENT);
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( PKCS7_ENC_CONTENT_free_procname );
end;

function ERR_d2i_PKCS7_ENC_CONTENT(a: PPPKCS7_ENC_CONTENT; const in_: PByte; len: TIdC_LONG): PPKCS7_ENC_CONTENT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( d2i_PKCS7_ENC_CONTENT_procname );
end;

function ERR_i2d_PKCS7_ENC_CONTENT(const a: PPKCS7_ENC_CONTENT; out_: PByte): TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( i2d_PKCS7_ENC_CONTENT_procname );
end;

function ERR_PKCS7_ENC_CONTENT_it: PASN1_ITEM;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( PKCS7_ENC_CONTENT_it_procname );
end;

function ERR_PKCS7_ENVELOPE_new: PPKCS7_ENVELOPE;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( PKCS7_ENVELOPE_new_procname);
end;

procedure ERR_PKCS7_ENVELOPE_free(a: PPKCS7_ENVELOPE);
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_ENVELOPE_free_procname);
end;

function ERR_d2i_PKCS7_ENVELOPE(a: PPPKCS7_ENVELOPE; const in_: PByte; len: TIdC_LONG): PPKCS7_ENVELOPE;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( d2i_PKCS7_ENVELOPE_procname);
end;

function ERR_i2d_PKCS7_ENVELOPE(const a: PPKCS7_ENVELOPE; out_: PByte): TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( i2d_PKCS7_ENVELOPE_procname);
end;

function ERR_PKCS7_ENVELOPE_it: PASN1_ITEM;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( PKCS7_ENVELOPE_it_procname);
end;

function ERR_PKCS7_SIGN_ENVELOPE_new: PPKCS7_SIGN_ENVELOPE;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( PKCS7_SIGN_ENVELOPE_new_procname);
end;

procedure ERR_PKCS7_SIGN_ENVELOPE_free(a: PPKCS7_SIGN_ENVELOPE);
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( PKCS7_SIGN_ENVELOPE_free_procname );
end;

function ERR_d2i_PKCS7_SIGN_ENVELOPE(a: PPPKCS7_SIGN_ENVELOPE; const in_: PByte; len: TIdC_LONG): PPKCS7_SIGN_ENVELOPE;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(d2i_PKCS7_SIGN_ENVELOPE_procname);
end;

function ERR_i2d_PKCS7_SIGN_ENVELOPE(const a: PPKCS7_SIGN_ENVELOPE; out_: PByte): TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( i2d_PKCS7_SIGN_ENVELOPE_procname );
end;

function ERR_PKCS7_SIGN_ENVELOPE_it: PASN1_ITEM;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_SIGN_ENVELOPE_it_procname);
end;

function ERR_PKCS7_DIGEST_new: PPKCS7_DIGEST;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_DIGEST_new_procname);
end;

procedure ERR_PKCS7_DIGEST_free(a: PPKCS7_DIGEST);
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( PKCS7_DIGEST_free_procname);
end;

function ERR_d2i_PKCS7_DIGEST(a: PPPKCS7_DIGEST; const in_: PByte; len: TIdC_LONG): PPKCS7_DIGEST;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( d2i_PKCS7_DIGEST_procname);
end;

function ERR_i2d_PKCS7_DIGEST(const a: PPKCS7_DIGEST; out_: PByte): TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( i2d_PKCS7_DIGEST_procname);
end;

function ERR_PKCS7_DIGEST_it: PASN1_ITEM;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( PKCS7_DIGEST_it_procname);
end;

function ERR_PKCS7_ENCRYPT_new: PPKCS7_ENCRYPT_STRUCT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( PKCS7_ENCRYPT_new_procname);
end;

procedure ERR_PKCS7_ENCRYPT_free(a: PPKCS7_ENCRYPT_STRUCT);
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( PKCS7_ENCRYPT_free_procname );
end;

function ERR_d2i_PKCS7_ENCRYPT(a: PPPKCS7_ENCRYPT_STRUCT; const in_: PByte; len: TIdC_LONG): PPKCS7_ENCRYPT_STRUCT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( d2i_PKCS7_ENCRYPT_procname);
end;

function ERR_i2d_PKCS7_ENCRYPT(const a: PPKCS7_ENCRYPT_STRUCT; out_: PByte): TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( i2d_PKCS7_ENCRYPT_procname);
end;

function ERR_PKCS7_ENCRYPT_it: PASN1_ITEM;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( PKCS7_ENCRYPT_it_procname);
end;

function ERR_PKCS7_new: PPKCS7;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( PKCS7_new_procname);
end;

procedure ERR_PKCS7_free(a: PPKCS7);
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( PKCS7_free_procname );
end;

function ERR_d2i_PKCS7(a: PPPKCS7; const in_: PByte; len: TIdC_LONG): PPKCS7;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( d2i_PKCS7_procname);
end;

function ERR_i2d_PKCS7(const a: PPKCS7; out_: PByte): TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( i2d_PKCS7_procname);
end;

function ERR_PKCS7_it: PASN1_ITEM;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( PKCS7_it_procname);
end;

function ERR_PKCS7_ATTR_SIGN_it: PASN1_ITEM;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( PKCS7_ATTR_SIGN_it_procname);
end;

function ERR_PKCS7_ATTR_VERIFY_it: PASN1_ITEM;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_ATTR_VERIFY_it_procname);
end;

function ERR_i2d_PKCS7_NDEF(const a: PPKCS7; out_: PPByte): TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(i2d_PKCS7_NDEF_procname);
end;

function ERR_PKCS7_print_ctx(out_: PBIO; const x: PPKCS7; indent: TIdC_INT; const pctx: PASN1_PCTX): TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_print_ctx_procname);
end;

function  ERR_PKCS7_ctrl(p7: PPKCS7; cmd: TIdC_INT; larg: TIdC_LONG; parg: PIdAnsiChar): TIdC_LONG;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_ctrl_procname);
end;


function  ERR_PKCS7_set_type(p7: PPKCS7; type_: TIdC_INT): TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_set_type_procname);
end;

function  ERR_PKCS7_set0_type_other(p7: PPKCS7; type_: TIdC_INT; other: PASN1_TYPE): TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_set0_type_other_procname);
end;


function  ERR_PKCS7_set_content(p7: PPKCS7; p7_data: PPKCS7): TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_set_content_procname);
end;


function  ERR_PKCS7_SIGNER_INFO_set(p7i: PPKCS7_SIGNER_INFO; x509: PX509; pkey: PEVP_PKEY; const dgst: PEVP_MD): TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_SIGNER_INFO_set_procname);
end;

function  ERR_PKCS7_SIGNER_INFO_sign(si: PPKCS7_SIGNER_INFO): TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_SIGNER_INFO_sign_procname);
end;


function  ERR_PKCS7_add_signer(p7: PPKCS7; p7i: PPKCS7_SIGNER_INFO): TIdC_INT; 
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_add_signer_procname);
end;


function  ERR_PKCS7_add_certificate(p7: PPKCS7; x509: PX509): TIdC_INT; 
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_add_certificate_procname);
end;


function  ERR_PKCS7_add_crl(p7: PPKCS7; x509: PX509_CRL): TIdC_INT; 
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_add_crl_procname);
end;


function  ERR_PKCS7_content_new(p7: PPKCS7; nid: TIdC_INT): TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_content_new_procname);
end;


function  ERR_PKCS7_dataVerify(cert_store: PX509_STORE; ctx: PX509_STORE_CTX; bio: PBIO; p7: PPKCS7; si: PPKCS7_SIGNER_INFO): TIdC_INT; 
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_dataVerify_procname);
end;


function  ERR_PKCS7_signatureVerify(bio: PBIO; p7: PPKCS7; si: PPKCS7_SIGNER_INFO; x509: PX509): TIdC_INT; 
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_signatureVerify_procname);
end;



function  ERR_PKCS7_dataInit(p7: PPKCS7; bio: PBIO): PBIO; 
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_dataInit_procname);
end;


function  ERR_PKCS7_dataFinal(p7: PPKCS7; bio: PBIO): TIdC_INT; 
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_dataFinal_procname);
end;


function  ERR_PKCS7_dataDecode(p7: PPKCS7; pkey: PEVP_PKEY; in_bio: PBIO; pcert: PX509): PBIO; 
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_dataDecode_procname);
end;



function  ERR_PKCS7_add_signature(p7: PPKCS7; x509: PX509; pkey: PEVP_PKEY; const dgst: PEVP_MD): PPKCS7_SIGNER_INFO; 
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_add_signature_procname);
end;


function  ERR_PKCS7_cert_from_signer_info(p7: PPKCS7; si: PPKCS7_SIGNER_INFO): PX509; 
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_cert_from_signer_info_procname);
end;


function  ERR_PKCS7_set_digest(p7: PPKCS7; const md: PEVP_MD): TIdC_INT; 
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_set_digest_procname);
end;


function ERR_PKCS7_get_signer_info(p7: PPKCS7): PSTACK_OF_PKCS7_SIGNER_INFO;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_get_signer_info_procname);
end;

function  ERR_PKCS7_add_recipient(p7: PPKCS7; x509: PX509): PPKCS7_RECIP_INFO; 
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_add_recipient_procname);
end;


procedure  ERR_PKCS7_SIGNER_INFO_get0_algs(si: PPKCS7_SIGNER_INFO; pk: PPEVP_PKEY; pdig: PPX509_ALGOR; psig: PPX509_ALGOR); 
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_SIGNER_INFO_get0_algs_procname);
end;


procedure  ERR_PKCS7_RECIP_INFO_get0_alg(ri: PPKCS7_RECIP_INFO; penc: PPX509_ALGOR); 
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_RECIP_INFO_get0_alg_procname);
end;


function  ERR_PKCS7_add_recipient_info(p7: PPKCS7; ri: PPKCS7_RECIP_INFO): TIdC_INT; 
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_add_recipient_info_procname);
end;


function  ERR_PKCS7_RECIP_INFO_set(p7i: PPKCS7_RECIP_INFO; x509: PX509): TIdC_INT; 
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_RECIP_INFO_set_procname);
end;


function  ERR_PKCS7_set_cipher(p7: PPKCS7; const cipher: PEVP_CIPHER): TIdC_INT; 
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_set_cipher_procname);
end;


function  ERR_PKCS7_stream(boundary: PPPByte; p7: PPKCS7): TIdC_INT; 
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_stream_procname);
end;



function  ERR_PKCS7_get_issuer_and_serial(p7: PPKCS7; idx: TIdC_INT): PPKCS7_ISSUER_AND_SERIAL; 
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_get_issuer_and_serial_procname);
end;


function ERR_PKCS7_digest_from_attributes(sk: PSTACK_OF_X509_ATTRIBUTE): PASN1_OCTET_STRING;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( PKCS7_digest_from_attributes_procname);
end;

function  ERR_PKCS7_add_signed_attribute(p7si: PPKCS7_SIGNER_INFO; nid: TIdC_INT; type_: TIdC_INT; data: Pointer): TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_add_signed_attribute_procname);
end;


function  ERR_PKCS7_add_attribute(p7si: PPKCS7_SIGNER_INFO; nid: TIdC_INT; atrtype: TIdC_INT; value: Pointer): TIdC_INT; 
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_add_attribute_procname);
end;


function  ERR_PKCS7_get_attribute(si: PPKCS7_SIGNER_INFO; nid: TIdC_INT): PASN1_TYPE; 
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_get_attribute_procname);
end;


function  ERR_PKCS7_get_signed_attribute(si: PPKCS7_SIGNER_INFO; nid: TIdC_INT): PASN1_TYPE; 
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_get_signed_attribute_procname);
end;


function ERR_PKCS7_set_signed_attributes(p7si: PPKCS7_SIGNER_INFO; sk: PSTACK_OF_X509): TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_set_signed_attributes_procname);
end;

function ERR_PKCS7_set_attributes(p7si: PPKCS7_SIGNER_INFO; sk: PSTACK_OF_X509_ATTRIBUTE): TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_set_attributes_procname);
end;

function ERR_PKCS7_sign(signcert: PX509; pkey: PEVP_PKEY; certs: PSTACK_OF_X509; data: PBIO; flags: TIdC_INT): PPKCS7;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_sign_procname);
end;

function  ERR_PKCS7_sign_add_signer(p7: PPKCS7; signcert: PX509; pkey: PEVP_PKEY; const md: PEVP_MD; flags: TIdC_INT): PPKCS7_SIGNER_INFO;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_sign_add_signer_procname);
end;

function  ERR_PKCS7_final(p7: PPKCS7; data: PBIO; flags: TIdC_INT): TIdC_INT; 
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_final_procname);
end;


function ERR_PKCS7_verify(p7: PPKCS7; certs: PSTACK_OF_X509; store: PX509_STORE; indata: PBIO; out_: PBIO; flags: TIdC_INT): TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_verify_procname);
end;

function ERR_PKCS7_get0_signers(p7: PPKCS7; certs: PSTACK_OF_X509; flags: TIdC_INT): PSTACK_OF_X509;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( PKCS7_get0_signers_procname );
end;

function ERR_PKCS7_encrypt(certs: PSTACK_OF_X509; in_: PBIO; const cipher: PEVP_CIPHER; flags: TIdC_INT): PPKCS7;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( PKCS7_encrypt_procname );
end;

function  ERR_PKCS7_decrypt(p7: PPKCS7; pkey: PEVP_PKEY; cert: PX509; data: PBIO; flags: TIdC_INT): TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_decrypt_procname);
end;

function ERR_PKCS7_add_attrib_smimecap(si: PPKCS7_SIGNER_INFO; cap: PSTACK_OF_X509_ALGOR): TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( PKCS7_add_attrib_smimecap_procname );
end;

function ERR_PKCS7_get_smimecap(si: PPKCS7_SIGNER_INFO): PSTACK_OF_X509_ALGOR;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( PKCS7_get_smimecap_procname );
end;

function ERR_PKCS7_simple_smimecap(sk: PSTACK_OF_X509_ALGOR; nid: TIdC_INT; arg: TIdC_INT): TIdC_INT;
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException( PKCS7_simple_smimecap_procname );
end;

function  ERR_PKCS7_add_attrib_content_type(si: PPKCS7_SIGNER_INFO; coid: PASN1_OBJECT): TIdC_INT; 
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_add_attrib_content_type_procname);
end;


function  ERR_PKCS7_add0_attrib_signing_time(si: PPKCS7_SIGNER_INFO; t: PASN1_TIME): TIdC_INT; 
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_add0_attrib_signing_time_procname);
end;


function  ERR_PKCS7_add1_attrib_digest(si: PPKCS7_SIGNER_INFO; const md: PByte; mdlen: TIdC_INT): TIdC_INT; 
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(PKCS7_add1_attrib_digest_procname);
end;



function  ERR_SMIME_write_PKCS7(bio: PBIO; p7: PPKCS7; data: PBIO; flags: TIdC_INT): TIdC_INT; 
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(SMIME_write_PKCS7_procname);
end;


function  ERR_SMIME_read_PKCS7(bio: PBIO; bcont: PPBIO): PPKCS7; 
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(SMIME_read_PKCS7_procname);
end;



function  ERR_BIO_new_PKCS7(out_: PBIO; p7: PPKCS7): PBIO; 
begin
  ETaurusTLSAPIFunctionNotPresent.RaiseException(BIO_new_PKCS7_procname);
end;



  {$i TaurusTLSNoRetValOn.inc} 

  {$i TaurusTLSUnusedParamOff.inc}
procedure Load(const ADllHandle: TIdLibHandle; LibVersion: TIdC_UINT; const AFailed: TStringList);

var FuncLoadError: boolean;

begin
  PKCS7_ISSUER_AND_SERIAL_digest := LoadLibFunction(ADllHandle, PKCS7_ISSUER_AND_SERIAL_digest_procname);
  FuncLoadError := not assigned(PKCS7_ISSUER_AND_SERIAL_digest);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_ISSUER_AND_SERIAL_digest_allownil)}
    PKCS7_ISSUER_AND_SERIAL_digest := @ERR_PKCS7_ISSUER_AND_SERIAL_digest;
    {$ifend}
    {$if declared(PKCS7_ISSUER_AND_SERIAL_digest_introduced)}
    if LibVersion < PKCS7_ISSUER_AND_SERIAL_digest_introduced then
    begin
      {$if declared(FC_PKCS7_ISSUER_AND_SERIAL_digest)}
      PKCS7_ISSUER_AND_SERIAL_digest := @FC_PKCS7_ISSUER_AND_SERIAL_digest;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_ISSUER_AND_SERIAL_digest_removed)}
    if PKCS7_ISSUER_AND_SERIAL_digest_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_ISSUER_AND_SERIAL_digest)}
      PKCS7_ISSUER_AND_SERIAL_digest := @_PKCS7_ISSUER_AND_SERIAL_digest;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_ISSUER_AND_SERIAL_digest_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_ISSUER_AND_SERIAL_digest');
    {$ifend}
  end;


  PKCS7_dup := LoadLibFunction(ADllHandle, PKCS7_dup_procname);
  FuncLoadError := not assigned(PKCS7_dup);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_dup_allownil)}
    PKCS7_dup := @ERR_PKCS7_dup;
    {$ifend}
    {$if declared(PKCS7_dup_introduced)}
    if LibVersion < PKCS7_dup_introduced then
    begin
      {$if declared(FC_PKCS7_dup)}
      PKCS7_dup := @FC_PKCS7_dup;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_dup_removed)}
    if PKCS7_dup_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_dup)}
      PKCS7_dup := @_PKCS7_dup;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_dup_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_dup');
    {$ifend}
  end;


  d2i_PKCS7_bio := LoadLibFunction(ADllHandle, d2i_PKCS7_bio_procname);
  FuncLoadError := not assigned(d2i_PKCS7_bio);
  if FuncLoadError then
  begin
    {$if not defined(d2i_PKCS7_bio_allownil)}
    d2i_PKCS7_bio := @ERR_d2i_PKCS7_bio;
    {$ifend}
    {$if declared(d2i_PKCS7_bio_introduced)}
    if LibVersion < d2i_PKCS7_bio_introduced then
    begin
      {$if declared(FC_d2i_PKCS7_bio)}
      d2i_PKCS7_bio := @FC_d2i_PKCS7_bio;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(d2i_PKCS7_bio_removed)}
    if d2i_PKCS7_bio_removed <= LibVersion then
    begin
      {$if declared(_d2i_PKCS7_bio)}
      d2i_PKCS7_bio := @_d2i_PKCS7_bio;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(d2i_PKCS7_bio_allownil)}
    if FuncLoadError then
      AFailed.Add('d2i_PKCS7_bio');
    {$ifend}
  end;


  i2d_PKCS7_bio := LoadLibFunction(ADllHandle, i2d_PKCS7_bio_procname);
  FuncLoadError := not assigned(i2d_PKCS7_bio);
  if FuncLoadError then
  begin
    {$if not defined(i2d_PKCS7_bio_allownil)}
    i2d_PKCS7_bio := @ERR_i2d_PKCS7_bio;
    {$ifend}
    {$if declared(i2d_PKCS7_bio_introduced)}
    if LibVersion < i2d_PKCS7_bio_introduced then
    begin
      {$if declared(FC_i2d_PKCS7_bio)}
      i2d_PKCS7_bio := @FC_i2d_PKCS7_bio;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(i2d_PKCS7_bio_removed)}
    if i2d_PKCS7_bio_removed <= LibVersion then
    begin
      {$if declared(_i2d_PKCS7_bio)}
      i2d_PKCS7_bio := @_i2d_PKCS7_bio;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(i2d_PKCS7_bio_allownil)}
    if FuncLoadError then
      AFailed.Add('i2d_PKCS7_bio');
    {$ifend}
  end;


  i2d_PKCS7_bio_stream := LoadLibFunction(ADllHandle, i2d_PKCS7_bio_stream_procname);
  FuncLoadError := not assigned(i2d_PKCS7_bio_stream);
  if FuncLoadError then
  begin
    {$if not defined(i2d_PKCS7_bio_stream_allownil)}
    i2d_PKCS7_bio_stream := @ERR_i2d_PKCS7_bio_stream;
    {$ifend}
    {$if declared(i2d_PKCS7_bio_stream_introduced)}
    if LibVersion < i2d_PKCS7_bio_stream_introduced then
    begin
      {$if declared(FC_i2d_PKCS7_bio_stream)}
      i2d_PKCS7_bio_stream := @FC_i2d_PKCS7_bio_stream;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(i2d_PKCS7_bio_stream_removed)}
    if i2d_PKCS7_bio_stream_removed <= LibVersion then
    begin
      {$if declared(_i2d_PKCS7_bio_stream)}
      i2d_PKCS7_bio_stream := @_i2d_PKCS7_bio_stream;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(i2d_PKCS7_bio_stream_allownil)}
    if FuncLoadError then
      AFailed.Add('i2d_PKCS7_bio_stream');
    {$ifend}
  end;


  PEM_write_bio_PKCS7_stream := LoadLibFunction(ADllHandle, PEM_write_bio_PKCS7_stream_procname);
  FuncLoadError := not assigned(PEM_write_bio_PKCS7_stream);
  if FuncLoadError then
  begin
    {$if not defined(PEM_write_bio_PKCS7_stream_allownil)}
    PEM_write_bio_PKCS7_stream := @ERR_PEM_write_bio_PKCS7_stream;
    {$ifend}
    {$if declared(PEM_write_bio_PKCS7_stream_introduced)}
    if LibVersion < PEM_write_bio_PKCS7_stream_introduced then
    begin
      {$if declared(FC_PEM_write_bio_PKCS7_stream)}
      PEM_write_bio_PKCS7_stream := @FC_PEM_write_bio_PKCS7_stream;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PEM_write_bio_PKCS7_stream_removed)}
    if PEM_write_bio_PKCS7_stream_removed <= LibVersion then
    begin
      {$if declared(_PEM_write_bio_PKCS7_stream)}
      PEM_write_bio_PKCS7_stream := @_PEM_write_bio_PKCS7_stream;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PEM_write_bio_PKCS7_stream_allownil)}
    if FuncLoadError then
      AFailed.Add('PEM_write_bio_PKCS7_stream');
    {$ifend}
  end;


  PKCS7_SIGNER_INFO_new := LoadLibFunction(ADllHandle, PKCS7_SIGNER_INFO_new_procname);
  FuncLoadError := not assigned(PKCS7_SIGNER_INFO_new);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_SIGNER_INFO_new_allownil)}
    PKCS7_SIGNER_INFO_new := @ERR_PKCS7_SIGNER_INFO_new;
    {$ifend}
    {$if declared(PKCS7_SIGNER_INFO_new_introduced)}
    if LibVersion < PKCS7_SIGNER_INFO_new_introduced then
    begin
      {$if declared(FC_PKCS7_SIGNER_INFO_new)}
      PKCS7_SIGNER_INFO_new := @FC_PKCS7_SIGNER_INFO_new;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_SIGNER_INFO_new_removed)}
    if PKCS7_SIGNER_INFO_new_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_SIGNER_INFO_new)}
      PKCS7_SIGNER_INFO_new := @_PKCS7_SIGNER_INFO_new;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_SIGNER_INFO_new_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_SIGNER_INFO_new');
    {$ifend}
  end;


  PKCS7_SIGNER_INFO_free := LoadLibFunction(ADllHandle, PKCS7_SIGNER_INFO_free_procname);
  FuncLoadError := not assigned(PKCS7_SIGNER_INFO_free);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_SIGNER_INFO_free_allownil)}
    PKCS7_SIGNER_INFO_free := @ERR_PKCS7_SIGNER_INFO_free;
    {$ifend}
    {$if declared(PKCS7_SIGNER_INFO_free_introduced)}
    if LibVersion < PKCS7_SIGNER_INFO_free_introduced then
    begin
      {$if declared(FC_PKCS7_SIGNER_INFO_free)}
      PKCS7_SIGNER_INFO_free := @FC_PKCS7_SIGNER_INFO_free;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_SIGNER_INFO_free_removed)}
    if PKCS7_SIGNER_INFO_free_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_SIGNER_INFO_free)}
      PKCS7_SIGNER_INFO_free := @_PKCS7_SIGNER_INFO_free;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_SIGNER_INFO_free_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_SIGNER_INFO_free');
    {$ifend}
  end;


  d2i_PKCS7_SIGNER_INFO := LoadLibFunction(ADllHandle, d2i_PKCS7_SIGNER_INFO_procname);
  FuncLoadError := not assigned(d2i_PKCS7_SIGNER_INFO);
  if FuncLoadError then
  begin
    {$if not defined(d2i_PKCS7_SIGNER_INFO_allownil)}
    d2i_PKCS7_SIGNER_INFO := @ERR_d2i_PKCS7_SIGNER_INFO;
    {$ifend}
    {$if declared(d2i_PKCS7_SIGNER_INFO_introduced)}
    if LibVersion < d2i_PKCS7_SIGNER_INFO_introduced then
    begin
      {$if declared(FC_d2i_PKCS7_SIGNER_INFO)}
      d2i_PKCS7_SIGNER_INFO := @FC_d2i_PKCS7_SIGNER_INFO;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(d2i_PKCS7_SIGNER_INFO_removed)}
    if d2i_PKCS7_SIGNER_INFO_removed <= LibVersion then
    begin
      {$if declared(_d2i_PKCS7_SIGNER_INFO)}
      d2i_PKCS7_SIGNER_INFO := @_d2i_PKCS7_SIGNER_INFO;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(d2i_PKCS7_SIGNER_INFO_allownil)}
    if FuncLoadError then
      AFailed.Add('d2i_PKCS7_SIGNER_INFO');
    {$ifend}
  end;


  i2d_PKCS7_SIGNER_INFO := LoadLibFunction(ADllHandle, i2d_PKCS7_SIGNER_INFO_procname);
  FuncLoadError := not assigned(i2d_PKCS7_SIGNER_INFO);
  if FuncLoadError then
  begin
    {$if not defined(i2d_PKCS7_SIGNER_INFO_allownil)}
    i2d_PKCS7_SIGNER_INFO := @ERR_i2d_PKCS7_SIGNER_INFO;
    {$ifend}
    {$if declared(i2d_PKCS7_SIGNER_INFO_introduced)}
    if LibVersion < i2d_PKCS7_SIGNER_INFO_introduced then
    begin
      {$if declared(FC_i2d_PKCS7_SIGNER_INFO)}
      i2d_PKCS7_SIGNER_INFO := @FC_i2d_PKCS7_SIGNER_INFO;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(i2d_PKCS7_SIGNER_INFO_removed)}
    if i2d_PKCS7_SIGNER_INFO_removed <= LibVersion then
    begin
      {$if declared(_i2d_PKCS7_SIGNER_INFO)}
      i2d_PKCS7_SIGNER_INFO := @_i2d_PKCS7_SIGNER_INFO;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(i2d_PKCS7_SIGNER_INFO_allownil)}
    if FuncLoadError then
      AFailed.Add('i2d_PKCS7_SIGNER_INFO');
    {$ifend}
  end;


  PKCS7_SIGNER_INFO_it := LoadLibFunction(ADllHandle, PKCS7_SIGNER_INFO_it_procname);
  FuncLoadError := not assigned(PKCS7_SIGNER_INFO_it);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_SIGNER_INFO_it_allownil)}
    PKCS7_SIGNER_INFO_it := @ERR_PKCS7_SIGNER_INFO_it;
    {$ifend}
    {$if declared(PKCS7_SIGNER_INFO_it_introduced)}
    if LibVersion < PKCS7_SIGNER_INFO_it_introduced then
    begin
      {$if declared(FC_PKCS7_SIGNER_INFO_it)}
      PKCS7_SIGNER_INFO_it := @FC_PKCS7_SIGNER_INFO_it;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_SIGNER_INFO_it_removed)}
    if PKCS7_SIGNER_INFO_it_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_SIGNER_INFO_it)}
      PKCS7_SIGNER_INFO_it := @_PKCS7_SIGNER_INFO_it;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_SIGNER_INFO_it_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_SIGNER_INFO_it');
    {$ifend}
  end;


  PKCS7_RECIP_INFO_new := LoadLibFunction(ADllHandle, PKCS7_RECIP_INFO_new_procname);
  FuncLoadError := not assigned(PKCS7_RECIP_INFO_new);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_RECIP_INFO_new_allownil)}
    PKCS7_RECIP_INFO_new := @ERR_PKCS7_RECIP_INFO_new;
    {$ifend}
    {$if declared(PKCS7_RECIP_INFO_new_introduced)}
    if LibVersion < PKCS7_RECIP_INFO_new_introduced then
    begin
      {$if declared(FC_PKCS7_RECIP_INFO_new)}
      PKCS7_RECIP_INFO_new := @FC_PKCS7_RECIP_INFO_new;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_RECIP_INFO_new_removed)}
    if PKCS7_RECIP_INFO_new_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_RECIP_INFO_new)}
      PKCS7_RECIP_INFO_new := @_PKCS7_RECIP_INFO_new;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_RECIP_INFO_new_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_RECIP_INFO_new');
    {$ifend}
  end;


  PKCS7_RECIP_INFO_free := LoadLibFunction(ADllHandle, PKCS7_RECIP_INFO_free_procname);
  FuncLoadError := not assigned(PKCS7_RECIP_INFO_free);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_RECIP_INFO_free_allownil)}
    PKCS7_RECIP_INFO_free := @ERR_PKCS7_RECIP_INFO_free;
    {$ifend}
    {$if declared(PKCS7_RECIP_INFO_free_introduced)}
    if LibVersion < PKCS7_RECIP_INFO_free_introduced then
    begin
      {$if declared(FC_PKCS7_RECIP_INFO_free)}
      PKCS7_RECIP_INFO_free := @FC_PKCS7_RECIP_INFO_free;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_RECIP_INFO_free_removed)}
    if PKCS7_RECIP_INFO_free_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_RECIP_INFO_free)}
      PKCS7_RECIP_INFO_free := @_PKCS7_RECIP_INFO_free;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_RECIP_INFO_free_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_RECIP_INFO_free');
    {$ifend}
  end;


  d2i_PKCS7_RECIP_INFO := LoadLibFunction(ADllHandle, d2i_PKCS7_RECIP_INFO_procname);
  FuncLoadError := not assigned(d2i_PKCS7_RECIP_INFO);
  if FuncLoadError then
  begin
    {$if not defined(d2i_PKCS7_RECIP_INFO_allownil)}
    d2i_PKCS7_RECIP_INFO := @ERR_d2i_PKCS7_RECIP_INFO;
    {$ifend}
    {$if declared(d2i_PKCS7_RECIP_INFO_introduced)}
    if LibVersion < d2i_PKCS7_RECIP_INFO_introduced then
    begin
      {$if declared(FC_d2i_PKCS7_RECIP_INFO)}
      d2i_PKCS7_RECIP_INFO := @FC_d2i_PKCS7_RECIP_INFO;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(d2i_PKCS7_RECIP_INFO_removed)}
    if d2i_PKCS7_RECIP_INFO_removed <= LibVersion then
    begin
      {$if declared(_d2i_PKCS7_RECIP_INFO)}
      d2i_PKCS7_RECIP_INFO := @_d2i_PKCS7_RECIP_INFO;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(d2i_PKCS7_RECIP_INFO_allownil)}
    if FuncLoadError then
      AFailed.Add('d2i_PKCS7_RECIP_INFO');
    {$ifend}
  end;


  i2d_PKCS7_RECIP_INFO := LoadLibFunction(ADllHandle, i2d_PKCS7_RECIP_INFO_procname);
  FuncLoadError := not assigned(i2d_PKCS7_RECIP_INFO);
  if FuncLoadError then
  begin
    {$if not defined(i2d_PKCS7_RECIP_INFO_allownil)}
    i2d_PKCS7_RECIP_INFO := @ERR_i2d_PKCS7_RECIP_INFO;
    {$ifend}
    {$if declared(i2d_PKCS7_RECIP_INFO_introduced)}
    if LibVersion < i2d_PKCS7_RECIP_INFO_introduced then
    begin
      {$if declared(FC_i2d_PKCS7_RECIP_INFO)}
      i2d_PKCS7_RECIP_INFO := @FC_i2d_PKCS7_RECIP_INFO;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(i2d_PKCS7_RECIP_INFO_removed)}
    if i2d_PKCS7_RECIP_INFO_removed <= LibVersion then
    begin
      {$if declared(_i2d_PKCS7_RECIP_INFO)}
      i2d_PKCS7_RECIP_INFO := @_i2d_PKCS7_RECIP_INFO;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(i2d_PKCS7_RECIP_INFO_allownil)}
    if FuncLoadError then
      AFailed.Add('i2d_PKCS7_RECIP_INFO');
    {$ifend}
  end;


  PKCS7_RECIP_INFO_it := LoadLibFunction(ADllHandle, PKCS7_RECIP_INFO_it_procname);
  FuncLoadError := not assigned(PKCS7_RECIP_INFO_it);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_RECIP_INFO_it_allownil)}
    PKCS7_RECIP_INFO_it := @ERR_PKCS7_RECIP_INFO_it;
    {$ifend}
    {$if declared(PKCS7_RECIP_INFO_it_introduced)}
    if LibVersion < PKCS7_RECIP_INFO_it_introduced then
    begin
      {$if declared(FC_PKCS7_RECIP_INFO_it)}
      PKCS7_RECIP_INFO_it := @FC_PKCS7_RECIP_INFO_it;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_RECIP_INFO_it_removed)}
    if PKCS7_RECIP_INFO_it_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_RECIP_INFO_it)}
      PKCS7_RECIP_INFO_it := @_PKCS7_RECIP_INFO_it;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_RECIP_INFO_it_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_RECIP_INFO_it');
    {$ifend}
  end;

  PKCS7_SIGNED_new := LoadLibFunction(ADllHandle, PKCS7_SIGNED_new_procname);
  FuncLoadError := not assigned(PKCS7_SIGNED_new);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_SIGNED_new_allownil)}
    PKCS7_SIGNED_new := @ERR_PKCS7_SIGNED_new;
    {$ifend}
    {$if declared(PKCS7_SIGNED_new_introduced)}
    if LibVersion < PKCS7_SIGNED_new_introduced then
    begin
      {$if declared(FC_PKCS7_SIGNED_new)}
      PKCS7_SIGNED_new := @FC_PKCS7_SIGNED_new;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_SIGNED_new_removed)}
    if PKCS7_SIGNED_new_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_SIGNED_new)}
      PKCS7_SIGNED_new := @_PKCS7_SIGNED_new;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_SIGNED_new_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_SIGNED_new');
    {$ifend}
  end;


  PKCS7_SIGNED_free := LoadLibFunction(ADllHandle, PKCS7_SIGNED_free_procname);
  FuncLoadError := not assigned(PKCS7_SIGNED_free);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_SIGNED_free_allownil)}
    PKCS7_SIGNED_free := @ERR_PKCS7_SIGNED_free;
    {$ifend}
    {$if declared(PKCS7_SIGNED_free_introduced)}
    if LibVersion < PKCS7_SIGNED_free_introduced then
    begin
      {$if declared(FC_PKCS7_SIGNED_free)}
      PKCS7_SIGNED_free := @FC_PKCS7_SIGNED_free;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_SIGNED_free_removed)}
    if PKCS7_SIGNED_free_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_SIGNED_free)}
      PKCS7_SIGNED_free := @_PKCS7_SIGNED_free;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_SIGNED_free_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_SIGNED_free');
    {$ifend}
  end;


  d2i_PKCS7_SIGNED := LoadLibFunction(ADllHandle, d2i_PKCS7_SIGNED_procname);
  FuncLoadError := not assigned(d2i_PKCS7_SIGNED);
  if FuncLoadError then
  begin
    {$if not defined(d2i_PKCS7_SIGNED_allownil)}
    d2i_PKCS7_SIGNED := @ERR_d2i_PKCS7_SIGNED;
    {$ifend}
    {$if declared(d2i_PKCS7_SIGNED_introduced)}
    if LibVersion < d2i_PKCS7_SIGNED_introduced then
    begin
      {$if declared(FC_d2i_PKCS7_SIGNED)}
      d2i_PKCS7_SIGNED := @FC_d2i_PKCS7_SIGNED;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(d2i_PKCS7_SIGNED_removed)}
    if d2i_PKCS7_SIGNED_removed <= LibVersion then
    begin
      {$if declared(_d2i_PKCS7_SIGNED)}
      d2i_PKCS7_SIGNED := @_d2i_PKCS7_SIGNED;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(d2i_PKCS7_SIGNED_allownil)}
    if FuncLoadError then
      AFailed.Add('d2i_PKCS7_SIGNED');
    {$ifend}
  end;


  i2d_PKCS7_SIGNED := LoadLibFunction(ADllHandle, i2d_PKCS7_SIGNED_procname);
  FuncLoadError := not assigned(i2d_PKCS7_SIGNED);
  if FuncLoadError then
  begin
    {$if not defined(i2d_PKCS7_SIGNED_allownil)}
    i2d_PKCS7_SIGNED := @ERR_i2d_PKCS7_SIGNED;
    {$ifend}
    {$if declared(i2d_PKCS7_SIGNED_introduced)}
    if LibVersion < i2d_PKCS7_SIGNED_introduced then
    begin
      {$if declared(FC_i2d_PKCS7_SIGNED)}
      i2d_PKCS7_SIGNED := @FC_i2d_PKCS7_SIGNED;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(i2d_PKCS7_SIGNED_removed)}
    if i2d_PKCS7_SIGNED_removed <= LibVersion then
    begin
      {$if declared(_i2d_PKCS7_SIGNED)}
      i2d_PKCS7_SIGNED := @_i2d_PKCS7_SIGNED;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(i2d_PKCS7_SIGNED_allownil)}
    if FuncLoadError then
      AFailed.Add('i2d_PKCS7_SIGNED');
    {$ifend}
  end;


  PKCS7_SIGNED_it := LoadLibFunction(ADllHandle, PKCS7_SIGNED_it_procname);
  FuncLoadError := not assigned(PKCS7_SIGNED_it);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_SIGNED_it_allownil)}
    PKCS7_SIGNED_it := @ERR_PKCS7_SIGNED_it;
    {$ifend}
    {$if declared(PKCS7_SIGNED_it_introduced)}
    if LibVersion < PKCS7_SIGNED_it_introduced then
    begin
      {$if declared(FC_PKCS7_SIGNED_it)}
      PKCS7_SIGNED_it := @FC_PKCS7_SIGNED_it;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_SIGNED_it_removed)}
    if PKCS7_SIGNED_it_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_SIGNED_it)}
      PKCS7_SIGNED_it := @_PKCS7_SIGNED_it;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_SIGNED_it_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_SIGNED_it');
    {$ifend}
  end;


  PKCS7_ENC_CONTENT_new := LoadLibFunction(ADllHandle, PKCS7_ENC_CONTENT_new_procname);
  FuncLoadError := not assigned(PKCS7_ENC_CONTENT_new);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_ENC_CONTENT_new_allownil)}
    PKCS7_ENC_CONTENT_new := @ERR_PKCS7_ENC_CONTENT_new;
    {$ifend}
    {$if declared(PKCS7_ENC_CONTENT_new_introduced)}
    if LibVersion < PKCS7_ENC_CONTENT_new_introduced then
    begin
      {$if declared(FC_PKCS7_ENC_CONTENT_new)}
      PKCS7_ENC_CONTENT_new := @FC_PKCS7_ENC_CONTENT_new;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_ENC_CONTENT_new_removed)}
    if PKCS7_ENC_CONTENT_new_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_ENC_CONTENT_new)}
      PKCS7_ENC_CONTENT_new := @_PKCS7_ENC_CONTENT_new;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_ENC_CONTENT_new_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_ENC_CONTENT_new');
    {$ifend}
  end;


  PKCS7_ENC_CONTENT_free := LoadLibFunction(ADllHandle, PKCS7_ENC_CONTENT_free_procname);
  FuncLoadError := not assigned(PKCS7_ENC_CONTENT_free);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_ENC_CONTENT_free_allownil)}
    PKCS7_ENC_CONTENT_free := @ERR_PKCS7_ENC_CONTENT_free;
    {$ifend}
    {$if declared(PKCS7_ENC_CONTENT_free_introduced)}
    if LibVersion < PKCS7_ENC_CONTENT_free_introduced then
    begin
      {$if declared(FC_PKCS7_ENC_CONTENT_free)}
      PKCS7_ENC_CONTENT_free := @FC_PKCS7_ENC_CONTENT_free;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_ENC_CONTENT_free_removed)}
    if PKCS7_ENC_CONTENT_free_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_ENC_CONTENT_free)}
      PKCS7_ENC_CONTENT_free := @_PKCS7_ENC_CONTENT_free;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_ENC_CONTENT_free_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_ENC_CONTENT_free');
    {$ifend}
  end;


  d2i_PKCS7_ENC_CONTENT := LoadLibFunction(ADllHandle, d2i_PKCS7_ENC_CONTENT_procname);
  FuncLoadError := not assigned(d2i_PKCS7_ENC_CONTENT);
  if FuncLoadError then
  begin
    {$if not defined(d2i_PKCS7_ENC_CONTENT_allownil)}
    d2i_PKCS7_ENC_CONTENT := @ERR_d2i_PKCS7_ENC_CONTENT;
    {$ifend}
    {$if declared(d2i_PKCS7_ENC_CONTENT_introduced)}
    if LibVersion < d2i_PKCS7_ENC_CONTENT_introduced then
    begin
      {$if declared(FC_d2i_PKCS7_ENC_CONTENT)}
      d2i_PKCS7_ENC_CONTENT := @FC_d2i_PKCS7_ENC_CONTENT;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(d2i_PKCS7_ENC_CONTENT_removed)}
    if d2i_PKCS7_ENC_CONTENT_removed <= LibVersion then
    begin
      {$if declared(_d2i_PKCS7_ENC_CONTENT)}
      d2i_PKCS7_ENC_CONTENT := @_d2i_PKCS7_ENC_CONTENT;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(d2i_PKCS7_ENC_CONTENT_allownil)}
    if FuncLoadError then
      AFailed.Add('d2i_PKCS7_ENC_CONTENT');
    {$ifend}
  end;


  i2d_PKCS7_ENC_CONTENT := LoadLibFunction(ADllHandle, i2d_PKCS7_ENC_CONTENT_procname);
  FuncLoadError := not assigned(i2d_PKCS7_ENC_CONTENT);
  if FuncLoadError then
  begin
    {$if not defined(i2d_PKCS7_ENC_CONTENT_allownil)}
    i2d_PKCS7_ENC_CONTENT := @ERR_i2d_PKCS7_ENC_CONTENT;
    {$ifend}
    {$if declared(i2d_PKCS7_ENC_CONTENT_introduced)}
    if LibVersion < i2d_PKCS7_ENC_CONTENT_introduced then
    begin
      {$if declared(FC_i2d_PKCS7_ENC_CONTENT)}
      i2d_PKCS7_ENC_CONTENT := @FC_i2d_PKCS7_ENC_CONTENT;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(i2d_PKCS7_ENC_CONTENT_removed)}
    if i2d_PKCS7_ENC_CONTENT_removed <= LibVersion then
    begin
      {$if declared(_i2d_PKCS7_ENC_CONTENT)}
      i2d_PKCS7_ENC_CONTENT := @_i2d_PKCS7_ENC_CONTENT;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(i2d_PKCS7_ENC_CONTENT_allownil)}
    if FuncLoadError then
      AFailed.Add('i2d_PKCS7_ENC_CONTENT');
    {$ifend}
  end;


  PKCS7_ENC_CONTENT_it := LoadLibFunction(ADllHandle, PKCS7_ENC_CONTENT_it_procname);
  FuncLoadError := not assigned(PKCS7_ENC_CONTENT_it);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_ENC_CONTENT_it_allownil)}
    PKCS7_ENC_CONTENT_it := @ERR_PKCS7_ENC_CONTENT_it;
    {$ifend}
    {$if declared(PKCS7_ENC_CONTENT_it_introduced)}
    if LibVersion < PKCS7_ENC_CONTENT_it_introduced then
    begin
      {$if declared(FC_PKCS7_ENC_CONTENT_it)}
      PKCS7_ENC_CONTENT_it := @FC_PKCS7_ENC_CONTENT_it;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_ENC_CONTENT_it_removed)}
    if PKCS7_ENC_CONTENT_it_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_ENC_CONTENT_it)}
      PKCS7_ENC_CONTENT_it := @_PKCS7_ENC_CONTENT_it;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_ENC_CONTENT_it_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_ENC_CONTENT_it');
    {$ifend}
  end;


  PKCS7_ENVELOPE_new := LoadLibFunction(ADllHandle, PKCS7_ENVELOPE_new_procname);
  FuncLoadError := not assigned(PKCS7_ENVELOPE_new);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_ENVELOPE_new_allownil)}
    PKCS7_ENVELOPE_new := @ERR_PKCS7_ENVELOPE_new;
    {$ifend}
    {$if declared(PKCS7_ENVELOPE_new_introduced)}
    if LibVersion < PKCS7_ENVELOPE_new_introduced then
    begin
      {$if declared(FC_PKCS7_ENVELOPE_new)}
      PKCS7_ENVELOPE_new := @FC_PKCS7_ENVELOPE_new;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_ENVELOPE_new_removed)}
    if PKCS7_ENVELOPE_new_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_ENVELOPE_new)}
      PKCS7_ENVELOPE_new := @_PKCS7_ENVELOPE_new;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_ENVELOPE_new_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_ENVELOPE_new');
    {$ifend}
  end;


  PKCS7_ENVELOPE_free := LoadLibFunction(ADllHandle, PKCS7_ENVELOPE_free_procname);
  FuncLoadError := not assigned(PKCS7_ENVELOPE_free);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_ENVELOPE_free_allownil)}
    PKCS7_ENVELOPE_free := @ERR_PKCS7_ENVELOPE_free;
    {$ifend}
    {$if declared(PKCS7_ENVELOPE_free_introduced)}
    if LibVersion < PKCS7_ENVELOPE_free_introduced then
    begin
      {$if declared(FC_PKCS7_ENVELOPE_free)}
      PKCS7_ENVELOPE_free := @FC_PKCS7_ENVELOPE_free;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_ENVELOPE_free_removed)}
    if PKCS7_ENVELOPE_free_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_ENVELOPE_free)}
      PKCS7_ENVELOPE_free := @_PKCS7_ENVELOPE_free;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_ENVELOPE_free_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_ENVELOPE_free');
    {$ifend}
  end;


  d2i_PKCS7_ENVELOPE := LoadLibFunction(ADllHandle, d2i_PKCS7_ENVELOPE_procname);
  FuncLoadError := not assigned(d2i_PKCS7_ENVELOPE);
  if FuncLoadError then
  begin
    {$if not defined(d2i_PKCS7_ENVELOPE_allownil)}
    d2i_PKCS7_ENVELOPE := @ERR_d2i_PKCS7_ENVELOPE;
    {$ifend}
    {$if declared(d2i_PKCS7_ENVELOPE_introduced)}
    if LibVersion < d2i_PKCS7_ENVELOPE_introduced then
    begin
      {$if declared(FC_d2i_PKCS7_ENVELOPE)}
      d2i_PKCS7_ENVELOPE := @FC_d2i_PKCS7_ENVELOPE;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(d2i_PKCS7_ENVELOPE_removed)}
    if d2i_PKCS7_ENVELOPE_removed <= LibVersion then
    begin
      {$if declared(_d2i_PKCS7_ENVELOPE)}
      d2i_PKCS7_ENVELOPE := @_d2i_PKCS7_ENVELOPE;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(d2i_PKCS7_ENVELOPE_allownil)}
    if FuncLoadError then
      AFailed.Add('d2i_PKCS7_ENVELOPE');
    {$ifend}
  end;


  i2d_PKCS7_ENVELOPE := LoadLibFunction(ADllHandle, i2d_PKCS7_ENVELOPE_procname);
  FuncLoadError := not assigned(i2d_PKCS7_ENVELOPE);
  if FuncLoadError then
  begin
    {$if not defined(i2d_PKCS7_ENVELOPE_allownil)}
    i2d_PKCS7_ENVELOPE := @ERR_i2d_PKCS7_ENVELOPE;
    {$ifend}
    {$if declared(i2d_PKCS7_ENVELOPE_introduced)}
    if LibVersion < i2d_PKCS7_ENVELOPE_introduced then
    begin
      {$if declared(FC_i2d_PKCS7_ENVELOPE)}
      i2d_PKCS7_ENVELOPE := @FC_i2d_PKCS7_ENVELOPE;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(i2d_PKCS7_ENVELOPE_removed)}
    if i2d_PKCS7_ENVELOPE_removed <= LibVersion then
    begin
      {$if declared(_i2d_PKCS7_ENVELOPE)}
      i2d_PKCS7_ENVELOPE := @_i2d_PKCS7_ENVELOPE;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(i2d_PKCS7_ENVELOPE_allownil)}
    if FuncLoadError then
      AFailed.Add('i2d_PKCS7_ENVELOPE');
    {$ifend}
  end;


  PKCS7_ENVELOPE_it := LoadLibFunction(ADllHandle, PKCS7_ENVELOPE_it_procname);
  FuncLoadError := not assigned(PKCS7_ENVELOPE_it);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_ENVELOPE_it_allownil)}
    PKCS7_ENVELOPE_it := @ERR_PKCS7_ENVELOPE_it;
    {$ifend}
    {$if declared(PKCS7_ENVELOPE_it_introduced)}
    if LibVersion < PKCS7_ENVELOPE_it_introduced then
    begin
      {$if declared(FC_PKCS7_ENVELOPE_it)}
      PKCS7_ENVELOPE_it := @FC_PKCS7_ENVELOPE_it;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_ENVELOPE_it_removed)}
    if PKCS7_ENVELOPE_it_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_ENVELOPE_it)}
      PKCS7_ENVELOPE_it := @_PKCS7_ENVELOPE_it;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_ENVELOPE_it_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_ENVELOPE_it');
    {$ifend}
  end;


  PKCS7_SIGN_ENVELOPE_new := LoadLibFunction(ADllHandle, PKCS7_SIGN_ENVELOPE_new_procname);
  FuncLoadError := not assigned(PKCS7_SIGN_ENVELOPE_new);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_SIGN_ENVELOPE_new_allownil)}
    PKCS7_SIGN_ENVELOPE_new := @ERR_PKCS7_SIGN_ENVELOPE_new;
    {$ifend}
    {$if declared(PKCS7_SIGN_ENVELOPE_new_introduced)}
    if LibVersion < PKCS7_SIGN_ENVELOPE_new_introduced then
    begin
      {$if declared(FC_PKCS7_SIGN_ENVELOPE_new)}
      PKCS7_SIGN_ENVELOPE_new := @FC_PKCS7_SIGN_ENVELOPE_new;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_SIGN_ENVELOPE_new_removed)}
    if PKCS7_SIGN_ENVELOPE_new_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_SIGN_ENVELOPE_new)}
      PKCS7_SIGN_ENVELOPE_new := @_PKCS7_SIGN_ENVELOPE_new;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_SIGN_ENVELOPE_new_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_SIGN_ENVELOPE_new');
    {$ifend}
  end;


  PKCS7_SIGN_ENVELOPE_free := LoadLibFunction(ADllHandle, PKCS7_SIGN_ENVELOPE_free_procname);
  FuncLoadError := not assigned(PKCS7_SIGN_ENVELOPE_free);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_SIGN_ENVELOPE_free_allownil)}
    PKCS7_SIGN_ENVELOPE_free := @ERR_PKCS7_SIGN_ENVELOPE_free;
    {$ifend}
    {$if declared(PKCS7_SIGN_ENVELOPE_free_introduced)}
    if LibVersion < PKCS7_SIGN_ENVELOPE_free_introduced then
    begin
      {$if declared(FC_PKCS7_SIGN_ENVELOPE_free)}
      PKCS7_SIGN_ENVELOPE_free := @FC_PKCS7_SIGN_ENVELOPE_free;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_SIGN_ENVELOPE_free_removed)}
    if PKCS7_SIGN_ENVELOPE_free_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_SIGN_ENVELOPE_free)}
      PKCS7_SIGN_ENVELOPE_free := @_PKCS7_SIGN_ENVELOPE_free;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_SIGN_ENVELOPE_free_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_SIGN_ENVELOPE_free');
    {$ifend}
  end;


  d2i_PKCS7_SIGN_ENVELOPE := LoadLibFunction(ADllHandle, d2i_PKCS7_SIGN_ENVELOPE_procname);
  FuncLoadError := not assigned(d2i_PKCS7_SIGN_ENVELOPE);
  if FuncLoadError then
  begin
    {$if not defined(d2i_PKCS7_SIGN_ENVELOPE_allownil)}
    d2i_PKCS7_SIGN_ENVELOPE := @ERR_d2i_PKCS7_SIGN_ENVELOPE;
    {$ifend}
    {$if declared(d2i_PKCS7_SIGN_ENVELOPE_introduced)}
    if LibVersion < d2i_PKCS7_SIGN_ENVELOPE_introduced then
    begin
      {$if declared(FC_d2i_PKCS7_SIGN_ENVELOPE)}
      d2i_PKCS7_SIGN_ENVELOPE := @FC_d2i_PKCS7_SIGN_ENVELOPE;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(d2i_PKCS7_SIGN_ENVELOPE_removed)}
    if d2i_PKCS7_SIGN_ENVELOPE_removed <= LibVersion then
    begin
      {$if declared(_d2i_PKCS7_SIGN_ENVELOPE)}
      d2i_PKCS7_SIGN_ENVELOPE := @_d2i_PKCS7_SIGN_ENVELOPE;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(d2i_PKCS7_SIGN_ENVELOPE_allownil)}
    if FuncLoadError then
      AFailed.Add('d2i_PKCS7_SIGN_ENVELOPE');
    {$ifend}
  end;


  i2d_PKCS7_SIGN_ENVELOPE := LoadLibFunction(ADllHandle, i2d_PKCS7_SIGN_ENVELOPE_procname);
  FuncLoadError := not assigned(i2d_PKCS7_SIGN_ENVELOPE);
  if FuncLoadError then
  begin
    {$if not defined(i2d_PKCS7_SIGN_ENVELOPE_allownil)}
    i2d_PKCS7_SIGN_ENVELOPE := @ERR_i2d_PKCS7_SIGN_ENVELOPE;
    {$ifend}
    {$if declared(i2d_PKCS7_SIGN_ENVELOPE_introduced)}
    if LibVersion < i2d_PKCS7_SIGN_ENVELOPE_introduced then
    begin
      {$if declared(FC_i2d_PKCS7_SIGN_ENVELOPE)}
      i2d_PKCS7_SIGN_ENVELOPE := @FC_i2d_PKCS7_SIGN_ENVELOPE;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(i2d_PKCS7_SIGN_ENVELOPE_removed)}
    if i2d_PKCS7_SIGN_ENVELOPE_removed <= LibVersion then
    begin
      {$if declared(_i2d_PKCS7_SIGN_ENVELOPE)}
      i2d_PKCS7_SIGN_ENVELOPE := @_i2d_PKCS7_SIGN_ENVELOPE;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(i2d_PKCS7_SIGN_ENVELOPE_allownil)}
    if FuncLoadError then
      AFailed.Add('i2d_PKCS7_SIGN_ENVELOPE');
    {$ifend}
  end;


  PKCS7_SIGN_ENVELOPE_it := LoadLibFunction(ADllHandle, PKCS7_SIGN_ENVELOPE_it_procname);
  FuncLoadError := not assigned(PKCS7_SIGN_ENVELOPE_it);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_SIGN_ENVELOPE_it_allownil)}
    PKCS7_SIGN_ENVELOPE_it := @ERR_PKCS7_SIGN_ENVELOPE_it;
    {$ifend}
    {$if declared(PKCS7_SIGN_ENVELOPE_it_introduced)}
    if LibVersion < PKCS7_SIGN_ENVELOPE_it_introduced then
    begin
      {$if declared(FC_PKCS7_SIGN_ENVELOPE_it)}
      PKCS7_SIGN_ENVELOPE_it := @FC_PKCS7_SIGN_ENVELOPE_it;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_SIGN_ENVELOPE_it_removed)}
    if PKCS7_SIGN_ENVELOPE_it_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_SIGN_ENVELOPE_it)}
      PKCS7_SIGN_ENVELOPE_it := @_PKCS7_SIGN_ENVELOPE_it;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_SIGN_ENVELOPE_it_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_SIGN_ENVELOPE_it');
    {$ifend}
  end;


  PKCS7_DIGEST_new := LoadLibFunction(ADllHandle, PKCS7_DIGEST_new_procname);
  FuncLoadError := not assigned(PKCS7_DIGEST_new);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_DIGEST_new_allownil)}
    PKCS7_DIGEST_new := @ERR_PKCS7_DIGEST_new;
    {$ifend}
    {$if declared(PKCS7_DIGEST_new_introduced)}
    if LibVersion < PKCS7_DIGEST_new_introduced then
    begin
      {$if declared(FC_PKCS7_DIGEST_new)}
      PKCS7_DIGEST_new := @FC_PKCS7_DIGEST_new;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_DIGEST_new_removed)}
    if PKCS7_DIGEST_new_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_DIGEST_new)}
      PKCS7_DIGEST_new := @_PKCS7_DIGEST_new;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_DIGEST_new_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_DIGEST_new');
    {$ifend}
  end;


  PKCS7_DIGEST_free := LoadLibFunction(ADllHandle, PKCS7_DIGEST_free_procname);
  FuncLoadError := not assigned(PKCS7_DIGEST_free);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_DIGEST_free_allownil)}
    PKCS7_DIGEST_free := @ERR_PKCS7_DIGEST_free;
    {$ifend}
    {$if declared(PKCS7_DIGEST_free_introduced)}
    if LibVersion < PKCS7_DIGEST_free_introduced then
    begin
      {$if declared(FC_PKCS7_DIGEST_free)}
      PKCS7_DIGEST_free := @FC_PKCS7_DIGEST_free;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_DIGEST_free_removed)}
    if PKCS7_DIGEST_free_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_DIGEST_free)}
      PKCS7_DIGEST_free := @_PKCS7_DIGEST_free;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_DIGEST_free_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_DIGEST_free');
    {$ifend}
  end;


  d2i_PKCS7_DIGEST := LoadLibFunction(ADllHandle, d2i_PKCS7_DIGEST_procname);
  FuncLoadError := not assigned(d2i_PKCS7_DIGEST);
  if FuncLoadError then
  begin
    {$if not defined(d2i_PKCS7_DIGEST_allownil)}
    d2i_PKCS7_DIGEST := @ERR_d2i_PKCS7_DIGEST;
    {$ifend}
    {$if declared(d2i_PKCS7_DIGEST_introduced)}
    if LibVersion < d2i_PKCS7_DIGEST_introduced then
    begin
      {$if declared(FC_d2i_PKCS7_DIGEST)}
      d2i_PKCS7_DIGEST := @FC_d2i_PKCS7_DIGEST;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(d2i_PKCS7_DIGEST_removed)}
    if d2i_PKCS7_DIGEST_removed <= LibVersion then
    begin
      {$if declared(_d2i_PKCS7_DIGEST)}
      d2i_PKCS7_DIGEST := @_d2i_PKCS7_DIGEST;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(d2i_PKCS7_DIGEST_allownil)}
    if FuncLoadError then
      AFailed.Add('d2i_PKCS7_DIGEST');
    {$ifend}
  end;


  i2d_PKCS7_DIGEST := LoadLibFunction(ADllHandle, i2d_PKCS7_DIGEST_procname);
  FuncLoadError := not assigned(i2d_PKCS7_DIGEST);
  if FuncLoadError then
  begin
    {$if not defined(i2d_PKCS7_DIGEST_allownil)}
    i2d_PKCS7_DIGEST := @ERR_i2d_PKCS7_DIGEST;
    {$ifend}
    {$if declared(i2d_PKCS7_DIGEST_introduced)}
    if LibVersion < i2d_PKCS7_DIGEST_introduced then
    begin
      {$if declared(FC_i2d_PKCS7_DIGEST)}
      i2d_PKCS7_DIGEST := @FC_i2d_PKCS7_DIGEST;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(i2d_PKCS7_DIGEST_removed)}
    if i2d_PKCS7_DIGEST_removed <= LibVersion then
    begin
      {$if declared(_i2d_PKCS7_DIGEST)}
      i2d_PKCS7_DIGEST := @_i2d_PKCS7_DIGEST;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(i2d_PKCS7_DIGEST_allownil)}
    if FuncLoadError then
      AFailed.Add('i2d_PKCS7_DIGEST');
    {$ifend}
  end;


  PKCS7_DIGEST_it := LoadLibFunction(ADllHandle, PKCS7_DIGEST_it_procname);
  FuncLoadError := not assigned(PKCS7_DIGEST_it);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_DIGEST_it_allownil)}
    PKCS7_DIGEST_it := @ERR_PKCS7_DIGEST_it;
    {$ifend}
    {$if declared(PKCS7_DIGEST_it_introduced)}
    if LibVersion < PKCS7_DIGEST_it_introduced then
    begin
      {$if declared(FC_PKCS7_DIGEST_it)}
      PKCS7_DIGEST_it := @FC_PKCS7_DIGEST_it;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_DIGEST_it_removed)}
    if PKCS7_DIGEST_it_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_DIGEST_it)}
      PKCS7_DIGEST_it := @_PKCS7_DIGEST_it;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_DIGEST_it_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_DIGEST_it');
    {$ifend}
  end;


  PKCS7_ENCRYPT_new := LoadLibFunction(ADllHandle, PKCS7_ENCRYPT_new_procname);
  FuncLoadError := not assigned(PKCS7_ENCRYPT_new);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_ENCRYPT_new_allownil)}
    PKCS7_ENCRYPT_new := @ERR_PKCS7_ENCRYPT_new;
    {$ifend}
    {$if declared(PKCS7_ENCRYPT_new_introduced)}
    if LibVersion < PKCS7_ENCRYPT_new_introduced then
    begin
      {$if declared(FC_PKCS7_ENCRYPT_new)}
      PKCS7_ENCRYPT_new := @FC_PKCS7_ENCRYPT_new;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_ENCRYPT_new_removed)}
    if PKCS7_ENCRYPT_new_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_ENCRYPT_new)}
      PKCS7_ENCRYPT_new := @_PKCS7_ENCRYPT_new;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_ENCRYPT_new_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_ENCRYPT_new');
    {$ifend}
  end;


  PKCS7_ENCRYPT_free := LoadLibFunction(ADllHandle, PKCS7_ENCRYPT_free_procname);
  FuncLoadError := not assigned(PKCS7_ENCRYPT_free);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_ENCRYPT_free_allownil)}
    PKCS7_ENCRYPT_free := @ERR_PKCS7_ENCRYPT_free;
    {$ifend}
    {$if declared(PKCS7_ENCRYPT_free_introduced)}
    if LibVersion < PKCS7_ENCRYPT_free_introduced then
    begin
      {$if declared(FC_PKCS7_ENCRYPT_free)}
      PKCS7_ENCRYPT_free := @FC_PKCS7_ENCRYPT_free;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_ENCRYPT_free_removed)}
    if PKCS7_ENCRYPT_free_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_ENCRYPT_free)}
      PKCS7_ENCRYPT_free := @_PKCS7_ENCRYPT_free;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_ENCRYPT_free_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_ENCRYPT_free');
    {$ifend}
  end;


  d2i_PKCS7_ENCRYPT := LoadLibFunction(ADllHandle, d2i_PKCS7_ENCRYPT_procname);
  FuncLoadError := not assigned(d2i_PKCS7_ENCRYPT);
  if FuncLoadError then
  begin
    {$if not defined(d2i_PKCS7_ENCRYPT_allownil)}
    d2i_PKCS7_ENCRYPT := @ERR_d2i_PKCS7_ENCRYPT;
    {$ifend}
    {$if declared(d2i_PKCS7_ENCRYPT_introduced)}
    if LibVersion < d2i_PKCS7_ENCRYPT_introduced then
    begin
      {$if declared(FC_d2i_PKCS7_ENCRYPT)}
      d2i_PKCS7_ENCRYPT := @FC_d2i_PKCS7_ENCRYPT;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(d2i_PKCS7_ENCRYPT_removed)}
    if d2i_PKCS7_ENCRYPT_removed <= LibVersion then
    begin
      {$if declared(_d2i_PKCS7_ENCRYPT)}
      d2i_PKCS7_ENCRYPT := @_d2i_PKCS7_ENCRYPT;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(d2i_PKCS7_ENCRYPT_allownil)}
    if FuncLoadError then
      AFailed.Add('d2i_PKCS7_ENCRYPT');
    {$ifend}
  end;


  i2d_PKCS7_ENCRYPT := LoadLibFunction(ADllHandle, i2d_PKCS7_ENCRYPT_procname);
  FuncLoadError := not assigned(i2d_PKCS7_ENCRYPT);
  if FuncLoadError then
  begin
    {$if not defined(i2d_PKCS7_ENCRYPT_allownil)}
    i2d_PKCS7_ENCRYPT := @ERR_i2d_PKCS7_ENCRYPT;
    {$ifend}
    {$if declared(i2d_PKCS7_ENCRYPT_introduced)}
    if LibVersion < i2d_PKCS7_ENCRYPT_introduced then
    begin
      {$if declared(FC_i2d_PKCS7_ENCRYPT)}
      i2d_PKCS7_ENCRYPT := @FC_i2d_PKCS7_ENCRYPT;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(i2d_PKCS7_ENCRYPT_removed)}
    if i2d_PKCS7_ENCRYPT_removed <= LibVersion then
    begin
      {$if declared(_i2d_PKCS7_ENCRYPT)}
      i2d_PKCS7_ENCRYPT := @_i2d_PKCS7_ENCRYPT;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(i2d_PKCS7_ENCRYPT_allownil)}
    if FuncLoadError then
      AFailed.Add('i2d_PKCS7_ENCRYPT');
    {$ifend}
  end;


  PKCS7_ENCRYPT_it := LoadLibFunction(ADllHandle, PKCS7_ENCRYPT_it_procname);
  FuncLoadError := not assigned(PKCS7_ENCRYPT_it);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_ENCRYPT_it_allownil)}
    PKCS7_ENCRYPT_it := @ERR_PKCS7_ENCRYPT_it;
    {$ifend}
    {$if declared(PKCS7_ENCRYPT_it_introduced)}
    if LibVersion < PKCS7_ENCRYPT_it_introduced then
    begin
      {$if declared(FC_PKCS7_ENCRYPT_it)}
      PKCS7_ENCRYPT_it := @FC_PKCS7_ENCRYPT_it;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_ENCRYPT_it_removed)}
    if PKCS7_ENCRYPT_it_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_ENCRYPT_it)}
      PKCS7_ENCRYPT_it := @_PKCS7_ENCRYPT_it;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_ENCRYPT_it_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_ENCRYPT_it');
    {$ifend}
  end;


  PKCS7_new := LoadLibFunction(ADllHandle, PKCS7_new_procname);
  FuncLoadError := not assigned(PKCS7_new);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_new_allownil)}
    PKCS7_new := @ERR_PKCS7_new;
    {$ifend}
    {$if declared(PKCS7_new_introduced)}
    if LibVersion < PKCS7_new_introduced then
    begin
      {$if declared(FC_PKCS7_new)}
      PKCS7_new := @FC_PKCS7_new;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_new_removed)}
    if PKCS7_new_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_new)}
      PKCS7_new := @_PKCS7_new;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_new_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_new');
    {$ifend}
  end;

  PKCS7_free := LoadLibFunction(ADllHandle, PKCS7_free_procname);
  FuncLoadError := not assigned(PKCS7_free);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_free_allownil)}
    PKCS7_free := @ERR_PKCS7_free;
    {$ifend}
    {$if declared(PKCS7_free_introduced)}
    if LibVersion < PKCS7_free_introduced then
    begin
      {$if declared(FC_PKCS7_free)}
      PKCS7_free := @FC_PKCS7_free;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_free_removed)}
    if PKCS7_free_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_free)}
      PKCS7_free := @_PKCS7_free;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_free_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_free');
    {$ifend}
  end;
  d2i_PKCS7 := LoadLibFunction(ADllHandle, d2i_PKCS7_procname);
  FuncLoadError := not assigned(d2i_PKCS7);
  if FuncLoadError then
  begin
    {$if not defined(d2i_PKCS7_allownil)}
    d2i_PKCS7 := @ERR_d2i_PKCS7;
    {$ifend}
    {$if declared(d2i_PKCS7_introduced)}
    if LibVersion < d2i_PKCS7_introduced then
    begin
      {$if declared(FC_d2i_PKCS7)}
      d2i_PKCS7 := @FC_d2i_PKCS7;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(d2i_PKCS7_removed)}
    if d2i_PKCS7_removed <= LibVersion then
    begin
      {$if declared(_d2i_PKCS7)}
      d2i_PKCS7 := @_d2i_PKCS7;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(d2i_PKCS7_allownil)}
    if FuncLoadError then
      AFailed.Add('d2i_PKCS7');
    {$ifend}
  end;

  i2d_PKCS7 := LoadLibFunction(ADllHandle, i2d_PKCS7_procname);
  FuncLoadError := not assigned(i2d_PKCS7);
  if FuncLoadError then
  begin
    {$if not defined(i2d_PKCS7_allownil)}
    i2d_PKCS7 := @ERR_i2d_PKCS7;
    {$ifend}
    {$if declared(i2d_PKCS7_introduced)}
    if LibVersion < i2d_PKCS7_introduced then
    begin
      {$if declared(FC_i2d_PKCS7)}
      i2d_PKCS7 := @FC_i2d_PKCS7;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(i2d_PKCS7_removed)}
    if i2d_PKCS7_removed <= LibVersion then
    begin
      {$if declared(_i2d_PKCS7)}
      i2d_PKCS7 := @_i2d_PKCS7;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(i2d_PKCS7_allownil)}
    if FuncLoadError then
      AFailed.Add('i2d_PKCS7');
    {$ifend}
  end;

  PKCS7_it := LoadLibFunction(ADllHandle, PKCS7_it_procname);
  FuncLoadError := not assigned(PKCS7_it);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_it_allownil)}
    PKCS7_it := @ERR_PKCS7_it;
    {$ifend}
    {$if declared(PKCS7_it_introduced)}
    if LibVersion < PKCS7_it_introduced then
    begin
      {$if declared(FC_PKCS7_it)}
      PKCS7_it := @FC_PKCS7_it;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_it_removed)}
    if PKCS7_it_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_it)}
      PKCS7_it := @_PKCS7_it;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_it_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_it');
    {$ifend}
  end;


  PKCS7_ATTR_SIGN_it := LoadLibFunction(ADllHandle, PKCS7_ATTR_SIGN_it_procname);
  FuncLoadError := not assigned(PKCS7_ATTR_SIGN_it);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_ATTR_SIGN_it_allownil)}
    PKCS7_ATTR_SIGN_it := @ERR_PKCS7_ATTR_SIGN_it;
    {$ifend}
    {$if declared(PKCS7_ATTR_SIGN_it_introduced)}
    if LibVersion < PKCS7_ATTR_SIGN_it_introduced then
    begin
      {$if declared(FC_PKCS7_ATTR_SIGN_it)}
      PKCS7_ATTR_SIGN_it := @FC_PKCS7_ATTR_SIGN_it;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_ATTR_SIGN_it_removed)}
    if PKCS7_ATTR_SIGN_it_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_ATTR_SIGN_it)}
      PKCS7_ATTR_SIGN_it := @_PKCS7_ATTR_SIGN_it;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_ATTR_SIGN_it_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_ATTR_SIGN_it');
    {$ifend}
  end;


  PKCS7_ATTR_VERIFY_it := LoadLibFunction(ADllHandle, PKCS7_ATTR_VERIFY_it_procname);
  FuncLoadError := not assigned(PKCS7_ATTR_VERIFY_it);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_ATTR_VERIFY_it_allownil)}
    PKCS7_ATTR_VERIFY_it := @ERR_PKCS7_ATTR_VERIFY_it;
    {$ifend}
    {$if declared(PKCS7_ATTR_VERIFY_it_introduced)}
    if LibVersion < PKCS7_ATTR_VERIFY_it_introduced then
    begin
      {$if declared(FC_PKCS7_ATTR_VERIFY_it)}
      PKCS7_ATTR_VERIFY_it := @FC_PKCS7_ATTR_VERIFY_it;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_ATTR_VERIFY_it_removed)}
    if PKCS7_ATTR_VERIFY_it_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_ATTR_VERIFY_it)}
      PKCS7_ATTR_VERIFY_it := @_PKCS7_ATTR_VERIFY_it;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_ATTR_VERIFY_it_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_ATTR_VERIFY_it');
    {$ifend}
  end;


  i2d_PKCS7_NDEF := LoadLibFunction(ADllHandle, i2d_PKCS7_NDEF_procname);
  FuncLoadError := not assigned(i2d_PKCS7_NDEF);
  if FuncLoadError then
  begin
    {$if not defined(i2d_PKCS7_NDEF_allownil)}
    i2d_PKCS7_NDEF := @ERR_i2d_PKCS7_NDEF;
    {$ifend}
    {$if declared(i2d_PKCS7_NDEF_introduced)}
    if LibVersion < i2d_PKCS7_NDEF_introduced then
    begin
      {$if declared(FC_i2d_PKCS7_NDEF)}
      i2d_PKCS7_NDEF := @FC_i2d_PKCS7_NDEF;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(i2d_PKCS7_NDEF_removed)}
    if i2d_PKCS7_NDEF_removed <= LibVersion then
    begin
      {$if declared(_i2d_PKCS7_NDEF)}
      i2d_PKCS7_NDEF := @_i2d_PKCS7_NDEF;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(i2d_PKCS7_NDEF_allownil)}
    if FuncLoadError then
      AFailed.Add('i2d_PKCS7_NDEF');
    {$ifend}
  end;
  PKCS7_print_ctx := LoadLibFunction(ADllHandle, PKCS7_print_ctx_procname);
  FuncLoadError := not assigned(PKCS7_print_ctx);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_print_ctx_allownil)}
    PKCS7_print_ctx := @ERR_PKCS7_print_ctx;
    {$ifend}
    {$if declared(PKCS7_print_ctx_introduced)}
    if LibVersion < PKCS7_print_ctx_introduced then
    begin
      {$if declared(FC_PKCS7_print_ctx)}
      PKCS7_print_ctx := @FC_PKCS7_print_ctx;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_print_ctx_removed)}
    if PKCS7_print_ctx_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_print_ctx)}
      PKCS7_print_ctx := @_PKCS7_print_ctx;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_print_ctx_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_print_ctx');
    {$ifend}
  end;


  PKCS7_ctrl := LoadLibFunction(ADllHandle, PKCS7_ctrl_procname);
  FuncLoadError := not assigned(PKCS7_ctrl);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_ctrl_allownil)}
    PKCS7_ctrl := @ERR_PKCS7_ctrl;
    {$ifend}
    {$if declared(PKCS7_ctrl_introduced)}
    if LibVersion < PKCS7_ctrl_introduced then
    begin
      {$if declared(FC_PKCS7_ctrl)}
      PKCS7_ctrl := @FC_PKCS7_ctrl;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_ctrl_removed)}
    if PKCS7_ctrl_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_ctrl)}
      PKCS7_ctrl := @_PKCS7_ctrl;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_ctrl_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_ctrl');
    {$ifend}
  end;

  PKCS7_set_type := LoadLibFunction(ADllHandle, PKCS7_set_type_procname);
  FuncLoadError := not assigned(PKCS7_set_type);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_set_type_allownil)}
    PKCS7_set_type := @ERR_PKCS7_set_type;
    {$ifend}
    {$if declared(PKCS7_set_type_introduced)}
    if LibVersion < PKCS7_set_type_introduced then
    begin
      {$if declared(FC_PKCS7_set_type)}
      PKCS7_set_type := @FC_PKCS7_set_type;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_set_type_removed)}
    if PKCS7_set_type_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_set_type)}
      PKCS7_set_type := @_PKCS7_set_type;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_set_type_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_set_type');
    {$ifend}
  end;


  PKCS7_set0_type_other := LoadLibFunction(ADllHandle, PKCS7_set0_type_other_procname);
  FuncLoadError := not assigned(PKCS7_set0_type_other);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_set0_type_other_allownil)}
    PKCS7_set0_type_other := @ERR_PKCS7_set0_type_other;
    {$ifend}
    {$if declared(PKCS7_set0_type_other_introduced)}
    if LibVersion < PKCS7_set0_type_other_introduced then
    begin
      {$if declared(FC_PKCS7_set0_type_other)}
      PKCS7_set0_type_other := @FC_PKCS7_set0_type_other;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_set0_type_other_removed)}
    if PKCS7_set0_type_other_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_set0_type_other)}
      PKCS7_set0_type_other := @_PKCS7_set0_type_other;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_set0_type_other_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_set0_type_other');
    {$ifend}
  end;


  PKCS7_set_content := LoadLibFunction(ADllHandle, PKCS7_set_content_procname);
  FuncLoadError := not assigned(PKCS7_set_content);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_set_content_allownil)}
    PKCS7_set_content := @ERR_PKCS7_set_content;
    {$ifend}
    {$if declared(PKCS7_set_content_introduced)}
    if LibVersion < PKCS7_set_content_introduced then
    begin
      {$if declared(FC_PKCS7_set_content)}
      PKCS7_set_content := @FC_PKCS7_set_content;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_set_content_removed)}
    if PKCS7_set_content_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_set_content)}
      PKCS7_set_content := @_PKCS7_set_content;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_set_content_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_set_content');
    {$ifend}
  end;


  PKCS7_SIGNER_INFO_set := LoadLibFunction(ADllHandle, PKCS7_SIGNER_INFO_set_procname);
  FuncLoadError := not assigned(PKCS7_SIGNER_INFO_set);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_SIGNER_INFO_set_allownil)}
    PKCS7_SIGNER_INFO_set := @ERR_PKCS7_SIGNER_INFO_set;
    {$ifend}
    {$if declared(PKCS7_SIGNER_INFO_set_introduced)}
    if LibVersion < PKCS7_SIGNER_INFO_set_introduced then
    begin
      {$if declared(FC_PKCS7_SIGNER_INFO_set)}
      PKCS7_SIGNER_INFO_set := @FC_PKCS7_SIGNER_INFO_set;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_SIGNER_INFO_set_removed)}
    if PKCS7_SIGNER_INFO_set_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_SIGNER_INFO_set)}
      PKCS7_SIGNER_INFO_set := @_PKCS7_SIGNER_INFO_set;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_SIGNER_INFO_set_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_SIGNER_INFO_set');
    {$ifend}
  end;


  PKCS7_SIGNER_INFO_sign := LoadLibFunction(ADllHandle, PKCS7_SIGNER_INFO_sign_procname);
  FuncLoadError := not assigned(PKCS7_SIGNER_INFO_sign);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_SIGNER_INFO_sign_allownil)}
    PKCS7_SIGNER_INFO_sign := @ERR_PKCS7_SIGNER_INFO_sign;
    {$ifend}
    {$if declared(PKCS7_SIGNER_INFO_sign_introduced)}
    if LibVersion < PKCS7_SIGNER_INFO_sign_introduced then
    begin
      {$if declared(FC_PKCS7_SIGNER_INFO_sign)}
      PKCS7_SIGNER_INFO_sign := @FC_PKCS7_SIGNER_INFO_sign;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_SIGNER_INFO_sign_removed)}
    if PKCS7_SIGNER_INFO_sign_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_SIGNER_INFO_sign)}
      PKCS7_SIGNER_INFO_sign := @_PKCS7_SIGNER_INFO_sign;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_SIGNER_INFO_sign_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_SIGNER_INFO_sign');
    {$ifend}
  end;


  PKCS7_add_signer := LoadLibFunction(ADllHandle, PKCS7_add_signer_procname);
  FuncLoadError := not assigned(PKCS7_add_signer);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_add_signer_allownil)}
    PKCS7_add_signer := @ERR_PKCS7_add_signer;
    {$ifend}
    {$if declared(PKCS7_add_signer_introduced)}
    if LibVersion < PKCS7_add_signer_introduced then
    begin
      {$if declared(FC_PKCS7_add_signer)}
      PKCS7_add_signer := @FC_PKCS7_add_signer;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_add_signer_removed)}
    if PKCS7_add_signer_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_add_signer)}
      PKCS7_add_signer := @_PKCS7_add_signer;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_add_signer_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_add_signer');
    {$ifend}
  end;


  PKCS7_add_certificate := LoadLibFunction(ADllHandle, PKCS7_add_certificate_procname);
  FuncLoadError := not assigned(PKCS7_add_certificate);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_add_certificate_allownil)}
    PKCS7_add_certificate := @ERR_PKCS7_add_certificate;
    {$ifend}
    {$if declared(PKCS7_add_certificate_introduced)}
    if LibVersion < PKCS7_add_certificate_introduced then
    begin
      {$if declared(FC_PKCS7_add_certificate)}
      PKCS7_add_certificate := @FC_PKCS7_add_certificate;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_add_certificate_removed)}
    if PKCS7_add_certificate_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_add_certificate)}
      PKCS7_add_certificate := @_PKCS7_add_certificate;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_add_certificate_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_add_certificate');
    {$ifend}
  end;


  PKCS7_add_crl := LoadLibFunction(ADllHandle, PKCS7_add_crl_procname);
  FuncLoadError := not assigned(PKCS7_add_crl);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_add_crl_allownil)}
    PKCS7_add_crl := @ERR_PKCS7_add_crl;
    {$ifend}
    {$if declared(PKCS7_add_crl_introduced)}
    if LibVersion < PKCS7_add_crl_introduced then
    begin
      {$if declared(FC_PKCS7_add_crl)}
      PKCS7_add_crl := @FC_PKCS7_add_crl;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_add_crl_removed)}
    if PKCS7_add_crl_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_add_crl)}
      PKCS7_add_crl := @_PKCS7_add_crl;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_add_crl_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_add_crl');
    {$ifend}
  end;


  PKCS7_content_new := LoadLibFunction(ADllHandle, PKCS7_content_new_procname);
  FuncLoadError := not assigned(PKCS7_content_new);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_content_new_allownil)}
    PKCS7_content_new := @ERR_PKCS7_content_new;
    {$ifend}
    {$if declared(PKCS7_content_new_introduced)}
    if LibVersion < PKCS7_content_new_introduced then
    begin
      {$if declared(FC_PKCS7_content_new)}
      PKCS7_content_new := @FC_PKCS7_content_new;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_content_new_removed)}
    if PKCS7_content_new_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_content_new)}
      PKCS7_content_new := @_PKCS7_content_new;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_content_new_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_content_new');
    {$ifend}
  end;


  PKCS7_dataVerify := LoadLibFunction(ADllHandle, PKCS7_dataVerify_procname);
  FuncLoadError := not assigned(PKCS7_dataVerify);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_dataVerify_allownil)}
    PKCS7_dataVerify := @ERR_PKCS7_dataVerify;
    {$ifend}
    {$if declared(PKCS7_dataVerify_introduced)}
    if LibVersion < PKCS7_dataVerify_introduced then
    begin
      {$if declared(FC_PKCS7_dataVerify)}
      PKCS7_dataVerify := @FC_PKCS7_dataVerify;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_dataVerify_removed)}
    if PKCS7_dataVerify_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_dataVerify)}
      PKCS7_dataVerify := @_PKCS7_dataVerify;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_dataVerify_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_dataVerify');
    {$ifend}
  end;


  PKCS7_signatureVerify := LoadLibFunction(ADllHandle, PKCS7_signatureVerify_procname);
  FuncLoadError := not assigned(PKCS7_signatureVerify);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_signatureVerify_allownil)}
    PKCS7_signatureVerify := @ERR_PKCS7_signatureVerify;
    {$ifend}
    {$if declared(PKCS7_signatureVerify_introduced)}
    if LibVersion < PKCS7_signatureVerify_introduced then
    begin
      {$if declared(FC_PKCS7_signatureVerify)}
      PKCS7_signatureVerify := @FC_PKCS7_signatureVerify;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_signatureVerify_removed)}
    if PKCS7_signatureVerify_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_signatureVerify)}
      PKCS7_signatureVerify := @_PKCS7_signatureVerify;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_signatureVerify_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_signatureVerify');
    {$ifend}
  end;

  PKCS7_set_signed_attributes := LoadLibFunction(ADllHandle, PKCS7_set_signed_attributes_procname);
  FuncLoadError := not assigned(PKCS7_set_signed_attributes);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_set_signed_attributes_allownil)}
    PKCS7_set_signed_attributes := @ERR_PKCS7_set_signed_attributes;
    {$ifend}
    {$if declared(PKCS7_set_signed_attributes_introduced)}
    if LibVersion < PKCS7_set_signed_attributes_introduced then
    begin
      {$if declared(FC_PKCS7_set_signed_attributes)}
      PKCS7_set_signed_attributes := @FC_PKCS7_set_signed_attributes;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_set_signed_attributes_removed)}
    if PKCS7_set_signed_attributes_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_set_signed_attributes)}
      PKCS7_set_signed_attributes := @_PKCS7_set_signed_attributes;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_set_signed_attributes_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_set_signed_attributes');
    {$ifend}
  end;

  PKCS7_dataInit := LoadLibFunction(ADllHandle, PKCS7_dataInit_procname);
  FuncLoadError := not assigned(PKCS7_dataInit);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_dataInit_allownil)}
    PKCS7_dataInit := @ERR_PKCS7_dataInit;
    {$ifend}
    {$if declared(PKCS7_dataInit_introduced)}
    if LibVersion < PKCS7_dataInit_introduced then
    begin
      {$if declared(FC_PKCS7_dataInit)}
      PKCS7_dataInit := @FC_PKCS7_dataInit;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_dataInit_removed)}
    if PKCS7_dataInit_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_dataInit)}
      PKCS7_dataInit := @_PKCS7_dataInit;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_dataInit_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_dataInit');
    {$ifend}
  end;


  PKCS7_dataFinal := LoadLibFunction(ADllHandle, PKCS7_dataFinal_procname);
  FuncLoadError := not assigned(PKCS7_dataFinal);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_dataFinal_allownil)}
    PKCS7_dataFinal := @ERR_PKCS7_dataFinal;
    {$ifend}
    {$if declared(PKCS7_dataFinal_introduced)}
    if LibVersion < PKCS7_dataFinal_introduced then
    begin
      {$if declared(FC_PKCS7_dataFinal)}
      PKCS7_dataFinal := @FC_PKCS7_dataFinal;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_dataFinal_removed)}
    if PKCS7_dataFinal_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_dataFinal)}
      PKCS7_dataFinal := @_PKCS7_dataFinal;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_dataFinal_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_dataFinal');
    {$ifend}
  end;


  PKCS7_dataDecode := LoadLibFunction(ADllHandle, PKCS7_dataDecode_procname);
  FuncLoadError := not assigned(PKCS7_dataDecode);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_dataDecode_allownil)}
    PKCS7_dataDecode := @ERR_PKCS7_dataDecode;
    {$ifend}
    {$if declared(PKCS7_dataDecode_introduced)}
    if LibVersion < PKCS7_dataDecode_introduced then
    begin
      {$if declared(FC_PKCS7_dataDecode)}
      PKCS7_dataDecode := @FC_PKCS7_dataDecode;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_dataDecode_removed)}
    if PKCS7_dataDecode_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_dataDecode)}
      PKCS7_dataDecode := @_PKCS7_dataDecode;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_dataDecode_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_dataDecode');
    {$ifend}
  end;


  PKCS7_add_signature := LoadLibFunction(ADllHandle, PKCS7_add_signature_procname);
  FuncLoadError := not assigned(PKCS7_add_signature);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_add_signature_allownil)}
    PKCS7_add_signature := @ERR_PKCS7_add_signature;
    {$ifend}
    {$if declared(PKCS7_add_signature_introduced)}
    if LibVersion < PKCS7_add_signature_introduced then
    begin
      {$if declared(FC_PKCS7_add_signature)}
      PKCS7_add_signature := @FC_PKCS7_add_signature;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_add_signature_removed)}
    if PKCS7_add_signature_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_add_signature)}
      PKCS7_add_signature := @_PKCS7_add_signature;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_add_signature_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_add_signature');
    {$ifend}
  end;


  PKCS7_cert_from_signer_info := LoadLibFunction(ADllHandle, PKCS7_cert_from_signer_info_procname);
  FuncLoadError := not assigned(PKCS7_cert_from_signer_info);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_cert_from_signer_info_allownil)}
    PKCS7_cert_from_signer_info := @ERR_PKCS7_cert_from_signer_info;
    {$ifend}
    {$if declared(PKCS7_cert_from_signer_info_introduced)}
    if LibVersion < PKCS7_cert_from_signer_info_introduced then
    begin
      {$if declared(FC_PKCS7_cert_from_signer_info)}
      PKCS7_cert_from_signer_info := @FC_PKCS7_cert_from_signer_info;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_cert_from_signer_info_removed)}
    if PKCS7_cert_from_signer_info_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_cert_from_signer_info)}
      PKCS7_cert_from_signer_info := @_PKCS7_cert_from_signer_info;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_cert_from_signer_info_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_cert_from_signer_info');
    {$ifend}
  end;


  PKCS7_set_digest := LoadLibFunction(ADllHandle, PKCS7_set_digest_procname);
  FuncLoadError := not assigned(PKCS7_set_digest);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_set_digest_allownil)}
    PKCS7_set_digest := @ERR_PKCS7_set_digest;
    {$ifend}
    {$if declared(PKCS7_set_digest_introduced)}
    if LibVersion < PKCS7_set_digest_introduced then
    begin
      {$if declared(FC_PKCS7_set_digest)}
      PKCS7_set_digest := @FC_PKCS7_set_digest;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_set_digest_removed)}
    if PKCS7_set_digest_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_set_digest)}
      PKCS7_set_digest := @_PKCS7_set_digest;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_set_digest_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_set_digest');
    {$ifend}
  end;

  PKCS7_get_signer_info := LoadLibFunction(ADllHandle, PKCS7_get_signer_info_procname);
  FuncLoadError := not assigned(PKCS7_get_signer_info);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_get_signer_info_allownil)}
    PKCS7_get_signer_info := @ERR_PKCS7_get_signer_info;
    {$ifend}
    {$if declared(PKCS7_get_signer_info_introduced)}
    if LibVersion < PKCS7_get_signer_info_introduced then
    begin
      {$if declared(FC_PKCS7_get_signer_info)}
      PKCS7_get_signer_info := @FC_PKCS7_get_signer_info;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_get_signer_info_removed)}
    if PKCS7_get_signer_info_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_get_signer_info)}
      PKCS7_get_signer_info := @_PKCS7_get_signer_info;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_get_signer_info_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_get_signer_info');
    {$ifend}
  end;

  PKCS7_add_recipient := LoadLibFunction(ADllHandle, PKCS7_add_recipient_procname);
  FuncLoadError := not assigned(PKCS7_add_recipient);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_add_recipient_allownil)}
    PKCS7_add_recipient := @ERR_PKCS7_add_recipient;
    {$ifend}
    {$if declared(PKCS7_add_recipient_introduced)}
    if LibVersion < PKCS7_add_recipient_introduced then
    begin
      {$if declared(FC_PKCS7_add_recipient)}
      PKCS7_add_recipient := @FC_PKCS7_add_recipient;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_add_recipient_removed)}
    if PKCS7_add_recipient_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_add_recipient)}
      PKCS7_add_recipient := @_PKCS7_add_recipient;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_add_recipient_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_add_recipient');
    {$ifend}
  end;


  PKCS7_SIGNER_INFO_get0_algs := LoadLibFunction(ADllHandle, PKCS7_SIGNER_INFO_get0_algs_procname);
  FuncLoadError := not assigned(PKCS7_SIGNER_INFO_get0_algs);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_SIGNER_INFO_get0_algs_allownil)}
    PKCS7_SIGNER_INFO_get0_algs := @ERR_PKCS7_SIGNER_INFO_get0_algs;
    {$ifend}
    {$if declared(PKCS7_SIGNER_INFO_get0_algs_introduced)}
    if LibVersion < PKCS7_SIGNER_INFO_get0_algs_introduced then
    begin
      {$if declared(FC_PKCS7_SIGNER_INFO_get0_algs)}
      PKCS7_SIGNER_INFO_get0_algs := @FC_PKCS7_SIGNER_INFO_get0_algs;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_SIGNER_INFO_get0_algs_removed)}
    if PKCS7_SIGNER_INFO_get0_algs_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_SIGNER_INFO_get0_algs)}
      PKCS7_SIGNER_INFO_get0_algs := @_PKCS7_SIGNER_INFO_get0_algs;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_SIGNER_INFO_get0_algs_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_SIGNER_INFO_get0_algs');
    {$ifend}
  end;


  PKCS7_RECIP_INFO_get0_alg := LoadLibFunction(ADllHandle, PKCS7_RECIP_INFO_get0_alg_procname);
  FuncLoadError := not assigned(PKCS7_RECIP_INFO_get0_alg);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_RECIP_INFO_get0_alg_allownil)}
    PKCS7_RECIP_INFO_get0_alg := @ERR_PKCS7_RECIP_INFO_get0_alg;
    {$ifend}
    {$if declared(PKCS7_RECIP_INFO_get0_alg_introduced)}
    if LibVersion < PKCS7_RECIP_INFO_get0_alg_introduced then
    begin
      {$if declared(FC_PKCS7_RECIP_INFO_get0_alg)}
      PKCS7_RECIP_INFO_get0_alg := @FC_PKCS7_RECIP_INFO_get0_alg;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_RECIP_INFO_get0_alg_removed)}
    if PKCS7_RECIP_INFO_get0_alg_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_RECIP_INFO_get0_alg)}
      PKCS7_RECIP_INFO_get0_alg := @_PKCS7_RECIP_INFO_get0_alg;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_RECIP_INFO_get0_alg_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_RECIP_INFO_get0_alg');
    {$ifend}
  end;


  PKCS7_add_recipient_info := LoadLibFunction(ADllHandle, PKCS7_add_recipient_info_procname);
  FuncLoadError := not assigned(PKCS7_add_recipient_info);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_add_recipient_info_allownil)}
    PKCS7_add_recipient_info := @ERR_PKCS7_add_recipient_info;
    {$ifend}
    {$if declared(PKCS7_add_recipient_info_introduced)}
    if LibVersion < PKCS7_add_recipient_info_introduced then
    begin
      {$if declared(FC_PKCS7_add_recipient_info)}
      PKCS7_add_recipient_info := @FC_PKCS7_add_recipient_info;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_add_recipient_info_removed)}
    if PKCS7_add_recipient_info_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_add_recipient_info)}
      PKCS7_add_recipient_info := @_PKCS7_add_recipient_info;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_add_recipient_info_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_add_recipient_info');
    {$ifend}
  end;


  PKCS7_RECIP_INFO_set := LoadLibFunction(ADllHandle, PKCS7_RECIP_INFO_set_procname);
  FuncLoadError := not assigned(PKCS7_RECIP_INFO_set);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_RECIP_INFO_set_allownil)}
    PKCS7_RECIP_INFO_set := @ERR_PKCS7_RECIP_INFO_set;
    {$ifend}
    {$if declared(PKCS7_RECIP_INFO_set_introduced)}
    if LibVersion < PKCS7_RECIP_INFO_set_introduced then
    begin
      {$if declared(FC_PKCS7_RECIP_INFO_set)}
      PKCS7_RECIP_INFO_set := @FC_PKCS7_RECIP_INFO_set;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_RECIP_INFO_set_removed)}
    if PKCS7_RECIP_INFO_set_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_RECIP_INFO_set)}
      PKCS7_RECIP_INFO_set := @_PKCS7_RECIP_INFO_set;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_RECIP_INFO_set_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_RECIP_INFO_set');
    {$ifend}
  end;


  PKCS7_set_cipher := LoadLibFunction(ADllHandle, PKCS7_set_cipher_procname);
  FuncLoadError := not assigned(PKCS7_set_cipher);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_set_cipher_allownil)}
    PKCS7_set_cipher := @ERR_PKCS7_set_cipher;
    {$ifend}
    {$if declared(PKCS7_set_cipher_introduced)}
    if LibVersion < PKCS7_set_cipher_introduced then
    begin
      {$if declared(FC_PKCS7_set_cipher)}
      PKCS7_set_cipher := @FC_PKCS7_set_cipher;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_set_cipher_removed)}
    if PKCS7_set_cipher_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_set_cipher)}
      PKCS7_set_cipher := @_PKCS7_set_cipher;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_set_cipher_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_set_cipher');
    {$ifend}
  end;


  PKCS7_stream := LoadLibFunction(ADllHandle, PKCS7_stream_procname);
  FuncLoadError := not assigned(PKCS7_stream);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_stream_allownil)}
    PKCS7_stream := @ERR_PKCS7_stream;
    {$ifend}
    {$if declared(PKCS7_stream_introduced)}
    if LibVersion < PKCS7_stream_introduced then
    begin
      {$if declared(FC_PKCS7_stream)}
      PKCS7_stream := @FC_PKCS7_stream;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_stream_removed)}
    if PKCS7_stream_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_stream)}
      PKCS7_stream := @_PKCS7_stream;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_stream_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_stream');
    {$ifend}
  end;


  PKCS7_get_issuer_and_serial := LoadLibFunction(ADllHandle, PKCS7_get_issuer_and_serial_procname);
  FuncLoadError := not assigned(PKCS7_get_issuer_and_serial);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_get_issuer_and_serial_allownil)}
    PKCS7_get_issuer_and_serial := @ERR_PKCS7_get_issuer_and_serial;
    {$ifend}
    {$if declared(PKCS7_get_issuer_and_serial_introduced)}
    if LibVersion < PKCS7_get_issuer_and_serial_introduced then
    begin
      {$if declared(FC_PKCS7_get_issuer_and_serial)}
      PKCS7_get_issuer_and_serial := @FC_PKCS7_get_issuer_and_serial;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_get_issuer_and_serial_removed)}
    if PKCS7_get_issuer_and_serial_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_get_issuer_and_serial)}
      PKCS7_get_issuer_and_serial := @_PKCS7_get_issuer_and_serial;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_get_issuer_and_serial_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_get_issuer_and_serial');
    {$ifend}
  end;

  PKCS7_digest_from_attributes := LoadLibFunction(ADllHandle, PKCS7_digest_from_attributes_procname);
  FuncLoadError := not assigned(PKCS7_digest_from_attributes);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_digest_from_attributes_allownil)}
    PKCS7_digest_from_attributes := @ERR_PKCS7_digest_from_attributes;
    {$ifend}
    {$if declared(PKCS7_digest_from_attributes_introduced)}
    if LibVersion < PKCS7_digest_from_attributes_introduced then
    begin
      {$if declared(FC_PKCS7_digest_from_attributes)}
      PKCS7_digest_from_attributes := @FC_PKCS7_digest_from_attributes;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_digest_from_attributes_removed)}
    if PKCS7_digest_from_attributes_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_digest_from_attributes)}
      PKCS7_digest_from_attributes := @_PKCS7_digest_from_attributes;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_digest_from_attributes_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_digest_from_attributes');
    {$ifend}
  end;

  PKCS7_add_signed_attribute := LoadLibFunction(ADllHandle, PKCS7_add_signed_attribute_procname);
  FuncLoadError := not assigned(PKCS7_add_signed_attribute);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_add_signed_attribute_allownil)}
    PKCS7_add_signed_attribute := @ERR_PKCS7_add_signed_attribute;
    {$ifend}
    {$if declared(PKCS7_add_signed_attribute_introduced)}
    if LibVersion < PKCS7_add_signed_attribute_introduced then
    begin
      {$if declared(FC_PKCS7_add_signed_attribute)}
      PKCS7_add_signed_attribute := @FC_PKCS7_add_signed_attribute;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_add_signed_attribute_removed)}
    if PKCS7_add_signed_attribute_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_add_signed_attribute)}
      PKCS7_add_signed_attribute := @_PKCS7_add_signed_attribute;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_add_signed_attribute_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_add_signed_attribute');
    {$ifend}
  end;


  PKCS7_add_attribute := LoadLibFunction(ADllHandle, PKCS7_add_attribute_procname);
  FuncLoadError := not assigned(PKCS7_add_attribute);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_add_attribute_allownil)}
    PKCS7_add_attribute := @ERR_PKCS7_add_attribute;
    {$ifend}
    {$if declared(PKCS7_add_attribute_introduced)}
    if LibVersion < PKCS7_add_attribute_introduced then
    begin
      {$if declared(FC_PKCS7_add_attribute)}
      PKCS7_add_attribute := @FC_PKCS7_add_attribute;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_add_attribute_removed)}
    if PKCS7_add_attribute_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_add_attribute)}
      PKCS7_add_attribute := @_PKCS7_add_attribute;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_add_attribute_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_add_attribute');
    {$ifend}
  end;


  PKCS7_get_attribute := LoadLibFunction(ADllHandle, PKCS7_get_attribute_procname);
  FuncLoadError := not assigned(PKCS7_get_attribute);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_get_attribute_allownil)}
    PKCS7_get_attribute := @ERR_PKCS7_get_attribute;
    {$ifend}
    {$if declared(PKCS7_get_attribute_introduced)}
    if LibVersion < PKCS7_get_attribute_introduced then
    begin
      {$if declared(FC_PKCS7_get_attribute)}
      PKCS7_get_attribute := @FC_PKCS7_get_attribute;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_get_attribute_removed)}
    if PKCS7_get_attribute_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_get_attribute)}
      PKCS7_get_attribute := @_PKCS7_get_attribute;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_get_attribute_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_get_attribute');
    {$ifend}
  end;


  PKCS7_get_signed_attribute := LoadLibFunction(ADllHandle, PKCS7_get_signed_attribute_procname);
  FuncLoadError := not assigned(PKCS7_get_signed_attribute);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_get_signed_attribute_allownil)}
    PKCS7_get_signed_attribute := @ERR_PKCS7_get_signed_attribute;
    {$ifend}
    {$if declared(PKCS7_get_signed_attribute_introduced)}
    if LibVersion < PKCS7_get_signed_attribute_introduced then
    begin
      {$if declared(FC_PKCS7_get_signed_attribute)}
      PKCS7_get_signed_attribute := @FC_PKCS7_get_signed_attribute;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_get_signed_attribute_removed)}
    if PKCS7_get_signed_attribute_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_get_signed_attribute)}
      PKCS7_get_signed_attribute := @_PKCS7_get_signed_attribute;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_get_signed_attribute_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_get_signed_attribute');
    {$ifend}
  end;


  PKCS7_sign_add_signer := LoadLibFunction(ADllHandle, PKCS7_sign_add_signer_procname);
  FuncLoadError := not assigned(PKCS7_sign_add_signer);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_sign_add_signer_allownil)}
    PKCS7_sign_add_signer := @ERR_PKCS7_sign_add_signer;
    {$ifend}
    {$if declared(PKCS7_sign_add_signer_introduced)}
    if LibVersion < PKCS7_sign_add_signer_introduced then
    begin
      {$if declared(FC_PKCS7_sign_add_signer)}
      PKCS7_sign_add_signer := @FC_PKCS7_sign_add_signer;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_sign_add_signer_removed)}
    if PKCS7_sign_add_signer_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_sign_add_signer)}
      PKCS7_sign_add_signer := @_PKCS7_sign_add_signer;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_sign_add_signer_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_sign_add_signer');
    {$ifend}
  end;


  PKCS7_final := LoadLibFunction(ADllHandle, PKCS7_final_procname);
  FuncLoadError := not assigned(PKCS7_final);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_final_allownil)}
    PKCS7_final := @ERR_PKCS7_final;
    {$ifend}
    {$if declared(PKCS7_final_introduced)}
    if LibVersion < PKCS7_final_introduced then
    begin
      {$if declared(FC_PKCS7_final)}
      PKCS7_final := @FC_PKCS7_final;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_final_removed)}
    if PKCS7_final_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_final)}
      PKCS7_final := @_PKCS7_final;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_final_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_final');
    {$ifend}
  end;

  PKCS7_verify := LoadLibFunction(ADllHandle, PKCS7_verify_procname);
  FuncLoadError := not assigned(PKCS7_verify);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_verify_allownil)}
    PKCS7_verify := @ERR_PKCS7_verify;
    {$ifend}
    {$if declared(PKCS7_verify_introduced)}
    if LibVersion < PKCS7_verify_introduced then
    begin
      {$if declared(FC_PKCS7_verify)}
      PKCS7_verify := @FC_PKCS7_verify;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_verify_removed)}
    if PKCS7_verify_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_verify)}
      PKCS7_verify := @_PKCS7_verify;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_verify_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_verify');
    {$ifend}
  end;

  PKCS7_get0_signers := LoadLibFunction(ADllHandle, PKCS7_get0_signers_procname);
  FuncLoadError := not assigned(PKCS7_get0_signers);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_get0_signers_allownil)}
    PKCS7_get0_signers := @ERR_PKCS7_get0_signers;
    {$ifend}
    {$if declared(PKCS7_get0_signers_introduced)}
    if LibVersion < PKCS7_get0_signers_introduced then
    begin
      {$if declared(FC_PKCS7_get0_signers)}
      PKCS7_get0_signers := @FC_PKCS7_get0_signers;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_get0_signers_removed)}
    if PKCS7_get0_signers_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_get0_signers)}
      PKCS7_get0_signers := @_PKCS7_get0_signers;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_get0_signers_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_get0_signers');
    {$ifend}
  end;


  PKCS7_encrypt := LoadLibFunction(ADllHandle, PKCS7_encrypt_procname);
  FuncLoadError := not assigned(PKCS7_encrypt);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_encrypt_allownil)}
    PKCS7_encrypt := @ERR_PKCS7_encrypt;
    {$ifend}
    {$if declared(PKCS7_encrypt_introduced)}
    if LibVersion < PKCS7_encrypt_introduced then
    begin
      {$if declared(FC_PKCS7_encrypt)}
      PKCS7_encrypt := @FC_PKCS7_encrypt;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_encrypt_removed)}
    if PKCS7_encrypt_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_encrypt)}
      PKCS7_encrypt := @_PKCS7_encrypt;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_encrypt_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_encrypt');
    {$ifend}
  end;

  PKCS7_decrypt := LoadLibFunction(ADllHandle, PKCS7_decrypt_procname);
  FuncLoadError := not assigned(PKCS7_decrypt);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_decrypt_allownil)}
    PKCS7_decrypt := @ERR_PKCS7_decrypt;
    {$ifend}
    {$if declared(PKCS7_decrypt_introduced)}
    if LibVersion < PKCS7_decrypt_introduced then
    begin
      {$if declared(FC_PKCS7_decrypt)}
      PKCS7_decrypt := @FC_PKCS7_decrypt;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_decrypt_removed)}
    if PKCS7_decrypt_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_decrypt)}
      PKCS7_decrypt := @_PKCS7_decrypt;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_decrypt_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_decrypt');
    {$ifend}
  end;

  PKCS7_add_attrib_smimecap  := LoadLibFunction(ADllHandle, PKCS7_add_attrib_smimecap_procname);
  FuncLoadError := not assigned(PKCS7_add_attrib_smimecap);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_add_attrib_smimecap_allownil)}
    PKCS7_add_attrib_smimecap := @ERR_PKCS7_add_attrib_smimecap;
    {$ifend}
    {$if declared(PKCS7_add_attrib_smimecap_introduced)}
    if LibVersion < PKCS7_add_attrib_smimecap_introduced then
    begin
      {$if declared(FC_PKCS7_add_attrib_smimecap)}
      PKCS7_add_attrib_smimecap := @FC_PKCS7_add_attrib_smimecap;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_add_attrib_smimecap_removed)}
    if PKCS7_add_attrib_smimecap_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_add_attrib_smimecap)}
      PKCS7_add_attrib_smimecap := @_PKCS7_add_attrib_smimecap;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_add_attrib_smimecap_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_add_attrib_smimecap');
    {$ifend}
  end;

  PKCS7_get_smimecap  := LoadLibFunction(ADllHandle, PKCS7_get_smimecap_procname);
  FuncLoadError := not assigned(PKCS7_get_smimecap);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_get_smimecap_allownil)}
    PKCS7_get_smimecap := @ERR_PKCS7_get_smimecap;
    {$ifend}
    {$if declared(PKCS7_get_smimecap_introduced)}
    if LibVersion < PKCS7_get_smimecap_introduced then
    begin
      {$if declared(FC_PKCS7_get_smimecap)}
      PKCS7_get_smimecap := @FC_PKCS7_get_smimecap;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_get_smimecap_removed)}
    if PKCS7_get_smimecap_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_get_smimecap)}
      PKCS7_get_smimecap := @_PKCS7_get_smimecap;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_get_smimecap_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_get_smimecap');
    {$ifend}
  end;

  PKCS7_simple_smimecap  := LoadLibFunction(ADllHandle, PKCS7_simple_smimecap_procname);
  FuncLoadError := not assigned(PKCS7_simple_smimecap);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_simple_smimecap_allownil)}
    PKCS7_simple_smimecap := @ERR_PKCS7_simple_smimecap;
    {$ifend}
    {$if declared(PKCS7_simple_smimecap_introduced)}
    if LibVersion < PKCS7_simple_smimecap_introduced then
    begin
      {$if declared(FC_PKCS7_simple_smimecap)}
      PKCS7_simple_smimecap := @FC_PKCS7_simple_smimecap;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_simple_smimecap_removed)}
    if PKCS7_simple_smimecap_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_simple_smimecap)}
      PKCS7_simple_smimecap := @_PKCS7_simple_smimecap;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_simple_smimecap_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_simple_smimecap');
    {$ifend}
  end;

  PKCS7_add_attrib_content_type := LoadLibFunction(ADllHandle, PKCS7_add_attrib_content_type_procname);
  FuncLoadError := not assigned(PKCS7_add_attrib_content_type);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_add_attrib_content_type_allownil)}
    PKCS7_add_attrib_content_type := @ERR_PKCS7_add_attrib_content_type;
    {$ifend}
    {$if declared(PKCS7_add_attrib_content_type_introduced)}
    if LibVersion < PKCS7_add_attrib_content_type_introduced then
    begin
      {$if declared(FC_PKCS7_add_attrib_content_type)}
      PKCS7_add_attrib_content_type := @FC_PKCS7_add_attrib_content_type;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_add_attrib_content_type_removed)}
    if PKCS7_add_attrib_content_type_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_add_attrib_content_type)}
      PKCS7_add_attrib_content_type := @_PKCS7_add_attrib_content_type;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_add_attrib_content_type_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_add_attrib_content_type');
    {$ifend}
  end;


  PKCS7_add0_attrib_signing_time := LoadLibFunction(ADllHandle, PKCS7_add0_attrib_signing_time_procname);
  FuncLoadError := not assigned(PKCS7_add0_attrib_signing_time);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_add0_attrib_signing_time_allownil)}
    PKCS7_add0_attrib_signing_time := @ERR_PKCS7_add0_attrib_signing_time;
    {$ifend}
    {$if declared(PKCS7_add0_attrib_signing_time_introduced)}
    if LibVersion < PKCS7_add0_attrib_signing_time_introduced then
    begin
      {$if declared(FC_PKCS7_add0_attrib_signing_time)}
      PKCS7_add0_attrib_signing_time := @FC_PKCS7_add0_attrib_signing_time;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_add0_attrib_signing_time_removed)}
    if PKCS7_add0_attrib_signing_time_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_add0_attrib_signing_time)}
      PKCS7_add0_attrib_signing_time := @_PKCS7_add0_attrib_signing_time;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_add0_attrib_signing_time_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_add0_attrib_signing_time');
    {$ifend}
  end;


  PKCS7_add1_attrib_digest := LoadLibFunction(ADllHandle, PKCS7_add1_attrib_digest_procname);
  FuncLoadError := not assigned(PKCS7_add1_attrib_digest);
  if FuncLoadError then
  begin
    {$if not defined(PKCS7_add1_attrib_digest_allownil)}
    PKCS7_add1_attrib_digest := @ERR_PKCS7_add1_attrib_digest;
    {$ifend}
    {$if declared(PKCS7_add1_attrib_digest_introduced)}
    if LibVersion < PKCS7_add1_attrib_digest_introduced then
    begin
      {$if declared(FC_PKCS7_add1_attrib_digest)}
      PKCS7_add1_attrib_digest := @FC_PKCS7_add1_attrib_digest;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(PKCS7_add1_attrib_digest_removed)}
    if PKCS7_add1_attrib_digest_removed <= LibVersion then
    begin
      {$if declared(_PKCS7_add1_attrib_digest)}
      PKCS7_add1_attrib_digest := @_PKCS7_add1_attrib_digest;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(PKCS7_add1_attrib_digest_allownil)}
    if FuncLoadError then
      AFailed.Add('PKCS7_add1_attrib_digest');
    {$ifend}
  end;


  SMIME_write_PKCS7 := LoadLibFunction(ADllHandle, SMIME_write_PKCS7_procname);
  FuncLoadError := not assigned(SMIME_write_PKCS7);
  if FuncLoadError then
  begin
    {$if not defined(SMIME_write_PKCS7_allownil)}
    SMIME_write_PKCS7 := @ERR_SMIME_write_PKCS7;
    {$ifend}
    {$if declared(SMIME_write_PKCS7_introduced)}
    if LibVersion < SMIME_write_PKCS7_introduced then
    begin
      {$if declared(FC_SMIME_write_PKCS7)}
      SMIME_write_PKCS7 := @FC_SMIME_write_PKCS7;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(SMIME_write_PKCS7_removed)}
    if SMIME_write_PKCS7_removed <= LibVersion then
    begin
      {$if declared(_SMIME_write_PKCS7)}
      SMIME_write_PKCS7 := @_SMIME_write_PKCS7;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(SMIME_write_PKCS7_allownil)}
    if FuncLoadError then
      AFailed.Add('SMIME_write_PKCS7');
    {$ifend}
  end;


  SMIME_read_PKCS7 := LoadLibFunction(ADllHandle, SMIME_read_PKCS7_procname);
  FuncLoadError := not assigned(SMIME_read_PKCS7);
  if FuncLoadError then
  begin
    {$if not defined(SMIME_read_PKCS7_allownil)}
    SMIME_read_PKCS7 := @ERR_SMIME_read_PKCS7;
    {$ifend}
    {$if declared(SMIME_read_PKCS7_introduced)}
    if LibVersion < SMIME_read_PKCS7_introduced then
    begin
      {$if declared(FC_SMIME_read_PKCS7)}
      SMIME_read_PKCS7 := @FC_SMIME_read_PKCS7;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(SMIME_read_PKCS7_removed)}
    if SMIME_read_PKCS7_removed <= LibVersion then
    begin
      {$if declared(_SMIME_read_PKCS7)}
      SMIME_read_PKCS7 := @_SMIME_read_PKCS7;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(SMIME_read_PKCS7_allownil)}
    if FuncLoadError then
      AFailed.Add('SMIME_read_PKCS7');
    {$ifend}
  end;


  BIO_new_PKCS7 := LoadLibFunction(ADllHandle, BIO_new_PKCS7_procname);
  FuncLoadError := not assigned(BIO_new_PKCS7);
  if FuncLoadError then
  begin
    {$if not defined(BIO_new_PKCS7_allownil)}
    BIO_new_PKCS7 := @ERR_BIO_new_PKCS7;
    {$ifend}
    {$if declared(BIO_new_PKCS7_introduced)}
    if LibVersion < BIO_new_PKCS7_introduced then
    begin
      {$if declared(FC_BIO_new_PKCS7)}
      BIO_new_PKCS7 := @FC_BIO_new_PKCS7;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if declared(BIO_new_PKCS7_removed)}
    if BIO_new_PKCS7_removed <= LibVersion then
    begin
      {$if declared(_BIO_new_PKCS7)}
      BIO_new_PKCS7 := @_BIO_new_PKCS7;
      {$ifend}
      FuncLoadError := false;
    end;
    {$ifend}
    {$if not defined(BIO_new_PKCS7_allownil)}
    if FuncLoadError then
      AFailed.Add('BIO_new_PKCS7');
    {$ifend}
  end;


end;

{$i TaurusTLSUnusedParamOn.inc}

procedure Unload;
begin
  PKCS7_ISSUER_AND_SERIAL_digest := nil;
  PKCS7_dup := nil;
  d2i_PKCS7_bio := nil;
  i2d_PKCS7_bio := nil;
  i2d_PKCS7_bio_stream := nil;
  PEM_write_bio_PKCS7_stream := nil;
  PKCS7_SIGNER_INFO_new := nil;
  PKCS7_SIGNER_INFO_free := nil;
  d2i_PKCS7_SIGNER_INFO := nil;
  i2d_PKCS7_SIGNER_INFO := nil;
  PKCS7_SIGNER_INFO_it := nil;
  PKCS7_RECIP_INFO_new := nil;
  PKCS7_RECIP_INFO_free := nil;
  d2i_PKCS7_RECIP_INFO := nil;
  i2d_PKCS7_RECIP_INFO := nil;
  PKCS7_RECIP_INFO_it := nil;
  PKCS7_SIGNED_new := nil;
  PKCS7_SIGNED_free := nil;
  d2i_PKCS7_SIGNED := nil;
  i2d_PKCS7_SIGNED := nil;
  PKCS7_SIGNED_it := nil;
  PKCS7_ENC_CONTENT_new := nil;
  PKCS7_ENC_CONTENT_free := nil;
  d2i_PKCS7_ENC_CONTENT := nil;
  i2d_PKCS7_ENC_CONTENT := nil;
  PKCS7_ENC_CONTENT_it := nil;

  PKCS7_ctrl := nil;
  PKCS7_set_type := nil;
  PKCS7_set0_type_other := nil;
  PKCS7_set_content := nil;
  PKCS7_SIGNER_INFO_set := nil;
  PKCS7_SIGNER_INFO_sign := nil;
  PKCS7_add_signer := nil;
  PKCS7_add_certificate := nil;
  PKCS7_add_crl := nil;
  PKCS7_content_new := nil;
  PKCS7_dataVerify := nil;
  PKCS7_signatureVerify := nil;
  PKCS7_set_signed_attributes := nil;
  PKCS7_dataInit := nil;
  PKCS7_dataFinal := nil;
  PKCS7_dataDecode := nil;
  PKCS7_add_signature := nil;
  PKCS7_cert_from_signer_info := nil;
  PKCS7_set_digest := nil;
  PKCS7_get_signer_info := nil;
  PKCS7_add_recipient := nil;
  PKCS7_SIGNER_INFO_get0_algs := nil;
  PKCS7_RECIP_INFO_get0_alg := nil;
  PKCS7_add_recipient_info := nil;
  PKCS7_RECIP_INFO_set := nil;
  PKCS7_set_cipher := nil;
  PKCS7_stream := nil;
  PKCS7_get_issuer_and_serial := nil;
  PKCS7_digest_from_attributes := nil;
  PKCS7_add_signed_attribute := nil;
  PKCS7_add_attribute := nil;
  PKCS7_get_attribute := nil;
  PKCS7_get_signed_attribute := nil;
  PKCS7_sign_add_signer := nil;
  PKCS7_final := nil;
  PKCS7_verify := nil;
  PKCS7_get0_signers := nil;
  PKCS7_decrypt := nil;
  PKCS7_encrypt := nil;
  PKCS7_add_attrib_smimecap := nil;
  PKCS7_simple_smimecap := nil;
  PKCS7_get_smimecap := nil;
  PKCS7_add_attrib_content_type := nil;
  PKCS7_add0_attrib_signing_time := nil;
  PKCS7_add1_attrib_digest := nil;
  SMIME_write_PKCS7 := nil;
  SMIME_read_PKCS7 := nil;
  BIO_new_PKCS7 := nil;
end;
{$ELSE}
{$ENDIF}

{$IFNDEF OPENSSL_STATIC_LINK_MODEL}
initialization
  Register_SSLLoader(@Load,'LibCrypto');
  Register_SSLUnloader(@Unload);
{$ENDIF}
end.

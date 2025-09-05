/// <exclude />
  (* This unit was generated using the script genTaurusTLSHdrs.sh from the source file TaurusTLSHeaders_ossl_typ.h2pas
     It should not be modified directly. All changes should be made to TaurusTLSHeaders_ossl_typ.h2pas
     and this file regenerated. TaurusTLSHeaders_ossl_typ.h2pas is distributed with the full Indy
     Distribution.
   *)
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
{$I TaurusTLSCompilerDefines.inc}

unit TaurusTLSHeaders_types;

interface

{$I TaurusTLSLinkDefines.inc}

// Headers for OpenSSL 1.1.1
// ossl_typ.h


uses
  IdCTypes,
  IdGlobal;

type
{$IF NOT DECLARED(TIdC_SIZET)}
  {$IFDEF HAS_SIZE_T}
  TIdC_SIZET = size_t;
  {$ELSE}
    {$IFDEF HAS_PtrUInt}
  TIdC_SIZET = PtrUInt;
    {$ELSE}
      {$IFDEF CPU32}
  TIdC_SIZET = TIdC_UINT32;
      {$ENDIF}
      {$IFDEF CPU64}
  TIdC_SIZET = TIdC_UINT64;
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
{$IFEND}
{$IF NOT DECLARED(PIdC_SIZET)}
  {$IF DECLARED(PSIZE_T)}
  PIdC_SIZET = psize_t;
  {$ELSE}
  PIdC_SIZET = ^TIdC_SIZET;
  {$IFEND}
{$IFEND}
{$IF NOT DECLARED(TIdC_SSIZET)}
  {$IFDEF HAS_SSIZE_T}
  TIdC_SSIZET = ssize_t;
  {$ELSE}
    {$IFDEF HAS_PtrInt}
  TIdC_SSIZET = PtrInt;
    {$ELSE}
      {$IFDEF CPU32}
  TIdC_SSIZET = TIdC_INT32;
      {$ENDIF}
      {$IFDEF CPU64}
  TIdC_SSIZET = TIdC_INT64;
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
{$IFEND}
{$IF NOT DECLARED(PIdC_SSIZET)}
  {$IFDEF HAS_PSSIZE_T}
  // in ptypes.inc, pssize_t is missing, but pSSize is present, and it is defined as ^ssize_t...
  PIdC_SSIZET = {pssize_t}pSSize;
  {$ELSE}
  PIdC_SSIZET = ^TIdC_SSIZET;
  {$ENDIF}
{$IFEND}
{$IF NOT DECLARED(TIdC_TIMET)}
  {$IFDEF HAS_TIME_T}
  TIdC_TIMET = time_t;
  {$ELSE}
    {$IFDEF HAS_PtrInt}
  TIdC_TIMET = PtrInt;
    {$ELSE}
      {$IFDEF CPU32}
  TIdC_TIMET = TIdC_INT32;
      {$ENDIF}
      {$IFDEF CPU64}
  TIdC_TIMET = TIdC_INT64;
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
{$IFEND}
{$IF NOT DECLARED(PIdC_TIMET)}
  {$IFDEF HAS_PTIME_T}
  PIdC_TIMET = ptime_t;
  {$ELSE}
  PIdC_TIMET = ^TIdC_TIMET;
  {$ENDIF}
{$IFEND}
{$IF NOT DECLARED(PByte)}
  PByte = ^Byte;
{$IFEND}
{$IF NOT DECLARED(PPByte)}
    PPByte = ^PByte;
{$IFEND}
{$IF NOT DECLARED(PPPByte)}
  PPPByte = ^PPByte;
{$IFEND}
{$IF NOT DECLARED(PPIdC_INT)}
  PPIdC_INT = ^PIdC_INT;
{$IFEND}
{$IF NOT DECLARED(TIdAnsiChar)}
  TIdAnsiChar = AnsiChar;
{$IFEND}
{$IF NOT DECLARED(PIdAnsiChar)}
  PIdAnsiChar = PAnsiChar;
{$IFEND}
{$IF NOT DECLARED(PPIdAnsiChar)}
  {$IFDEF HAS_PPAnsiChar}
  PPIdAnsiChar = PPAnsiChar;
  {$ELSE}
  PPIdAnsiChar = ^PIdAnsiChar;
  {$ENDIF}
{$IFEND}
{$IF NOT DECLARED(PPPIdAnsiChar)}
  PPPIdAnsiChar = ^PPIdAnsiChar;
{$IFEND}
  TIdC_TM = record
    tm_sec: TIdC_INT;         (* seconds,  range 0 to 59          *)
    tm_min: TIdC_INT;         (* minutes, range 0 to 59           *)
    tm_hour: TIdC_INT;        (* hours, range 0 to 23             *)
    tm_mday: TIdC_INT;        (* day of the month, range 1 to 31  *)
    tm_mon: TIdC_INT;         (* month, range 0 to 11             *)
    tm_year: TIdC_INT;        (* The number of years since 1900   *)
    tm_wday: TIdC_INT;        (* day of the week, range 0 to 6    *)
    tm_yday: TIdC_INT;        (* day in the year, range 0 to 365  *)
    tm_isdst: TIdC_INT;       (* daylight saving time             *)
  end;
  PIdC_TM = ^TIdC_TM;
  PPIdC_TM = ^PIdC_TM;

// moved from unit "asn1" to prevent circular references
  asn1_string_st = record
    _length: TIdC_INT;
    type_: TIdC_INT;
    data: PByte;
    (*
     * The value of the following field depends on the type being held.  It
     * is mostly being used for BIT_STRING so if the input data has a
     * non-zero 'unused bits' value, it will be handled correctly
     *)
    flags: TIdC_LONG;
  end;

  // moved from asn1
  PASN1_VALUE = type Pointer;
  PPASN1_VALUE = ^PASN1_VALUE;

  // moved from e_os2
  ossl_ssize_t = type {$IFDEF WIN64}TIdC_INT64{$ELSE}TIdC_INT{$ENDIF};

  PASN1_OBJECT = type Pointer;
  PPASN1_OBJECT = ^PASN1_OBJECT;

  ASN1_INTEGER = type asn1_string_st;
  PASN1_INTEGER = ^ASN1_INTEGER;
  PPASN1_INTEGER = ^PASN1_INTEGER;

  ASN1_ENUMERATED = type asn1_string_st;
  PASN1_ENUMERATED = ^ASN1_ENUMERATED;

  ASN1_BIT_STRING = type asn1_string_st;
  PASN1_BIT_STRING = ^ASN1_BIT_STRING;
  PPASN1_BIT_STRING = ^PASN1_BIT_STRING;

  ASN1_OCTET_STRING = type asn1_string_st;
  PASN1_OCTET_STRING = ^ASN1_OCTET_STRING;
  PPASN1_OCTET_STRING = ^PASN1_OCTET_STRING;

  ASN1_PRINTABLESTRING = type asn1_string_st;
  PASN1_PRINTABLESTRING = ^ASN1_PRINTABLESTRING;

  ASN1_T61STRING = type asn1_string_st;
  PASN1_T61STRING = ^ASN1_T61STRING;

  ASN1_IA5STRING = type asn1_string_st;
  PASN1_IA5STRING = ^ASN1_IA5STRING;

  ASN1_GENERALSTRING = type asn1_string_st;
  PASN1_GENERALSTRING = ^ASN1_GENERALSTRING;

  ASN1_UNIVERSALSTRING = type asn1_string_st;
  PASN1_UNIVERSALSTRING = ^ASN1_UNIVERSALSTRING;

  ASN1_BMPSTRING = type asn1_string_st;
  PASN1_BMPSTRING = ^ASN1_BMPSTRING;

  ASN1_UTCTIME = type asn1_string_st;
  PASN1_UTCTIME = ^ASN1_UTCTIME;
  PPASN1_UTCTIME = ^PASN1_UTCTIME;

  ASN1_TIME = type asn1_string_st;
  PASN1_TIME = ^ASN1_TIME;
  PPASN1_TIME = ^PASN1_TIME;

  ASN1_GENERALIZEDTIME = type asn1_string_st;
  PASN1_GENERALIZEDTIME = ^ASN1_GENERALIZEDTIME;
  PPASN1_GENERALIZEDTIME = ^PASN1_GENERALIZEDTIME;

  ASN1_VISIBLESTRING = type asn1_string_st;
  PASN1_VISIBLESTRING = ^ASN1_VISIBLESTRING;

  ASN1_UTF8STRING = type asn1_string_st;
  PASN1_UTF8STRING = ^ASN1_UTF8STRING;

  ASN1_STRING = type asn1_string_st;
  PASN1_STRING = ^ASN1_STRING;
  PPASN1_STRING = ^PASN1_STRING;

  ASN1_BOOLEAN = type TIdC_INT;
  PASN1_BOOLEAN = ^ASN1_BOOLEAN;

  ASN1_NULL = type TIdC_INT;
  PASN1_NULL = ^ASN1_NULL;

  PASN1_ITEM = type Pointer;

  PASN1_PCTX = type Pointer;

  PASN1_SCTX = type Pointer;

  PBIO = type Pointer;
  PPBIO  = type Pointer;
  PBIGNUM = type Pointer;
  PPBIGNUM  = type Pointer;
  PBN_CTX = type Pointer;
  PBN_BLINDING = type Pointer;
  PBN_MONT_CTX = type Pointer;
  PBN_RECP_CTX = type Pointer;
  PBN_GENCB = type Pointer;

  PBUF_MEM = Pointer;

  PEVP_CIPHER = type Pointer;
  PPEVP_CIPHER = ^PEVP_CIPHER;
  PEVP_CIPHER_CTX = type Pointer;
  PEVP_MD = type Pointer;
  PPEVP_MD = ^PEVP_MD;
  PEVP_MD_CTX = type Pointer;

  PEVP_PKEY = type Pointer;
  PPEVP_PKEY = ^PEVP_PKEY;
  PEVP_SKEY = type Pointer;
  PPEVP_SKEY = ^PEVP_SKEY;
  PEVP_PKEY_ASN1_METHOD = type Pointer;
  PPEVP_PKEY_ASN1_METHOD = ^PEVP_PKEY_ASN1_METHOD;

  PEVP_PKEY_METHOD = type Pointer;
  PPEVP_PKEY_METHOD = ^PEVP_PKEY_METHOD;
  PEVP_PKEY_CTX = type Pointer;
  PPEVP_PKEY_CTX = ^PEVP_PKEY_CTX;

  PEVP_ENCODE_CTX = type Pointer;

  PHMAC_CTX = type Pointer;

  PDH = type Pointer;
  PPDH = ^PDH;
  PDH_METHOD = type Pointer;

  PDSA = type Pointer;
  PPDSA = ^PDSA;
  PDSA_METHOD = type Pointer;

  PRSA = type Pointer;
  PPRSA = ^PRSA;
  PRSA_METHOD = type Pointer;

  PEC_KEY = type Pointer;
  PPEC_KEY = ^PEC_KEY;
  PEC_KEY_METHOD = type Pointer;

  PRAND_METHOD = type Pointer;
  PRAND_DRBG = type Pointer;

  PSSL_DANE = type Pointer;
  PX509 = type Pointer;
  PPX509 = ^PX509;
  PStack_Of_X509 = type Pointer;
  PPStack_Of_X509 = ^PStack_Of_X509;
  PX509_CRL = type Pointer;
  PPX509_CRL = ^PX509_CRL;
  PX509_CRL_METHOD = type Pointer;
  PX509_REVOKED = type Pointer;
  PPX509_REVOKED = ^PX509_REVOKED;
  PX509_NAME = type Pointer;
  PPX509_NAME = ^PX509_NAME;
  PX509_PUBKEY = type Pointer;
  PPX509_PUBKEY = ^PX509_PUBKEY;
  PX509_STORE = type Pointer;
  PX509_STORE_CTX = type Pointer;

  PX509_OBJECT = type Pointer;
  PX509_LOOKUP = type Pointer;
  PX509_LOOKUP_METHOD = type Pointer;
  PX509_VERIFY_PARAM = type Pointer;

  PX509_SIG_INFO = type Pointer;

  pkcs8_priv_key_info_st = type Pointer;
  PKCS8_PRIV_KEY_INFO = pkcs8_priv_key_info_st;
  PPKCS8_PRIV_KEY_INFO = ^PKCS8_PRIV_KEY_INFO;
  PPPKCS8_PRIV_KEY_INFO = ^PPKCS8_PRIV_KEY_INFO;

// moved from x509 to prevent circular references
  X509_REQ = type Pointer; // X509_req_st
  PX509_REQ = ^X509_REQ;
  PPX509_REQ = ^PX509_REQ;

// moved from x509v3 to prevent circular references
  (* Context specific info *)
  v3_ext_ctx = record
    flags: TIdC_INT;
    issuer_cert: PX509;
    subject_cert: PX509;
    subject_req: PX509_REQ;
    crl: PX509_CRL;
    db_meth: Pointer; //PX509V3_CONF_METHOD;
    db: Pointer;
  (* Maybe more here *)
  end;
  PX509V3_CTX = type Pointer;
  PCONF = type Pointer;
  POPENSSL_INIT_SETTINGS = type Pointer;

  PUI = type Pointer;
  PUI_METHOD = type Pointer;

  PENGINE = type Pointer;
  PPENGINE = ^PENGINE;
  PSSL = type Pointer;
  PSSL_CTX = type Pointer;
  PPSSL_CTX  = ^PSSL_CTX;

  PCOMP_CTX = type Pointer;
  PCOMP_METHOD = type Pointer;

  PX509_POLICY_NODE = type Pointer;
  PX509_POLICY_LEVEL = type Pointer;
  PX509_POLICY_TREE = type Pointer;
  X509_POLICY_CACHE_st = type Pointer;
  PX509_POLICY_CACHE = type Pointer;

  AUTHORITY_KEYID_st = type Pointer;
  AUTHORITY_KEYID = AUTHORITY_KEYID_st;
  PAUTHORITY_KEYID = ^AUTHORITY_KEYID;
  PDIST_POINT = type Pointer;
  PISSUING_DIST_POINT = type Pointer;
  PNAME_CONSTRAINTS = type Pointer;

  PCRYPTO_EX_DATA = type Pointer;

  POCSP_REQ_CTX = type Pointer;
  POCSP_RESPONSE = type Pointer;
  POCSP_RESPID = type Pointer;

  PSCT = type Pointer;
  PPSCT = ^PSCT;
  PSCT_CTX = type Pointer;
  PCTLOG = type Pointer;
  PPCTLOG = ^PCTLOG;
  PCTLOG_STORE = type Pointer;
  PCT_POLICY_EVAL_CTX = type Pointer;

  POSSL_STORE_INFO = type Pointer;
  POSSL_STORE_SEARCH = type Pointer;

  PEVP_KDF = type Pointer;
  PEVP_KDF_CTX = type Pointer;

// moved from unit "asn1" to prevent circular references'
const
  V_ASN1_UNIVERSAL = $00;
  V_ASN1_APPLICATION = $40;
  V_ASN1_CONTEXT_SPECIFIC = $80;
  V_ASN1_PRIVATE = $c0;

  V_ASN1_CONSTRUCTED = $20;
  V_ASN1_PRIMITIVE_TAG = $1f;
  V_ASN1_PRIMATIVE_TAG = V_ASN1_PRIMITIVE_TAG;

  V_ASN1_APP_CHOOSE = -2; (* let the recipient choose *)
  V_ASN1_OTHER = -3;      (* used in ASN1_TYPE *)
  V_ASN1_ANY = -4;        (* used in ASN1 template code *)

  V_ASN1_UNDEF = -1;
  V_ASN1_EOC =  0;
  V_ASN1_BOOLEAN = 1;
  V_ASN1_INTEGER = 2;
  V_ASN1_BIT_STRING = 3;
  V_ASN1_OCTET_STRING = 4;
  V_ASN1_NULL = 5;
  V_ASN1_OBJECT = 6;
  V_ASN1_OBJECT_DESCRIPTOR = 7;
  V_ASN1_EXTERNAL = 8;
  V_ASN1_REAL = 9;
  V_ASN1_ENUMERATED = 10;
  V_ASN1_UTF8STRING = 12;
  V_ASN1_SEQUENCE = 16;
  V_ASN1_SET = 17;
  V_ASN1_NUMERICSTRING = 18;
  V_ASN1_PRINTABLESTRING = 19;
  V_ASN1_T61STRING = 20;
  V_ASN1_TELETEXSTRING = 20;
  V_ASN1_VIDEOTEXSTRING = 21;
  V_ASN1_IA5STRING = 22;
  V_ASN1_UTCTIME = 23;
  V_ASN1_GENERALIZEDTIME = 24;
  V_ASN1_GRAPHICSTRING = 25;
  V_ASN1_ISO64STRING = 26;
  V_ASN1_VISIBLESTRING = 26;
  V_ASN1_GENERALSTRING = 27;
  V_ASN1_UNIVERSALSTRING = 28;
  V_ASN1_BMPSTRING = 30;

type
  asn1_type_st = record
    case type_: TIdC_INT of
//      (_ptr: PIdAnsichar);
      V_ASN1_BOOLEAN: (_boolean: ASN1_BOOLEAN);
//      (asn1_string: PASN1_STRING);
      V_ASN1_OBJECT: (object_: PASN1_OBJECT);
      V_ASN1_INTEGER: (_integer: PASN1_INTEGER);
      V_ASN1_ENUMERATED: (enumerated: PASN1_ENUMERATED);
      V_ASN1_BIT_STRING: (bit_string: PASN1_BIT_STRING);
      V_ASN1_OCTET_STRING: (octet_string: PASN1_OCTET_STRING);
      V_ASN1_PRINTABLESTRING: (printablestring: PASN1_PRINTABLESTRING);
      V_ASN1_T61STRING: (t61string: PASN1_T61STRING);
      V_ASN1_IA5STRING: (ia5string: PASN1_IA5STRING);
      V_ASN1_GENERALSTRING: (generalstring: PASN1_GENERALSTRING);
      V_ASN1_BMPSTRING: (bmpstring: PASN1_BMPSTRING);
      V_ASN1_UNIVERSALSTRING: (universalstring: PASN1_UNIVERSALSTRING);
      V_ASN1_UTCTIME: (utctime: PASN1_UTCTIME);
      V_ASN1_GENERALIZEDTIME: (generalizedtime: PASN1_GENERALIZEDTIME);
      V_ASN1_VISIBLESTRING: (visiblestring: PASN1_VISIBLESTRING);
      V_ASN1_UTF8STRING: (_utf8string: PASN1_UTF8STRING);
      (*
       * set and sequence are left complete and still contain the set or
       * sequence bytes
       *)
      V_ASN1_SET: (set_: PASN1_STRING);
      V_ASN1_SEQUENCE: (sequence: PASN1_STRING);
//      (asn1_value: PASN1_VALUE);

//      V_ASN1_UNDEF: ;
//      V_ASN1_EOC: ;
//      V_ASN1_NULL: ;
//      V_ASN1_OBJECT_DESCRIPTOR: ;
//      V_ASN1_EXTERNAL: ;
//      V_ASN1_REAL: ;
//      V_ASN1_NUMERICSTRING: ;
//      V_ASN1_TELETEXSTRING: ;
//      V_ASN1_VIDEOTEXSTRING: ;
//      V_ASN1_GRAPHICSTRING: ;
//      V_ASN1_ISO64STRING: ;
  end;
  ASN1_TYPE = asn1_type_st;
  PASN1_TYPE = ^ASN1_TYPE;
  PPASN1_TYPE = ^PASN1_TYPE;

// moved from unit "x509" to prevent circular references
  X509_algor_st = record
    algorithm: PASN1_OBJECT;
    parameter: PASN1_TYPE;
  end; (* X509_ALGOR *)

  X509_ALGOR = X509_algor_st;
  PX509_ALGOR = ^X509_ALGOR;
  PPX509_ALGOR = ^PX509_ALGOR;

  i2d_of_void = type Pointer;
  Pi2d_of_void = ^i2d_of_void;

  d2i_of_void = type Pointer;
  Pd2i_of_void = ^d2i_of_void;

  {OSSL_LIB_CTX is defined in types.h from 3.0.0 onwards}
  //  typedef struct ossl_lib_ctx_st OSSL_LIB_CTX;
  POSSL_LIB_CTX = Pointer;
  POSSL_ENCODER = Pointer;
  POSSL_PROVIDER = Pointer;
  POSSL_DECODER = Pointer;
  POSSL_DECODER_CTX = Pointer;
  OSSL_PARAM = record
  end;
  POSSL_PARAM = ^OSSL_PARAM;
  POSSL_ENCODER_CTX = Pointer;
  pem_password_cb = function(buf: PIdAnsiChar; size: TIdC_INT; rwflag: TIdC_INT; userdata: Pointer): TIdC_INT; cdecl;
  POSSL_ALGORITHM = Pointer;

implementation

end.

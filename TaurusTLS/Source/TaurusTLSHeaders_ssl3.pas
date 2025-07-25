/// <exclude />
  (* This unit was generated using the script genTaurusTLSHdrs.sh from the source file TaurusTLSHeaders_ssl3.h2pas
     It should not be modified directly. All changes should be made to TaurusTLSHeaders_ssl3.h2pas
     and this file regenerated. TaurusTLSHeaders_ssl3.h2pas is distributed with the full Indy
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
unit TaurusTLSHeaders_ssl3;

interface

// Headers for OpenSSL 1.1.1
// ssl3.h


uses
  IdGlobal
  {$IFNDEF FPC}
  , TaurusTLSHeaders_types
  {$ENDIF};

const
  (*
   * Signalling cipher suite value from RFC 5746
   * (TLS_EMPTY_RENEGOTIATION_INFO_SCSV)
   *)
  SSL3_CK_SCSV = $030000FF;

  (*
  * Signalling cipher suite value from draft-ietf-tls-downgrade-scsv-00
  * (TLS_FALLBACK_SCSV)
  *)
  SSL3_CK_FALLBACK_SCSV = $03005600;

  SSL3_CK_RSA_NULL_MD5 = $03000001;
  SSL3_CK_RSA_NULL_SHA = $03000002;
  SSL3_CK_RSA_RC4_40_MD5 = $03000003;
  SSL3_CK_RSA_RC4_128_MD5 = $03000004;
  SSL3_CK_RSA_RC4_128_SHA = $03000005;
  SSL3_CK_RSA_RC2_40_MD5 = $03000006;
  SSL3_CK_RSA_IDEA_128_SHA = $03000007;
  SSL3_CK_RSA_DES_40_CBC_SHA = $03000008;
  SSL3_CK_RSA_DES_64_CBC_SHA = $03000009;
  SSL3_CK_RSA_DES_192_CBC3_SHA = $0300000A;

  SSL3_CK_DH_DSS_DES_40_CBC_SHA = $0300000B;
  SSL3_CK_DH_DSS_DES_64_CBC_SHA = $0300000C;
  SSL3_CK_DH_DSS_DES_192_CBC3_SHA = $0300000D;
  SSL3_CK_DH_RSA_DES_40_CBC_SHA = $0300000E;
  SSL3_CK_DH_RSA_DES_64_CBC_SHA = $0300000F;
  SSL3_CK_DH_RSA_DES_192_CBC3_SHA = $03000010;

  SSL3_CK_DHE_DSS_DES_40_CBC_SHA = $03000011;
  SSL3_CK_EDH_DSS_DES_40_CBC_SHA = SSL3_CK_DHE_DSS_DES_40_CBC_SHA;
  SSL3_CK_DHE_DSS_DES_64_CBC_SHA = $03000012;
  SSL3_CK_EDH_DSS_DES_64_CBC_SHA = SSL3_CK_DHE_DSS_DES_64_CBC_SHA;
  SSL3_CK_DHE_DSS_DES_192_CBC3_SHA = $03000013;
  SSL3_CK_EDH_DSS_DES_192_CBC3_SHA = SSL3_CK_DHE_DSS_DES_192_CBC3_SHA;
  SSL3_CK_DHE_RSA_DES_40_CBC_SHA = $03000014;
  SSL3_CK_EDH_RSA_DES_40_CBC_SHA = SSL3_CK_DHE_RSA_DES_40_CBC_SHA;
  SSL3_CK_DHE_RSA_DES_64_CBC_SHA = $03000015;
  SSL3_CK_EDH_RSA_DES_64_CBC_SHA = SSL3_CK_DHE_RSA_DES_64_CBC_SHA;
  SSL3_CK_DHE_RSA_DES_192_CBC3_SHA = $03000016;
  SSL3_CK_EDH_RSA_DES_192_CBC3_SHA = SSL3_CK_DHE_RSA_DES_192_CBC3_SHA;

  SSL3_CK_ADH_RC4_40_MD5 = $03000017;
  SSL3_CK_ADH_RC4_128_MD5 = $03000018;
  SSL3_CK_ADH_DES_40_CBC_SHA = $03000019;
  SSL3_CK_ADH_DES_64_CBC_SHA = $0300001A;
  SSL3_CK_ADH_DES_192_CBC_SHA = $0300001B;

  (* a bundle of RFC standard cipher names, generated from ssl3_ciphers[] *)
  SSL3_RFC_RSA_NULL_MD5 = 'TLS_RSA_WITH_NULL_MD5';
  SSL3_RFC_RSA_NULL_SHA = 'TLS_RSA_WITH_NULL_SHA';
  SSL3_RFC_RSA_DES_192_CBC3_SHA = 'TLS_RSA_WITH_3DES_EDE_CBC_SHA';
  SSL3_RFC_DHE_DSS_DES_192_CBC3_SHA = 'TLS_DHE_DSS_WITH_3DES_EDE_CBC_SHA';
  SSL3_RFC_DHE_RSA_DES_192_CBC3_SHA = 'TLS_DHE_RSA_WITH_3DES_EDE_CBC_SHA';
  SSL3_RFC_ADH_DES_192_CBC_SHA = 'TLS_DH_anon_WITH_3DES_EDE_CBC_SHA';
  SSL3_RFC_RSA_IDEA_128_SHA = 'TLS_RSA_WITH_IDEA_CBC_SHA';
  SSL3_RFC_RSA_RC4_128_MD5 = 'TLS_RSA_WITH_RC4_128_MD5';
  SSL3_RFC_RSA_RC4_128_SHA = 'TLS_RSA_WITH_RC4_128_SHA';
  SSL3_RFC_ADH_RC4_128_MD5 = 'TLS_DH_anon_WITH_RC4_128_MD5';

  SSL3_TXT_RSA_NULL_MD5 = 'NULL-MD5';
  SSL3_TXT_RSA_NULL_SHA = 'NULL-SHA';
  SSL3_TXT_RSA_RC4_40_MD5 = 'EXP-RC4-MD5';
  SSL3_TXT_RSA_RC4_128_MD5 = 'RC4-MD5';
  SSL3_TXT_RSA_RC4_128_SHA = 'RC4-SHA';
  SSL3_TXT_RSA_RC2_40_MD5 = 'EXP-RC2-CBC-MD5';
  SSL3_TXT_RSA_IDEA_128_SHA = 'IDEA-CBC-SHA';
  SSL3_TXT_RSA_DES_40_CBC_SHA = 'EXP-DES-CBC-SHA';
  SSL3_TXT_RSA_DES_64_CBC_SHA = 'DES-CBC-SHA';
  SSL3_TXT_RSA_DES_192_CBC3_SHA = 'DES-CBC3-SHA';

  SSL3_TXT_DH_DSS_DES_40_CBC_SHA = 'EXP-DH-DSS-DES-CBC-SHA';
  SSL3_TXT_DH_DSS_DES_64_CBC_SHA = 'DH-DSS-DES-CBC-SHA';
  SSL3_TXT_DH_DSS_DES_192_CBC3_SHA = 'DH-DSS-DES-CBC3-SHA';
  SSL3_TXT_DH_RSA_DES_40_CBC_SHA = 'EXP-DH-RSA-DES-CBC-SHA';
  SSL3_TXT_DH_RSA_DES_64_CBC_SHA = 'DH-RSA-DES-CBC-SHA';
  SSL3_TXT_DH_RSA_DES_192_CBC3_SHA = 'DH-RSA-DES-CBC3-SHA';

  SSL3_TXT_DHE_DSS_DES_40_CBC_SHA = 'EXP-DHE-DSS-DES-CBC-SHA';
  SSL3_TXT_DHE_DSS_DES_64_CBC_SHA = 'DHE-DSS-DES-CBC-SHA';
  SSL3_TXT_DHE_DSS_DES_192_CBC3_SHA = 'DHE-DSS-DES-CBC3-SHA';
  SSL3_TXT_DHE_RSA_DES_40_CBC_SHA = 'EXP-DHE-RSA-DES-CBC-SHA';
  SSL3_TXT_DHE_RSA_DES_64_CBC_SHA = 'DHE-RSA-DES-CBC-SHA';
  SSL3_TXT_DHE_RSA_DES_192_CBC3_SHA = 'DHE-RSA-DES-CBC3-SHA';

  (*
   * This next block of six 'EDH' labels is for backward compatibility with
   * older versions of TaurusTLS.  New code should use the six 'DHE' labels above
   * instead:
   *)
  SSL3_TXT_EDH_DSS_DES_40_CBC_SHA = 'EXP-EDH-DSS-DES-CBC-SHA';
  SSL3_TXT_EDH_DSS_DES_64_CBC_SHA = 'EDH-DSS-DES-CBC-SHA';
  SSL3_TXT_EDH_DSS_DES_192_CBC3_SHA = 'EDH-DSS-DES-CBC3-SHA';
  SSL3_TXT_EDH_RSA_DES_40_CBC_SHA = 'EXP-EDH-RSA-DES-CBC-SHA';
  SSL3_TXT_EDH_RSA_DES_64_CBC_SHA = 'EDH-RSA-DES-CBC-SHA';
  SSL3_TXT_EDH_RSA_DES_192_CBC3_SHA = 'EDH-RSA-DES-CBC3-SHA';

  SSL3_TXT_ADH_RC4_40_MD5 = 'EXP-ADH-RC4-MD5';
  SSL3_TXT_ADH_RC4_128_MD5 = 'ADH-RC4-MD5';
  SSL3_TXT_ADH_DES_40_CBC_SHA = 'EXP-ADH-DES-CBC-SHA';
  SSL3_TXT_ADH_DES_64_CBC_SHA = 'ADH-DES-CBC-SHA';
  SSL3_TXT_ADH_DES_192_CBC_SHA = 'ADH-DES-CBC3-SHA';

  SSL3_SSL_SESSION_ID_LENGTH = 32;
  SSL3_MAX_SSL_SESSION_ID_LENGTH = 32;

  SSL3_MASTER_SECRET_SIZE = 48;
  SSL3_RANDOM_SIZE = 32;
  SSL3_SESSION_ID_SIZE = 32;
  SSL3_RT_HEADER_LENGTH = 5;

  SSL3_HM_HEADER_LENGTH = 4;

  (*
   * Some will argue that this increases memory footprint, but it's not
   * actually true. Point is that malloc has to return at least 64-bit aligned
   * pointers, meaning that allocating 5 bytes wastes 3 bytes in either case.
   * Suggested pre-gaping simply moves these wasted bytes from the end of
   * allocated region to its front, but makes data payload aligned, which
   * improves performance:-)
   *)
  SSL3_ALIGN_PAYLOAD = 8;


  (*
   * This is the maximum MAC (digest) size used by the SSL library. Currently
   * maximum of 20 is used by SHA1, but we reserve for future extension for
   * 512-bit hashes.
   *)
  SSL3_RT_MAX_MD_SIZE = 64;

  (*
   * Maximum block size used in all ciphersuites. Currently 16 for AES.
   *)
  SSL_RT_MAX_CIPHER_BLOCK_SIZE = 16;
  SSL3_RT_MAX_EXTRA = 16384;

  (* Maximum plaintext _length: defined by SSL/TLS standards *)
  SSL3_RT_MAX_PLAIN_LENGTH = 16384;
  (* Maximum compression overhead: defined by SSL/TLS standards *)
  SSL3_RT_MAX_COMPRESSED_OVERHEAD = 1024;

  (*
   * The standards give a maximum encryption overhead of 1024 bytes. In
   * practice the value is lower than this. The overhead is the maximum number
   * of padding bytes (256) plus the mac size.
   *)
  SSL3_RT_MAX_ENCRYPTED_OVERHEAD = 256 + SSL3_RT_MAX_MD_SIZE;
  SSL3_RT_MAX_TLS13_ENCRYPTED_OVERHEAD = 256;

  (*
   * TaurusTLS currently only uses a padding length of at most one block so the
   * send overhead is smaller.
   *)
  SSL3_RT_SEND_MAX_ENCRYPTED_OVERHEAD = SSL_RT_MAX_CIPHER_BLOCK_SIZE + SSL3_RT_MAX_MD_SIZE;

  (* If compression isn't used don't include the compression overhead *)
  SSL3_RT_MAX_COMPRESSED_LENGTH = SSL3_RT_MAX_PLAIN_LENGTH;
//  SSL3_RT_MAX_COMPRESSED_LENGTH = (SSL3_RT_MAX_PLAIN_LENGTH + SSL3_RT_MAX_COMPRESSED_OVERHEAD);

  SSL3_RT_MAX_ENCRYPTED_LENGTH = SSL3_RT_MAX_ENCRYPTED_OVERHEAD + SSL3_RT_MAX_COMPRESSED_LENGTH;
  SSL3_RT_MAX_TLS13_ENCRYPTED_LENGTH = SSL3_RT_MAX_PLAIN_LENGTH + SSL3_RT_MAX_TLS13_ENCRYPTED_OVERHEAD;
  SSL3_RT_MAX_PACKET_SIZE = SSL3_RT_MAX_ENCRYPTED_LENGTH + SSL3_RT_HEADER_LENGTH;

  SSL3_MD_CLIENT_FINISHED_= TIdAnsiChar($43) + TIdAnsiChar($4C) + TIdAnsiChar($4E) + TIdAnsiChar($54);
  SSL3_MD_SERVER_FINISHED_= TIdAnsiChar($53) + TIdAnsiChar($52) + TIdAnsiChar($56) + TIdAnsiChar($52);

  SSL3_VERSION = $0300;
  SSL3_VERSION_MAJOR = $03;
  SSL3_VERSION_MINOR = $00;

  SSL3_RT_CHANGE_CIPHER_SPEC = 20;
  SSL3_RT_ALERT = 21;
  SSL3_RT_HANDSHAKE = 22;
  SSL3_RT_APPLICATION_DATA = 23;
  DTLS1_RT_HEARTBEAT = 24;

  (* Pseudo content types to indicate additional parameters *)
  TLS1_RT_CRYPTO = $1000;
  TLS1_RT_CRYPTO_PREMASTER = TLS1_RT_CRYPTO or $1;
  TLS1_RT_CRYPTO_CLIENT_RANDOM = TLS1_RT_CRYPTO or $2;
  TLS1_RT_CRYPTO_SERVER_RANDOM = TLS1_RT_CRYPTO or $3;
  TLS1_RT_CRYPTO_MASTER = TLS1_RT_CRYPTO or $4;

  TLS1_RT_CRYPTO_READ = $0000;
  TLS1_RT_CRYPTO_WRITE = $0100;
  TLS1_RT_CRYPTO_MAC = TLS1_RT_CRYPTO or $5;
  TLS1_RT_CRYPTO_KEY = TLS1_RT_CRYPTO or $6;
  TLS1_RT_CRYPTO_IV = TLS1_RT_CRYPTO or $7;
  TLS1_RT_CRYPTO_FIXED_IV = TLS1_RT_CRYPTO or $8;

  (* Pseudo content types for SSL/TLS header info *)
  SSL3_RT_HEADER = $100;
  SSL3_RT_INNER_CONTENT_TYPE = $101;

  //* Pseudo content types for QUIC */
  SSL3_RT_QUIC_DATAGRAM           = $200;
  SSL3_RT_QUIC_PACKET             = $201;
  SSL3_RT_QUIC_FRAME_FULL         = $202;
  SSL3_RT_QUIC_FRAME_HEADER       = $203;
  SSL3_RT_QUIC_FRAME_PADDING      = $204;

  SSL3_AL_WARNING = 1;
  SSL3_AL_FATAL = 2;

  SSL3_AD_CLOSE_NOTIFY = 0;
  SSL3_AD_UNEXPECTED_MESSAGE = 10; (* fatal *)
  SSL3_AD_BAD_RECORD_MAC = 20; (* fatal *)
  SSL3_AD_DECOMPRESSION_FAILURE = 30; (* fatal *)
  SSL3_AD_HANDSHAKE_FAILURE = 40; (* fatal *)
  SSL3_AD_NO_CERTIFICATE = 41;
  SSL3_AD_BAD_CERTIFICATE = 42;
  SSL3_AD_UNSUPPORTED_CERTIFICATE = 43;
  SSL3_AD_CERTIFICATE_REVOKED = 44;
  SSL3_AD_CERTIFICATE_EXPIRED = 45;
  SSL3_AD_CERTIFICATE_UNKNOWN = 46;
  SSL3_AD_ILLEGAL_PARAMETER = 47; (* fatal *)

  TLS1_HB_REQUEST = 1;
  TLS1_HB_RESPONSE = 2;

  SSL3_CT_RSA_SIGN = 1;
  SSL3_CT_DSS_SIGN = 2;
  SSL3_CT_RSA_FIXED_DH = 3;
  SSL3_CT_DSS_FIXED_DH = 4;
  SSL3_CT_RSA_EPHEMERAL_DH = 5;
  SSL3_CT_DSS_EPHEMERAL_DH = 6;
  SSL3_CT_FORTEZZA_DMS = 20;

  (*
   * SSL3_CT_NUMBER is used to size arrays and it must be large enough to
   * contain all of the cert types defined for *either* SSLv3 and TLSv1.
   *)
  SSL3_CT_NUMBER = 10;

  (* No longer used as of TaurusTLS 1.1.1 *)
  SSL3_FLAGS_NO_RENEGOTIATE_CIPHERS = $0001;

  (* Removed from TaurusTLS 1.1.0 *)
  TLS1_FLAGS_TLS_PADDING_BUG = $0;
  TLS1_FLAGS_SKIP_CERT_VERIFY = $0010;

  (* Set if we encrypt then mac instead of usual mac then encrypt *)
  TLS1_FLAGS_ENCRYPT_THEN_MAC_READ = $0100;
  TLS1_FLAGS_ENCRYPT_THEN_MAC = TLS1_FLAGS_ENCRYPT_THEN_MAC_READ;


  (* Set if extended master secret extension received from peer *)
  TLS1_FLAGS_RECEIVED_EXTMS = $0200;

  TLS1_FLAGS_ENCRYPT_THEN_MAC_WRITE = $0400;

  TLS1_FLAGS_STATELESS = $0800;

  SSL3_MT_HELLO_REQUEST = 0;
  SSL3_MT_CLIENT_HELLO = 1;
  SSL3_MT_SERVER_HELLO = 2;
  SSL3_MT_NEWSESSION_TICKET = 4;
  SSL3_MT_END_OF_EARLY_DATA = 5;
  SSL3_MT_ENCRYPTED_EXTENSIONS = 8;
  SSL3_MT_CERTIFICATE = 11;
  SSL3_MT_SERVER_KEY_EXCHANGE = 12;
  SSL3_MT_CERTIFICATE_REQUEST = 13;
  SSL3_MT_SERVER_DONE = 14;
  SSL3_MT_CERTIFICATE_VERIFY = 15;
  SSL3_MT_CLIENT_KEY_EXCHANGE = 16;
  SSL3_MT_FINISHED = 20;
  SSL3_MT_CERTIFICATE_URL = 21;
  SSL3_MT_CERTIFICATE_STATUS = 22;
  SSL3_MT_SUPPLEMENTAL_DATA = 23;
  SSL3_MT_KEY_UPDATE = 24;
  SSL3_MT_NEXT_PROTO = 67;
  SSL3_MT_MESSAGE_HASH = 254;
  DTLS1_MT_HELLO_VERIFY_REQUEST = 3;

  (* Dummy message type for handling CCS like a normal handshake message *)
  SSL3_MT_CHANGE_CIPHER_SPEC = $0101;

  SSL3_MT_CCS = 1;

  (* These are used when changing over to a new cipher *)
  SSL3_CC_READ = $001;
  SSL3_CC_WRITE = $002;
  SSL3_CC_CLIENT = $010;
  SSL3_CC_SERVER = $020;
  SSL3_CC_EARLY = $040;
  SSL3_CC_HANDSHAKE = $080;
  SSL3_CC_APPLICATION = $100;
  SSL3_CHANGE_CIPHER_CLIENT_WRITE = SSL3_CC_CLIENT or SSL3_CC_WRITE;
  SSL3_CHANGE_CIPHER_SERVER_READ = SSL3_CC_SERVER or SSL3_CC_READ;
  SSL3_CHANGE_CIPHER_CLIENT_READ = SSL3_CC_CLIENT or SSL3_CC_READ;
  SSL3_CHANGE_CIPHER_SERVER_WRITE = SSL3_CC_SERVER or SSL3_CC_WRITE;

implementation

end.

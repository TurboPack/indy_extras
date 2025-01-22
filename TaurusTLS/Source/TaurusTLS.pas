{ ****************************************************************************** }
{ *  TaurusTLS                                                                 * }
{ *           https://github.com/JPeterMugaas/TaurusTLS                        * }
{ *                                                                            * }
{ *  Copyright (c) 2024 TaurusTLS Developers, All Rights Reserved              * }
{ *                                                                            * }
{ * Portions of this software are Copyright (c) 1993 – 2018,                   * }
{ * Chad Z. Hower (Kudzu) and the Indy Pit Crew – http://www.IndyProject.org/  * }
{ ****************************************************************************** }
{
  Rev 1.41    22/02/2024 AWhyman
  a. Property SSLProtocolVersion added to TSocket. This returns the SSL/TLS protocol
  version that was negotiated when the session was created.

  b. SSL Headers now loaded using the OpenSSLLoader unit in order to support
  OpenSSL 3 and later.

  c. New property TOpenSSLSSLOptions.UseSystemRootCertificateStore. Defaults to true.
  If true then SSL_CTX_set_default_verify_paths is called. This causes the
  certs in OPENSSLDIR/certs to be used for certificate verification

  d. Windows only: if OPENSSL_DONT_USE_WINDOWS_CERT_STORE not defined  and
  TOpenSSLSSLOptions.UseSystemRootCertificateStore is true then
  Windows Root Certificate store is also loaded into SSL Context X.509 certificate store.

  e. Direct access to OpenSSL internal data structures (exposed in earlier versions,
  but now opaque (typically 1.1.1 onwards) now uses getter and setter functions
  provided by later versions of OpenSSL libraries with forwards compatibility
  functions (in appropriate SSL Header unit) used to provide getters and setters
  for earlier versions.

  f. New functions: OPenSSLVersion and OpenSSLDir. These are information access
  that return, respectively, the OpenSSL Version string and the OpenSSL Directory.

  Rev 1.40    03/11/2009 09:04:00  AWinkelsdorf
  Implemented fix for Vista+ SSL_Read and SSL_Write to allow connection
  timeout.

  Rev 1.39    16/02/2005 23:26:08  CCostelloe
  Changed OnVerifyPeer.  Breaks existing implementation of OnVerifyPeer.  See
  long comment near top of file.

  Rev 1.38    1/31/05 6:02:28 PM  RLebeau
  Updated _GetThreadId() callback to reflect changes in IdGlobal unit

  Rev 1.37    7/27/2004 1:54:26 AM  JPMugaas
  Now should use the Intercept property for sends.

  Rev 1.36    2004-05-18 21:38:36  Mattias
  Fixed unload bug

  Rev 1.35    2004-05-07 16:34:26  Mattias
  Implemented  OpenSSL locking callbacks

  Rev 1.34    27/04/2004 9:38:48  HHariri
  Added compiler directive so it works in BCB

  Rev 1.33    4/26/2004 12:41:10 AM  BGooijen
  Fixed WriteDirect

  Rev 1.32    2004.04.08 10:55:30 PM  czhower
  IOHandler changes.

  Rev 1.31    3/7/2004 9:02:58 PM  JPMugaas
  Fixed compiler warning about visibility.

  Rev 1.30    2004.03.07 11:46:40 AM  czhower
  Flushbuffer fix + other minor ones found

  Rev 1.29    2/7/2004 5:50:50 AM  JPMugaas
  Fixed Copyright.

  Rev 1.28    2/6/2004 3:45:56 PM  JPMugaas
  Only a start on NET porting.  This is not finished and will not compile on
  DotNET>

  Rev 1.27    2004.02.03 5:44:24 PM  czhower
  Name changes

  Rev 1.26    1/21/2004 4:03:48 PM  JPMugaas
  InitComponent

  Rev 1.25    1/14/2004 11:39:10 AM  JPMugaas
  Server IOHandler now works.  Accept was commented out.

  Rev 1.24    2003.11.29 10:19:28 AM  czhower
  Updated for core change to InputBuffer.

  Rev 1.23    10/21/2003 10:09:14 AM  JPMugaas
  Intercept enabled.

  Rev 1.22    10/21/2003 09:41:38 AM  JPMugaas
  Updated for new API.  Verified with TIdFTP with active and passive transfers
  as well as clear and protected data channels.

  Rev 1.21    10/21/2003 07:32:38 AM  JPMugaas
  Checked in what I have.  Porting still continues.

  Rev 1.20    10/17/2003 1:08:08 AM  DSiders
  Added localization comments.

  Rev 1.19    2003.10.12 6:36:44 PM  czhower
  Now compiles.

  Rev 1.18    9/19/2003 11:24:58 AM  JPMugaas
  Should compile.

  Rev 1.17    9/18/2003 10:20:32 AM  JPMugaas
  Updated for new API.

  Rev 1.16    2003.07.16 3:26:52 PM  czhower
  Fixed for a core change.

  Rev 1.15    6/30/2003 1:52:22 PM  BGooijen
  Changed for new buffer interface

  Rev 1.14    6/29/2003 5:42:02 PM  BGooijen
  fixed problem in TIdOpenSSLIOHandlerSocket.SetPassThrough that Henrick
  Hellstrom reported

  Rev 1.13    5/7/2003 7:13:00 PM  BGooijen
  changed Connected to BindingAllocated in ReadFromSource

  Rev 1.12    3/30/2003 12:16:40 AM  BGooijen
  bugfixed+ added MakeFTPSvrPort/MakeFTPSvrPasv

  Rev 1.11    3/14/2003 06:56:08 PM  JPMugaas
  Added a clone method to the SSLContext.

  Rev 1.10    3/14/2003 05:29:10 PM  JPMugaas
  Change to prevent an AV when shutting down the FTP Server.

  Rev 1.9    3/14/2003 10:00:38 PM  BGooijen
  Removed TIdServerIOHandlerSSLBase.PeerPassthrough, the ssl is now enabled in
  the server-protocol-files

  Rev 1.8    3/13/2003 11:55:38 AM  JPMugaas
  Updated registration framework to give more information.

  Rev 1.7    3/13/2003 11:07:14 AM  JPMugaas
  OpenSSL classes renamed.

  Rev 1.6    3/13/2003 10:28:16 AM  JPMugaas
  Forgot the reegistration - OOPS!!!

  Rev 1.5    3/13/2003 09:49:42 AM  JPMugaas
  Now uses an abstract SSL base class instead of OpenSSL so 3rd-party vendors
  can plug-in their products.

  Rev 1.4    3/13/2003 10:20:08 AM  BGooijen
  Server side fibers

  Rev 1.3    2003.02.25 3:56:22 AM  czhower

  Rev 1.2    2/5/2003 10:27:46 PM  BGooijen
  Fixed bug in OpenEncodedConnection

  Rev 1.1    2/4/2003 6:31:22 PM  BGooijen
  Fixed for Indy 10

  Rev 1.0    11/13/2002 08:01:24 AM  JPMugaas
}
/// <summary>This unit contains the TTaurusTLSIOHandlerSocket and
/// TTaurusTLSServerIOHandler classes plus helper classes.</summary>
unit TaurusTLS;
{
  Author: Gregor Ibic (gregor.ibic@intelicom.si)
  Copyright: (c) Gregor Ibic, Intelicom d.o.o and Indy Working Group.
}

{
  Indy TaurusTLS now uses the standard TaurusTLS libraries
  for pre-compiled win32 dlls, see:
  http://www.openssl.org/related/binaries.html
  recommended v0.9.8a or later
}

{
  Important information concerning OnVerifyPeer:
  Rev 1.39 of February 2005 deliberately broke the OnVerifyPeer interface,
  which (obviously?) only affects programs that implemented that callback
  as part of the SSL negotiation.  Note that you really should always
  implement OnVerifyPeer, otherwise the certificate of the peer you are
  connecting to is NOT checked to ensure it is valid.

  Prior to this, if the SSL library detected a problem with a certificate
  or the Depth was insufficient (i.e. the "Ok" parameter in VerifyCallback
  is 0 / FALSE), then irrespective of whether your OnVerifyPeer returned True
  or False, the SSL connection would be deliberately failed.

  This created a problem in that even if there was only a very minor
  problem with one of the certificates in the chain (OnVerifyPeer is called
  once for each certificate in the certificate chain), which the user may
  have been happy to accept, the SSL negotiation would be failed.  However,
  changing the code to allow the SSL connection when a user returned True
  for OnVerifyPeer would have meant that existing code which depended on
  automatic rejection of invalid certificates would then be accepting
  invalid certificates, which would have been an unacceptable security
  change.

  Consequently, OnVerifyPeer was changed to deliberately break existing code
  by adding an AOk parameter.  To preserve the previous functionality, your
  OnVerifyPeer event should do "Result := AOk;".  If you wish to consider
  accepting certificates that the SSL library has considered invalid, then
  in your OnVerifyPeer, make sure you satisfy yourself that the certificate
  really is valid and then set Result to True.  In reality, in addition to
  checking AOk, you should always implement code that ensures you are only
  accepting certificates which are valid (at least from your point of view).

  Ciaran Costelloe, ccostelloe@flogas.ie
}
{
  RLebeau 1/12/2011: Breaking OnVerifyPeer event again, this time to add an
  additional AError parameter (patch courtesy of "jvlad", dmda@yandex.ru).
  This helps user code distinquish between Self-signed and invalid certificates.
}

{$I TaurusTLSCompilerDefines.inc}

interface

{$I TaurusTLSLinkDefines.inc}
{$IFDEF WINDOWS}
{$IFNDEF OPENSSL_DONT_USE_WINDOWS_CERT_STORE}
{$DEFINE USE_WINDOWS_CERT_STORE}
{$ENDIF}
{$ENDIF}
{$TYPEDADDRESS OFF}

uses
  // facilitate inlining only.
{$IFDEF WINDOWS}
  Windows,
{$ENDIF}
  Classes,
  IdCTypes,
  IdGlobal,
  IdStackConsts,
  IdSocketHandle,
  IdComponent,
  IdIOHandler,
  IdGlobalProtocols,
  IdThread,
  IdIOHandlerSocket,
  IdSSL,
  IdYarn,
  TaurusTLSExceptionHandlers,
  TaurusTLSHeaders_ossl_typ,
  TaurusTLSHeaders_ssl,
  TaurusTLSHeaders_ssl3,
  TaurusTLSHeaders_tls1,
  TaurusTLS_Utils,
  TaurusTLS_X509,
  TaurusTLSFIPS {Ensure FIPS functions initialised};

{$I TaurusTLSIndyVers.inc}
{$IFDEF HAS_TIdSSLVersion}

const
  /// <summary>SSL 2.0</summary>
  SSLv2 = sslvSSLv2;
  /// <summary>SSL 2.0 or 3.0</summary>
  SSLv23 = sslvSSLv23;
  /// <summary>SSL 3.0</summary>
  SSLv3 = sslvSSLv3;
  /// <summary>TLS 1.0</summary>
  TLSv1 = sslvTLSv1;
  /// <summary>TLS 1.1</summary>
  TLSv1_1 = sslvTLSv1_1;
  /// <summary>TLS 1.2</summary>
  TLSv1_2 = sslvTLSv1_2;
  /// <summary>TLS 1.3</summary>
  TLSv1_3 = sslvTLSv1_3;

type
  /// <summary>Type for specifying a version of the TLS Protocol.</summary>
  TTaurusTLSSSLVersion = TIdSSLVersion;
  /// <summary>Can be one of the following values
  /// <para><c>sslmUnassigned</c> Initial default value</para>
  /// <para><c>sslmClient</c> Use Client method</para>
  /// <para><c>sslmServer</c> Use Server method</para>
  /// <para><c>sslmBoth</c> Use Client/Server method</para>
  /// </summary>
  TTaurusTLSSSLMode = TIdSSLMode;
  /// <summary>Can be one of the following values
  /// <para><c>sslCtxClient</c></para>
  /// <para><c>sslCtxServer</c></para>
  /// </summary>
  TTaurusTLSCtxMode = TIdSSLCtxMode;
{$ELSE}

type
   /// <summary>Type for specifying a version of the TLS Protocol.</summary>
  TTaurusTLSSSLVersion = (
    /// <summary>SSL 2.0</summary>
    SSLv2,
    /// <summary>SSL 2.0 or 3.0</summary>
    SSLv23,
    /// <summary>SSL 3.0</summary>
    SSLv3,
    /// <summary>TLS 1.0</summary>
    TLSv1,
    /// <summary>TLS 1.1</summary>
    TLSv1_1,
    /// <summary>TLS 1.2</summary>
    TLSv1_2,
    /// <summary>TLS 1.3</summary>
    TLSv1_3);
  { May need to update constants below if adding to this set }
  /// <summary>
  /// Type that determines which OpenSSL method should be callled.
  /// </summary>
  TTaurusTLSSSLMode = (
    /// <summary>Initial default value</summary>
    sslmUnassigned,
    /// <summary>Use Client method</summary>
    sslmClient,
    /// <summary>Use Server method</summary>
    sslmServer,
    /// <summary>Use Client/Server method</summary>
    sslmBoth);

  /// <summary>Can be one of the following values
  /// <para><c>sslCtxClient</c></para>
  /// <para><c>sslCtxServer</c></para>
  /// </summary>
  TTaurusTLSCtxMode = (
    /// <summary>Client</summary>
    sslCtxClient,
    /// <summary>Server</summary>
    sslCtxServer);
{$ENDIF}
  /// <summary>Type used to specify a peer verification value.</summary>
  TTaurusTLSVerifyMode = (
    /// <summary>For servers, send certificate.  For clients, verify server certificate.</summary>
    sslvrfPeer,
    /// <summary>For servers, require client certificate</summary>
    sslvrfFailIfNoPeerCert,
    /// <summary>For servers, request client certificate only at initial handshake.  Do not ask for certificate during renegotiation.</summary>
    sslvrfClientOnce,
    /// <summary>For servers, server will not send client certificate request during initial handshake.  Send the request during the SSL_verify_client_post_handshake call.</summary>
    sslvrfPostHandshake);
  /// <summary>Controls the peer verification.  Can contain the following:
  /// <para><c>sslvrfPeer</c> For servers, send certificate.  For clients, verify server certificate.</para>
  /// <para><c>sslvrfFailIfNoPeerCert</c> For servers, require client certificate</para>
  /// <para><c>sslvrfClientOnce</c> For servers, request client certificate only at initial handshake.  Do not ask for certificate during renegotiation.</para>
  /// <para><c>sslvrfPostHandshake</c> For servers, server will not send client certificate request during initial handshake.  Send the request during the SSL_verify_client_post_handshake call.</para>
  /// </summary>
  TTaurusTLSVerifyModeSet = set of TTaurusTLSVerifyMode;
  /// <summary>OpenSSL security level from <c>0</c> (permit anything) to <c>5</c> (most restrictive)
  /// <para><c>0</c> Permit anything</para>
  /// <para><c>1</c> SSL 3.0 or later required.  Cipher must have a minimum of 80 security bits.</para>
  /// <para><c>2</c> TLS 1.0 or later required.  Cipher must have a minimum of 112 security bits.  Compression is disabled.</para>
  /// <para><c>3</c> TLS 1.1 or later required.  Cipher must have a minimum of 128 security bits.  Session tickets are disabled.</para>
  /// <para><c>4</c> TLS 1.2 or later required.  Cipher must have a minimum of 192 security bits.</para>
  /// <para><c>5</c> TLS 1.2 or later required.  Cipher must have a minimum of 256 security bits.</para>
  /// </summary>
  /// <seealso
  /// href="https://docs.openssl.org/3.0/man3/SSL_CTX_set_security_level/#default-callback-behaviour">
  /// default-callback-behaviour
  /// </seealso>
  TTaurusTLSSecurityLevel = 0 .. 5;

const
  /// <summary>The default value for the TSSLOptions.MinTLSVersion property</summary>
  DEF_MIN_TLSVERSION = TLSv1_2;
  /// <summary>The maximum TLS version supported by this library.</summary>
  MAX_SSLVERSION = TLSv1_3;
  /// <summary>The default OpenSSL security level.</summary>
  DEF_SECURITY_LEVEL = 1;
  /// <summary>The default value for TSLLOptions.SecurityLevel property.</summary>
  DEF_VERIFY_HOSTNAME = False;

type
  /// <summary>TLS version reported in the TMsgCallbackEvent callback type.</summary>
  TTaurusMsgCBVer = (
    /// <summary>SSL 3.0 header</summary>
    verSSL3Header,
    /// <summary>TLS 1.0</summary>
    verTLS1,
    /// <summary>TLS 1.1</summary>
    verTLS1_1,
    /// <summary>TLS 1.2</summary>
    verTLS1_2,
    /// <summary>TLS 1.3</summary>
    verTLS1_3,
    /// <summary>DTLS 1.0</summary>
    verDTLS1,
    /// <summary>DTLS 1.2</summary>
    verDTLS1_2,
    /// <summary>DTLS Bad Version</summary>
    verDTLSBadVer,
    /// <summary>QUIC</summary>
    verQUIC,
    /// <summary>TLS Any Version</summary>
    verTLSAny);
  TTaurusTLSIOHandlerSocket = class;
  TTaurusTLSCipher = class;
  /// <summary><c>OnDebugMessage</c> event</summary>
  TMsgCallbackEvent = procedure(ASender: TObject; const AWrite: Boolean;
    AVersion: TTaurusMsgCBVer; AContentType: TIdC_INT; const buf: TIdBytes;
    SSL: PSSL) of object;
  /// <summary><c>OnStatusInfo</c> event</summary>
  TCallbackExEvent = procedure(ASender: TObject; const AsslSocket: PSSL;
    const AWhere, Aret: TIdC_INT; const AType, AMsg: String) of object;
  /// <summary><c>OnSecurityLevel</c> event</summary>
  TSecurityEvent = procedure(ASender: TObject; const AsslSocket: PSSL;
    ACtx: PSSL_CTX; op: TIdC_INT; bits: TIdC_INT; const ACipher: String;
    out VAccepted: Boolean) of object;
  /// <summary><c>OnGetPassword</c> event</summary>
  TPasswordEvent = procedure(ASender: TObject; var VPassword: String;
    const AIsWrite: Boolean) of object;
  /// <summary><c>OnVerifyPeer</c> event</summary>
  TVerifyPeerEvent = function(Certificate: TTaurusTLSX509; const AOk: Boolean;
    const ADepth, AError: Integer): Boolean of object;
  /// <summary><c>OnBeforeConnectz</c> and <c>OnSSLNegotiated</c> events</summary>
  TIOHandlerNotify = procedure(ASender: TTaurusTLSIOHandlerSocket) of object;

  { TTaurusTLSSSLOptions }
  /// <summary>Class that provides properties that effect TLS.
  /// </summary>
  TTaurusTLSSSLOptions = class(TPersistent)
{$IFDEF USE_STRICT_PRIVATE_PROTECTED} strict{$ENDIF} protected
    fUseSystemRootCertificateStore: Boolean;
    fsRootCertFile, fsCertFile, fsKeyFile, fsDHParamsFile: String;
    fMode: TTaurusTLSSSLMode;
    fMinTLSVersion: TTaurusTLSSSLVersion;
    fVerifyDepth: Integer;
    FSecurityLevel: TTaurusTLSSecurityLevel;
    fMethod: TTaurusTLSSSLVersion;
    fVerifyHostname: Boolean;
    fVerifyDirs: String;
    fCipherList: String;
    fVerifyMode: TTaurusTLSVerifyModeSet;
    procedure AssignTo(Destination: TPersistent); override;
    procedure SetMinTLSVersion(const AValue: TTaurusTLSSSLVersion);
    procedure SetSecurityLevel(const AValue: TTaurusTLSSecurityLevel);
  public
    constructor Create;
    // procedure Assign(ASource: TPersistent); override;
  published
    /// <summary>Root certificate file.</summary>
    property RootCertFile: String read fsRootCertFile write fsRootCertFile;
    /// <summary>Client or Server certificate file.</summary>
    property CertFile: String read fsCertFile write fsCertFile;
    /// <summary>Private Key file.</summary>
    property KeyFile: String read fsKeyFile write fsKeyFile;
    /// <summary>DH Parameters file.</summary>
    property DHParamsFile: String read fsDHParamsFile write fsDHParamsFile;
    /// <summary>The Minimum TLS version you will accept.</summary>
    property MinTLSVersion: TTaurusTLSSSLVersion read fMinTLSVersion
      write fMinTLSVersion default DEF_MIN_TLSVERSION;
    /// <summary>
    /// OpenSSL security level from <c>0</c> (permit anything) to <c>5</c> (most
    /// restrictive), It may be one of the following values: <br />
    /// <para>
    /// <c>0</c> Permit anything
    /// </para>
    /// <para>
    /// <c>1</c> SSL 3.0 or later required. Cipher must have a minimum of 80
    /// security bits.
    /// </para>
    /// <para>
    /// <c>2</c> TLS 1.0 or later required. Cipher must have a minimum of 112
    /// security bits. Compression is disabled.
    /// </para>
    /// <para>
    /// <c>3</c> TLS 1.1 or later required. Cipher must have a minimum of 128
    /// security bits. Session tickets are disabled.
    /// </para>
    /// <para>
    /// <c>4</c> TLS 1.2 or later required. Cipher must have a minimum of 192
    /// security bits.
    /// </para>
    /// <para>
    /// <c>5</c> TLS 1.2 or later required. Cipher must have a minimum of 256
    /// security bits.
    /// </para>
    /// </summary>
    /// <seealso
    /// href="https://docs.openssl.org/3.0/man3/SSL_CTX_set_security_level/#default-callback-behaviour">
    /// default-callback-behaviour
    /// </seealso>
    property SecurityLevel: TTaurusTLSSecurityLevel read FSecurityLevel
      write SetSecurityLevel default DEF_SECURITY_LEVEL;
    /// <summary>Determines which OpenSSL method should be callled.</summary>
    property Mode: TTaurusTLSSSLMode read fMode write fMode;
    /// <summary>Controls the peer verification.  Can contain the following:
    /// <para><c>sslvrfPeer</c> For servers, send certificate.  For clients, verify server certificate.</para>
    /// <para><c>sslvrfFailIfNoPeerCert</c> For servers, require client certificate</para>
    /// <para><c>sslvrfClientOnce</c> For servers, request client certificate only at initial handshake.  Do not ask for certificate during renegotiation.</para>
    /// <para><c>sslvrfPostHandshake</c> For servers, server will not send client certificate request during initial handshake.  Send the request during the SSL_verify_client_post_handshake call.</para>
    /// </summary>
    property VerifyMode: TTaurusTLSVerifyModeSet read fVerifyMode
      write fVerifyMode;
    /// <summary>The maximum depth for the certificate chain verification allowed.</summary>
    property VerifyDepth: Integer read fVerifyDepth write fVerifyDepth;
    // property VerifyFile: String read fVerifyFile write fVerifyFile;
    /// <summary>Directories where to load root certificates from separated by colons.</summary>
    /// <remarks>Only the PEM files in the directories are loaded.</remarks>
    property VerifyDirs: String read fVerifyDirs write fVerifyDirs;
    /// <summary>Peer Certificate must match hostname</summary>
    property VerifyHostname: Boolean read fVerifyHostname write fVerifyHostname
      default DEF_VERIFY_HOSTNAME;
    /// <summary>Use system's certificate store to verify certificates.</summary>
    property UseSystemRootCertificateStore: Boolean
      read fUseSystemRootCertificateStore write fUseSystemRootCertificateStore
      default true;
    /// <summary>The list of available ciphers</summary>
    /// <remarks>
    /// <para>Leave empty to use all available ciphers.</para>
    /// </remarks>
    property CipherList: String read fCipherList write fCipherList;
  end;

  { TTaurusTLSContext }

  /// <summary>
  /// The TLS Context encapsolated into an object.
  /// </summary>
  TTaurusTLSContext = class(TObject)
{$IFDEF USE_STRICT_PRIVATE_PROTECTED} strict{$ENDIF} protected
    fUseSystemRootCertificateStore: Boolean;
{$IFDEF USE_OBJECT_ARC}[Weak]
{$ENDIF} FParent: TObject;

    fMode: TTaurusTLSSSLMode;
    fsRootCertFile, fsCertFile, fsKeyFile, fsDHParamsFile: String;
    fVerifyDepth: Integer;
    fVerifyMode: TTaurusTLSVerifyModeSet;
    FSecurityLevel: TTaurusTLSSecurityLevel;
    fMinTLSVersion: TTaurusTLSSSLVersion;

    // fVerifyFile: String;
    fVerifyDirs: String;
    fCipherList: String;
    fContext: PSSL_CTX;
    fStatusInfoOn: Boolean;
    fMessageCBOn: Boolean;
    fSecurityLevelCBOn: Boolean;
    // fPasswordRoutineOn: Boolean;
    fVerifyOn: Boolean;
    fSessionId: Integer;
    fVerifyHostname: Boolean;
{$IFDEF USE_WINDOWS_CERT_STORE}
    procedure LoadWindowsCertStore;
{$ENDIF}
    procedure SetSecurityLevel(const AValue: TTaurusTLSSecurityLevel);
    procedure DestroyContext;
    function GetSSLMethod: PSSL_METHOD;
    function GetVerifyMode: TTaurusTLSVerifyModeSet;
  public
    constructor Create;
    destructor Destroy; override;
    procedure InitContext(CtxMode: TTaurusTLSCtxMode);

    function Clone: TTaurusTLSContext;
    property Context: PSSL_CTX read fContext;
    property Parent: TObject read FParent write FParent;
    property MessageCBOn: Boolean read fMessageCBOn write fMessageCBOn;
    property StatusInfoOn: Boolean read fStatusInfoOn write fStatusInfoOn;
    // property PasswordRoutineOn: Boolean read fPasswordRoutineOn write fPasswordRoutineOn;
    property VerifyOn: Boolean read fVerifyOn write fVerifyOn;
    property SecurityLevelCBOn: Boolean read fSecurityLevelCBOn
      write fSecurityLevelCBOn;
    // THese can't be published in a TObject without a compiler warning.
    // published
    property MinTLSVersion: TTaurusTLSSSLVersion read fMinTLSVersion
      write fMinTLSVersion;
    property Mode: TTaurusTLSSSLMode read fMode write fMode;
    property SecurityLevel: TTaurusTLSSecurityLevel read FSecurityLevel
      write SetSecurityLevel;
    property RootCertFile: String read fsRootCertFile write fsRootCertFile;
    property CertFile: String read fsCertFile write fsCertFile;
    property CipherList: String read fCipherList write fCipherList;
    property KeyFile: String read fsKeyFile write fsKeyFile;
    property DHParamsFile: String read fsDHParamsFile write fsDHParamsFile;
    // property VerifyMode: TTaurusTLSVerifyModeSet read GetVerifyMode write SetVerifyMode;
    // property VerifyFile: String read fVerifyFile write fVerifyFile;
    property UseSystemRootCertificateStore: Boolean
      read fUseSystemRootCertificateStore write fUseSystemRootCertificateStore;
    property VerifyDirs: String read fVerifyDirs write fVerifyDirs;
    property VerifyMode: TTaurusTLSVerifyModeSet read fVerifyMode
      write fVerifyMode;
    property VerifyDepth: Integer read fVerifyDepth write fVerifyDepth;
    property VerifyHostname: Boolean read fVerifyHostname write fVerifyHostname;
  end;

  { TTaurusTLSSocket }
  /// <summary>Properties and methods for dealing with a TLS Socket.</summary>
  TTaurusTLSSocket = class(TObject)
{$IFDEF USE_STRICT_PRIVATE_PROTECTED}strict {$ENDIF}protected
    fSession: PSSL_SESSION;
{$IFDEF USE_OBJECT_ARC}[Weak]
{$ENDIF} FParent: TObject;
    fPeerCert: TTaurusTLSX509;
    fSSL: PSSL;
    fSSLCipher: TTaurusTLSCipher;
    fSSLContext: TTaurusTLSContext;
    fHostName: String;
    fVerifyHostname: Boolean;
    function GetProtocolVersion: TTaurusTLSSSLVersion;
    function GetSSLProtocolVersionStr: string;
    function GetPeerCert: TTaurusTLSX509;

    function GetSSLCipher: TTaurusTLSCipher;
  public
    constructor Create(AParent: TObject);
    destructor Destroy; override;
    /// <summary>Return an error code for the previous I/O operation.</summary>
    /// <param name="retCode">Return code from the previous function.</param>
    /// <returns>The error code</returns>
    function GetSSLError(retCode: Integer): Integer;
    /// <summary>Accept a TLS connection.</summary>
    /// <param name="pHandle">The connection to negotiate TLS with.</param>
    procedure Accept(const pHandle: TIdStackSocketHandle);
    /// <summary>Make a TLS connection.</summary>
    /// <param name="pHandle">The connection to negotiate TLS with.</param>
    procedure Connect(const pHandle: TIdStackSocketHandle);
    /// <summary>Encrypt bytes and send them to the peer.</summary>
    /// <param name="ABuffer">Buffer to encrypt and send.</param>
    /// <param name="AOffset">Offset into buffer.</param>
    /// <param name="ALength">number of bytes to send.</param>
    function Send(const ABuffer: TIdBytes; const AOffset, ALength: TIdC_SIZET)
      : TIdC_SIZET;
    /// <summary>Receives bytes that after they have been decrypted.</summary>
    /// <param name="VBuffer">The buffer for bytes read</param>
    /// <returns>The number of bytes read.</returns>
    function Recv(var VBuffer: TIdBytes): TIdC_SIZET;
    /// <summary>Session ID as a string</summary>
    function GetSessionIDAsString: String;
    /// <summary>OpenSSL SSL object.</summary>
    property SSL: PSSL read fSSL;
    /// <summary>SSL Context for this connection.</summary>
    property SSLContext: TTaurusTLSContext read fSSLContext write fSSLContext;
    /// <summary>The TTaurusTLSIOHandlerSocket or TTaurusTLSServerIOHandler that owns this object.</summary>
    property Parent: TObject read FParent;
    /// <summary>The peer's certificate encapsolated in a TTaurusTLSX509 object.</summary>
    property PeerCert: TTaurusTLSX509 read GetPeerCert;
    /// <summary>TLS Cipher information.</summary>
    property Cipher: TTaurusTLSCipher read GetSSLCipher;
    /// <summary>Name of peer you are connected to.</summary>
    /// <remarks>Used to verify that the Peer Certificate matches the HostName.</remarks>
    property HostName: String read fHostName write fHostName;
    /// <summary>TLS Protocol version in use.</summary>
    property SSLProtocolVersion: TTaurusTLSSSLVersion read GetProtocolVersion;
    /// <summary>TLS Protocol version in use as a string.</summary>
    property SSLProtocolVersionStr: string read GetSSLProtocolVersionStr;
  end;

  ///<summary>
  ///TTaurusTLSIOHandlerSocket and TTaurusTLSServerIOHandler common interface.
  ///  This is here because both classes do not share a common anscestor.  This
  ///  bridges the gap.
  ///</summary>
  ITaurusTLSCallbackHelper = interface(IInterface)
    ['{F79BDC4C-4B26-446A-8EF1-9B0818321FAF}']
    procedure DoOnDebugMessage(const AWrite: Boolean; AVersion: TTaurusMsgCBVer;
      AContentType: TIdC_INT; const buf: TIdBytes; SSL: PSSL);
    function GetPassword(const AIsWrite: Boolean): string;
    procedure StatusInfo(const ASSL: PSSL; AWhere, Aret: TIdC_INT);
    function VerifyPeer(ACertificate: TTaurusTLSX509; const AOk: Boolean;
      const ADepth, AError: Integer): Boolean;
    procedure SecurityLevelCB(const AsslSocket: PSSL; ACtx: PSSL_CTX;
      const op, bits: TIdC_INT; const ACipher: String; out VAccepted: Boolean);
    function GetIOHandlerSelf: TTaurusTLSIOHandlerSocket;
  end;

  /// <summary>TaurusTLS component that enables TLS in a TIdTCPClientCustom descendant.
  /// </summary>
  TTaurusTLSIOHandlerSocket = class(TIdSSLIOHandlerSocketBase,
    ITaurusTLSCallbackHelper)
{$IFDEF USE_STRICT_PRIVATE_PROTECTED} strict{$ENDIF} protected
    fSSLContext: TTaurusTLSContext;
    fSSLOptions: TTaurusTLSSSLOptions;
    fSSLSocket: TTaurusTLSSocket;
    // fPeerCert: TTaurusTLSX509;
    FOnDebugMessage: TMsgCallbackEvent;
    FOnStatusInfo: TCallbackExEvent;
    fOnGetPassword: TPasswordEvent;
    fOnSecurityLevel: TSecurityEvent;
    fOnVerifyPeer: TVerifyPeerEvent;
    // fSSLLayerClosed: Boolean;
    fOnBeforeConnect: TIOHandlerNotify;
    FOnSSLNegotiated: TIOHandlerNotify;
    // function GetPeerCert: TTaurusTLSX509;
    // procedure CreateSSLContext(axMode: TTaurusTLSSSLMode);
    //
    procedure SetPassThrough(const Value: Boolean); override;

    function DoVerifyPeer(Certificate: TTaurusTLSX509; const AOk: Boolean;
      const ADepth, AError: Integer): Boolean;
    function RecvEnc(var VBuffer: TIdBytes): Integer; override;
    function SendEnc(const ABuffer: TIdBytes; const AOffset, ALength: Integer)
      : Integer; override;
    procedure Init;
    procedure OpenEncodedConnection;
    // some overrides from base classes
    procedure InitComponent; override;
    procedure ConnectClient; override;
    function CheckForError(ALastResult: Integer): Integer; override;
    procedure RaiseError(AError: Integer); override;

    { ITaurusTLSCallbackHelper }
    procedure DoOnDebugMessage(const AWrite: Boolean; AVersion: TTaurusMsgCBVer;
      AContentType: TIdC_INT; const buf: TIdBytes; SSL: PSSL);
    function GetPassword(const AIsWrite: Boolean): string;
    procedure StatusInfo(const AsslSocket: PSSL; AWhere, Aret: TIdC_INT);
    function VerifyPeer(ACertificate: TTaurusTLSX509; const AOk: Boolean;
      const ADepth, AError: Integer): Boolean;
    procedure SecurityLevelCB(const AsslSocket: PSSL; ACtx: PSSL_CTX;
      const op, bits: TIdC_INT; const ACipher: String; out VAccepted: Boolean);
    function GetIOHandlerSelf: TTaurusTLSIOHandlerSocket;
{$IFNDEF GETURIHOST_SUPPORTED}
    function GetProxyTargetHost: string;
    function GetURIHost: string;
{$ENDIF}
  public
    destructor Destroy; override;
    // TODO: add an AOwner parameter
    function Clone: TIdSSLIOHandlerSocketBase; override;
    procedure StartSSL; override;
    procedure AfterAccept; override;
    procedure Close; override;
    procedure Open; override;
    function Readable(AMSec: Integer = IdTimeoutDefault): Boolean; override;
    /// <summary>Properties and methods for dealing with the TLS Connection.</summary>
    property SSLSocket: TTaurusTLSSocket read fSSLSocket write fSSLSocket;
    /// <summary>
    /// Occurs before TLS negotiation begins.
    /// </summary>
    /// <param name="ASender">The object that triggers the event.</param>
    property OnBeforeConnect: TIOHandlerNotify read fOnBeforeConnect
      write fOnBeforeConnect;
    property SSLContext: TTaurusTLSContext read fSSLContext write fSSLContext;
    /// <summary>
    /// Occurs when a TLS packet is read or sent.
    /// </summary>
    /// <param name="ASender">The object that triggers the event.</param>
    /// <param name="AWrite">True if packet was written.  False if packet was read.</param>
    /// <param name="AVersion">TLS version of packet.</param>
    /// <param name="AContentType">Integer value may be one of the SSL3_RT_ and TLS1_RT_ content-type constants</param>
    /// <param name="buf">The contents of the packet.</param>
    /// <param name="SSL">The SSL object where the event occurred.</param>
    property OnDebugMessage: TMsgCallbackEvent read FOnDebugMessage
      write FOnDebugMessage;
  published
    /// <summary>
    /// Occurs when TLS negotiation is concluded.
    /// </summary>
    /// <param name="ASender">The object that triggers the event.</param>
    ///
    property OnSSLNegotiated: TIOHandlerNotify read FOnSSLNegotiated
      write FOnSSLNegotiated;
    /// <summary>Properties that effect TLS.
    /// </summary>
    property SSLOptions: TTaurusTLSSSLOptions read fSSLOptions
      write fSSLOptions;
    /// <summary>
    /// Occurs when there is a status message.
    /// </summary>
    /// <param name="ASender">The object that triggers the event.</param>
    /// <param name="AsslSocket">The PSSL value associated with the event.</param>
    /// <param name="AWhere">A set of bitmasks that indicate where the event was called</param>
    /// <param name="Aret">A value indicating a particular message</param>
    /// <param name="AType">The AWhere value represented as a string</param>
    /// <param name="AMsg">The Aret value represented as a string</param>
    property OnStatusInfo: TCallbackExEvent read FOnStatusInfo
      write FOnStatusInfo;
    /// <summary>
    /// Occurs when a password is required.
    /// </summary>
    /// <param name="ASender">The object that triggers the event.</param>
    /// <param name="VPassword">Return value indicating the password.</param>
    /// <param name="AIsWrite">True if the password is written/encrypted and typically the password is prompted for twice to prevent entry error.</param>
    property OnGetPassword: TPasswordEvent read fOnGetPassword
      write fOnGetPassword;
    /// <summary>
    /// Occurs when a connection attempt is made.
    /// </summary>
    /// <param name="ASender">The object that triggers the event.</param>
    /// <param name="AsslSocket">The SSL socket where the event occurred.</param>
    /// <param name="ACtx">The SSL_CTX object where the event occurred.</param>
    /// <param name="op">The operation expressed as an integer.  This is one of the SSL_SECOP_* values.</param>
    /// <param name="bits">Number of security bits the cipher has.</param>
    /// <param name="ACipher">The name of the cipher.</param>
    /// <param name="VAccepted">Return true if you will accept the connection attempt.</param>
    property OnSecurityLevel: TSecurityEvent read fOnSecurityLevel
      write fOnSecurityLevel;
    /// <summary>
    /// Occurs when a certificate is presented for validation.
    /// </summary>
    /// <param name="Certificate">The certificate to be validated.</param>
    /// <param name="AOk">True if the certificat passed validation or False if it failed validation.</param>
    /// <param name="ADepth">The maximum depth of.</param>
    /// <param name="AError">The validation error if the certificate failed validation.</param>
    /// <returns>True if the certificate if you wish to accept the certificate or false if you wish to reject it.</returns>
    property OnVerifyPeer: TVerifyPeerEvent read fOnVerifyPeer
      write fOnVerifyPeer;
  end;

  /// <summary>TaurusTLS component that enables TLS in a TIdCustomTCPServer descendant
  /// </summary>
  TTaurusTLSServerIOHandler = class(TIdServerIOHandlerSSLBase,
    ITaurusTLSCallbackHelper)
{$IFDEF USE_STRICT_PRIVATE_PROTECTED} strict{$ENDIF} protected
    fSSLOptions: TTaurusTLSSSLOptions;
    fSSLContext: TTaurusTLSContext;
    FOnSSLNegotiated: TIOHandlerNotify;
    FOnStatusInfo: TCallbackExEvent;
    fOnSecurityLevel: TSecurityEvent;
    fOnGetPassword: TPasswordEvent;
    FOnDebugMessage: TMsgCallbackEvent;
    fOnVerifyPeer: TVerifyPeerEvent;
    //
    // procedure CreateSSLContext(axMode: TTaurusTLSSSLMode);
    // procedure CreateSSLContext;
    //
    procedure InitComponent; override;

    { ITaurusTLSCallbackHelper }
    procedure DoOnDebugMessage(const AWrite: Boolean; AVersion: TTaurusMsgCBVer;
      AContentType: TIdC_INT; const buf: TIdBytes; SSL: PSSL);
    function GetPassword(const AIsWrite: Boolean): string;
    procedure StatusInfo(const AsslSocket: PSSL; AWhere, Aret: TIdC_INT);
    function VerifyPeer(ACertificate: TTaurusTLSX509; const AOk: Boolean;
      const ADepth, AError: Integer): Boolean;
    procedure SecurityLevelCB(const AsslSocket: PSSL; ACtx: PSSL_CTX;
      const op, bits: TIdC_INT; const ACipher: String; out VAccepted: Boolean);
    function GetIOHandlerSelf: TTaurusTLSIOHandlerSocket;

  public
    procedure Init; override;
    procedure Shutdown; override;
    // AListenerThread is a thread and not a yarn. Its the listener thread.
    function Accept(ASocket: TIdSocketHandle; AListenerThread: TIdThread;
      AYarn: TIdYarn): TIdIOHandler; override;
    // function Accept(ASocket: TIdSocketHandle; AThread: TIdThread) : TIdIOHandler;  override;
    destructor Destroy; override;
    function MakeClientIOHandler: TIdSSLIOHandlerSocketBase; override;
    //
    function MakeFTPSvrPort: TIdSSLIOHandlerSocketBase; override;
    function MakeFTPSvrPasv: TIdSSLIOHandlerSocketBase; override;

    /// <summary>
    /// The SSL Context for the TTaurus​TLSServer​IOHandler​.
    /// </summary>
    property SSLContext: TTaurusTLSContext read fSSLContext;
    /// <summary>
    /// Occurs when a TLS packet is read or sent.
    /// </summary>
    /// <param name="ASender">The object that triggers the event.</param>
    /// <param name="AWrite">True if packet was written.  False if packet was read.</param>
    /// <param name="AVersion">TLS version of packet.</param>
    /// <param name="AContentType">Integer value may be one of the SSL3_RT_ and TLS1_RT_ content-type constants</param>
    /// <param name="buf">The contents of the packet.</param>
    /// <param name="SSL">The SSL object where the event occurred.</param>
    property OnDebugMessage: TMsgCallbackEvent read FOnDebugMessage
      write FOnDebugMessage;
  published
    /// <summary>Properties that effect TLS.
    /// </summary>
    property SSLOptions: TTaurusTLSSSLOptions read fSSLOptions
      write fSSLOptions;
    /// <summary>
    /// Occurs when TLS negotiation is concluded.
    /// </summary>
    /// <param name="ASender">The object that triggers the event.</param>
    property OnSSLNegotiated: TIOHandlerNotify read FOnSSLNegotiated
      write FOnSSLNegotiated;
    /// <summary>
    /// Occurs when there is a status message.
    /// </summary>
    /// <param name="ASender">The object that triggers the event.</param>
    /// <param name="AsslSocket">The PSSL value associated with the event.</param>
    /// <param name="AWhere">A set of bitmasks that indicate where the event was called</param>
    /// <param name="Aret">A value indicating a particular message</param>
    /// <param name="AType">The AWhere value represented as a string</param>
    /// <param name="AMsg">The Aret value represented as a string</param>
    property OnStatusInfo: TCallbackExEvent read FOnStatusInfo
      write FOnStatusInfo;
    /// <summary>
    /// Occurs when a password is required.
    /// </summary>
    /// <param name="ASender">The object that triggers the event.</param>
    /// <param name="VPassword">Return value indicating the password.</param>
    /// <param name="AIsWrite">True if the password is written/encrypted and typically the password is prompted for twice to prevent entry error.</param>
    property OnGetPassword: TPasswordEvent read fOnGetPassword
      write fOnGetPassword;
    /// <summary>
    /// Occurs when a connection attempt is made.
    /// </summary>
    /// <param name="ASender">The object that triggers the event.</param>
    /// <param name="AsslSocket">The SSL socket where the event occurred.</param>
    /// <param name="ACtx">The SSL_CTX object where the event occurred.</param>
    /// <param name="op">The operation expressed as an integer.  This is one of the SSL_SECOP_* values.</param>
    /// <param name="bits">Number of security bits the cipher has.</param>
    /// <param name="ACipher">The name of the cipher.</param>
    /// <param name="VAccepted">Return true if you will accept the connection attempt.</param>
    property OnSecurityLevel: TSecurityEvent read fOnSecurityLevel
      write fOnSecurityLevel;
    /// <summary>
    /// Occurs when a certificate is presented for validation.
    /// </summary>
    /// <param name="Certificate">The certificate to be validated.</param>
    /// <param name="AOk">True if the certificat passed validation or False if it failed validation.</param>
    /// <param name="ADepth">The maximum depth of.</param>
    /// <param name="AError">The validation error if the certificate failed validation.</param>
    /// <returns>True if the certificate if you wish to accept the certificate or false if you wish to reject it.</returns>
    property OnVerifyPeer: TVerifyPeerEvent read fOnVerifyPeer
      write fOnVerifyPeer;
  end;

  /// <summary>TLS Cipher information.</summary>
  TTaurusTLSCipher = class(TObject)
{$IFDEF USE_STRICT_PRIVATE_PROTECTED} strict{$ENDIF} private
    fSSLSocket: TTaurusTLSSocket;
    fSSLCipher: PSSL_CIPHER;
    function GetSSLCipher: PSSL_CIPHER;
    function GetDescription: String;
    function GetName: String;
    function GetBits: Integer;
    function GetVersion: String;
  public
    constructor Create(AOwner: TTaurusTLSSocket);
    destructor Destroy; override;
    // These can't be published without a compiler warning.
    // published
    /// <summary>Description of cipher.</summary>
    property Description: String read GetDescription;
    /// <summary>Name of cipher.</summary>
    property Name: String read GetName;
    /// <summary>Number of bits in cipher.</summary>
    property bits: Integer read GetBits;
    /// <summary>Version of cipher.</summary>
    property Version: String read GetVersion;
  end;

  /// <summary>
  /// Raised if the OpenSSL library failed to load.
  /// </summary>
  ETaurusTLSCouldNotLoadSSLLibrary = class(ETaurusTLSError);
  /// <summary>
  /// Raised if the Mode property is sslmUnassigned when the GetSSLMethod is
  /// called.
  /// </summary>
  ETaurusTLSModeNotSet = class(ETaurusTLSError);
  /// <summary>
  /// Raised if the Session in TTaurusTLSSocket.GetProtocolVersion is nil.
  /// </summary>
  ETaurusTLSSessionCanNotBeNil = class(ETaurusTLSError);
  /// <summary>
  /// Raised if SSL_SESSION_get_protocol_version returned in invalid value.
  /// </summary>
  ETaurusTLSInvalidSessionValue = class(ETaurusTLSError);

  /// <summary>
  /// Raised if SSL_new failed.
  /// </summary>
  ETaurusTLSCreatingSessionError = class(ETaurusTLSError);
  /// <summary>
  /// Raised if SSL_CTX_new_ex failed.
  /// </summary>
  ETaurusTLSCreatingContextError = class(ETaurusTLSAPICryptoError);
  /// <summary>
  /// Raised if the Root Certificate files failed to load.
  /// </summary>
  ETaurusTLSLoadingRootCertError = class(ETaurusTLSAPICryptoError);
  /// <summary>
  /// Raised if the Certificate failed to load.
  /// </summary>
  ETaurusTLSLoadingCertError = class(ETaurusTLSAPICryptoError);
  /// <summary>
  /// Raised if the private key failed to load.
  /// </summary>
  ETaurusTLSLoadingKeyError = class(ETaurusTLSAPICryptoError);
  /// <summary>
  /// Raised if DH parameters file failed to load.
  /// </summary>
  ETaurusTLSLoadingDHParamsError = class(ETaurusTLSAPICryptoError);
  /// <summary>
  /// Raised if SSL_CTX_set_cipher_list failed.
  /// </summary>
  ETaurusTLSSettingCipherError = class(ETaurusTLSAPICryptoError);

  /// <summary>
  /// Raised if SSL_set_fd failed.
  /// </summary>
  ETaurusTLSFDSetError = class(ETaurusTLSAPISSLError);
  /// <summary>
  /// Raised if SSL_set_app_data failed.
  /// </summary>
  ETaurusTLSDataBindingError = class(ETaurusTLSAPISSLError);
  /// <summary>
  /// Raised if SSL_accept fails.
  /// </summary>
  ETaurusTLSAcceptError = class(ETaurusTLSAPISSLError);
  /// <summary>
  /// Raised if the SSL_Connect fails.
  /// </summary>
  ETaurusTLSConnectError = class(ETaurusTLSAPISSLError);
  /// <summary>
  /// Raised if the Certificate Common Name does not match the specified
  /// hostname.
  /// </summary>
  ETaurusTLSCertificateError = class(ETaurusTLSAPISSLError);
{$IFNDEF OPENSSL_NO_TLSEXT}
  /// <summary>
  /// Raised if SSL_set_tlsext_host_name failed.
  /// </summary>
  ETaurusTLSSettingTLSHostNameError = class(ETaurusTLSAPISSLError);
{$ENDIF}
  /// <summary>
  /// Raised if SSL_CTX_set_min_proto_version failed.
  /// </summary>
  ETaurusTLSSettingMinProtocolError = class(ETaurusTLSAPICryptoError);
  /// <summary>
  /// Raised if SSL_CTX_set_max_proto_version failed.
  /// </summary>
  ETaurusTLSSettingMaxProtocolError = class(ETaurusTLSAPICryptoError);

  /// <summary>
  /// Loads the OpenSSL libraries. This is ignored if OpenSSL is loaded by
  /// TaurusTLS statically.
  /// </summary>
  /// <returns>
  /// True if successful or False if it failed.
  /// </returns>
  /// <remarks>
  /// The OpenSSL library is only loaded once. If it is already loaded, True is
  /// returned. True is also returned if the library is statically loaded by
  /// TaurusTLS.
  /// </remarks>
function LoadOpenSSLLibrary: Boolean;
/// <summary>
/// Unloads the OpenSSL libaries. Called when the program terminates. Ignored
/// if TaurusTLS loaded the OpenSSL libraries statically.
/// </summary>
procedure UnLoadOpenSSLLibrary;

/// <summary>
/// The version of OpenSSL that was loaded.
/// </summary>
function OpenSSLVersion: string;
/// <summary>
/// The OpenSSL directory. This is the directory that was configured when
/// OpenSSL was built.
/// </summary>
/// <returns>
/// The OpenSSL directory. Do <b>NOT</b> assume that this is the directory
/// where the library was loaded from.
/// </returns>
function OpenSSLDir: string;

implementation

uses
{$IFDEF HAS_UNIT_Generics_Collections}
  System.Generics.Collections,
{$ENDIF}
{$IFDEF USE_VCL_POSIX}
  Posix.SysTime,
  Posix.Time,
  Posix.Unistd,
{$ENDIF}
  IdFIPS,
  IdResourceStringsProtocols,
  TaurusTLS_ResourceStrings,
  IdStack,
  IdThreadSafe,
{$IFNDEF GETURIHOST_SUPPORTED}
  IdCustomTransparentProxy,
  IdURI,
{$ENDIF}
  SysUtils,
  SyncObjs,
  TaurusTLSHeaders_asn1,
  TaurusTLSHeaders_bn,
  TaurusTLSHeaders_x509_vfy,
  TaurusTLSHeaders_x509v3,
  TaurusTLSHeaders_pkcs12,
  TaurusTLSHeaders_sslerr,
  TaurusTLSHeaders_err,
  TaurusTLSHeaders_evp,
  TaurusTLSHeaders_bio,
  TaurusTLSHeaders_pem,
  TaurusTLSHeaders_stack,
  TaurusTLSHeaders_crypto,
  TaurusTLSHeaders_objects,
  TaurusTLSHeaders_x509,
  TaurusTLS_Files,
  TaurusTLSLoader;

type
  // TODO: TIdThreadSafeObjectList instead?
{$IFDEF HAS_GENERICS_TThreadList}
  TIdCriticalSectionThreadList = TThreadList<TIdCriticalSection>;
  TIdCriticalSectionList = TList<TIdCriticalSection>;
{$ELSE}
  // TODO: flesh out to match TThreadList<TIdCriticalSection> and TList<TIdCriticalSection> on non-Generics compilers
  TIdCriticalSectionThreadList = TThreadList;
  TIdCriticalSectionList = TList;
{$ENDIF}

  // RLebeau 1/24/2019: defining this as a private implementation for now to
  // avoid a change in the public interface above.  This should be rolled into
  // the public interface at some point...
  TTaurusTLSSSLOptions_Internal = class(TTaurusTLSSSLOptions)
  protected
{$IFDEF USE_OBJECT_ARC}[Weak]
{$ENDIF} FParent: TObject;
  public

  end;

var
  SSLIsLoaded: TIdThreadSafeBoolean = nil;
  LockInfoCB: TIdCriticalSection = nil;
  LockPassCB: TIdCriticalSection = nil;
  LockVerifyCB: TIdCriticalSection = nil;
  CallbackLockList: TIdCriticalSectionThreadList = nil;

procedure GetStateVars(const SSLSocket: PSSL; const AWhere, Aret: TIdC_INT;
  out VTypeStr, VMsg: String);
{$IFDEF USE_INLINE}inline; {$ENDIF}
{$IFNDEF USE_INLINE_VAR}
var
  LState, LAlert: String;
{$ENDIF}
begin
{$IFDEF USE_INLINE_VAR}
  var
    LState, LAlert: String;
{$ENDIF}
  VTypeStr := '';
  VMsg := '';
  LState := String(SSL_state_string_long(SSLSocket));
  LAlert := String(SSL_alert_type_string_long(Aret));

  case AWhere of
    SSL_CB_ALERT:
      begin
        VTypeStr := IndyFormat(RSOSSLAlert, [SSL_alert_type_string_long(Aret)]);
        VMsg := LAlert;
      end;
    SSL_CB_READ_ALERT:
      begin
        VTypeStr := IndyFormat(RSOSSLReadAlert,
          [SSL_alert_type_string_long(Aret)]);
        VMsg := LAlert;
      end;
    SSL_CB_WRITE_ALERT:
      begin
        VTypeStr := IndyFormat(RSOSSLWriteAlert, [LAlert]);
        VMsg := String(SSL_alert_desc_string_long(Aret));
      end;
    SSL_CB_ACCEPT_LOOP:
      begin
        VTypeStr := RSOSSLAcceptLoop;
        VMsg := LState;
      end;
    SSL_CB_ACCEPT_EXIT:
      begin
        if Aret < 0 then
        begin
          VTypeStr := RSOSSLAcceptError;
        end
        else
        begin
          if Aret = 0 then
          begin
            VTypeStr := RSOSSLAcceptFailed;
          end
          else
          begin
            VTypeStr := RSOSSLAcceptExit;
          end;
        end;
        VMsg := LState;
      end;
    SSL_CB_CONNECT_LOOP:
      begin
        VTypeStr := RSOSSLConnectLoop;
        VMsg := LState;
      end;
    SSL_CB_CONNECT_EXIT:
      begin
        if Aret < 0 then
        begin
          VTypeStr := RSOSSLConnectError;
        end
        else
        begin
          if Aret = 0 then
          begin
            VTypeStr := RSOSSLConnectFailed
          end
          else
          begin
            VTypeStr := RSOSSLConnectExit;
          end;
        end;
        VMsg := LState;
      end;
    SSL_CB_HANDSHAKE_START:
      begin
        VTypeStr := RSOSSLHandshakeStart;
        VMsg := LState;
      end;
    SSL_CB_HANDSHAKE_DONE:
      begin
        VTypeStr := RSOSSLHandshakeDone;
        VMsg := LState;
      end;
  end;
end;

function SecurityLevelCallback(const s: PSSL; const ctx: PSSL_CTX; op: TIdC_INT;
  bits: TIdC_INT; nid: TIdC_INT; other: Pointer; ex: Pointer): TIdC_INT; cdecl;
var
  LErr: Integer;
  LHelper: ITaurusTLSCallbackHelper;
  LRes: Boolean;

begin
  // Preserve last error just in case TaurusTLS is using it and we do something that
  // clobers it.  CYA.
  LErr := GStack.WSGetLastError;
  try
    LockInfoCB.Enter;
    try
      if Supports(TTaurusTLSContext(ex).Parent, ITaurusTLSCallbackHelper,
        IInterface(LHelper)) then
      begin
        LHelper.SecurityLevelCB(s, ctx, op, bits,
          String(OBJ_nid2ln(nid)), LRes);
      end
      else
      begin
        LRes := true;
      end;
      if LRes then
      begin
        Result := 1;
      end
      else
      begin
        Result := 0;
      end;
    finally
      LockPassCB.Leave;
    end;
  finally
    GStack.WSSetLastError(LErr);
  end;
end;

function PasswordCallback(var buf: PIdAnsiChar; size: TIdC_INT;
  rwflag: TIdC_INT; userdata: Pointer): TIdC_INT; cdecl;
{$IFDEF USE_MARSHALLED_PTRS}
type
  TBytesPtr = ^TBytes;
{$ENDIF}
var
{$IFNDEF USE_INLINE_VAR}
  LPassword: String;
{$ENDIF}
{$IFDEF STRING_IS_UNICODE}
  LBPassword: TIdBytes;
{$ENDIF}
  LErr: Integer;
  LHelper: ITaurusTLSCallbackHelper;
begin
  // Preserve last error just in case TaurusTLS is using it and we do something that
  // clobers it.  CYA.
  LErr := GStack.WSGetLastError;
  try
    LockPassCB.Enter;
    try
{$IFDEF USE_INLINE_VAR}
      var
        LPassword: String;
{$ENDIF}
      if Supports(TTaurusTLSContext(userdata).Parent, ITaurusTLSCallbackHelper,
        IInterface(LHelper)) then
      begin
        LPassword := LHelper.GetPassword(rwflag > 0);
        LHelper := nil;
      end;
      FillChar(buf^, size, 0);
{$IFDEF STRING_IS_UNICODE}
      LBPassword := IndyTextEncoding_OSDefault.GetBytes(LPassword);
      if Length(LBPassword) > 0 then
      begin
{$IFDEF USE_MARSHALLED_PTRS}
        TMarshal.Copy(TBytesPtr(@LBPassword)^, 0, TPtrWrapper.Create(buf),
          IndyMin(Length(LBPassword), size));
{$ELSE}
        Move(LBPassword[0], buf^, IndyMin(Length(LBPassword), size));
{$ENDIF}
      end;
      Result := Length(LBPassword);
{$ELSE}
      StrPLCopy(buf, LPassword, size);
      Result := Length(LPassword);
{$ENDIF}
      buf[size - 1] := #0; // RLebeau: truncate the password if needed
    finally
      LockPassCB.Leave;
    end;
  finally
    GStack.WSSetLastError(LErr);
  end;
end;

procedure InfoCallback(const SSLSocket: PSSL; where, ret: TIdC_INT); cdecl;
var
  LSocket: TTaurusTLSSocket;
  LErr: Integer;
  LHelper: ITaurusTLSCallbackHelper;
begin
  {
    You have to save the value of WSGetLastError as some Operating System API
    function calls will reset that value and we can't know what a programmer will
    do in this event.  We need the value of WSGetLastError so we can report
    an underlying socket error when the OpenSSL function returns.

    Keep LErr even if it is referenced once.
    JPM.
  }
  LErr := GStack.WSGetLastError;
  try
    LockInfoCB.Enter;
    try
      LSocket := TTaurusTLSSocket(SSL_get_app_data(SSLSocket));
      if Supports(LSocket.Parent, ITaurusTLSCallbackHelper, IInterface(LHelper))
      then
      begin
        LHelper.StatusInfo(SSLSocket, where, ret);
        LHelper := nil;
      end;
    finally
      LockInfoCB.Leave;
    end;
  finally
    GStack.WSSetLastError(LErr);
  end;
end;

procedure MsgCallback(write_p, Version, content_type: TIdC_INT;
  const buf: Pointer; len: TIdC_SIZET; SSL: PSSL; arg: Pointer)cdecl;
var
  LErr: Integer;
  LSocket: TTaurusTLSSocket;
  LHelper: ITaurusTLSCallbackHelper;
{$IFNDEF USE_INLINE_VAR}
  LBytes: TIdBytes;
{$ENDIF}
  LVer: TTaurusMsgCBVer;
begin
  {
    You have to save the value of WSGetLastError as some Operating System API
    function calls will reset that value and we can't know what a programmer will
    do in this event.  We need the value of WSGetLastError so we can report
    an underlying socket error when the OpenSSL function returns.

    Keep LErr even if it is referenced once.
    JPM.
  }
  LErr := GStack.WSGetLastError;
  try
    LockVerifyCB.Enter;
    try
      LSocket := TTaurusTLSSocket(arg);
      if Supports(LSocket.Parent, ITaurusTLSCallbackHelper, IInterface(LHelper))
      then
      begin
{$IFDEF USE_INLINE_VAR}
        var
          LBytes: TIdBytes;
{$ENDIF}
{$IFNDEF HAS_RAW_TO_BYTES_64_BIT}
        LBytes := TaurusTLSRawToBytes(buf, len);
{$ELSE}
        LBytes := RawToBytes(buf, len);
{$ENDIF}
        case Version of
          SSL3_VERSION:
            LVer := verSSL3Header;
          TLS1_VERSION:
            LVer := verTLS1;
          TLS1_1_VERSION:
            LVer := verTLS1_1;
          TLS1_2_VERSION:
            LVer := verTLS1_2;
          TLS1_3_VERSION:
            LVer := verTLS1_3;
          DTLS1_VERSION:
            LVer := verDTLS1;
          DTLS1_2_VERSION:
            LVer := verDTLS1_2;
          DTLS1_BAD_VER:
            LVer := verDTLSBadVer;
          OSSL_QUIC1_VERSION:
            LVer := verQUIC;
        else
          LVer := verDTLSBadVer;
        end;
        LHelper.DoOnDebugMessage(write_p > 0, LVer, content_type, LBytes, SSL);
        LHelper := nil;
      end;
    finally
      LockVerifyCB.Leave;
    end;
  finally
    GStack.WSSetLastError(LErr);
  end;
end;

function TranslateInternalVerifyToSSL(Mode: TTaurusTLSVerifyModeSet): Integer;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := SSL_VERIFY_NONE;
  if sslvrfPeer in Mode then
  begin
    Result := Result or SSL_VERIFY_PEER;
    if sslvrfPostHandshake in Mode then
    begin
      Result := Result or SSL_VERIFY_POST_HANDSHAKE;
    end;
    if sslvrfFailIfNoPeerCert in Mode then
    begin
      Result := Result or SSL_VERIFY_FAIL_IF_NO_PEER_CERT;
    end;
    if sslvrfClientOnce in Mode then
    begin
      Result := Result or SSL_VERIFY_CLIENT_ONCE;
    end;
  end;

end;

function VerifyCallback(const preverify_ok: TIdC_INT; x509_ctx: PX509_STORE_CTX)
  : TIdC_INT; cdecl;
var
  Lhcert: PX509;
  LCertificate: TTaurusTLSX509;
  hSSL: PSSL;
  IdSSLSocket: TTaurusTLSSocket;
  // _str: String;
  LVerifiedOK: Boolean;
  LDepth: Integer;
  LError: Integer;
  LPreverifyOK: TIdC_INT;
  LOk: Boolean;
{$IFNDEF USE_INLINE_VAR}
  LHelper: ITaurusTLSCallbackHelper;
{$ENDIF}
  // return
  // 1 - success -Ok
  // 0 - failed
begin
  LPreverifyOK := preverify_ok;
  Result := preverify_ok;
  LockVerifyCB.Enter;
  try
    LVerifiedOK := true;
    try
      hSSL := X509_STORE_CTX_get_app_data(x509_ctx);
      if Assigned(hSSL) then
      begin
        Lhcert := X509_STORE_CTX_get_current_cert(x509_ctx);
        LCertificate := TTaurusTLSX509.Create(Lhcert, False);
        // the certificate is owned by the store
        try
          IdSSLSocket := TTaurusTLSSocket(SSL_get_app_data(hSSL));
          LError := X509_STORE_CTX_get_error(x509_ctx);
          LDepth := X509_STORE_CTX_get_error_depth(x509_ctx);
          if (not(LPreverifyOK > 0)) and
            (IdSSLSocket.SSLContext.VerifyDepth >= LDepth) then
          begin
            LPreverifyOK := 0;
            if LError = X509_V_OK then
            begin
              LError := X509_V_ERR_CERT_CHAIN_TOO_LONG;
            end;
          end;
          LOk := LPreverifyOK = 1;
{$IFDEF USE_INLINE_VAR}
          var
            LHelper: ITaurusTLSCallbackHelper;
{$ENDIF}
          if Supports(IdSSLSocket.Parent, ITaurusTLSCallbackHelper,
            IInterface(LHelper)) then
          begin
            LVerifiedOK := LHelper.VerifyPeer(LCertificate, LOk,
              LDepth, LError);
            LHelper := nil;
          end;
        finally
          FreeAndNil(LCertificate);
        end;
        // if VerifiedOK and (Ok > 0) then begin
        if LVerifiedOK { and (Ok > 0) } then
        begin
          Result := 1;
        end
        else
        begin
          Result := 0;
        end;
        // Result := Ok; // testing
      end;
    except
      // indicate failed
      Result := 0;
    end;
  finally
    LockVerifyCB.Leave;
  end;
end;

{$IFDEF OPENSSL_SET_MEMORY_FUNCS}

function IdMalloc(num: UInt32): Pointer cdecl;
begin
  Result := AllocMem(num);
end;

function IdRealloc(address: Pointer; num: UInt32): Pointer cdecl;
begin
  Result := addr;
  ReallocMem(Result, num);
end;

procedure IdFree(address: Pointer)cdecl;
begin
  FreeMem(addr);
end;

procedure IdSslCryptoMallocInit;
// replaces the actual alloc routines
// this is useful if you are using a memory manager that can report on leaks
// at shutdown time.
var
  r: Integer;
begin
  r := CRYPTO_set_mem_functions(@IdMalloc, @IdRealloc, @IdFree);
  Assert(r <> 0);
end;
{$ENDIF}
{$IFNDEF WIN32_OR_WIN64}

procedure _threadid_func(id: PCRYPTO_THREADID)cdecl;
begin
{$IFNDEF OPENSSL_STATIC_LINK_MODEL}
  if Assigned(CRYPTO_THREADID_set_numeric) then
{$ENDIF}
  begin
    CRYPTO_THREADID_set_numeric(id, TIdC_ULONG(CurrentThreadId));
  end;
end;

function _GetThreadID: TIdC_ULONG; cdecl;
begin
  // TODO: Verify how well this will work with fibers potentially running from
  // thread to thread or many on the same thread.
  Result := TIdC_ULONG(CurrentThreadId);
end;
{$ENDIF}

procedure SslLockingCallback(Mode, n: TIdC_INT; Afile: PIdAnsiChar;
  line: TIdC_INT)cdecl;
var
  Lock: TIdCriticalSection;
  LList: TIdCriticalSectionList;
begin
  Assert(CallbackLockList <> nil);
  Lock := nil;

  LList := CallbackLockList.LockList;
  try
    if n < LList.Count then
    begin
      Lock := {$IFDEF HAS_GENERICS_TList}LList.Items[n]{$ELSE}TIdCriticalSection
        (LList.Items[n]){$ENDIF};
    end;
  finally
    CallbackLockList.UnlockList;
  end;
  Assert(Lock <> nil);
  if (Mode and CRYPTO_LOCK) = CRYPTO_LOCK then
  begin
    Lock.Acquire;
  end
  else
  begin
    Lock.Release;
  end;
end;

procedure PrepareTaurusTLSLocking;
var
  i, cnt: Integer;
  Lock: TIdCriticalSection;
  LList: TIdCriticalSectionList;
begin
  LList := CallbackLockList.LockList;
  try
{$IFNDEF OPENSSL_STATIC_LINK_MODEL}
    if Assigned(CRYPTO_num_locks) then
      cnt := CRYPTO_num_locks
    else
      cnt := 0;
{$ELSE}
    cnt := CRYPTO_num_locks;
{$ENDIF}
    for i := 0 to cnt - 1 do
    begin
      Lock := TIdCriticalSection.Create;
      try
        LList.Add(Lock);
      except
        Lock.Free;
        raise;
      end;
    end;
  finally
    CallbackLockList.UnlockList;
  end;
end;

{
  function RSACallback(sslSocket: PSSL; e: Integer; KeyLength: Integer):PRSA; cdecl;
  const
  RSA: PRSA = nil;
  var
  SSLSocket: TSSLWSocket;
  IdSSLSocket: TTaurusTLSSocket;
  begin
  IdSSLSocket := TTaurusTLSSocket(IdSslGetAppData(sslSocket));

  if Assigned(IdSSLSocket) then begin
  IdSSLSocket.TriggerSSLRSACallback(KeyLength);
  end;

  Result := RSA_generate_key(KeyLength, RSA_F4, @RSAProgressCallback, ssl);
  end;
}

function LoadOpenSSLLibrary: Boolean;
begin
  Assert(SSLIsLoaded <> nil);
  SSLIsLoaded.Lock;
  try
    if SSLIsLoaded.Value then
    begin
      Result := true;
      Exit;
    end;
{$IFNDEF OPENSSL_STATIC_LINK_MODEL}
    Result := GetOpenSSLLoader.Load;
    if not Result then
      Exit;
{$ENDIF}
{$IFDEF OPENSSL_SET_MEMORY_FUNCS}
    // has to be done before anything that uses memory
    IdSslCryptoMallocInit;
{$ENDIF}
    OPENSSL_init_ssl(OPENSSL_INIT_LOAD_SSL_STRINGS or
      OPENSSL_INIT_ADD_ALL_CIPHERS or OPENSSL_INIT_ADD_ALL_DIGESTS or
      OPENSSL_INIT_LOAD_CRYPTO_STRINGS or OPENSSL_INIT_LOAD_CONFIG or
      OPENSSL_INIT_ASYNC or OPENSSL_INIT_ENGINE_ALL_BUILTIN, nil);

    SSL_load_error_strings;
    // Create locking structures, we need them for callback routines
    Assert(LockInfoCB = nil);
    LockInfoCB := TIdCriticalSection.Create;
    LockPassCB := TIdCriticalSection.Create;
    LockVerifyCB := TIdCriticalSection.Create;
    // Handle internal TaurusTLS locking
    CallbackLockList := TIdCriticalSectionThreadList.Create;
    PrepareTaurusTLSLocking;
    CRYPTO_set_locking_callback(@SslLockingCallback);
{$IFNDEF WIN32_OR_WIN64}
{$IFNDEF OPENSSL_STATIC_LINK_MODEL}
    if Assigned(CRYPTO_THREADID_set_callback) then
    begin
      CRYPTO_THREADID_set_callback(@_threadid_func);
    end
    else
    begin
      CRYPTO_set_id_callback(@_GetThreadID);
    end;
{$ELSE}
    CRYPTO_THREADID_set_callback(@_threadid_func);
{$ENDIF}
{$ENDIF}
    SSLIsLoaded.Value := true;
    Result := true;
  finally
    SSLIsLoaded.Unlock;
  end;

end;

procedure UnLoadOpenSSLLibrary;
{$IFNDEF USE_OBJECT_ARC}
var
  i: Integer;
  LList: TIdCriticalSectionList;
{$ENDIF}
begin
  SSLIsLoaded.Lock;
  try
    if SSLIsLoaded.Value then
    begin
      SSL_load_error_strings;
{$IFNDEF OPENSSL_STATIC_LINK_MODEL}
      if Assigned(CRYPTO_set_locking_callback) then
{$ENDIF}
        CRYPTO_set_locking_callback(nil);

      // <-- RLebeau: why is this here and not in IdSSLTaurusTLSHeaders.Unload()?
{$IFNDEF OPENSSL_STATIC_LINK_MODEL}
      GetOpenSSLLoader.Unload;
{$ENDIF}
      FreeAndNil(LockInfoCB);
      FreeAndNil(LockPassCB);
      FreeAndNil(LockVerifyCB);
      if Assigned(CallbackLockList) then
      begin
{$IFDEF USE_OBJECT_ARC}
        CallbackLockList.Clear; // Items are auto-freed
{$ELSE}
        LList := CallbackLockList.LockList;

        begin
          try
            for i := 0 to LList.Count - 1 do
            begin
{$IFDEF HAS_GENERICS_TList}LList.Items[i]{$ELSE}TIdCriticalSection(LList.Items[i]){$ENDIF}.Free;
            end;
            LList.Clear;
          finally
            CallbackLockList.UnlockList;
          end;
        end;
{$ENDIF}
        FreeAndNil(CallbackLockList);
      end;
      SSLIsLoaded.Value := False;
    end;
  finally
    SSLIsLoaded.Unlock;
  end;
end;

function OpenSSLVersion: string;
begin
  Result := '';
  // RLebeau 9/7/2015: even if LoadOpenSSLLibrary() fails, _SSLeay_version()
  // might have been loaded OK before the failure occured. LoadOpenSSLLibrary()
  // does not unload ..
  LoadOpenSSLLibrary;
{$IFNDEF OPENSSL_STATIC_LINK_MODEL}
  if Assigned(SSLeay_version) then
{$ENDIF}
    Result := String(SSLeay_version(SSLEAY_VERSION_CONST));
end;

function OpenSSLDir: string;
var
  i: Integer;
begin
  Result := '';
  LoadOpenSSLLibrary;
{$IFNDEF OPENSSL_STATIC_LINK_MODEL}
  if Assigned(SSLeay_version) then
{$ENDIF}
    Result := String(SSLeay_version(OPENSSL_DIR));
  { assumed format is 'OPENSSLDIR: "<dir>"' }
  i := Pos('"', Result);
  if i < 0 then
    Result := ''
  else
  begin
    Delete(Result, 1, i);
    i := Pos('"', Result);
    if i < 0 then
      Result := ''
    else
      Delete(Result, i, Length(Result) - i + 1);
  end;
end;

/// ///////////////////////////////////////////////////
// TTaurusTLSSSLOptions
/// ////////////////////////////////////////////////////

constructor TTaurusTLSSSLOptions.Create;
begin
  inherited Create;
  fMinTLSVersion := DEF_MIN_TLSVERSION;
  fUseSystemRootCertificateStore := true;
  FSecurityLevel := DEF_SECURITY_LEVEL;
  fVerifyHostname := DEF_VERIFY_HOSTNAME;
end;

procedure TTaurusTLSSSLOptions.SetMinTLSVersion(const AValue
  : TTaurusTLSSSLVersion);
begin
  fMinTLSVersion := AValue;
end;

procedure TTaurusTLSSSLOptions.SetSecurityLevel(const AValue
  : TTaurusTLSSecurityLevel);
begin
  FSecurityLevel := AValue;
end;

procedure TTaurusTLSSSLOptions.AssignTo(Destination: TPersistent);
var
  LDest: TTaurusTLSSSLOptions;
begin
  if Destination is TTaurusTLSSSLOptions then
  begin
    LDest := TTaurusTLSSSLOptions(Destination);
    LDest.RootCertFile := RootCertFile;
    LDest.CertFile := CertFile;
    LDest.KeyFile := KeyFile;
    LDest.DHParamsFile := DHParamsFile;
    LDest.SecurityLevel := SecurityLevel;
    LDest.MinTLSVersion := MinTLSVersion;
    LDest.Mode := Mode;
    LDest.VerifyMode := VerifyMode;
    LDest.VerifyDepth := VerifyDepth;
    LDest.VerifyHostname := VerifyHostname;
    LDest.fUseSystemRootCertificateStore := fUseSystemRootCertificateStore;
    LDest.VerifyDirs := VerifyDirs;
    LDest.CipherList := CipherList;
  end
  else
  begin
    inherited AssignTo(Destination);
  end;
end;

/// ////////////////////////////////////////////////////
// TTaurusTLSServerIOHandler
/// ////////////////////////////////////////////////////

{ TTaurusTLSServerIOHandler }

procedure TTaurusTLSServerIOHandler.InitComponent;
begin
  inherited InitComponent;
  fSSLOptions := TTaurusTLSSSLOptions_Internal.Create;
  TTaurusTLSSSLOptions_Internal(fSSLOptions).FParent := Self;
end;

destructor TTaurusTLSServerIOHandler.Destroy;
begin
  FreeAndNil(fSSLOptions);
  inherited Destroy;
end;

procedure TTaurusTLSServerIOHandler.DoOnDebugMessage(const AWrite: Boolean;
  AVersion: TTaurusMsgCBVer; AContentType: TIdC_INT; const buf: TIdBytes;
  SSL: PSSL);
begin
  if Assigned(FOnDebugMessage) then
  begin
    FOnDebugMessage(Self, AWrite, AVersion, AContentType, buf, SSL);
  end;
end;

procedure TTaurusTLSServerIOHandler.Init;
// see also TTaurusTLSIOHandlerSocket.Init
begin
  // ensure Init isn't called twice
  Assert(fSSLContext = nil);
  fSSLContext := TTaurusTLSContext.Create;
  fSSLContext.Parent := Self;
  fSSLContext.RootCertFile := SSLOptions.RootCertFile;
  fSSLContext.CertFile := SSLOptions.CertFile;
  fSSLContext.KeyFile := SSLOptions.KeyFile;
  fSSLContext.DHParamsFile := SSLOptions.DHParamsFile;
  fSSLContext.VerifyDepth := SSLOptions.VerifyDepth;
  fSSLContext.VerifyMode := SSLOptions.VerifyMode;
  // fSSLContext.fVerifyFile := SSLOptions.fVerifyFile;
  fSSLContext.UseSystemRootCertificateStore :=
    SSLOptions.UseSystemRootCertificateStore;
  fSSLContext.VerifyDirs := SSLOptions.VerifyDirs;
  fSSLContext.VerifyHostname := SSLOptions.VerifyHostname;
  fSSLContext.CipherList := SSLOptions.CipherList;
  fSSLContext.VerifyOn := Assigned(fOnVerifyPeer);
  fSSLContext.StatusInfoOn := Assigned(FOnStatusInfo);
  fSSLContext.SecurityLevelCBOn := Assigned(fOnSecurityLevel);
  fSSLContext.MessageCBOn := Assigned(FOnDebugMessage);
  // fSSLContext.PasswordRoutineOn := Assigned(fOnGetPassword);
  fSSLContext.MinTLSVersion := SSLOptions.MinTLSVersion;
  fSSLContext.Mode := SSLOptions.Mode;
  fSSLContext.SecurityLevel := SSLOptions.SecurityLevel;
  fSSLContext.InitContext(sslCtxServer);
end;

function TTaurusTLSServerIOHandler.Accept(ASocket: TIdSocketHandle;
  // This is a thread and not a yarn. Its the listener thread.
  AListenerThread: TIdThread; AYarn: TIdYarn): TIdIOHandler;
var
  LIO: TTaurusTLSIOHandlerSocket;
begin
  // using a custom scheduler, AYarn may be nil, so don't assert
  Assert(ASocket <> nil);
  Assert(fSSLContext <> nil);
  Assert(AListenerThread <> nil);

  Result := nil;
  LIO := TTaurusTLSIOHandlerSocket.Create(nil);
  try
    LIO.PassThrough := true;
    LIO.Open;
    while not AListenerThread.Stopped do
    begin
      if ASocket.Select(250) then
      begin
        if (not AListenerThread.Stopped) and LIO.Binding.Accept(ASocket.Handle)
        then
        begin
          LIO.SSLOptions.Assign(fSSLOptions);
          LIO.IsPeer := true;
          LIO.SSLSocket := TTaurusTLSSocket.Create(Self);
          LIO.SSLContext := fSSLContext;
          // TODO: to enable server-side SNI, we need to:
          // - Set up an additional SSL_CTX for each different certificate;
          // - Add a servername callback to each SSL_CTX using SSL_CTX_set_tlsext_servername_callback();
          // - In the callback, retrieve the client-supplied servername with
          // SSL_get_servername(ssl, TLSEXT_NAMETYPE_host_name). Figure out the right
          // SSL_CTX to go with that host name, then switch the SSL object to that
          // SSL_CTX with SSL_set_SSL_CTX().

          // RLebeau 2/1/2022: note, the following call is basically a no-op for TaurusTLS,
          // because PassThrough=True and fSSLContext are both assigned above, so there
          // is really nothing for TTaurusTLSIOHandlerSocket.Init() or
          // TTaurusTLSIOHandlerSocket.StartSSL() to do when called by
          // TTaurusTLSIOHandlerSocket.AfterAccept().  If anything, all this will
          // really do is update the Binding's IPVersion.  But, calling this is consistent
          // with other server Accept() implementations, so we should do it here, too...
          LIO.AfterAccept;

          Result := LIO;
          LIO := nil;
          Break;
        end;
      end;
    end;
  finally
    FreeAndNil(LIO);
  end;
end;

function TTaurusTLSServerIOHandler.MakeFTPSvrPort: TIdSSLIOHandlerSocketBase;
var
  LIO: TTaurusTLSIOHandlerSocket;
begin
  LIO := TTaurusTLSIOHandlerSocket.Create(nil);
  try
    LIO.PassThrough := true;
    LIO.OnGetPassword := fOnGetPassword;
    LIO.OnDebugMessage := FOnDebugMessage;
    LIO.OnStatusInfo := FOnStatusInfo;
    LIO.OnSSLNegotiated := FOnSSLNegotiated;
    LIO.OnSecurityLevel := fOnSecurityLevel;
    LIO.IsPeer := true; // RLebeau 1/24/2019: is this still needed now?
    LIO.SSLOptions.Assign(SSLOptions);
    LIO.SSLOptions.Mode := sslmBoth; { or sslmClient }{ doesn't really matter }
    LIO.SSLContext := SSLContext;
  except
    LIO.Free;
    raise;
  end;
  Result := LIO;
end;

procedure TTaurusTLSServerIOHandler.Shutdown;
begin
  FreeAndNil(fSSLContext);
  inherited Shutdown;
end;

function TTaurusTLSServerIOHandler.MakeFTPSvrPasv: TIdSSLIOHandlerSocketBase;
var
  LIO: TTaurusTLSIOHandlerSocket;
begin
  LIO := TTaurusTLSIOHandlerSocket.Create(nil);
  try
    LIO.PassThrough := true;
    LIO.OnGetPassword := fOnGetPassword;
    LIO.IsPeer := true;
    LIO.SSLOptions.Assign(SSLOptions);
    LIO.SSLOptions.Mode := sslmBoth; { or sslmServer }
    LIO.SSLContext := nil;
  except
    LIO.Free;
    raise;
  end;
  Result := LIO;
end;

{ ITaurusTLSCallbackHelper }

function TTaurusTLSServerIOHandler.GetPassword(const AIsWrite: Boolean): string;
begin
  Result := '';
  if Assigned(fOnGetPassword) then
  begin
    fOnGetPassword(Self, Result, AIsWrite);
  end;
end;

procedure TTaurusTLSServerIOHandler.StatusInfo(const AsslSocket: PSSL;
  AWhere, Aret: TIdC_INT);
{$IFNDEF USE_INLINE_VAR}
var
  LType, LMsg: string;
{$ENDIF}
begin
  if Assigned(FOnStatusInfo) then
  begin
{$IFDEF USE_INLINE_VAR}
    var
      LType, LMsg: string;
{$ENDIF}
    GetStateVars(AsslSocket, AWhere, Aret, LType, LMsg);
    FOnStatusInfo(Self, AsslSocket, AWhere, Aret, LType, LMsg);
  end;
end;

function TTaurusTLSServerIOHandler.VerifyPeer(ACertificate: TTaurusTLSX509;
  const AOk: Boolean; const ADepth, AError: Integer): Boolean;
begin
  Result := true;
  if Assigned(fOnVerifyPeer) then
  begin
    Result := fOnVerifyPeer(ACertificate, AOk, ADepth, AError);
  end;
end;

procedure TTaurusTLSServerIOHandler.SecurityLevelCB(const AsslSocket: PSSL;
  ACtx: PSSL_CTX; const op, bits: TIdC_INT; const ACipher: String;
  out VAccepted: Boolean);
begin
  VAccepted := False;
  if Assigned(fOnSecurityLevel) then
  begin
    fOnSecurityLevel(Self, AsslSocket, ACtx, op, bits, ACipher, VAccepted);
  end;

end;

function TTaurusTLSServerIOHandler.GetIOHandlerSelf: TTaurusTLSIOHandlerSocket;
begin
  Result := nil;
end;

/// ////////////////////////////////////////////////////
// TTaurusTLSIOHandlerSocket
/// ////////////////////////////////////////////////////

function TTaurusTLSServerIOHandler.MakeClientIOHandler
  : TIdSSLIOHandlerSocketBase;
var
  LIO: TTaurusTLSIOHandlerSocket;
begin
  LIO := TTaurusTLSIOHandlerSocket.Create(nil);
  try
    LIO.PassThrough := true;
    // LIO.SSLOptions.Free;
    // LIO.SSLOptions := SSLOptions;
    // LIO.SSLContext := SSLContext;
    LIO.SSLOptions.Assign(SSLOptions);
    // LIO.SSLContext := SSLContext;
    LIO.SSLContext := nil;
    // SSLContext.Clone; // BGO: clone does not work, it must be either NIL, or SSLContext
    LIO.OnGetPassword := fOnGetPassword;
  except
    LIO.Free;
    raise;
  end;
  Result := LIO;
end;

{ TTaurusTLSIOHandlerSocket }

procedure TTaurusTLSIOHandlerSocket.InitComponent;
begin
  inherited InitComponent;
  IsPeer := False;
  fSSLOptions := TTaurusTLSSSLOptions_Internal.Create;
  TTaurusTLSSSLOptions_Internal(fSSLOptions).FParent := Self;
  // fSSLLayerClosed := true;
  fSSLContext := nil;
end;

destructor TTaurusTLSIOHandlerSocket.Destroy;
begin
  FreeAndNil(fSSLSocket);
  // we do not destroy these if their Parent is not Self
  // because these do not belong to us when we are in a server.
  if (fSSLContext <> nil) and (fSSLContext.Parent = Self) then
  begin
    FreeAndNil(fSSLContext);
  end;
  if (fSSLOptions <> nil) and (fSSLOptions is TTaurusTLSSSLOptions_Internal) and
    (TTaurusTLSSSLOptions_Internal(fSSLOptions).FParent = Self) then
  begin
    FreeAndNil(fSSLOptions);
  end;
  inherited Destroy;
end;

procedure TTaurusTLSIOHandlerSocket.ConnectClient;
var
  LPassThrough: Boolean;
begin
  // RLebeau: initialize TaurusTLS before connecting the socket...
  try
    Init;
  except
    on ETaurusTLSCouldNotLoadSSLLibrary do
    begin
      if not PassThrough then
        raise;
    end;
  end;
  // RLebeau 1/11/07: In case a proxy is being used, pass through
  // any data from the base class unencrypted when setting up that
  // connection.  We should do this anyway since SSL hasn't been
  // negotiated yet!
  // Save LPassThrough instead of "fixing" the "Local variable is referenced
  // only once" warning.
  LPassThrough := fPassThrough;
  fPassThrough := true;
  try
    inherited ConnectClient;
  finally
    fPassThrough := LPassThrough;
  end;
  if Assigned(fOnBeforeConnect) then
  begin
    fOnBeforeConnect(Self);
  end;
  // CreateSSLContext(sslmClient);
  // CreateSSLContext(SSLOptions.fMode);
  StartSSL;
end;

procedure TTaurusTLSIOHandlerSocket.StartSSL;
begin
  if not PassThrough then
  begin
    OpenEncodedConnection;
  end;
end;

procedure TTaurusTLSIOHandlerSocket.Close;
begin
  FreeAndNil(fSSLSocket);
  if fSSLContext <> nil then
  begin
    if fSSLContext.Parent = Self then
    begin
      FreeAndNil(fSSLContext);
    end
    else
    begin
      fSSLContext := nil;
    end;
  end;
  inherited Close;
end;

procedure TTaurusTLSIOHandlerSocket.Open;
begin
  FOpened := False;
  inherited Open;
end;

function TTaurusTLSIOHandlerSocket.Readable
  (AMSec: Integer = IdTimeoutDefault): Boolean;
begin
  if not fPassThrough then
  begin
    Result := (fSSLSocket <> nil) and (ssl_pending(fSSLSocket.SSL) > 0);
    if Result then
      Exit;
  end;
  Result := inherited Readable(AMSec);
end;

procedure TTaurusTLSIOHandlerSocket.SetPassThrough(const Value: Boolean);
begin
  if fPassThrough <> Value then
  begin
    if not Value then
    begin
      if BindingAllocated then
      begin
        if Assigned(fSSLContext) then
        begin
          OpenEncodedConnection;
        end
        else
        begin
          raise ETaurusTLSCouldNotLoadSSLLibrary.Create
            (RSOSSLCouldNotLoadSSLLibrary);
        end;
      end;
    end
    else
    begin
      // RLebeau 8/16/2019: need to call SSL_shutdown() here if the SSL/TLS session is active.
      // This is for FTP when handling CCC and REIN commands. The SSL/TLS session needs to be
      // shutdown cleanly on both ends without closing the underlying socket connection because
      // it is going to be used for continued unsecure communications!
      if (fSSLSocket <> nil) and (fSSLSocket.SSL <> nil) then
      begin
        // if SSL_shutdown() returns 0, a "close notify" was sent to the peer and SSL_shutdown()
        // needs to be called again to receive the peer's "close notify" in response...
        if SSL_shutdown(fSSLSocket.SSL) = 0 then
        begin
          SSL_shutdown(fSSLSocket.SSL);
        end;
      end;
{$IFDEF WIN32_OR_WIN64}
      // begin bug fix
      if BindingAllocated and IndyCheckWindowsVersion(6) then
      begin
        // disables Vista+ SSL_Read and SSL_Write timeout fix
        Binding.SetSockOpt(Id_SOL_SOCKET, Id_SO_RCVTIMEO, 0);
        Binding.SetSockOpt(Id_SOL_SOCKET, Id_SO_SNDTIMEO, 0);
      end;
      // end bug fix
{$ENDIF}
    end;
    fPassThrough := Value;
  end;
end;

function TTaurusTLSIOHandlerSocket.RecvEnc(var VBuffer: TIdBytes): Integer;
begin
  Result := fSSLSocket.Recv(VBuffer);
end;

procedure TTaurusTLSIOHandlerSocket.SecurityLevelCB(const AsslSocket: PSSL;
  ACtx: PSSL_CTX; const op, bits: TIdC_INT; const ACipher: String;
  out VAccepted: Boolean);
begin
  VAccepted := False;
  if Assigned(fOnSecurityLevel) then
  begin
    fOnSecurityLevel(Self, AsslSocket, ACtx, op, bits, ACipher, VAccepted);
  end;
end;

function TTaurusTLSIOHandlerSocket.SendEnc(const ABuffer: TIdBytes;
  const AOffset, ALength: Integer): Integer;
begin
  // This can not be altered because it inherits from Indy.
  Result := fSSLSocket.Send(ABuffer, AOffset, ALength);
end;

procedure TTaurusTLSIOHandlerSocket.AfterAccept;
begin
  try
    inherited AfterAccept;
    // RLebeau: initialize TaurusTLS after accepting a client socket...
    try
      Init;
    except
      on ETaurusTLSCouldNotLoadSSLLibrary do
      begin
        if not PassThrough then
          raise;
      end;
    end;
    StartSSL;
  except
    Close;
    raise;
  end;
end;

procedure TTaurusTLSIOHandlerSocket.Init;
// see also TTaurusTLSServerIOHandler.Init
begin
  if not Assigned(fSSLContext) then
  begin
    fSSLContext := TTaurusTLSContext.Create;
    fSSLContext.Parent := Self;
    fSSLContext.RootCertFile := SSLOptions.RootCertFile;
    fSSLContext.CertFile := SSLOptions.CertFile;
    fSSLContext.KeyFile := SSLOptions.KeyFile;
    fSSLContext.DHParamsFile := SSLOptions.DHParamsFile;
    fSSLContext.VerifyDepth := SSLOptions.VerifyDepth;
    fSSLContext.VerifyMode := SSLOptions.VerifyMode;
    // fSSLContext.fVerifyFile := SSLOptions.fVerifyFile;
    fSSLContext.UseSystemRootCertificateStore :=
      SSLOptions.UseSystemRootCertificateStore;
    fSSLContext.VerifyDirs := SSLOptions.VerifyDirs;
    fSSLContext.CipherList := SSLOptions.CipherList;
    fSSLContext.VerifyOn := Assigned(fOnVerifyPeer);
    fSSLContext.StatusInfoOn := Assigned(FOnStatusInfo);
    fSSLContext.SecurityLevelCBOn := Assigned(fOnSecurityLevel);
    fSSLContext.MessageCBOn := Assigned(FOnDebugMessage);

    // fSSLContext.PasswordRoutineOn := Assigned(fOnGetPassword);
    fSSLContext.MinTLSVersion := SSLOptions.MinTLSVersion;
    fSSLContext.Mode := SSLOptions.Mode;
    fSSLContext.SecurityLevel := SSLOptions.SecurityLevel;
    fSSLContext.InitContext(sslCtxClient);
  end;
end;

procedure TTaurusTLSIOHandlerSocket.DoOnDebugMessage(const AWrite: Boolean;
  AVersion: TTaurusMsgCBVer; AContentType: TIdC_INT; const buf: TIdBytes;
  SSL: PSSL);
begin
  if Assigned(FOnDebugMessage) then
  begin
    FOnDebugMessage(Self, AWrite, AVersion, AContentType, buf, SSL);
  end;
end;
// }

function TTaurusTLSIOHandlerSocket.DoVerifyPeer(Certificate: TTaurusTLSX509;
  const AOk: Boolean; const ADepth, AError: Integer): Boolean;
begin
  Result := true;
  if Assigned(fOnVerifyPeer) then
  begin
    Result := fOnVerifyPeer(Certificate, AOk, ADepth, AError);
  end;
end;

procedure TTaurusTLSIOHandlerSocket.OpenEncodedConnection;
var
{$IFDEF WIN32_OR_WIN64}
  LTimeout: Integer;
{$ENDIF}
  LMode: TTaurusTLSSSLMode;
{$IFNDEF USE_INLINE_VAR}
  LHost: string;
{$ENDIF}
begin
  Assert(Binding <> nil);
  if not Assigned(fSSLSocket) then
  begin
    fSSLSocket := TTaurusTLSSocket.Create(Self);
  end;
  Assert(fSSLSocket.SSLContext = nil);
  fSSLSocket.SSLContext := fSSLContext;
{$IFDEF WIN32_OR_WIN64}
  // begin bug fix
  if IndyCheckWindowsVersion(6) then
  begin
    // Note: Fix needed to allow SSL_Read and SSL_Write to timeout under
    // Vista+ when connection is dropped
    LTimeout := FReadTimeOut;
    if LTimeout <= 0 then
    begin
      LTimeout := 30000; // 30 seconds
    end;
    Binding.SetSockOpt(Id_SOL_SOCKET, Id_SO_RCVTIMEO, LTimeout);
    Binding.SetSockOpt(Id_SOL_SOCKET, Id_SO_SNDTIMEO, LTimeout);
  end;
  // end bug fix
{$ENDIF}
  // RLebeau 7/2/2015: do not rely on IsPeer to decide whether to call Connect()
  // or Accept(). SSLContext.Mode controls whether a client or server method is
  // used to handle the connection, so that same value should be used here as well.
  // A user encountered a scenario where he needed to connect a TIdTCPClient to a
  // TCP server on a hardware device, but run the client's SSLIOHandler as an SSL
  // server because the device was initiating the SSL handshake as an SSL client.
  // IsPeer was not designed to handle that scenario.  Setting IsPeer to True
  // allowed Accept() to be called here, but at the cost of causing memory leaks
  // in TTaurusTLSIOHandlerSocket.Destroy() and TTaurusTLSIOHandlerSocket.Close()
  // in client components!  IsPeer is intended to be set to True only in server
  // components...
  LMode := fSSLContext.Mode;
  if not(LMode in [sslmClient, sslmServer]) then
  begin
    // Mode must be sslmBoth (or else TTaurusTLSContext.GetSSLMethod() would have
    // raised an exception), so just fall back to previous behavior for now,
    // until we can figure out a better way to handle this scenario...
    if IsPeer then
    begin
      LMode := sslmServer;
    end
    else
    begin
      LMode := sslmClient;
    end;
  end;
  if LMode = sslmClient then
  begin
{$IFDEF USE_INLINE_VAR}
    var
      LHost: String;
{$ENDIF}
    LHost := GetURIHost;
    if LHost = '' then
    begin
      LHost := GetProxyTargetHost;
      if LHost = '' then
      begin
        LHost := Self.Host;
      end;
    end;
    fSSLSocket.HostName := LHost;
    fSSLSocket.Connect(Binding.Handle);
  end
  else
  begin
    fSSLSocket.HostName := '';
    fSSLSocket.Accept(Binding.Handle);
  end;
  if Assigned(FOnSSLNegotiated) then
  begin
    FOnSSLNegotiated(Self);
  end;
  fPassThrough := False;
end;

// TODO: add an AOwner parameter
function TTaurusTLSIOHandlerSocket.Clone: TIdSSLIOHandlerSocketBase;
var
  LIO: TTaurusTLSIOHandlerSocket;
begin
  LIO := TTaurusTLSIOHandlerSocket.Create(nil);
  try
    LIO.SSLOptions.Assign(SSLOptions);
    LIO.OnStatusInfo := FOnStatusInfo;
    LIO.OnDebugMessage := FOnDebugMessage;
    LIO.OnGetPassword := fOnGetPassword;
    LIO.OnVerifyPeer := DoVerifyPeer;
    LIO.OnSSLNegotiated := OnSSLNegotiated;
    LIO.fSSLSocket := TTaurusTLSSocket.Create(Self);
  except
    LIO.Free;
    raise;
  end;
  Result := LIO;
end;

function TTaurusTLSIOHandlerSocket.CheckForError(ALastResult: Integer): Integer;
// var
// err: Integer;
begin
  if PassThrough then
  begin
    Result := inherited CheckForError(ALastResult);
  end
  else
  begin
    Result := fSSLSocket.GetSSLError(ALastResult);
    if Result = SSL_ERROR_NONE then
    begin
      Result := 0;
      Exit;
    end;
    if Result = SSL_ERROR_SYSCALL then
    begin
      Result := inherited CheckForError(Integer(Id_SOCKET_ERROR));
      Exit;
    end;
    ETaurusTLSAPISSLError.RaiseExceptionCode(Result, ALastResult, '');
  end;
end;

procedure TTaurusTLSIOHandlerSocket.RaiseError(AError: Integer);
begin
  if PassThrough or (AError = Id_WSAESHUTDOWN) or (AError = Id_WSAECONNABORTED)
    or (AError = Id_WSAECONNRESET) then
  begin
    inherited RaiseError(AError);
  end
  else
  begin
    ETaurusTLSAPISSLError.RaiseException(fSSLSocket.SSL, AError, '');
  end;
end;

{ ITaurusTLSCallbackHelper }

function TTaurusTLSIOHandlerSocket.GetPassword(const AIsWrite: Boolean): string;
begin
  Result := '';
  if Assigned(fOnGetPassword) then
  begin
    fOnGetPassword(Self, Result, AIsWrite);
  end;
end;

{$IFNDEF GETURIHOST_SUPPORTED}

function TTaurusTLSIOHandlerSocket.GetProxyTargetHost: string;
var
  // under ARC, convert a weak reference to a strong reference before working with it
  LTransparentProxy, LNextTransparentProxy: TIdCustomTransparentProxy;
begin
  Result := '';
  // RLebeau: not reading from the property as it will create a
  // default Proxy object if one is not already assigned...
  LTransparentProxy := FTransparentProxy;
  if Assigned(LTransparentProxy) then
  begin
    if LTransparentProxy.Enabled then
    begin
      repeat
        LNextTransparentProxy := LTransparentProxy.ChainedProxy;
        if not Assigned(LNextTransparentProxy) then
          Break;
        if not LNextTransparentProxy.Enabled then
          Break;
        LTransparentProxy := LNextTransparentProxy;
      until False;
      Result := LTransparentProxy.Host;
    end;
  end;

end;

function TTaurusTLSIOHandlerSocket.GetURIHost: string;
var
  LURI: TIdURI;
begin
  Result := '';
  if URIToCheck <> '' then
  begin
    LURI := TIdURI.Create(URIToCheck);
    try
      Result := LURI.Host;
    finally
      LURI.Free;
    end;
  end;
end;
{$ENDIF}

procedure TTaurusTLSIOHandlerSocket.StatusInfo(const AsslSocket: PSSL;
  AWhere, Aret: TIdC_INT);
{$IFNDEF USE_INLINE_VAR}
var
  LType, LMsg: string;
begin
{$ELSE}
begin
{$ENDIF}
  if Assigned(FOnStatusInfo) then
  begin
{$IFDEF USE_INLINE_VAR}
    var
      LType, LMsg: string;
{$ENDIF}
    GetStateVars(AsslSocket, AWhere, Aret, LType, LMsg);
    FOnStatusInfo(Self, AsslSocket, AWhere, Aret, LType, LMsg);
  end;
end;

function TTaurusTLSIOHandlerSocket.VerifyPeer(ACertificate: TTaurusTLSX509;
  const AOk: Boolean; const ADepth, AError: Integer): Boolean;
begin
  Result := DoVerifyPeer(ACertificate, AOk, ADepth, AError);
end;

function TTaurusTLSIOHandlerSocket.GetIOHandlerSelf: TTaurusTLSIOHandlerSocket;
begin
  Result := Self;
end;

{ TTaurusTLSContext }

constructor TTaurusTLSContext.Create;
begin
  inherited Create;
  // an exception here probably means that you are using the wrong version
  // of the openssl libraries. refer to comments at the top of this file.
  if not LoadOpenSSLLibrary then
  begin
    raise ETaurusTLSCouldNotLoadSSLLibrary.Create(RSOSSLCouldNotLoadSSLLibrary);
  end;
  fVerifyMode := [];
  fMode := sslmUnassigned;
  fSessionId := 1;
  fUseSystemRootCertificateStore := true;
end;

destructor TTaurusTLSContext.Destroy;
begin
  DestroyContext;
  inherited Destroy;
end;

{$IFDEF USE_WINDOWS_CERT_STORE}

const
  wincryptdll = 'crypt32.dll';
  RootStore = 'ROOT';

type
  HCERTSTORE = THandle;
{$IFDEF WIN64}
  HCRYPTPROV_LEGACY = PIdC_UINT64;
{$ELSE}
  HCRYPTPROV_LEGACY = PIdC_UINT32;
{$ENDIF}
  PCERT_INFO = Pointer; { don't need to know this structure }
  PCCERT_CONTEXT = ^CERT_CONTEXT;

  CERT_CONTEXT = record
    dwCertEncodingType: DWORD;
    pbCertEncoded: PByte;
    cbCertEncoded: DWORD;
    CertInfo: PCERT_INFO;
    certstore: HCERTSTORE;
  end;

{$IFDEF STRING_IS_ANSI}
{$EXTERNALSYM CertOpenSystemStoreA}

function CertOpenSystemStoreA(hProv: HCRYPTPROV_LEGACY;
  szSubsystemProtocol: PIdAnsiChar): HCERTSTORE; stdcall; external wincryptdll;
{$ELSE}
{$EXTERNALSYM CertOpenSystemStoreW}
function CertOpenSystemStoreW(hProv: HCRYPTPROV_LEGACY;
  szSubsystemProtocol: PCHar): HCERTSTORE; stdcall; external wincryptdll;
{$ENDIF}
{$EXTERNALSYM CertCloseStore}
function CertCloseStore(certstore: HCERTSTORE; dwFlags: DWORD): Boolean;
  stdcall; external wincryptdll;

{$EXTERNALSYM CertEnumCertificatesInStore}
function CertEnumCertificatesInStore(certstore: HCERTSTORE;
  pPrevCertContext: PCCERT_CONTEXT): PCCERT_CONTEXT; stdcall;
  external wincryptdll;

{ Copy Windows CA Certs to out cert store }
procedure TTaurusTLSContext.LoadWindowsCertStore;
var
  LWinCertStore: HCERTSTORE;
  LX509Cert: PX509;
  Lcert_context: PCCERT_CONTEXT;
  LError: Integer;
  LSSLCertStore: PX509_STORE;
begin
  Lcert_context := nil;
{$IFDEF STRING_IS_ANSI}
  LWinCertStore := CertOpenSystemStoreA(nil, RootStore);
{$ELSE}
  LWinCertStore := CertOpenSystemStoreW(nil, RootStore);
{$ENDIF}
  if LWinCertStore = 0 then
    Exit;

  LSSLCertStore := SSL_CTX_get_cert_store(fContext);
  try
    Lcert_context := CertEnumCertificatesInStore(LWinCertStore, Lcert_context);
    while Lcert_context <> nil do
    begin
      LX509Cert := d2i_X509(nil, @Lcert_context^.pbCertEncoded,
        Lcert_context^.cbCertEncoded);
      if LX509Cert <> nil then
      begin
        LError := X509_STORE_add_cert(LSSLCertStore, LX509Cert);
        // Ignore if cert already in store
        if (LError = 0) and
          (ERR_GET_REASON(ERR_get_error) <> X509_R_CERT_ALREADY_IN_HASH_TABLE)
        then
        begin
          ETaurusTLSAPICryptoError.RaiseException
            (ROSCertificateNotAddedToStore);
        end;
        X509_free(LX509Cert);
      end;
      Lcert_context := CertEnumCertificatesInStore(LWinCertStore,
        Lcert_context);
    end;
  finally
    if not CertCloseStore(LWinCertStore, 0) then
    begin
      RaiseLastOSError;
    end;
  end;
end;
{$ENDIF}

procedure TTaurusTLSContext.DestroyContext;
begin
  if fContext <> nil then
  begin
    SSL_CTX_free(fContext);
    fContext := nil;
  end;
end;

procedure TTaurusTLSContext.InitContext(CtxMode: TTaurusTLSCtxMode);
const
  SSLProtoVersion: array [TTaurusTLSSSLVersion] of TIdC_LONG = (0, 0,
    SSL3_VERSION, { SSLv3 }
    TLS1_VERSION, { TLSv1 }
    TLS1_1_VERSION, { TLSv1_1 }
    TLS1_2_VERSION, { TLSv1_2 }
    TLS1_3_VERSION); { TLSv1_3 }

var
  LError: TIdC_INT;
  // pCAname: PSTACK_X509_NAME;
{$IFDEF USE_MARSHALLED_PTRS}
  M: TMarshaller;
{$ENDIF}
  Func: SSL_verify_cb;
  LRes: Boolean;
begin
  // Destroy the context first
  DestroyContext;
  if fMode = sslmUnassigned then
  begin
    if CtxMode = sslCtxServer then
    begin
      fMode := sslmServer;
    end
    else
    begin
      fMode := sslmClient;
    end
  end;

  // create new SSL context
  fContext := SSL_CTX_new_ex(nil, nil, GetSSLMethod);
  if fContext = nil then
  begin
    ETaurusTLSCreatingContextError.RaiseException(RSSSLCreatingContextError);
  end;

  // set SSL Versions we will use
  if HasTLS_method then
  begin
    if SSL_CTX_set_min_proto_version(fContext, SSLProtoVersion[fMinTLSVersion]
      ) = 0 then
    begin
      ETaurusTLSSettingMinProtocolError.RaiseException(RSOSSLMinProtocolError);
    end;
    // Maximum version is always TLS 1.3.
    if SSL_CTX_set_max_proto_version(fContext, TLS1_3_VERSION) = 0 then
    begin
      ETaurusTLSSettingMaxProtocolError.RaiseException(RSOSSLMaxProtocolError);
    end;
  end;
  SSL_CTX_set_mode(fContext, SSL_MODE_AUTO_RETRY);
  // assign a password lookup routine
  // if PasswordRoutineOn then begin
  SSL_CTX_set_default_passwd_cb(fContext, @PasswordCallback);
  SSL_CTX_set_default_passwd_cb_userdata(fContext, Self);
  // end;

  if fUseSystemRootCertificateStore then
  begin
{$IFDEF USE_WINDOWS_CERT_STORE}
    LoadWindowsCertStore;
{$ELSE}
    SSL_CTX_set_default_verify_paths(fContext);
{$ENDIF}
  end;
  // load key and certificate files
  if (RootCertFile <> '') or (VerifyDirs <> '') then
  begin { Do not Localize }
    if not IndySSL_CTX_load_verify_locations(fContext, RootCertFile,
      VerifyDirs) > 0 then
    begin
      ETaurusTLSLoadingRootCertError.RaiseException(RSSSLLoadingRootCertError);
    end;
  end;

  if CertFile <> '' then
  begin { Do not Localize }

    if PosInStrArray(ExtractFileExt(CertFile), ['.p12', '.pfx'], False) <> -1
    then
    begin
      LRes := IndySSL_CTX_use_certificate_file_PKCS12(fContext, CertFile) > 0;
    end
    else
    begin
      // OpenSSL 1.0.2 has a new function, SSL_CTX_use_certificate_chain_file
      // that handles a chain of certificates in a PEM file.  That is prefered.
{$IFNDEF OPENSSL_STATIC_LINK_MODEL}
      if Assigned(SSL_CTX_use_certificate_chain_file) then
      begin
        LRes := IndySSL_CTX_use_certificate_chain_file(fContext, CertFile) > 0;
      end
      else
      begin
        LRes := IndySSL_CTX_use_certificate_file(fContext, CertFile,
          SSL_FILETYPE_PEM) > 0;
      end;
{$ELSE}
      LRes := IndySSL_CTX_use_certificate_chain_file(fContext, CertFile) > 0;
{$ENDIF}
    end;
    if not LRes then
    begin
      ETaurusTLSLoadingCertError.RaiseException(RSSSLLoadingCertError);
    end;
  end;

  if KeyFile <> '' then
  begin { Do not Localize }
    if PosInStrArray(ExtractFileExt(KeyFile), ['.p12', '.pfx'], False) <> -1
    then
    begin
      LRes := IndySSL_CTX_use_PrivateKey_file_PKCS12(fContext, KeyFile) > 0;
    end
    else
    begin
      LRes := IndySSL_CTX_use_PrivateKey_file(fContext, KeyFile,
        SSL_FILETYPE_PEM) > 0;
    end;
    if LRes then
    begin
      LRes := SSL_CTX_check_private_key(fContext) > 0;
    end;
    if not LRes then
    begin
      ETaurusTLSLoadingKeyError.RaiseException(RSSSLLoadingKeyError);
    end;
  end;
  if DHParamsFile <> '' then
  begin { Do not Localize }
    if not IndySSL_CTX_use_DHparams_file(fContext, fsDHParamsFile,
      SSL_FILETYPE_PEM) > 0 then
    begin
      ETaurusTLSLoadingDHParamsError.RaiseException(RSSSLLoadingDHParamsError);
    end;
  end;
  SSL_CTX_set_security_level(fContext, FSecurityLevel);
  if StatusInfoOn then
  begin
    SSL_CTX_set_info_callback(fContext, InfoCallback);
  end;
  if SecurityLevelCBOn then
  begin
    SSL_CTX_set_security_callback(fContext, SecurityLevelCallback);
    SSL_CTX_set0_security_ex_data(fContext, Self);
  end;
  if MessageCBOn then
  begin
    SSL_CTX_set_msg_callback(fContext, MsgCallback);
    SSL_CTX_set_msg_callback_arg(fContext, Self);
  end;
  // if_SSL_CTX_set_tmp_rsa_callback(hSSLContext, @RSACallback);
  if fCipherList <> '' then
  begin { Do not Localize }
    LError := SSL_CTX_set_cipher_list(fContext,
{$IFDEF USE_MARSHALLED_PTRS}
      M.AsAnsi(fCipherList).ToPointer
{$ELSE}
      PAnsiChar(
{$IFDEF STRING_IS_ANSI}
      fCipherList
{$ELSE}
      AnsiString(fCipherList) // explicit cast to Ansi
{$ENDIF}
      )
{$ENDIF}
      );
  end
  else
  begin
    // RLebeau: don't override TaurusTLS's default.  As TaurusTLS evolves, the
    // SSL_DEFAULT_CIPHER_LIST constant defined in the C/C++ SDK may change,
    // while Indy's define of it might take some time to catch up.  We don't
    // want users using an older default with newer DLLs...
    (*
      error := SSL_CTX_set_cipher_list(fContext,
      {$IFDEF USE_MARSHALLED_PTRS}
      M.AsAnsi(SSL_DEFAULT_CIPHER_LIST).ToPointer
      {$ELSE}
      SSL_DEFAULT_CIPHER_LIST
      {$ENDIF}
      );
    *)
    LError := 1;
  end;
  if LError <= 0 then
  begin
    ETaurusTLSSettingCipherError.RaiseException(RSSSLSettingCipherError);
  end;
  if fVerifyMode <> [] then
  begin
    if fContext <> nil then
    begin
      // SSL_CTX_set_default_verify_paths(fContext);
      if VerifyOn then
      begin
        Func := VerifyCallback;
      end
      else
      begin
        Func := nil;
      end;

      SSL_CTX_set_verify(fContext,
        TranslateInternalVerifyToSSL(fVerifyMode), Func);
      SSL_CTX_set_verify_depth(fContext, fVerifyDepth);
    end;
  end;
  if CtxMode = sslCtxServer then
  begin
    SSL_CTX_set_session_id_context(fContext, PByte(@fSessionId),
      SizeOf(fSessionId));
  end;
  // CA list
  if RootCertFile <> '' then
  begin { Do not Localize }
    SSL_CTX_set_client_CA_list(fContext,
      IndySSL_load_client_CA_file(RootCertFile));
  end

  // TODO: provide an event so users can apply their own settings as needed...
end;

procedure TTaurusTLSContext.SetSecurityLevel(const AValue
  : TTaurusTLSSecurityLevel);
begin
  FSecurityLevel := AValue;
end;

function TTaurusTLSContext.GetVerifyMode: TTaurusTLSVerifyModeSet;
begin
  Result := fVerifyMode;
end;
{
  function TTaurusTLSContext.LoadVerifyLocations(FileName: String; Dirs: String): Boolean;
  begin
  Result := False;

  if (Dirs <> '') or (FileName <> '') then begin
  if IndySSL_CTX_load_verify_locations(fContext, FileName, Dirs) <= 0 then begin
  raise EIdOSSLCouldNotLoadSSLLibrary.Create(RSOSSLCouldNotLoadSSLLibrary);
  end;
  end;

  Result := True;
  end;
}

{$IFNDEF OPENSSL_STATIC_LINK_MODEL}

function SelectTLS1Method(const AMode: TTaurusTLSSSLMode): PSSL_METHOD;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := nil;
  case AMode of
    sslmServer:
      begin
        if Assigned(TLSv1_server_method) then
        begin
          Result := TLSv1_server_method();
        end;
      end;
    sslmClient:
      begin
        if Assigned(TLSv1_client_method) then
        begin
          Result := TLSv1_client_method();
        end;
      end;
  else
    if Assigned(TLSv1_method) then
    begin
      Result := TLSv1_method();
    end;
  end;
end;
{$ENDIF}

function TTaurusTLSContext.GetSSLMethod: PSSL_METHOD;
begin
  Result := nil;
  if fMode = sslmUnassigned then
  begin
    raise ETaurusTLSModeNotSet.Create(RSOSSLModeNotSet);
  end;
  { We are running with OpenSSL 1.1.1 or later. OpenSSL will negotiate the best
    available SSL/TLS version and there is not much that we can do to influence this.
    Hence, we ignore fMethod.

    Quoting from the OpenSSL man page:

    TLS_method(), TLS_server_method(), TLS_client_method()

    These are the general-purpose version-flexible SSL/TLS methods. The actual
    protocol version used will be negotiated to the highest version mutually
    supported by the client and the server. The supported protocols are SSLv3,
    TLSv1, TLSv1.1, TLSv1.2 and TLSv1.3. Applications should use these methods,
    and avoid the version-specific methods described below [e.g. SSLv2_method),
    which are deprecated.
  }
  case fMode of
    sslmClient:
      Result := TLS_client_method();

    sslmServer:
      Result := TLS_server_method();

    sslmBoth, sslmUnassigned:
      Result := TLS_Method();
  end;
end;

/// ///////////////////////////////////////////////////////////

function TTaurusTLSContext.Clone: TTaurusTLSContext;
begin
  Result := TTaurusTLSContext.Create;
  Result.StatusInfoOn := StatusInfoOn;
  // property PasswordRoutineOn: Boolean read fPasswordRoutineOn write fPasswordRoutineOn;
  Result.VerifyOn := VerifyOn;
  Result.MinTLSVersion := MinTLSVersion;
  Result.Mode := Mode;
  Result.RootCertFile := RootCertFile;
  Result.SecurityLevel := SecurityLevel;
  Result.CertFile := CertFile;
  Result.KeyFile := KeyFile;
  Result.VerifyMode := VerifyMode;
  Result.VerifyDepth := VerifyDepth;
  Result.VerifyHostname := VerifyHostname;
end;

{ TTaurusTLSSocket }

constructor TTaurusTLSSocket.Create(AParent: TObject);
begin
  inherited Create;
  FParent := AParent;
end;

destructor TTaurusTLSSocket.Destroy;
begin
  if fSession <> nil then
    SSL_SESSION_free(fSession);
  if fSSL <> nil then
  begin
    // TODO: should this be moved to TTaurusTLSContext instead?  Is this here
    // just to make sure the SSL shutdown does not log any messages?
    {
      if (fSSLContext <> nil) and (fSSLContext.StatusInfoOn) and
      (fSSLContext.fContext <> nil) then begin
      SSL_CTX_set_info_callback(fSSLContext.fContext, nil);
      end;
    }
    // SSL_set_shutdown(fSSL, SSL_SENT_SHUTDOWN);
    SSL_shutdown(fSSL);
    SSL_free(fSSL);
    fSSL := nil;
  end;
  FreeAndNil(fSSLCipher);
  FreeAndNil(fPeerCert);
  inherited Destroy;
end;

function TTaurusTLSSocket.GetSSLError(retCode: Integer): Integer;
begin
  // COMMENT!!!
  // I found out that SSL layer should not interpret errors, cause they will pop up
  // on the socket layer. Only thing that the SSL layer should consider is key
  // or protocol renegotiation. This is done by loop in read and write
  Result := SSL_get_error(fSSL, retCode);
end;

procedure TTaurusTLSSocket.Accept(const pHandle: TIdStackSocketHandle);

// Accept and Connect have a lot of duplicated code
var
  LError: Integer;
  // LParentIO: TTaurusTLSIOHandlerSocket;
  // LHelper: ITaurusTLSCallbackHelper;
begin
  Assert(fSSL = nil);
  Assert(fSSLContext <> nil);
  fSSL := SSL_new(fSSLContext.Context);
  if fSSL = nil then
  begin
    raise ETaurusTLSCreatingSessionError.Create(RSSSLCreatingSessionError);
  end;
  LError := SSL_set_app_data(fSSL, Self);
  if LError <= 0 then
  begin
    ETaurusTLSDataBindingError.RaiseException(fSSL, LError,
      RSSSLDataBindingError);
  end;
  // ignore warning about 64-bit value being passed to a 32bit parameter.
  // See: https://docs.openssl.org/3.0/man3/SSL_set_fd/#return-values
  LError := SSL_set_fd(fSSL, pHandle);
  if LError <= 0 then
  begin
    ETaurusTLSFDSetError.RaiseException(fSSL, LError, RSSSLFDSetError);
  end;
  // RLebeau: if this socket's IOHandler was cloned, no need to reuse the
  // original IOHandler's active session ID, since this is a server socket
  // that generates its own sessions...
  //
  // RLebeau: is this actually true?  Should we be reusing the original
  // IOHandler's active session ID regardless of whether this is a client
  // or server socket? What about FTP in non-passive mode, for example?
  {
    if (LParentIO <> nil) and (LParentIO.fSSLSocket <> nil) and
    (LParentIO.fSSLSocket <> Self) then
    begin
    SSL_copy_session_id(fSSL, LParentIO.fSSLSocket.fSSL);
    end;
  }
  LError := SSL_accept(fSSL);
  if LError <= 0 then
  begin
    ETaurusTLSAcceptError.RaiseException(fSSL, LError, RSSSLAcceptError);
  end;
  fSession := SSL_get1_session(fSSL);
end;

procedure TTaurusTLSSocket.Connect(const pHandle: TIdStackSocketHandle);
var
  LError: Integer;
  LParentIO: TTaurusTLSIOHandlerSocket;
  LHelper: ITaurusTLSCallbackHelper;

  Lpeercert: PX509;

{$IFNDEF  USE_INLINE_VAR}
  lHostName: AnsiString;
{$ENDIF}
begin
  Assert(fSSL = nil);
  Assert(fSSLContext <> nil);
  if Supports(FParent, ITaurusTLSCallbackHelper, IInterface(LHelper)) then
  begin
    LParentIO := LHelper.GetIOHandlerSelf;
  end
  else
  begin
    LParentIO := nil;
  end;
  fSSL := SSL_new(fSSLContext.Context);
  if fSSL = nil then
  begin
    raise ETaurusTLSCreatingSessionError.Create(RSSSLCreatingSessionError);
  end;
  LError := SSL_set_app_data(fSSL, Self);
  if LError <= 0 then
  begin
    ETaurusTLSDataBindingError.RaiseException(fSSL, LError,
      RSSSLDataBindingError);
  end;
  // ignore 64 value passed to 32bit parameter.
  // see: https://docs.openssl.org/3.0/man3/SSL_set_fd/#return-values
  LError := SSL_set_fd(fSSL, pHandle);
  if LError <= 0 then
  begin
    ETaurusTLSFDSetError.RaiseException(fSSL, LError, RSSSLFDSetError);
  end;
  // RLebeau: if this socket's IOHandler was cloned, reuse the
  // original IOHandler's active session ID...
  if (LParentIO <> nil) and (LParentIO.SSLSocket <> nil) and
    (LParentIO.SSLSocket <> Self) then
  begin
    SSL_copy_session_id(fSSL, LParentIO.SSLSocket.SSL);
  end;
{$IFNDEF OPENSSL_NO_TLSEXT}
  { Delphi appears to need the extra AnsiString coerction. Otherwise, only the
    first character to the hostname is passed }
  LError := SSL_set_tlsext_host_name(fSSL, PIdAnsiChar(AnsiString(fHostName)));
  if LError <= 0 then
  begin
    ETaurusTLSSettingTLSHostNameError.RaiseException(fSSL, error,
      RSSSLSettingTLSHostNameError);
  end;
{$ENDIF}
  LError := SSL_connect(fSSL);
  if LError <= 0 then
  begin
    // TODO: if sslv23 is being used, but sslv23 is not being used on the
    // remote side, SSL_connect() will fail. In that case, before giving up,
    // try re-connecting using a version-specific method for each enabled
    // version, maybe one will succeed...
    LError := SSL_get_error(fSSL, LError);
    ETaurusTLSConnectError.RaiseException(fSSL, LError, RSSSLConnectError);
  end;
  fSession := SSL_get1_session(fSSL);
  // TODO: even if SSL_connect() returns success, the connection might
  // still be insecure if SSL_connect() detected that certificate validation
  // actually failed, but ignored it because SSL_VERIFY_PEER was disabled!
  // It would report such a failure via SSL_get_verify_result() instead of
  // returning an error code, so we should call SSL_get_verify_result() here
  // to make sure...

  // TODO: enable this
  if fSSLContext.VerifyHostname then
  begin
    Lpeercert := SSL_get_peer_certificate(fSSL);
    try
{$IFDEF  USE_INLINE_VAR}
      var
        lHostName: AnsiString;
{$ENDIF}
      lHostName := AnsiString(fHostName);
      if (X509_check_host(Lpeercert, PAnsiChar(lHostName), Length(lHostName), 0,
        nil) <> 1) then
      begin
        ETaurusTLSCertificateError.RaiseException(fSSL, error,
          'SSL certificate does not match host name');
      end;

    finally
      X509_free(Lpeercert);
    end;
  end;
end;

function TTaurusTLSSocket.Recv(var VBuffer: TIdBytes): TIdC_SIZET;
var
  Lret, LErr: Integer;
  LRead: TIdC_SIZET;
begin
  Result := 0;
  repeat
    Lret := SSL_read_ex(fSSL, PByte(VBuffer), Length(VBuffer), @LRead);
    if Lret > 0 then
    begin
      Result := LRead;
      Break;
    end;
    LErr := GetSSLError(Lret);
    if (LErr = SSL_ERROR_WANT_READ) or (LErr = SSL_ERROR_WANT_WRITE) then
    begin
      Continue;
    end;
    if LErr <> SSL_ERROR_ZERO_RETURN then
    begin
      Result := LRead;
    end;
    Break;
  until False;
end;

function TTaurusTLSSocket.Send(const ABuffer: TIdBytes;
  const AOffset, ALength: TIdC_SIZET): TIdC_SIZET;
var
  Lret, LErr: Integer;
  LOffset, LLength, LWritten: TIdC_SIZET;
begin
  Result := 0;
  LOffset := AOffset;
  LLength := ALength;
  repeat
    Lret := SSL_write_ex2(fSSL, @ABuffer[LOffset], LLength, 0, @LWritten);
    if Lret > 0 then
    begin
      Result := Result + LWritten;
      LOffset := LOffset + LWritten;
      LLength := LLength - LWritten;
      if LLength < 1 then
      begin
        Break;
      end;
      Continue;
    end;
    LErr := GetSSLError(Lret);
    if (LErr = SSL_ERROR_WANT_READ) or (LErr = SSL_ERROR_WANT_WRITE) then
    begin
      Continue;
    end;
    if LErr = SSL_ERROR_ZERO_RETURN then
    begin
      Result := 0;
    end
    else
    begin
      Result := LWritten;
    end;
    Break;
  until False;
end;

function TTaurusTLSSocket.GetProtocolVersion: TTaurusTLSSSLVersion;
begin
  if fSession = nil then
    raise ETaurusTLSSessionCanNotBeNil.Create(RSOSSSessionCanNotBeNul)
  else
    case SSL_SESSION_get_protocol_version(fSession) of
      SSL3_VERSION:
        Result := SSLv3;
      TLS1_VERSION:
        Result := TLSv1;
      TLS1_1_VERSION:
        Result := TLSv1_1;
      TLS1_2_VERSION:
        Result := TLSv1_2;
      TLS1_3_VERSION:
        Result := TLSv1_3;
    else
      Raise ETaurusTLSInvalidSessionValue.Create(RSOSSInvalidSessionValue);
    end;
end;

function TTaurusTLSSocket.GetSSLProtocolVersionStr: string;
begin
  case SSLProtocolVersion of
    SSLv23:
      Result := 'SSLv2 or SSLv3';
    SSLv2:
      Result := 'SSLv2';
    SSLv3:
      Result := 'SSLv3';
    TLSv1:
      Result := 'TLS';
    TLSv1_1:
      Result := 'TLSv1.1';
    TLSv1_2:
      Result := 'TLSv1.2';
    TLSv1_3:
      Result := 'TLSv1.3';
  end;
end;

function TTaurusTLSSocket.GetPeerCert: TTaurusTLSX509;
var
  LX509: PX509;
begin
  if fPeerCert = nil then
  begin
    LX509 := SSL_get_peer_certificate(fSSL);
    if LX509 <> nil then
    begin
      fPeerCert := TTaurusTLSX509.Create(LX509, False);
    end;
  end;
  Result := fPeerCert;
end;

function TTaurusTLSSocket.GetSSLCipher: TTaurusTLSCipher;
begin
  if (fSSLCipher = nil) and (fSSL <> nil) then
  begin
    fSSLCipher := TTaurusTLSCipher.Create(Self);
  end;
  Result := fSSLCipher;
end;

function TTaurusTLSSocket.GetSessionIDAsString: String;
var
  LData: TTaurusTLSByteArray;
  i: TIdC_UINT;
  LDataPtr: PByte;
  pSession: PSSL_SESSION;
begin
  Result := ''; { Do not Localize }

  LData._Length := 0;
  LData.Data := nil;
{$IFNDEF OPENSSL_STATIC_LINK_MODEL}
  if Assigned(SSL_get_session) and Assigned(SSL_SESSION_get_id) then
{$ENDIF}
  begin
    if fSSL <> nil then
    begin
      pSession := SSL_get_session(fSSL);
      if pSession <> nil then
      begin
        LData.Data := SSL_SESSION_get_id(pSession, @LData._Length);
      end;
    end;
  end;
  if LData._Length > 0 then
  begin
    for i := 0 to LData._Length - 1 do
    begin
      // RLebeau: not all Delphi versions support indexed access using PByte
      LDataPtr := LData.Data;
      Inc(LDataPtr, i);
      Result := Result + IndyFormat('%.2x', [LDataPtr^]); { do not localize }
    end;
  end;
end;

/// ////////////////////////////////////////////////////////////
// TTaurusTLSCipher
/// ////////////////////////////////////////////////////////////
constructor TTaurusTLSCipher.Create(AOwner: TTaurusTLSSocket);
begin
  inherited Create;
  fSSLSocket := AOwner;
  Self.fSSLCipher := nil;
end;

destructor TTaurusTLSCipher.Destroy;
begin
  inherited Destroy;
end;

function TTaurusTLSCipher.GetDescription;
var
  buf: array [0 .. 1024] of TIdAnsiChar;
begin
  Result := String(SSL_CIPHER_description(GetSSLCipher, @buf[0],
    SizeOf(buf) - 1));
end;

function TTaurusTLSCipher.GetName: String;
begin
  Result := String(SSL_CIPHER_get_name(GetSSLCipher));
end;

function TTaurusTLSCipher.GetSSLCipher: PSSL_CIPHER;
begin
  if not Assigned(fSSLCipher) then
  begin
    fSSLCipher := SSL_get_current_cipher(fSSLSocket.SSL);
  end;
  Result := fSSLCipher;
end;

function TTaurusTLSCipher.GetBits: TIdC_INT;
begin
  Result := 0;
  SSL_CIPHER_get_bits(GetSSLCipher, Result);
end;

function TTaurusTLSCipher.GetVersion: String;
begin
  Result := String(SSL_CIPHER_get_version(GetSSLCipher));
end;

{$I TaurusTLSSymbolDeprecatedOff.inc}

initialization

Assert(SSLIsLoaded = nil);
SSLIsLoaded := TIdThreadSafeBoolean.Create;

{$I TaurusTLSSymbolDeprecatedOff.inc}
RegisterSSL('TaurusTLS', 'TaurusTLS Developers', { do not localize }
  'Copyright ' + Char(169) + ' 2014'#10#13 + { do not localize }
  'TaurusTLS Developers. All rights reserved.', { do not localize }
  'Open SSL 1.1.1 and 3.x DLL Delphi and C++Builder interface',
  { do not localize }
  'https://github.com/JPeterMugaas/TaurusTLS'#10#13 + { do not localize }
  'Original Authors - J. Peter Mugaas and Tony Whyman', { do not localize }
  TTaurusTLSIOHandlerSocket, TTaurusTLSServerIOHandler);
{$I TaurusTLSSymbolDeprecatedOn.inc}
TTaurusTLSIOHandlerSocket.RegisterIOHandler;

finalization

// TODO: TTaurusTLSIOHandlerSocket.UnregisterIOHandler;
UnLoadOpenSSLLibrary;
// free the lock last as unload makes calls that use it
FreeAndNil(SSLIsLoaded);

end.

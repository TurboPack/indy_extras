{******************************************************************************}
{*  TaurusTLS                                                                 *}
{*           https://github.com/JPeterMugaas/TaurusTLS                        *}
{*                                                                            *}
{*  Copyright (c) 2024 - 2025 TaurusTLS Developers, All Rights Reserved       *}
{*                                                                            *}
{* Portions of this software are Copyright (c) 1993 – 2018,                   *}
{* Chad Z. Hower (Kudzu) and the Indy Pit Crew – http://www.IndyProject.org/  *}
{******************************************************************************}
{$I TaurusTLSCompilerDefines.inc}
///  <summary>
///  Declares classes to Encrypt/Decrypt sensitive configuration values
///  like private keys in memory.
///  </summary>

unit TaurusTLS_Encryptors;
{$I TaurusTLSLinkDefines.inc}

interface

uses
  SysUtils, TaurusTLSHeaders_types,
  TaurusTLSHeaders_evp, TaurusTLSExceptionHandlers, TaurusTLS_Random,
  IdGlobal, IdCTypes;

type
  ///  <summary>
  ///  Exception class indicates error(s) in Encryption cipher configuration
  ///  </summary>
  ///  <seealso cref="TTaurusTLS_Cipher" />
  ETaurusTLSCipherError = class(ETaurusTLSAPICryptoError);
  ///  <summary>
  ///  Exception class indicates error(s) in data Encryption or Decryption
  ///  </summary>
  ///  <seealso cref="TTaurusTLS_CustomEncryptor" />
  ETaurusTLSEncryptorError = class(ETaurusTLSAPICryptoError);

  ///  <summary>
  ///  Manages OpenSSL the <c>cipher algorithm</c> used in
  ///  symmetric Encryption and Decription operations.
  ///  </summary>
  TTaurusTLS_Cipher = class
{$IFDEF USE_STRICT_PRIVATE_PROTECTED}strict{$ENDIF} private
    FOwnCipher: boolean;
    FCipher: PEVP_CIPHER;
    FBlockSize: TIdC_UINT;
    FKeyLen: TIdC_UINT;
    FIVLen: TIdC_UINT;
    FBlock2P: TIdC_UINT;
    FFlags: TIdC_ULONG;
    FMode: TIdC_INT;
  public
    ///  <summary>
    ///  Initializes the instance internal fileds based on <see name="ACipher">value</see>
    ///  </summary>
    ///  <param name="ACipher">
    ///  Pointer to the <c>EVP_CIPHER</c> initialized by one of
    ///  <c>EVP_get_cipherbyname()</c>, <c>EVP_get_cipherbynid()</c> or <c>EVP_get_cipherbyobj()</c>
    ///  OpenSSL functions.
    ///  <seealso href="https://docs.openssl.org/3.3/man3/EVP_EncryptInit/#description" />
    ///  </param>
    ///  <param name="AOwnCipher">
    ///  Indicates whether the <c>TTaurusTLS_Cipher</c> needs to release
    ///  the pointer to <c>EVP_CIPHER</c> structure on destruction or not.
    ///  </param>
    constructor Create(ACipher: PEVP_CIPHER; AOwnCipher: boolean); overload;
    ///  <summary>
    ///  Initializes the instance using a <c>cipher algorithm</c> name registered in the
    ///  <c>OpenSSL</c> library
    ///  </summary>
    ///  <param name="ACipherName"> a Unicode string with a <c>cipher algorithm</c> name
    ///  </param>
    constructor Create(ACipherName: string); overload;
    ///  <summary>
    ///  Initializes the instance using a <c>cipher algorithm</c> name
    ///   registered in the <c>OpenSSL</c> library
    ///  </summary>
    ///  <param name="ACipherName"> a pointer to the null-terminated Ansi string
    ///  with a <c>cipher algorithm</c> name>
    ///  </param>
    constructor Create(ACipherName: PIdAnsiChar); overload;
    ///  <summary>
    ///  Destroys the instance and releases pointer to the <c>EVP_CIPHER</c>
    ///  structure if configured.
    ///  </summary>
    destructor Destroy; override;

    /// <summary>
    ///   Lookups a <c>cipher algorithm</c> by its name, initialize and returns
    ///   the pointer to <c>EVP_CIPHER</c> structure
    /// </summary>
    /// <param name="ACipherName">
    ///   a Unicode string with a <c>cipher algorithm</c> name
    /// </param>
    /// <returns>
    ///   The pointer to <c>EVP_CIPHER</c> structure
    /// </returns>
    /// <remarks>
    ///   The caller code is responcible to release returning pointer to <c>
    ///   EVP_CIPHER</c> structure using OpenSSL function <see
    ///   href="https://docs.openssl.org/3.0/man3/EVP_EncryptInit/">
    ///   EVP_CIPHER_free</see>.
    /// </remarks>
    class function GetCipherByName(ACipherName: string): PEVP_CIPHER;
      overload; static; {$IFDEF USE_INLINE}inline;{$ENDIF}
    /// <summary>
    ///   Lookups a <c>cipher algorithm</c> by its name, initialize and returns
    ///   pointer to <c>EVP_CIPHER</c> structure
    /// </summary>
    /// <param name="ACipherName">
    ///   a pointer to the null-terminated Ansi string with a <c>cipher
    ///   algorithm</c> name
    /// </param>
    /// <returns>
    ///   The pointer to <c>EVP_CIPHER</c> structure
    /// </returns>
    /// <remarks>
    ///   The caller code is responcible to release returning pointer to <c>
    ///   EVP_CIPHER</c> structure using OpenSSL function <see
    ///   href="https://docs.openssl.org/3.0/man3/EVP_EncryptInit/">
    ///   EVP_CIPHER_free</see>.
    /// </remarks>
    class function GetCipherByName(ACipherName: PIdAnsiChar): PEVP_CIPHER;
      overload; static; {$IFDEF USE_INLINE}inline;{$ENDIF}

    ///  <summary>
    ///  Creates <c>array of bytes</c> with length needed to be a <c>Key</c>
    ///  for symmetric Encryption and Decryption operations
    ///  with this <c>cipher algorithm</c>.
    ///  </summary>
    ///  <returns>
    ///  array of <c>random byte</c> values of length to be a <c>Key</c>
    ///  with the cipher.
    ///  </returns>
    function NewKey: TBytes; {$IFDEF USE_INLINE}inline;{$ENDIF}
    ///  <summary>
    ///  Creates <c>array of bytes</c> with length needed to be
    ///  an <c>Initialization Vector</c> for symmetric Encryption and Decryption
    ///  operations with this <c>cipher algorithm</c>.
    ///  </summary>
    ///  <returns>
    ///  array of <c>random byte</c> values of length to be
    ///  an <c>Initialization Vector</c> for symmetric Encryption and Decryption
    ///  operations with this <c>cipher algorithm</c>.
    ///  </returns>
    function NewIV: TBytes; {$IFDEF USE_INLINE}inline;{$ENDIF}

    ///  <summary>
    ///  Returns pointer to <c>EVP_CIPHER</c> structure
    ///  </summary>
    ///  <seealso href="https://docs.openssl.org/3.3/man3/EVP_EncryptInit/#description" />
    property Cipher: PEVP_CIPHER read FCipher;
    ///  <summary>
    ///  Returns <c>encryption key</c> length required for the
    ///  symmetric Encryption and Decryption operations.
    ///  </summary>
    property KeyLen: TIdC_UINT read FKeyLen;
    ///  <summary>
    ///  Returns <c>initialization vector</c> length required for the
    ///  symmetric Encryption and Decryption operations
    ///  </summary>
    property IVLen: TIdC_UINT read FIVLen;
    ///  <summary>
    ///  Returns <c>encryption block</c> size used in the symmetric Encryption
    ///  and Decryption operations
    ///  </summary>
    property BlockSize: TIdC_UINT read FBlockSize;
    ///  <summary>
    ///  Returns <c>encryption block</c> size value in power of 2
    ///  </summary>
    property BlockPower2: TIdC_UINT read FBlock2P;
    ///  <summary>
    ///  Returns the <c>flags</c> value configured for the <c>cipher algorithm</c>
    ///  </summary>
    ///  <seealso href="https://docs.openssl.org/3.3/man3/EVP_EncryptInit/#flags" />
    property Flags: TIdC_ULONG read FFlags;
    ///  <summary>
    ///  Returns the <c>mode</c> associated with the <c>cipher algorithm</c>
    ///  </summary>
    ///  <seealso href="https://docs.openssl.org/3.3/man3/EVP_EncryptInit/#flags" />
    property Mode: TIdC_INT read FMode;
  end;


  ///  <summary>
  ///  The <c>TTaurusTLS_CustomEncryptor</c> class is the base class
  ///  for classes implementing the symmetric Encryption and Decryption operations
  ///  on array of bytes.
  ///  </summary>
  ///  <seealso name="TBytes" />
  TTaurusTLS_CustomEncryptor = class abstract
{$IFDEF USE_STRICT_PRIVATE_PROTECTED}strict{$ENDIF} private
    FCipher: TTaurusTLS_Cipher;
    FCtx: PEVP_CIPHER_CTX;
    FKey: TBytes;
    FIV: TBytes;

    function GetBlockPower2: TIdC_UINT;
    function GetBlockSize: TIdC_UINT;
    function GetFlags: TIdC_ULONG;
    function GetIVLen: TIdC_UINT;
    function GetKeyLen: TIdC_UINT;
    function GetMode: TIdC_INT;

{$IFDEF USE_STRICT_PRIVATE_PROTECTED}strict{$ENDIF} protected
    ///  <summary>
    ///  Allocates and returns a pointer to <c>Openssl cipher context</c>
    ///  </summary>
    ///  <seealso href="https://docs.openssl.org/3.3/man3/EVP_EncryptInit/#description" />
    ///  <returns>pointer to <c>OpenSSL EVP_CIPHER_CTX</c> structure.
    ///  </returns>
    function NewContext: PEVP_CIPHER_CTX;
    ///  <summary>
    ///  Returns minimal output buffer size required for the
    ///  symmetric Encryption or Decryption operation.
    ///  </summary>
    ///  <param name="ASize"> Initial buffer size in bytes
    ///  </param>
    ///  <returns>
    ///  A minimal buffer size value for the symmetric Encryption or Decryption operation.
    ///  </returns>
    function GetAdjustedSize(ASize: TIdC_SIZET): TIdC_SIZET;
      {$IFDEF USE_INLINE}inline;{$ENDIF}

    ///  <summary>
    ///  Implements base Decryption functionality can be used by inherited class(es)
    ///  to Decrypt the <c>array of bytes</c> Encryipted with this instance.
    ///  </summary>
    procedure DefaultDecrypt(const ASecret: TBytes; var APlain: TBytes);
    ///  <summary>
    ///  Implements base Encryption functionality can be used by inherited class(es)
    ///  to Encrypt the <c>array of bytes</c>.
    ///  </summary>
    procedure DefaultEncrypt(const APlain: TBytes; var ASecret: TBytes);

    ///  <summary>
    ///  Returns a pointer to <c>Openssl cipher context</c> used by the instance
    ///  </summary>
    property Ctx: PEVP_CIPHER_CTX read FCtx;

  public
    ///  <summary>
    ///  Create the class instance and initialize internal fields
    ///  </summary>
    ///  <param name="ACipher"> An instance of <c>TTaurusTLS_Cipher</c>
    ///  <seealso cref="TTaurusTLS_Cipher" />
    ///  </param>
    constructor Create(ACipher: TTaurusTLS_Cipher);
    ///  <summary>
    ///  Destroys instance and release a pointer to <c>Openssl cipher context</c>,
    ///  </summary>
    destructor Destroy; override;
    ///  <summary>
    ///  Abstract method must be implemented by inherited class(es).
    ///  Implements an symmetric Encryption operation on <c>array of bytes</c>
    ///  </summary>
    ///  <param name="APlain"> An <c>array of bytes</c> should be encrypted.
    ///  </param>
    ///  <param name="AEncrypted"> An <c>array of bytes</c> where Encrypted data
    ///  will be stored.
    ///  <remarks>The size of array is automatically asjustes based on
    ///  the <c>cipher algorithm</c> used.</remarks>
    ///  </param>
    procedure Encrypt(const APlain: TBytes; out AEncrypted: TBytes); virtual; abstract;
    ///  <summary>
    ///  Abstract method must be implemented by inherited class(es).
    ///  Implements an symmetric Decryption operation on <c>array of bytes</c>
    ///  </summary>
    ///  <param name="AEncrypted"> An <c>array of bytes</c> should be decrypted.
    ///  </param>
    ///  <param name="APlain"> An <c>array of bytes</c> where Decrypted data
    ///  will be stored.
    ///  <remarks>The size of array is automatically asjustes based on
    ///  the <c>cipher algorithm</c> used.</remarks>
    ///  </param>
    procedure Decrypt(const AEncrypted: TBytes; out APlain: TBytes); virtual; abstract;

    ///  <summary>
    ///  Returns <c>encryption key</c> length used for the
    ///  symmetric Encryption and Decryption operations.
    ///  </summary>
    property KeyLen: TIdC_UINT read GetKeyLen;
    ///  <summary>
    ///  Returns <c>initialization vector</c> length used for the
    ///  symmetric Encryption and Decryption operations
    ///  </summary>
    property IVLen: TIdC_UINT read GetIVLen;
    ///  <summary>
    ///  Returns <c>encryption block</c> size used in the symmetric Encryption
    ///  and Decryption operations
    ///  </summary>
    property BlockSize: TIdC_UINT read GetBlockSize;
    ///  <summary>
    ///  Returns <c>encryption block</c> size value in power of 2
    ///  </summary>
    property BlockPower2: TIdC_UINT read GetBlockPower2;
    ///  <summary>
    ///  Returns the <c>flags</c> value configured for the <c>cipher algorithm</c>
    ///  </summary>
    ///  <seealso href="https://docs.openssl.org/3.3/man3/EVP_EncryptInit/#flags" />
    property Flags: TIdC_ULONG read GetFlags;
    ///  <summary>
    ///  Returns the <c>mode</c> associated with the <c>cipher algorithm</c>
    ///  </summary>
    ///  <seealso href="https://docs.openssl.org/3.3/man3/EVP_EncryptInit/#flags" />
    property Mode: TIdC_INT read GetMode;
  end;

  ///  <summary>
  ///  Enum type defines the <c>Advanced Encryption Standard (AES) cipher algorithm</c> family <c>cipher algorithm</c> sizes
  ///  </summary>
  TTaurusTLS_AESKeySize = (
    ///  <summary>
    ///  Advanced Encryption Standard (AES) 128 bits
    ///  </summary>
    aks128,
    ///  <summary>
    ///  Advanced Encryption Standard (AES) 192 bits
    ///  </summary>
    aks192,
    ///  <summary>
    ///  Advanced Encryption Standard (AES) 256 bits
    ///  </summary>
    aks256);
  ///  <summary>
  ///  Enum type defines <c>cipher algorithm</c> encode modes
  ///  </summary>
  TTaurusTLS_EncodeModeWide = (
    ///  <summary>
    ///  Stream Cipher
    ///  </summary>
    emStream=EVP_CIPH_STREAM_CIPHER,
    ///  <summary>
    ///  Electronic Codebook (ECB)
    ///  </summary>
    emECB=EVP_CIPH_ECB_MODE,
    ///  <summary>
    ///  Cipher block chaining (CBC)
    ///  </summary>
    emCBC=EVP_CIPH_CBC_MODE,
    ///  <summary>
    ///  Cipher Feedback (CFB)
    ///  </summary>
    emCFB=EVP_CIPH_CFB_MODE,
    ///  <summary>
    ///  Output Feedback (OFB)
    ///  </summary>
    emOFB=EVP_CIPH_OFB_MODE,
    ///  <summary>
    ///  Counter (CTR)
    ///  </summary>
    emCTR=EVP_CIPH_CTR_MODE,
    ///  <summary>
    ///  Galois/Counter Mode (GCM)
    ///  </summary>
    emGCM=EVP_CIPH_GCM_MODE,
    ///  <summary>
    ///  Counter with Cipher block chaining Message authentication code;
    ///  counter (CCM)
    ///  </summary>
    emCCM=EVP_CIPH_CCM_MODE);
  ///  <summary>
  ///  Enum type defines subset of <c>cipher algorithm</c> encode modes
  ///  from <see cref="emCFB">Cipher Feedback (CFB)</see>
  ///  to <see cref="emCTR">Counter (CTR)</see>
  ///  used by <see cref="TTaurusTLS_SimpleAESEncryptor" /> class.
  ///  </summary>
  TTaurusTLS_SimleAESEncodeMode = emCBC..emCTR;

  ///  <summary>
  ///  Implements symmetric Encryption and Decryption functionality
  ///  using subset of <c>cipher algorithms</c>
  ///  </summary>
  TTaurusTLS_SimpleAESEncryptor = class(TTaurusTLS_CustomEncryptor)
  protected
    ///  <summary>
    ///  Builds the Advanced Encryption Standard (AES) <c>cipher algorithm</c> name using parameters
    ///  </summary>
    ///  <param name="AKeySize">Advanced Encryption Standard (AES) <c>cipher algorithm</c> key size.
    ///  </param>
    ///  <param name="AEncoderMode">Advanced Encryption Standard (AES) <c>cipher algorithm</c> encode mode.
    ///  </param>
    class function BuildCipherName(AKeySize: TTaurusTLS_AESKeySize;
      AEncoderMode: TTaurusTLS_SimleAESEncodeMode): string; static; {$IFDEF USE_INLINE}inline;{$ENDIF}
  public
    ///  <summary>
    ///  Creates instance of <c>TTaurusTLS_SimpleAESEncryptor</c> type
    ///  with provided parameters.
    ///  </summary>
    ///  <param name="AKeySize">Advanced Encryption Standard (AES) <c>cipher algorithm</c> key size.
    ///  </param>
    ///  <param name="AEncoderMode">Advanced Encryption Standard (AES) <c>cipher algorithm</c> encode mode.
    ///  </param>
    constructor Create(AKeySize: TTaurusTLS_AESKeySize;
      AEncoderMode: TTaurusTLS_SimleAESEncodeMode);
    ///  <summary>
    ///  Implements <c>Advanced Encryption Standard (AES)</c> encryption mechanism
    ///  </summary>
    procedure Encrypt(const APlain: TBytes; out AEncrypted: TBytes); override;
    ///  <summary>
    ///  Implements <c>Advanced Encryption Standard (AES)</c> decryption mechanism
    ///  </summary>
    procedure Decrypt(const AEncrypted: TBytes; out APlain: TBytes); override;
  end;

  ///  <summary>
  ///  This class implements singleton factory to issue instances of
  ///  <see cref="TTaurusTLS_SimpleAESEncryptor"> type.</see>
  ///  </summary>
  TTaurusTLS_SimpleAESFactory = class
{$IFDEF USE_STRICT_PRIVATE_PROTECTED}strict{$ENDIF} private class var
    FFactory: TTaurusTLS_SimpleAESFactory;
{$IFDEF DCC}
    FLock: TMultiReadExclusiveWriteSynchronizer;
{$ELSE}
    FLock: TIdCriticalSection;
{$ENDIF}
{$IFDEF USE_STRICT_PRIVATE_PROTECTED}strict{$ENDIF} private
    FKeySize: TTaurusTLS_AESKeySize;
    FEncodeMode: TTaurusTLS_SimleAESEncodeMode;
    class function GetEncoderMode: TTaurusTLS_SimleAESEncodeMode; static;
    class function GetKeySize: TTaurusTLS_AESKeySize; static;
    class function GetEncodingModeName(AEncoderMode: TTaurusTLS_SimleAESEncodeMode): string;
      static; {$IFDEF USE_INLINE}inline;{$ENDIF}
    class function GetKeySizeName(AKeySize: TTaurusTLS_AESKeySize): string;
      static; {$IFDEF USE_INLINE}inline;{$ENDIF}
  protected const
    // DO NOT LOCALIZE
    cKeySizes: array[TTaurusTLS_AESKeySize] of string = ('128','192','256');
    cEncoderModes: array[TTaurusTLS_SimleAESEncodeMode] of string =
      ('CBC','CFB','OFB','CTR');
    cDefaultKey = aks192;
    cDefaultEncoder = emCFB;
  protected
    class function BuildCipherName(AKeySize: TTaurusTLS_AESKeySize;
      AEncoderMode: TTaurusTLS_SimleAESEncodeMode): string; static;
      {$IFDEF USE_INLINE}inline;{$ENDIF}
    class procedure BeginRead; static; {$IFDEF USE_INLINE}inline;{$ENDIF}
    class procedure BeginWrite; static; {$IFDEF USE_INLINE}inline;{$ENDIF}
    class procedure EndRead; static; {$IFDEF USE_INLINE}inline;{$ENDIF}
    class procedure EndWrite; static; {$IFDEF USE_INLINE}inline;{$ENDIF}
    class function GetFactory: TTaurusTLS_SimpleAESFactory; static;
      {$IFDEF USE_INLINE}inline;{$ENDIF}
    class property Factory: TTaurusTLS_SimpleAESFactory read GetFactory;

{$IFDEF FPC}
  {$WARN 3018 off : Constructor should be public}
{$ENDIF}
    // constructor defined i protected section intentionally
    // the Factory instance can be created only by class Factory methods.
    constructor Create(AKeySize: TTaurusTLS_AESKeySize;
      AEncoderMode: TTaurusTLS_SimleAESEncodeMode);
{$IFDEF FPC}
  {$WARN 3018 on : Constructor should be public}
{$ENDIF}
  public
    ///  <summary>
    ///  Initializes the factory
    ///  </summary>
    class constructor Create;
    ///  <summary>
    ///  Releases resources used by a factory
    ///  </summary>
    class destructor Destroy;
    ///  <summary>
    ///  Changes the factory default <c>cipher algorithm</c> will be used
    ///  in the instances of <seealso cref="TTaurusTLS_SimpleAESEncryptor" /> class
    ///  issed after this call.
    ///  </summary>
    ///  <param name="AKeySize"> An <c>Advanced Encryption Standard (AES) cipher algorithm</c> key size
    ///  </param>
    ///  <param name="AEncoderMode"> An <c>Advanced Encryption Standard (AES) cipher algorithm</c> encode mode
    ///  </param>
    class procedure SetDefaultCipher(AKeySize: TTaurusTLS_AESKeySize;
      AEncoderMode: TTaurusTLS_SimleAESEncodeMode);
    ///  <summary>
    ///  Initializes and issues new instance of <seealso cref="TTaurusTLS_SimpleAESEncryptor" />
    ///  type with defualt <c>Advanced Encryption Standard (AES) cipher algorithm</c>.
    ///  </summary>
    ///  <returns>
    ///  An instance of <seealso cref="TTaurusTLS_SimpleAESEncryptor" /> type.
    ///  </returns>
    class function NewEncryptor: TTaurusTLS_SimpleAESEncryptor; overload;
      static; {$IFDEF USE_INLINE}inline;{$ENDIF}
    ///  <summary>
    ///  Initializes and issues new instance of <seealso cref="TTaurusTLS_SimpleAESEncryptor" />
    ///  type with cpecific <c>Advanced Encryption Standard (AES) cipher algorithm</c>.
    ///  </summary>
    ///  <param name="AKeySize"> An <c>Advanced Encryption Standard (AES) cipher algorithm</c> key size
    ///  </param>
    ///  <param name="AEncoderMode"> An <c>Advanced Encryption Standard (AES) cipher algorithm</c> encode mode
    ///  </param>
    ///  <returns>
    ///  An instance of <seealso cref="TTaurusTLS_SimpleAESEncryptor" /> type.
    ///  </returns>
    class function NewEncryptor(AKeySize: TTaurusTLS_AESKeySize;
      AEncoderMode: TTaurusTLS_SimleAESEncodeMode): TTaurusTLS_SimpleAESEncryptor;
      overload; static; {$IFDEF USE_INLINE}inline;{$ENDIF}

    ///  <summary>
    ///  Returns the encyption key size of default <c>Advanced Encryption Standard (AES) cipher algorithm</c>
    ///  used to issue <seealso cref="TTaurusTLS_SimpleAESEncryptor" /> instances.
    ///  </summary>
    class property DefaultKeySize: TTaurusTLS_AESKeySize read GetKeySize;
    ///  <summary>
    ///  Returns the encyption encode mode of default <c>Advanced Encryption Standard (AES) cipher algorithm</c>
    ///  used to issue <seealso cref="TTaurusTLS_SimpleAESEncryptor" /> instances.
    ///  </summary>
    class property DefaultEncodeMode: TTaurusTLS_SimleAESEncodeMode read GetEncoderMode;
    ///  <summary>
    ///  Returns string representing symbol name of <see name="AKeySize">property</see>
    ///  </summary>
    class property KeySizeName[AKeySize: TTaurusTLS_AESKeySize]: string
      read GetKeySizeName;
    ///  <summary>
    ///  Returns string representing symbol name of <see name="AEncoderMode">property</see>
    ///  </summary>
    class property EncodeModeName[AEncoderMode: TTaurusTLS_SimleAESEncodeMode]: string
      read GetEncodingModeName;
  end;

implementation

uses
  TaurusTLSHeaders_evperr, TaurusTLS_ResourceStrings;

function OsslSucceeded(AResult: TIdC_INT): boolean;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result:=AResult = 1;
end;

function OsslFailed(AResult: TIdC_INT): boolean;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result:=AResult <> 1;
end;

{ TOSSLCipher }

constructor TTaurusTLS_Cipher.Create(ACipher: PEVP_CIPHER; AOwnCipher: boolean);

  {$R-}{$Q-}
  function BitsP2(ABytes: NativeUInt): byte; {$IFDEF USE_INLINE}inline;{$ENDIF}
  begin
    Result:=0;
    while ABytes > 1 do
    begin
      Inc(Result);
      ABytes:=ABytes shr 1;
    end;
  end;
  {$Q+}{$R+}

begin
  inherited Create;
  if not Assigned(ACipher) then
     ETaurusTLSCipherError.RaiseWithMessage(REVP_Cipher_NoCipherProvided);
  FCipher:=ACipher;
  FOwnCipher:=AOwnCipher;
  FKeyLen:=EVP_CIPHER_get_key_length(ACipher);
  if FKeyLen = 0 then
    FKeyLen:=EVP_MAX_KEY_LENGTH;
  FIVLen:=EVP_CIPHER_get_iv_length(ACipher);
  if FIVLen = 0 then
    FIVLen:=EVP_MAX_IV_LENGTH;
  FBlockSize:=EVP_CIPHER_get_block_size(ACipher);
  FBlock2P:=BitsP2(FBlockSize);
  FFlags:=EVP_CIPHER_get_flags(ACipher);
  FMode:=EVP_CIPHER_get_mode(ACipher);
end;

constructor TTaurusTLS_Cipher.Create(ACipherName: string);
begin
  Create(GetCipherByName(ACipherName), True);
end;

constructor TTaurusTLS_Cipher.Create(ACipherName: PIdAnsiChar);
begin
  Create(GetCipherByName(ACipherName), True);
end;

destructor TTaurusTLS_Cipher.Destroy;
begin
  if FOwnCipher and Assigned(FCipher) then
    EVP_CIPHER_free(FCipher);
  inherited;
end;

class function TTaurusTLS_Cipher.GetCipherByName(
  ACipherName: PIdAnsiChar): PEVP_CIPHER;
begin
  Result:=EVP_Cipher_fetch(nil, ACipherName, nil);
end;

class function TTaurusTLS_Cipher.GetCipherByName(
  ACipherName: string): PEVP_CIPHER;
var
  lAnsiStr: RawByteString;

begin
  lAnsiStr:=AnsiString(ACipherName); //expicit conversion from Unicode to Ansi string
  Result:=GetCipherByName(PIdAnsiChar(lAnsiStr));
end;

function TTaurusTLS_Cipher.NewIV: TBytes;
begin
  Result:=TTaurusTLS_Random.PublicRandom.Random(IVLen);
end;

function TTaurusTLS_Cipher.NewKey: TBytes;
begin
  Result:=TTaurusTLS_Random.PrivateRandom.Random(KeyLen);
end;

{ TTaurusTLS_CustomEncryptor }

constructor TTaurusTLS_CustomEncryptor.Create(ACipher: TTaurusTLS_Cipher);
begin
  inherited Create;
  if not Assigned(ACipher) then
    raise ETaurusTLSEncryptorError.Create(REVP_EncryptDecrypt_InitNoCipher);
  FCipher:=ACipher;
  FKey:=ACipher.NewKey;
  FIV:=ACipher.NewIV;
  FCtx:=NewContext;
end;

destructor TTaurusTLS_CustomEncryptor.Destroy;
begin
  EVP_CIPHER_CTX_free(FCtx);
  FreeAndNil(FCipher);
  inherited;
end;

procedure TTaurusTLS_CustomEncryptor.DefaultEncrypt(const APlain: TBytes;
  var ASecret: TBytes);
var
  lLen, lResultLen: TIdC_INT;
  lCipher: PEVP_CIPHER;
  lCtx: PEVP_CIPHER_CTX;

  procedure RaiseException;
  begin
    ETaurusTLSEncryptorError.RaiseException(REVP_Encryptor_Encrypt_Error);
  end;

begin
  lLen:=Length(APlain);
  if lLen = 0 then
  begin
    SetLength(ASecret, 0);
    Exit;
  end;
  try
    lCtx := Ctx;
    lCipher := FCipher.Cipher;
    SetLength(ASecret, GetAdjustedSize(lLen));
    if OsslFailed(EVP_CipherInit_ex(lCtx, lCipher, nil, @FKey[0], @FIV[0],
      Ord(True))) then
      RaiseException;
{$IFDEF FPC}
  {$warn 5057 OFF}
{$ENDIF}
    if OsslFailed(EVP_CipherUpdate(lCtx, ASecret[0], lResultLen, APlain[0],
      lLen)) then
{$IFDEF FPC}
  {$warn 5057 ON}
{$ENDIF}
      RaiseException;
    if OsslFailed(EVP_CipherFinal_ex(lCtx, ASecret[lResultLen], lLen)) then
      RaiseException;
    SetLength(ASecret, lResultLen + lLen);
  except
    SetLength(ASecret, 0);
    raise;
  end;
end;

procedure TTaurusTLS_CustomEncryptor.DefaultDecrypt(const ASecret: TBytes;
  var APlain: TBytes);
var
  lLen, lResultLen: TIdC_INT;
  lCipher: PEVP_CIPHER;
  lCtx: PEVP_CIPHER_CTX;

  procedure RaiseException;
  begin
    ETaurusTLSEncryptorError.RaiseException(REVP_Encryptor_Decrypt_Error);
  end;

begin
  lLen:=Length(ASecret);
  if lLen = 0 then
  begin
    SetLength(APlain, 0);
    Exit;
  end;
  try
    lCtx := Ctx;
    lCipher := FCipher.Cipher;
    SetLength(APlain, GetAdjustedSize(lLen));
    if OsslFailed(EVP_CipherInit_ex(lCtx, lCipher, nil, @FKey[0], @FIV[0],
      Ord(False))) then
      RaiseException;
{$IFDEF FPC}
  {$warn 5057 OFF}
{$ENDIF}
    if OsslFailed(EVP_CipherUpdate(lCtx, APlain[0], lResultLen, ASecret[0],
      lLen)) then
{$IFDEF FPC}
  {$warn 5057 ON}
{$ENDIF}
      RaiseException;
    if OsslFailed(EVP_CipherFinal_ex(lCtx, APlain[lResultLen], lLen)) then
      RaiseException;
    SetLength(APlain, lResultLen + lLen);
  except
    SetLength(APlain, 0);
    raise;
  end;
end;

function TTaurusTLS_CustomEncryptor.GetAdjustedSize(
  ASize: TIdC_SIZET): TIdC_SIZET;
var
  lBlockSize: TIdC_UINT;
  lBits: TIdC_UINT;

begin
  lBlockSize:=FCipher.BlockSize;
  lBits:=FCipher.BlockPower2;
  Result:=(((ASize+lBlockSize) shr lBits) shl lBits)+lBlockSize;
end;

function TTaurusTLS_CustomEncryptor.GetBlockPower2: TIdC_UINT;
begin
  Result:=FCipher.BlockPower2;
end;

function TTaurusTLS_CustomEncryptor.GetBlockSize: TIdC_UINT;
begin
  Result:=FCipher.BlockSize;
end;

function TTaurusTLS_CustomEncryptor.GetFlags: TIdC_ULONG;
begin
  Result:=FCipher.Flags;
end;

function TTaurusTLS_CustomEncryptor.GetIVLen: TIdC_UINT;
begin
  Result:=FCipher.IVLen;
end;

function TTaurusTLS_CustomEncryptor.GetKeyLen: TIdC_UINT;
begin
  Result:=FCipher.KeyLen;
end;

function TTaurusTLS_CustomEncryptor.GetMode: TIdC_INT;
begin
  Result:=FCipher.Mode;
end;

function TTaurusTLS_CustomEncryptor.NewContext: PEVP_CIPHER_CTX;
begin
  Result:=EVP_CIPHER_CTX_new;
  if not Assigned(Result) then
    ETaurusTLSEncryptorError.RaiseException(REVP_Encryptor_CtxInitError);
end;

{ TTaurusTLS_SimpleAESEncryptor }

constructor TTaurusTLS_SimpleAESEncryptor.Create(AKeySize: TTaurusTLS_AESKeySize;
  AEncoderMode: TTaurusTLS_SimleAESEncodeMode);
begin
  inherited Create(TTaurusTLS_Cipher.Create(
    BuildCipherName(AKeySize, AEncoderMode)));
end;

procedure TTaurusTLS_SimpleAESEncryptor.Encrypt(const APlain: TBytes;
  out AEncrypted: TBytes);
begin
{$IFDEF FPC}
  {$warn 5092 OFF}
{$ENDIF}
  DefaultEncrypt(APlain, AEncrypted);
{$IFDEF FPC}
  {$warn 5092 ON}
{$ENDIF}
end;

procedure TTaurusTLS_SimpleAESEncryptor.Decrypt(const AEncrypted: TBytes;
  out APlain: TBytes);
begin
{$IFDEF FPC}
  {$warn 5092 OFF}
{$ENDIF}
  DefaultDecrypt(AEncrypted, APlain);
{$IFDEF FPC}
  {$warn 5092 ON}
{$ENDIF}
end;

class function TTaurusTLS_SimpleAESEncryptor.BuildCipherName(
  AKeySize: TTaurusTLS_AESKeySize; AEncoderMode: TTaurusTLS_SimleAESEncodeMode): string;
begin
  Result:=TTaurusTLS_SimpleAESFactory.BuildCipherName(AKeySize, AEncoderMode);
end;

{ TTaurusTLS_SimpleAESFactory }

class constructor TTaurusTLS_SimpleAESFactory.Create;
begin
{$IFDEF DCC}
  FLock:=TMultiReadExclusiveWriteSynchronizer.Create;
{$ELSE}
  FLock:=TIdCriticalSection.Create;
{$ENDIF}
end;

constructor TTaurusTLS_SimpleAESFactory.Create(AKeySize: TTaurusTLS_AESKeySize;
  AEncoderMode: TTaurusTLS_SimleAESEncodeMode);
begin
  FKeySize:=AKeySize;
  FEncodeMode:=AEncoderMode;
end;

class destructor TTaurusTLS_SimpleAESFactory.Destroy;
begin
  FreeAndNil(FFactory);
  FreeAndNil(FLock);
end;

class function TTaurusTLS_SimpleAESFactory.BuildCipherName(
  AKeySize: TTaurusTLS_AESKeySize;
  AEncoderMode: TTaurusTLS_SimleAESEncodeMode): string;
begin
  Result:=Format('AES-%s-%s',
    [cKeySizes[AKeySize], cEncoderModes[AEncoderMode]]);
end;

class procedure TTaurusTLS_SimpleAESFactory.BeginRead;
begin
{$IFDEF DCC}
  FLock.BeginRead;
{$ELSE}
  FLock.Enter;
{$ENDIF}
end;

class procedure TTaurusTLS_SimpleAESFactory.BeginWrite;
begin
{$IFDEF DCC}
  FLock.BeginWrite;
{$ELSE}
  FLock.Enter;
{$ENDIF}
end;

class procedure TTaurusTLS_SimpleAESFactory.EndRead;
begin
{$IFDEF DCC}
  FLock.EndRead;
{$ELSE}
  FLock.Leave;
{$ENDIF}
end;

class procedure TTaurusTLS_SimpleAESFactory.EndWrite;
begin
{$IFDEF DCC}
  FLock.EndWrite;
{$ELSE}
  FLock.Leave;
{$ENDIF}
end;

class function TTaurusTLS_SimpleAESFactory.GetFactory: TTaurusTLS_SimpleAESFactory;
begin
  BeginRead;
  try
    if not Assigned(FFactory) then
      SetDefaultCipher(cDefaultKey, cDefaultEncoder);
    Result:=FFactory;
  finally
    EndRead;
  end;
end;

class function TTaurusTLS_SimpleAESFactory.GetKeySize: TTaurusTLS_AESKeySize;
begin
  Result:=GetFactory.FKeySize;
end;

class function TTaurusTLS_SimpleAESFactory.GetEncoderMode: TTaurusTLS_SimleAESEncodeMode;
begin
  Result:=GetFactory.FEncodeMode;
end;

class function TTaurusTLS_SimpleAESFactory.GetKeySizeName(
  AKeySize: TTaurusTLS_AESKeySize): string;
begin
  Result:=cKeySizes[AKeySize];
end;

class function TTaurusTLS_SimpleAESFactory.GetEncodingModeName(
  AEncoderMode: TTaurusTLS_SimleAESEncodeMode): string;
begin
  Result:=cEncoderModes[AEncoderMode];
end;

class function TTaurusTLS_SimpleAESFactory.NewEncryptor: TTaurusTLS_SimpleAESEncryptor;
var
  lFactory: TTaurusTLS_SimpleAESFactory;

begin
  BeginRead;
  try
    lFactory:=GetFactory;
    Result:=NewEncryptor(lFactory.FKeySize, lFactory.FEncodeMode);
  finally
    EndRead;
  end;
end;

class function TTaurusTLS_SimpleAESFactory.NewEncryptor(
  AKeySize: TTaurusTLS_AESKeySize;
  AEncoderMode: TTaurusTLS_SimleAESEncodeMode): TTaurusTLS_SimpleAESEncryptor;
begin
  Result:=TTaurusTLS_SimpleAESEncryptor.Create(AKeySize, AEncoderMode);
end;

class procedure TTaurusTLS_SimpleAESFactory.SetDefaultCipher(
  AKeySize: TTaurusTLS_AESKeySize; AEncoderMode: TTaurusTLS_SimleAESEncodeMode);
begin
  BeginWrite;
  try
    FFactory.Free;
    FFactory:=TTaurusTLS_SimpleAESFactory.Create(AKeySize, AEncoderMode);
  finally
    EndWrite;
  end;
end;

end.

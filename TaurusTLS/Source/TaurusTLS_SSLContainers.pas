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
///   <summary>
///   Implements "container" classes to operate with OpenSSL public and private entities.
///   </summary>

unit TaurusTLS_SSLContainers;
{$I TaurusTLSLinkDefines.inc}

interface

uses
  Classes, {$IFDEF DCC}SyncObjs,{$ENDIF}SysUtils, TaurusTLS_Encryptors,
  TaurusTLSHeaders_types, TaurusTLSHeaders_bio, TaurusTLSExceptionHandlers,
  IdGlobal, IdCTypes;

type
  ///  <summary>
  ///  Exception class indicates error(s) raised by classes in this unit
  ///  </summary>
  ETaurusTLSIBytesError = class(ETaurusTLSError);

  ///  <summary>
  ///  Interface declares function and property to provide access
  ///  to the data stored in the <c>containers'</c> memory for the
  ///  <c>OpenSSL API</c> functions.
  ///  </summary>
  ITaurusTLS_Bio = interface
  ['{FE133CBE-0D85-46A3-9F62-A4FED6EF6F3F}']
    ///  <summary>
    ///  Initialize a memory <see href="https://docs.openssl.org/3.3/man3/BIO_s_mem/#description">BIO</see>
    ///  and returns pointer to it.
    ///  <c>OpenSSL</c> operates with this <c>BIO</c> in the same manner
    ///  as other <c>BIOs</c> issued by other <c>OpenSSL</c> functions
    ///  </summary>
    ///  <returns> Pointer to <c>OpenSSL</c> <see href="https://docs.openssl.org/3.0/man7/bio/">BIO</see>
    ///  </returns>
    function GetBio: PBIO;
    property Bio: PBIO read GetBio;
  end;

  ///  <summary>
  ///  Interface declares function and property manage the data
  ///  stored in the <c>containers'</c> memory.
  ///  </summary>
  ITaurusTLS_Bytes = interface
  ['{EE497C17-DE0C-4470-80B8-B0EC528B62F7}']
    ///  <summary>
    ///  Initialzes and retern a new instance of <see cref="ITaurusTLS_Bio" /> interface.
    ///  Every <c>ITaurusTLS_Bio</c> instance points to the same memory storage
    ///  and allows to get access to it from multiple threads.
    ///  </summary>
    function NewBio: ITaurusTLS_Bio;
    ///  <summary>
    ///  Retuns internal data storage in form of <see name="System.SysUtils.TBytes" />
    ///  <remarks>
    ///  Be caution, do not modify this memory content any time.
    ///  </remarks>
    ///  </summary>
    function GetBytes: TBytes;
    property Bytes: TBytes read GetBytes;
  end;

  ///  <summary>
  ///  This class implements base <see cref="ITaurusTLS_Bytes" /> functionality
  ///  </summary>
  TTaurusTLS_Bytes = class (TInterfacedObject, ITaurusTLS_Bytes)
    protected type
      ///  <summary>
      ///  The implementation of <see cref="ITaurusTLS_Bio" /> interface
      ///  used by <see cref="TTaurusTLS_Bytes" /> and its descendant(s).
      ///  </summary>
      TBio = class(TInterfacedObject, ITaurusTLS_Bio)
      private
        FOwner: ITaurusTLS_Bytes;
        FBytes: TBytes;
        FBio: PBIO;
    {$IFDEF USE_STRICT_PRIVATE_PROTECTED}strict{$ENDIF} protected
        ///  <summary>
        ///    <para>
        ///    Implements <see cref="ITaurusTLS_Bio.GetBio" /> method.
        ///    </para>
        ///    <para>
        ///    Initializes <c>OpenSSL BIO</c> structure and returns pointer to it.
        ///    </para>
        ///  </summary>
        ///  <returns> Pointer to <c>OpenSSL</c> <see href="https://docs.openssl.org/3.0/man7/bio/">BIO</see>
        ///  </returns>
        function GetBio: PBIO;
      public
        ///  <summary>
        ///  Create the instance of <see cref="ITaurusTLS_Bio" /> interface.
        ///  </summary>
        ///  <param name="ABytes">Reference to the <c>array of bytes</c> used as a memory
        ///  storage for the <c>OpenSSL</c> operations.
        ///  </param>
        ///  <param name="AOwner">Instance of <see name="TTaurusTLS_Bytes" /> class
        ///  created this instance.
        ///  </param>
        constructor Create(ABytes: TBytes; AOwner: TTaurusTLS_Bytes);
        ///  <summary>
        ///  Destroys the instance and releases <c>OpenSSL BIO</c> structure.
        ///  </summary>
        destructor Destroy; override;
      end;

  private
    FBytes: TBytes;
  protected
    ///  <summary>
    ///  Implements the <see cref="ITaurusTLS_Bytes.GetBytes" /> method
    ///  </summary>
    ///  <returns>
    ///  A reference to the internal <c>array of bytes</c> storage.
    ///  </returns>
    function GetBytes: TBytes; virtual;
    ///  <summary>
    ///  Implements the <see cref="ITaurusTLS_Bytes.NewBio" /> method
    ///  Creates a instance of <see cref="TTaurusTLS_Bytes.TBio" /> class,
    ///  creates the <c>OpenSSL BIO</c> pointed to the
    ///  internal <c>array of bytes</c> storage
    ///  and returns it as a <see cref="ITaurusTLS_Bio" /> interface instance.
    ///  </summary>
    function NewBio: ITaurusTLS_Bio; virtual;
    ///  <summary>
    ///  Initializes the internal <c>array of bytes</c> storage with
    ///  provided data
    ///  </summary>
    ///  <remarks>
    ///  This method uses internal only at the instance creation time.
    ///  It raises exception if being calling any time after that.
    ///  </remarks>
    ///  <param name="ABytes">
    ///  An <c>array of bytes</c> is used as internal storage.
    ///  </param>
    procedure SetBytes(const ABytes: TBytes); {$IFDEF USE_INLINE}inline;{$ENDIF}
  public
    ///  <summary>
    ///  Creates the <see cref="TTaurusTLS_Bytes" /> interface instance
    ///  </summary>
    ///  <param name="ABytes"> Reference to the <c>array of bytes</c> to be use
    ///  as a storage for <c>OpenSSL BIO</c> functions.
    ///  </param>
    constructor Create(const ABytes: TBytes); overload;
    ///  <summary>
    ///  Creates the <see cref="TTaurusTLS_Bytes" /> interface instance and initialize
    ///  <c>array of bytes</c> with size <see name="ASize" /> and fill it with "zero" values.
    ///  </summary>
    ///  <param name="ASize">A size of <c>array of bytes</c> to be use
    ///  as a storage for <c>OpenSSL BIO</c> functions.
    ///  </param>
    constructor Create(ASize: TIdC_SIZET); overload;
  end;

  /// <inheritdoc />
  ///  <summary>
  ///  This class implements see cref="ITaurusTLS_Bytes" /> interface functionality.
  ///  Instance of this class automatically clears <c>array of bytes</c> it holds
  ///  with "zero" values when it being destroyed
  ///  </summary>
  TTaurusTLS_WipingBytes = class(TTaurusTLS_Bytes)
  protected
    procedure WipeData; overload;
  public
    ///  <summary>
    ///  This <c>class method</c> fills <c>array of bytes</c> with a value
    ///  provided in <c>AValue</c> parameter value.
    ///  </summary>
    ///  <param name = "AData"><c>array of bytes</c> to be filled with a
    ///  <c>AValue</c> parameter value.
    ///  </param>
    ///  <param name="AValue">An integer value the <c>array of bytes</c> to be filled with.
    ///  </param>
    class procedure WipeData(var AData: TBytes; AValue: integer = $0); overload;
      static; {$IFDEF USE_INLINE}inline;{$ENDIF}
    destructor Destroy; override;
  end;

  ///  <summary>
  ///  Interface to manage releaseing and cleaning out <c>array of bytes</c>
  ///  containing sensitive data in unencrypted form
  ///  </summary>
  ITaurusTLS_BytesHost = interface
  ['{D4C93767-9DFB-4ADE-A8A0-4586CEB0A135}']
    ///  <summary>
    ///  Methods notifies the Owner that the object is releasing and destroying
    ///  </summary>
    ///  <remarks>
    ///  Uses internaly by the <see cref="TTaurusTLS_EncryptedBytes" />
    ///  </remarks>
    ///  <seealso cref="TTaurusTLS_EncryptedBytes" />
    procedure ReleaseNotify(const ASender: TTaurusTLS_Bytes);
  end;

  ///  <inheritdoc />
  ///  <summary>
  ///  This class implements <see cref="ITaurusTLS_Bytes" /> interface functionality
  ///  and stores the content of <c>array of bytes</c> in encrypted form and
  ///  decrypt it when a <see cref="ITaurusTLS_Bio" /> instance(s) is requested via <see cref="ITaurusTLS_Bytes.NewBio" /> method.
  ///  The decrypted <c>array of bytes</c> is cleared automatically with "zero" values
  ///  when all <see cref="ITaurusTLS_Bio" /> instances are released.
  ///  </summary>
  TTaurusTLS_EncryptedBytes = class(TInterfacedObject, ITaurusTLS_Bytes,
    ITaurusTLS_BytesHost)
{$IFDEF USE_STRICT_PRIVATE_PROTECTED}strict{$ENDIF} protected type
    ///  <inheritdoc />
    /// <summary>
    ///  Instance of this class is used to keep <c>decrypted array of bytes</c>
    ///  and share it with the <c>OpenSSL BIO</c> function calls.
    ///  This isnstance is automatically destroyed and fills the
    ///  <c>decrypted array of bytes</c> with "zero" values
    ///  </summary>
    TPlainBytes = class(TTaurusTLS_WipingBytes)
    {$IFDEF USE_STRICT_PRIVATE_PROTECTED}strict{$ENDIF} private
      FHost: ITaurusTLS_BytesHost;
    public
      /// <summary>
      ///  Creates instance of <see cref="ITaurusTLS_Bytes" /> to store <c>decrypted array of bytes</c>
      ///  </summary>
      ///  <param name="ABytes"><c>array of bytes</c> keeps decrypted value
      ///  </param>
      ///  <param name="AHost">reference to the <see cref="TTaurusTLS_EncryptedBytes" /> instance
      ///  created this instance
      ///  </param>
      constructor Create(ABytes: TBytes; AHost: TTaurusTLS_EncryptedBytes);
      destructor Destroy; override;
    end;
{$IFDEF USE_STRICT_PRIVATE_PROTECTED}strict{$ENDIF} private
{$IFDEF DCC}
    [volatile]
{$ENDIF}
    FPlainBytes: TPlainBytes;
    FEncryptedBytes: TBytes;
    FEncryptor: TTaurusTLS_CustomEncryptor;
{$IFDEF USE_STRICT_PRIVATE_PROTECTED}strict{$ENDIF} protected
    ///  <summary>
    ///  Implements the <see cref="ITaurusTLS_Bytes.GetBytes" /> method
    ///  </summary>
    ///  <returns>
    ///  A reference to the internal <c>array of bytes</c> storage.
    ///  <remarks>The content of the <c>array of bytes</c> is encrypted
    ///  </remarks>
    ///  </returns>
    function GetBytes: TBytes;
    ///  <summary>
    ///  Implements the <see cref="ITaurusTLS_Bytes.NewBio" /> method.
    ///  Creates the instance of <see cref="ITaurusTLS_Bio" /> interface,
    ///  holding <c>decrypted array of bytes</c> storage to use
    ///  with the <c>OpenSSL BIO</c> functions.
    ///  </summary>
    function NewBio: ITaurusTLS_Bio;
    ///  <summary>
    ///  Implements <see cref="ITaurusTLS_BytesHost.ReleaseNotify" /> method.
    ///  This method is called by the instance of
    ///  <see cref="TTaurusTLS_EncryptedBytes.TPlainBytes" /> when all references
    ///  to it are released.
    ///  </summary>
    procedure ReleaseNotify(const ASender: TTaurusTLS_Bytes);

    ///  <summary>
    ///  Decrypt data from interanl <c>array of bytes</c> storage.
    ///  </summary>
    ///  <returns>
    ///  <c>Array of bytes</c> contains decrypted value from <c>array of bytes</c> storage.
    ///  </returns>
    function DecryptBytes: TBytes;
    ///  <summary>
    ///  Encrypt data from exteranl <c>array of bytes</c>.
    ///  </summary>
    ///  <param name="ASrc"><c>array of bytes</c> to be encrypted.
    ///  </param>
    ///  <returns>
    ///  <c>Array of bytes</c> contains encrypted value from <c>array of bytes</c>
    ///  in <c>ASrc</c> parameter.
    ///  </returns>
    function EncrypBytes(ASrc: TBytes): TBytes;
    ///  <summary>
    ///  Check if internal instance of <see cref="ITaurusTLS_Bytes" /> to store
    ///  <c>decrypted array of bytes</c> exists.
    ///  If does not exists - creates new one.
    ///  </summary>
    ///  <returns>
    ///  Return instance of <see cref="ITaurusTLS_Bytes" /> which keeps
    ///  <c>decrypted array of bytes</c>.
    ///  </returns>
    function GetPlainBytes: ITaurusTLS_Bytes;
    ///  <summary>
    ///  Encrypts the provided data and initialize the internal <c>array of bytes</c>
    ///  storage with it.
    ///  </summary>
    ///  <remarks>
    ///  The content of parameter <c>ABytes</c> will be filled with a "zero" values
    ///  after setting the internal storage up.
    ///  </remarks>
    ///  <remarks>
    ///  This method uses internal only at the instance creation time.
    ///  It raises exception if being calling any time after that.
    ///  </remarks>
    ///  <param name="ABytes">
    ///  An <c>array of bytes</c> is used as internal storage.
    ///  </param>
    procedure SetBytes(const ABytes: TBytes);
  public
    ///  <summary>
    ///  Create the instance of <see cref="ITaurusTLS_Bytes" /> to store a
    ///  sensitive data in <c>encrypted form</c> and provide access to this
    ///  data in <c>decrypted form</c> for the <c>OpenSSL BIO</c> functions.
    ///  </summary>
    ///  <param name="ABytes">
    ///  Encrypts the provided data and initialize the internal <c>array of
    ///  bytes</c> storage with it. The content of parameter <c>ABytes</c> will
    ///  be filled with a "zero" values after setting the internal storage up.
    ///  </param>
    ///  <param name="AEncryptor">
    ///  The instance of class derived from <see
    ///  cref="TTaurusTLS_CustomEncryptor" />. The <c>AEncryptor</c> instance
    ///  executes <c>encryption</c> and <c>decryption</c> on <c>internal array
    ///  of bytes</c> storage.
    ///  </param>
    constructor Create(ABytes: TBytes; AEncryptor: TTaurusTLS_CustomEncryptor);
    destructor Destroy; override;
  end;

  /// <summary>
  ///  Helper class for the <see cref="TTaurusTLS_Bytes" /> to create new instances
  ///  using different source for <c>interanl array of bytes</c>
  ///  </summary>
  TTaurusTLS_BytesHelper = class helper for TTaurusTLS_Bytes
  private
    class function NewBytes(ASize: NativeUInt): TBytes;
      static; {$IFDEF USE_INLINE}inline;{$ENDIF}
  public
    ///  <summary>
    ///  Creates the instance of <see cref="ITaurusTLS_Bytes" /> interface
    ///  using content of <c>Unicode string</c> as an <c>internal array of bytes</c> storage
    ///  and using <typeparam name="T">T</typeparam> as an <c>object interface</c> class.
    ///  </summary>
    ///  <remarks>
    ///  <c>Unicode string</c> converts to the <c>Ansi string</c> before content
    ///  is assigned to the <c>internal array of bytes</c> storage.
    ///  Using <c>non-ASCII</c> characters in the <c>ASrc</c> parameter may have unpredictable result.
    ///  </remarks>
    ///  <param name="ASrc">
    ///  An <c>Unicode string</c> which content will be stored in the <c>internal array of bytes</c> storage.
    ///  </param>
    ///  <returns>The instance of <see cref="ITaurusTLS_Bytes" /> holds the content of
    ///  <c>ASrc</c> in the <c>internal array of bytes</c> storage.
    ///  </returns>
    class function LoadFromString<T: TTaurusTLS_Bytes, constructor>(const ASrc: string):
      ITaurusTLS_Bytes; overload; static; {$IFDEF USE_INLINE}inline;{$ENDIF}
    ///  <summary>
    ///  Creates the instance of <see cref="ITaurusTLS_Bytes" /> interface
    ///  using content of <c>Ansi string</c> as an <c>internal array of bytes</c> storage
    ///  and using <typeparam name="T">T</typeparam> as an <c>object interface</c> class.
    ///  </summary>
    ///  <param name="ASrc">
    ///  An <c>Ansi string</c> which content will be stored in the <c>internal array of bytes</c> storage.
    ///  </param>
    ///  <returns>The instance of <see cref="ITaurusTLS_Bytes" /> holds the content of
    ///  <c>ASrc</c> in the <c>internal array of bytes</c> storage.
    ///  </returns>
    class function LoadFromRawByteString<T: TTaurusTLS_Bytes, constructor>
      (const ASrc: RawByteString): ITaurusTLS_Bytes; overload; static;
      {$IFDEF USE_INLINE}inline;{$ENDIF}
    ///  <summary>
    ///  Creates the instance of <see cref="ITaurusTLS_Bytes" /> interface
    ///  using content of <c>Ansi null-terminated string</c> as an <c>internal array of bytes</c> storage
    ///  and using <typeparam name="T">T</typeparam> as an <c>object interface</c> class.
    ///  </summary>
    ///  <param name="ASrc">A pointer to the <c>Ansi string</c> which content will be stored
    ///  in the <c>internal array of bytes</c> storage.
    ///  </param>
    ///  <returns>The instance of <see cref="ITaurusTLS_Bytes" /> holds the content of
    ///  <c>ASrc</c> in the <c>internal array of bytes</c> storage.
    ///  </returns>
    class function LoadFromPChar<T: TTaurusTLS_Bytes, constructor>(
      const ASrc: PIdAnsiChar): ITaurusTLS_Bytes; overload; static;
      {$IFDEF USE_INLINE}inline;{$ENDIF}
    ///  <summary>
    ///  Creates the instance of <see cref="ITaurusTLS_Bytes" /> interface
    ///  using content of <c>array of bytes</c> as an <c>internal array of bytes</c> storage
    ///  and using <typeparam name="T">T</typeparam> as an <c>object interface</c> class.
    ///  </summary>
    ///  <param name="ASrc">An <c>array of bytes</c> which content will be stored
    ///  in the <c>internal array of bytes</c> storage.
    ///  </param>
    ///  <returns>The instance of <see cref="ITaurusTLS_Bytes" /> holds the content of
    ///  <c>ASrc</c> in the <c>internal array of bytes</c> storage.
    ///  </returns>
    class function LoadFromBytes<T: TTaurusTLS_Bytes, constructor>(
      const ASrc: TBytes): ITaurusTLS_Bytes; overload; static;
      {$IFDEF USE_INLINE}inline;{$ENDIF}
    ///  <summary>
    ///  Creates the instance of <see cref="ITaurusTLS_Bytes" /> interface
    ///  using content of <c>Stream</c> as an <c>internal array of bytes</c> storage
    ///  and using <typeparam name="T">T</typeparam> as an <c>object interface</c> class.
    ///  </summary>
    ///  <param name="AStream">A instance of <see cref="TStream" /> which content will be stored
    ///  in the <c>internal array of bytes</c> storage.
    ///  </param>
    ///  <returns>The instance of <see cref="ITaurusTLS_Bytes" /> holds the content of
    ///  <c>AStream</c> in the <c>internal array of bytes</c> storage.
    ///  </returns>
    class function LoadFromStream<T: TTaurusTLS_Bytes, constructor>(const AStream: TStream):
      ITaurusTLS_Bytes; overload; static; {$IFDEF USE_INLINE}inline;{$ENDIF}
  end;

  /// <summary>
  ///  Helper class for the <see cref="TTaurusTLS_EncryptedBytes" /> to create
  ///  new instances initializiing <c>internal encrypted array of bytes</c>
  ///  from a content of <see cref="TStream" /> instance.
  ///  </summary>
  TTaurusTLS_EncryptedBytesHelper = class helper for TTaurusTLS_EncryptedBytes
  public
    ///  <summary>
    ///  Creates the instance of <see cref="ITaurusTLS_Bytes" /> interface
    ///  using content of <c>Stream</c> as an <c>internal array of bytes</c> storage
    ///  and keeps it in <c>encrypted</c> form.
    ///  </summary>
    ///  <param name="AStream">A instance of <see cref="TStream" /> which content will be stored
    ///  in the <c>internal encrypted array of bytes</c> storage.
    ///  </param>
    ///  <param name="AWipeSrcMem"> Indicates whether the content of <c>AStream</c> instance
    ///  should be filled with "zeros" after the instance of the <see cref="ITaurusTLS_Bytes" /> created.
    ///  <remarks>
    ///  The only memory content of see cref="TMemoyStream" /> class and its desendants
    ///  can be "zeroed".
    ///  </remarks>
    ///  </param>
    ///  <param name="AEncryptor">An instance of <see cref="TTaurusTLS_CustomEncryptor" /> type
    ///  is used for the <c>encryption</c> and <c>decryption</c> operations.
    ///  </param>
    ///  <returns>The instance of <see cref="ITaurusTLS_Bytes" /> holds the content of
    ///  <c>AStream</c> in the <c>internal encrypted array of bytes</c> storage.
    ///  </returns>
    ///  <seealso cref="TTaurusTLS_CustomEncryptor" />
    class function LoadFromStream(const AStream: TStream; AWipeSrcMem: boolean;
      AEncryptor: TTaurusTLS_CustomEncryptor = nil): ITaurusTLS_Bytes;
      overload; static;
    ///  <summary>
    ///  Creates the instance of <see cref="ITaurusTLS_Bytes" /> interface
    ///  using content of <c>Stream</c> as an <c>internal array of bytes</c> storage
    ///  and keeps it in <c>encrypted</c> form
    ///  using <c>Advanced Encryption Standard (AES) cipher algorithm</c> family
    ///  </summary>
    ///  <param name="AStream">A instance of <see cref="TStream" /> which content will be stored
    ///  in the <c>internal encrypted array of bytes</c> storage.
    ///  </param>
    ///  <param name="AWipeSrcMem"> Indicates whether the content of <c>AStream</c> instance
    ///  should be filled with "zeros" after the instance of the <see cref="ITaurusTLS_Bytes" /> created.
    ///  <remarks>
    ///  The only memory content of see cref="TMemoyStream" /> class and its desendants
    ///  can be "zeroed".
    ///  </remarks>
    ///  </param>
    ///  <param name="AKeySize"><c>Advanced Encryption Standard (AES) cipher algorithm</c>
    ///  <c>key size</c>. <see cref="TTaurusTLS_AESKeySize" />
    ///  </param>
    ///  <param name="AEncodeMode"><c>Advanced Encryption Standard (AES) cipher algorithm</c>
    ///  <c>encode mode</c>. <see cref="TTaurusTLS_SimleAESEncodeMode" />
    ///  </param>
    ///  <remarks>
    ///  This method utilizes <see cref="TTaurusTLS_SimpleAESFactory" /> factory
    ///  to create the <see cref="TTaurusTLS_SimleAESEncodeMode" /> instance and
    ///  with the specified values in parameters <c>AKeySize</c> and <c>AEncodeMode</c>.
    ///  </remarks>
    ///  <returns>The instance of <see cref="ITaurusTLS_Bytes" /> holds the content of
    ///  <c>AStream</c> in the <c>internal encrypted array of bytes</c> storage.
    ///  </returns>
    ///  <seealso cref="TTaurusTLS_SimpleAESFactory" />
    class function LoadFromStream(const AStream: TStream; AWipeSrcMem: boolean;
      AKeySize: TTaurusTLS_AESKeySize; AEncodeMode: TTaurusTLS_SimleAESEncodeMode):
      ITaurusTLS_Bytes; overload; static; {$IFDEF USE_INLINE}inline;{$ENDIF}
  end;

implementation

uses
  TaurusTLS_ResourceStrings;

{ TTaurusTLS_CustomBytes.TBioIntf }

constructor TTaurusTLS_Bytes.TBio.Create(ABytes: TBytes;
  AOwner: TTaurusTLS_Bytes);
begin
  FOwner:=AOwner;
  FBytes:=ABytes;
end;

destructor TTaurusTLS_Bytes.TBio.Destroy;
begin
  if Assigned(FBio) then
    BIO_free(FBio);
  inherited;
end;

function TTaurusTLS_Bytes.TBio.GetBio: PBIO;
begin
  if not Assigned(FBio) and (Length(FBytes) > 0) then
    FBIO:=BIO_new_mem_buf(FBytes[0], Length(FBytes));
  Result:=FBIO;
end;

{ TTaurusTLS_Bytes }

constructor TTaurusTLS_Bytes.Create(const ABytes: TBytes);
begin
  Create;
  SetBytes(ABytes);
end;

constructor TTaurusTLS_Bytes.Create(ASize: TIdC_SIZET);
var
  lBytes: TBytes;

begin
{$IFDEF FPC}
  {$warn 5091 OFF}
{$ENDIF}
  SetLength(lBytes, ASize);
  Create(lBytes);
{$IFDEF FPC}
  {$warn 5091 ON}
{$ENDIF}
end;

procedure TTaurusTLS_Bytes.SetBytes(const ABytes: TBytes);
begin
  if Length(FBytes) <> 0 then
    ETaurusTLSIBytesError.RaiseWithMessage(RIB_Bytes_CanNotChange);
  FBytes:=ABytes;
end;

function TTaurusTLS_Bytes.GetBytes: TBytes;
begin
  Result:=FBytes;
end;

function TTaurusTLS_Bytes.NewBio: ITaurusTLS_Bio;
begin
  if Length(FBytes) > 0 then
    Result:=TBio.Create(FBytes, Self)
  else
    Result:=nil;
end;

{ TTaurusTLS_WipedBytes }

destructor TTaurusTLS_WipingBytes.Destroy;
begin
  WipeData;
  inherited;
end;

procedure TTaurusTLS_WipingBytes.WipeData;
begin
  WipeData(FBytes);
end;

class procedure TTaurusTLS_WipingBytes.WipeData(var AData: TBytes; AValue: integer);
var
  lLen: NativeUInt;

begin
  lLen:=Length(AData);
  if lLen = 0 then
    Exit;
  FillChar(AData[0], lLen, AValue);
  SetLength(AData, 0);
end;

{ TTaurusTLS_EncryptedBytes.TPlainBytes }

constructor TTaurusTLS_EncryptedBytes.TPlainBytes.Create(ABytes: TBytes;
  AHost: TTaurusTLS_EncryptedBytes);
begin
  // Assert is added intentionally to avoid this class improper usage.
  Assert(Assigned(AHost),
    ClassName+'.Create: parameter AHost must not be  ''nil''.');
  FHost:=AHost;
  inherited Create(ABytes);
end;

destructor TTaurusTLS_EncryptedBytes.TPlainBytes.Destroy;
begin
  FHost.ReleaseNotify(Self);
  inherited;
end;

{ TTaurusTLS_EncryptedBytes }

constructor TTaurusTLS_EncryptedBytes.Create(ABytes: TBytes;
  AEncryptor: TTaurusTLS_CustomEncryptor);
begin
  // Assert is added intentionally to avoid this class improper usage.
  Assert(Assigned(AEncryptor),
    ClassName+'.Create: parameter AEncryptor must not be ''nil''.');
  FEncryptor:=AEncryptor;
  SetBytes(ABytes);
end;

destructor TTaurusTLS_EncryptedBytes.Destroy;
begin
  FreeAndNil(FEncryptor);
  inherited;
end;

function TTaurusTLS_EncryptedBytes.DecryptBytes: TBytes;
begin
  FEncryptor.Decrypt(FEncryptedBytes, Result);
end;

function TTaurusTLS_EncryptedBytes.EncrypBytes(ASrc: TBytes): TBytes;
begin
  FEncryptor.Encrypt(ASrc, Result);
end;

function TTaurusTLS_EncryptedBytes.GetBytes: TBytes;
begin
  Result:=FEncryptedBytes;
end;

function TTaurusTLS_EncryptedBytes.GetPlainBytes: ITaurusTLS_Bytes;
var
  lOldPlainBytes, lNewPlainBytes: TPlainBytes;
  lNewPlainData: TBytes;

begin
  Result:=FPlainBytes;
  lOldPlainBytes:=FPlainBytes;
  if not Assigned(lOldPlainBytes) then
  begin
    lNewPlainData:=DecryptBytes;
    lNewPlainBytes:=TPlainBytes.Create(lNewPlainData, Self);
{$IFDEF DCC}
    if TInterlocked.CompareExchange(Pointer(FPlainBytes), Pointer(lNewPlainBytes),
      Pointer(lOldPlainBytes)) <> nil then
{$ELSE}
    if InterlockedCompareExchangePointer(Pointer(FPlainBytes), Pointer(lNewPlainBytes),
      Pointer(lOldPlainBytes)) <> nil then
{$ENDIF}
        lNewPlainBytes.Free
      else
        Result:=lNewPlainBytes;
  end;
end;

function TTaurusTLS_EncryptedBytes.NewBio: ITaurusTLS_Bio;
begin
  Result:=GetPlainBytes.NewBio;
end;

procedure TTaurusTLS_EncryptedBytes.ReleaseNotify(const ASender: TTaurusTLS_Bytes);
{$IFDEF DEBUG}
var
  lOldBytes: TTaurusTLS_Bytes;
{$ENDIF}
begin
  if ASender <> FPlainBytes then
    Exit;
{$IFDEF DEBUG}
  lOldBytes:=
{$ENDIF}
{$IFDEF DCC}
  TInterlocked.CompareExchange(Pointer(FPlainBytes), nil,
    Pointer(ASender));
{$ELSE}
  InterlockedCompareExchangePointer(Pointer(FPlainBytes), nil,
    Pointer(ASender));
{$ENDIF}
end;

procedure TTaurusTLS_EncryptedBytes.SetBytes(const ABytes: TBytes);
var
  lBytes: TBytes;

begin
    if Length(FEncryptedBytes) <> 0 then
    ETaurusTLSIBytesError.RaiseWithMessage(RIB_Bytes_CanNotChange);
  lBytes := ABytes;
  FEncryptedBytes := EncrypBytes(ABytes);
  TPlainBytes.WipeData(lBytes); // clean-up source data always
end;

{ TTaurusTLS_CustomBytesHelper }

class function TTaurusTLS_BytesHelper.NewBytes(ASize: NativeUInt): TBytes;
begin
  if ASize > 0 then
{$IFDEF FPC}
  {$warn 5093 OFF}
{$ENDIF}
    SetLength(Result, ASize);
{$IFDEF FPC}
  {$warn 5093 ON}
{$ENDIF}
end;

class function TTaurusTLS_BytesHelper.LoadFromBytes<T>(
  const ASrc: TBytes): ITaurusTLS_Bytes;
var
  lResult: T;

begin
  Result:=nil;
  lResult:=nil;
  try
    lResult:=T.Create;
    lResult.SetBytes(ASrc);
  except
    lResult.Free;
  end;
  Result:=lResult;
end;

class function TTaurusTLS_BytesHelper.LoadFromString<T>(
  const ASrc: string): ITaurusTLS_Bytes;
begin
  Result:=LoadFromRawByteString<T>(RawByteString(ASrc));
end;

class function TTaurusTLS_BytesHelper.LoadFromRawByteString<T>(
  const ASrc: RawByteString): ITaurusTLS_Bytes;
begin
  Result:=LoadFromPChar<T>(PIdAnsiChar(ASrc));
end;

class function TTaurusTLS_BytesHelper.LoadFromPchar<T>(
  const ASrc: PIdAnsiChar): ITaurusTLS_Bytes;
begin
  Result:=LoadFromBytes<T>(BytesOf(ASrc));
end;

class function TTaurusTLS_BytesHelper.LoadFromStream<T>(
  const AStream: TStream): ITaurusTLS_Bytes;
var
  lStream: TBytesStream;
  lBytes: TBytes;
  lResult: T;

begin
  if not Assigned(AStream) then
    Exit(nil);

  if AStream is TBytesStream then
  begin
    lBytes:=TBytesStream(AStream).Bytes; // reuse TBytes from the underlyed stream
  end
  else
  begin
    lStream:=TBytesStream.Create(NewBytes(AStream.Size));
    try
      lStream.CopyFrom(AStream, 0);
      lBytes:=lStream.Bytes;
    finally
      lStream.Free;
    end;
  end;
  lResult:=nil;
  try
    lResult:=T.Create;
    lResult.SetBytes(lBytes);
    Result:=lResult;
  except
    lResult.Free;
  end;
end;

type
  TStreamHelper = class helper for TStream
    procedure WipeMemoryData(AValue: integer = $0);
  end;

{ TStreamHelper }

procedure TStreamHelper.WipeMemoryData(AValue: integer = $0);
var
  lSize: UInt64;

begin
  lSize:=Size;
  if (Self is TMemoryStream) and (lSize > 0) then
    FillChar(TMemoryStream(Self).Memory^, lSize, AValue);
end;

{ TTaurusTLS_EncryptedBytesHelper }

class function TTaurusTLS_EncryptedBytesHelper.LoadFromStream(
  const AStream: TStream; AWipeSrcMem: boolean;
  AEncryptor: TTaurusTLS_CustomEncryptor): ITaurusTLS_Bytes;
var
  lSize: UInt64;
  lStream: TBytesStream;
  lBytes: TBytes;

begin
  Result:=nil;
  if not Assigned(AStream) then
    Exit;
  if not Assigned(AEncryptor) then
    AEncryptor:=TTaurusTLS_SimpleAESFactory.NewEncryptor;
  lSize:= AStream.Size;
{$IFDEF FPC}
  {$warn 5091 OFF}
{$ENDIF}
  SetLength(lBytes, lSize);
{$IFDEF FPC}
  {$warn 5091 ON}
{$ENDIF}
  lStream := TBytesStream.Create(lBytes);
  try
    lStream.CopyFrom(AStream, 0);
    if AWipeSrcMem then
      AStream.WipeMemoryData;
  finally
    lStream.Free;
  end;
  Result:=TTaurusTLS_EncryptedBytes.Create(lBytes, AEncryptor);
end;

class function TTaurusTLS_EncryptedBytesHelper.LoadFromStream(
  const AStream: TStream; AWipeSrcMem: boolean; AKeySize: TTaurusTLS_AESKeySize;
  AEncodeMode: TTaurusTLS_SimleAESEncodeMode): ITaurusTLS_Bytes;
begin
  Result:=LoadFromStream(AStream, AWipeSrcMem,
    TTaurusTLS_SimpleAESFactory.NewEncryptor(AKeySize, AEncodeMode));
end;

end.

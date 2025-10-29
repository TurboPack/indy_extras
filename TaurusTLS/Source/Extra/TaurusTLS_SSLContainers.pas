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
  Classes, {$IFDEF DCC}SyncObjs,{$ENDIF}SysUtils,
  TaurusTLS_SSLContainersHelpers, TaurusTLS_Encryptors,
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
  ///  Returns size in bytes of internal data storage
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
    ///  Returns internal data storage in form of <see cref="TBytes" />
    ///  </summary>
    function GetBytes: TBytes;
    ///  <summary>
    ///  Returns internal data storage in form of <see cref="TBytes" />
    ///  </summary>
    property Bytes: TBytes read GetBytes;
    ///  <summary>
    ///  Returns internal data storage size in bytes
    ///  </summary>
    function GetSize: TIdC_UInt;
    ///  <summary>
    ///  Returns internal data storage size in bytes
    ///  </summary>
    property Size: TIdC_UInt read GetSize;
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
        ///  <param name="AOwner">Instance of <see cref="TTaurusTLS_Bytes" /> class
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
    ///  Implements the <see cref="ITaurusTLS_Bytes.GetSize" /> method
    ///  </summary>
    ///  <returns>
    ///  A size of the internal <c>array of bytes</c> storage.
    ///  </returns>
    function GetSize: TIdC_UInt; virtual;
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
    ///  <c>array of bytes</c> with size (ASize) and fill it with "zero" values.
    ///  </summary>
    ///  <param name="ASize">A size of <c>array of bytes</c> to be use
    ///  as a storage for <c>OpenSSL BIO</c> functions.
    ///  </param>
    constructor Create(ASize: TIdC_SIZET); overload;
  end;

  /// <inheritdoc />
  ///  <summary>
  ///  This class implements <see cref="ITaurusTLS_Bytes" /> interface functionality.
  ///  Instance of this class automatically clears <c>array of bytes</c> it holds
  ///  with "zero" values when it being destroyed
  ///  </summary>
  TTaurusTLS_WipingBytes = class(TTaurusTLS_Bytes)
  public
    ///  <inheritdoc />
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
    ///  Uses internaly by the <see cref="TTaurusTLS_BytesVault" />
    ///  </remarks>
    ///  <seealso cref="TTaurusTLS_BytesVault" />
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
  TTaurusTLS_BytesVault = class(TInterfacedObject, ITaurusTLS_Bytes,
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
      ///  <param name="AHost">reference to the <see cref="TTaurusTLS_BytesVault" /> instance
      ///  created this instance
      ///  </param>
      constructor Create(ABytes: TBytes; AHost: TTaurusTLS_BytesVault);
      destructor Destroy; override;
    end;
{$IFDEF USE_STRICT_PRIVATE_PROTECTED}strict{$ENDIF} private
{$IFDEF DCC}
    [volatile]
{$ENDIF}
    FPlainBytes: TPlainBytes;
    FPlainBytesSize: TIdC_SizeT;
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
    ///  Implements the <see cref="ITaurusTLS_Bytes.GetSize" /> method
    ///  </summary>
    ///  <returns>
    ///  A size of the unencrypted data in internal <c>array of bytes</c> storage.
    ///  <remarks>The content of the <c>array of bytes</c> is encrypted
    ///  </remarks>
    ///  </returns>
    function GetSize: TIdC_UInt;

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
    ///  <see cref="TTaurusTLS_BytesVault.TPlainBytes" /> when all references
    ///  to it are released.
    ///  </summary>
    procedure ReleaseNotify(const ASender: TTaurusTLS_Bytes);

    ///  <summary>
    ///  Creates instance of TPlainBytes class which contains
    ///  <c>decrypted array of bytes</c> to be exposed through <see cref="ITaurusTLS_Bio" />
    ///  interface. Descendant class(es) can override this method.
    ///  </summary>
    procedure NewPlainBytes(const ABytes: TBytes; out APlainBytes: TPlainBytes);
      virtual;
    ///  <summary>
    ///  Check if internal instance of <see cref="ITaurusTLS_Bytes" /> to store
    ///  <c>decrypted array of bytes</c> exists.
    ///  If does not exists - creates new one.
    ///  </summary>
    ///  <returns>
    ///  Return instance of <see cref="TPlainBytes" />
    ///  which keeps <c>decrypted array of bytes</c>.
    ///  </returns>
    function GetPlainBytes: TPlainBytes;

    class procedure CheckEncryptor(AEncryptor: TTaurusTLS_CustomEncryptor); static;
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
    procedure SetBytes(const ABytes: TBytes); {$IFDEF USE_INLINE}inline;{$ENDIF}

    ///  <summary>
    ///  Decrypt data from interanl <c>array of bytes</c> storage.
    ///  </summary>
    ///  <returns>
    ///  <c>Array of bytes</c> contains decrypted value from <c>array of bytes</c> storage.
    ///  </returns>
    function DecryptBytes: TBytes; {$IFDEF USE_INLINE}inline;{$ENDIF}

    ///  <summary>
    ///  Encrypt data from exteranl <c>array of bytes</c>.
    ///  </summary>
    ///  <param name="ASrc"><c>array of bytes</c> to be encrypted.
    ///  </param>
    ///  <returns>
    ///  <c>Array of bytes</c> contains encrypted value from <c>array of bytes</c>
    ///  in <c>ASrc</c> parameter.
    ///  </returns>
    function EncrypBytes(ASrc: TBytes): TBytes; {$IFDEF USE_INLINE}inline;{$ENDIF}
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
    ///  The instance of class derived from <see cref="TTaurusTLS_CustomEncryptor" />.
    ///  The <c>AEncryptor</c> instance executes <c>encryption</c> and
    ///  <c>decryption</c> on <c>internal array of bytes</c> storage.
    ///  </param>
    constructor Create(ABytes: TBytes; AEncryptor: TTaurusTLS_CustomEncryptor);
    destructor Destroy; override;
  end;

  /// <summary>
  ///  Helper class for the <see cref="TTaurusTLS_BytesVault" /> to create
  ///  new instances initializiing <c>internal encrypted array of bytes</c>
  ///  from a content of TStream instance.
  ///  </summary>
  TTaurusTLS_BytesVaultHelper = class helper for TTaurusTLS_BytesVault
  public type
    /// <summary>
    ///  Number of trailing null bytes to add to the <c>array of bytes</c>
    ///  to represent it as a <see cref="PAnsiChar" /> or <see cref="PWideChar" />
    ///  null-terminated string.
    ///  </summary>
    TTrailingNulls = TBytesFactory.TTrailingNulls;
  public
    ///  <summary>
    ///  Creates an instance of <see cref="ITaurusTLS_Bytes" /> interface
    ///  storing content of <c>AStr</c> in encrypting storage and filling
    ///  content of <c>AStr</c> with zeros.
    ///  </summary>
    ///  <param name="AStr">
    ///  Content of <c>AStr</c> to be stored as encrypted <c>array of bytes</c>.
    ///  Content of <c>AStr</c> is filled with zerod after the instance of
    ///  <see cref="ITaurusTLS_Bytes" /> created.
    ///  </param>
    ///  <param name="AEncryptor">
    ///  The instance of class derived from <see cref="TTaurusTLS_CustomEncryptor" />.
    ///  The <c>AEncryptor</c> instance executes <c>encryption</c> and
    ///  <c>decryption</c> on <c>internal array of bytes</c> storage.
    ///  </param>
    ///  <param name="AWithTrailingNull">
    ///  Method adds two zero bytes after content copied from <c>AString</c>
    ///  when <c>AWithTrailingNull</c> is <c>True</c> to allow passing
    ///  unencrypted content as <see cref="PWideChar" /> null-terminated string
    ///  to the <c>OpenSSL</c> functions via <see cref="ITaurusTLS_Bio" />
    ///  interface.
    ///  </param>
    class function Create(var AStr: UnicodeString;
      AEncryptor: TTaurusTLS_CustomEncryptor;
      AWithTrailingNull: boolean = False): ITaurusTLS_Bytes;
      overload; static; {$IFDEF USE_INLINE}inline;{$ENDIF}

    ///  <summary>
    ///  Creates an instance of <see cref="ITaurusTLS_Bytes" /> interface
    ///  storing content of <c>AStr</c> in encrypting storage and filling
    ///  content of <c>AStr</c> with zeros.
    ///  </summary>
    ///  <param name="AStr">
    ///  Content of <c>AStr</c> to be stored as encrypted <c>array of bytes</c>.
    ///  Content of <c>AStr</c> is filled with zerod after the instance of
    ///  <see cref="ITaurusTLS_Bytes" /> created.
    ///  </param>
    ///  <param name="AEncryptor">
    ///  The instance of class derived from <see cref="TTaurusTLS_CustomEncryptor" />.
    ///  The <c>AEncryptor</c> instance executes <c>encryption</c> and
    ///  <c>decryption</c> on <c>internal array of bytes</c> storage.
    ///  </param>
    ///  <param name="AWithTrailingNull">
    ///  Method adds zero byte after content copied from <c>AString</c>
    ///  when <c>AWithTrailingNull</c> is <c>True</c> to allow passing
    ///  unencrypted content as <see cref="PAnsiChar" /> null-terminated string
    ///  to the <c>OpenSSL</c> functions via <see cref="ITaurusTLS_Bio" />
    ///  interface.
    ///  </param>
    class function Create(var AStr: AnsiString;
      AEncryptor: TTaurusTLS_CustomEncryptor;
      AWithTrailingNull: boolean = False): ITaurusTLS_Bytes;
      overload; static; {$IFDEF USE_INLINE}inline;{$ENDIF}

    ///  <summary>
    ///  Creates an instance of <see cref="ITaurusTLS_Bytes" /> interface
    ///  storing content of <c>AStr</c> in encrypting storage and filling
    ///  content of <c>AStr</c> with zeros.
    ///  </summary>
    ///  <param name="AStr">
    ///  Content of <c>AStr</c> to be stored as encrypted <c>array of bytes</c>.
    ///  Content of <c>AStr</c> is filled with zerod after the instance of
    ///  <see cref="ITaurusTLS_Bytes" /> created.
    ///  </param>
    ///  <param name="AEncryptor">
    ///  The instance of class derived from <see cref="TTaurusTLS_CustomEncryptor" />.
    ///  The <c>AEncryptor</c> instance executes <c>encryption</c> and
    ///  <c>decryption</c> on <c>internal array of bytes</c> storage.
    ///  </param>
    ///  <param name="AWithTrailingNull">
    ///  Method adds zero byte after content copied from <c>AString</c>
    ///  when <c>AWithTrailingNull</c> is <c>True</c> to allow passing
    ///  unencrypted content as <see cref="PAnsiChar" /> null-terminated string
    ///  to the <c>OpenSSL</c> functions via <see cref="ITaurusTLS_Bio" />
    ///  interface.
    ///  </param>
    class function Create(var AStr: RawByteString;
      AEncryptor: TTaurusTLS_CustomEncryptor;
      AWithTrailingNull: boolean = False): ITaurusTLS_Bytes;
      overload; static; {$IFDEF USE_INLINE}inline;{$ENDIF}

    ///  <summary>
    ///  Creates an instance of <see cref="ITaurusTLS_Bytes" /> interface
    ///  storing content of <c>AStr</c> in encrypting storage and filling
    ///  content of <c>AStr</c> with zeros.
    ///  </summary>
    ///  <param name="AStr">
    ///  Content of <c>AStr</c> to be stored as encrypted <c>array of bytes</c>.
    ///  Content of <c>AStr</c> is filled with zerod after the instance of
    ///  <see cref="ITaurusTLS_Bytes" /> created.
    ///  </param>
    ///  <param name="AEncryptor">
    ///  The instance of class derived from <see cref="TTaurusTLS_CustomEncryptor" />.
    ///  The <c>AEncryptor</c> instance executes <c>encryption</c> and
    ///  <c>decryption</c> on <c>internal array of bytes</c> storage.
    ///  </param>
    ///  <param name="AWithTrailingNull">
    ///  Method adds zero byte after content copied from <c>AString</c>
    ///  when <c>AWithTrailingNull</c> is <c>True</c> to allow passing
    ///  unencrypted content as <see cref="PAnsiChar" /> null-terminated string
    ///  to the <c>OpenSSL</c> functions via <see cref="ITaurusTLS_Bio" />
    ///  interface.
    ///  </param>
    class function Create(var AStr: UTF8String;
      AEncryptor: TTaurusTLS_CustomEncryptor;
      AWithTrailingNull: boolean = False): ITaurusTLS_Bytes;
      overload; static; {$IFDEF USE_INLINE}inline;{$ENDIF}

    ///  <summary>
    ///  Creates the instance of <see cref="ITaurusTLS_Bytes" /> interface
    ///  using content of <c>Stream</c> as an <c>internal array of bytes</c> storage
    ///  and keeps it in <c>encrypted</c> form.
    ///  </summary>
    ///  <param name="AStream">A instance of TStream which content will be stored
    ///  in the <c>internal encrypted array of bytes</c> storage.
    ///  </param>
    ///  <param name="AEncryptor">An instance of <see cref="TTaurusTLS_CustomEncryptor" /> type
    ///  is used for the <c>encryption</c> and <c>decryption</c> operations.
    ///  </param>
    ///  <param name="AAddTrailingNulls">
    ///  Allows to add trailing zero bytes aftec content loaded from the
    ///  <c>AStream</c> to allow passing unencrypted content
    ///  as a <see cref="PAnsiChar" /> or a <see cref="PWideChar" /> null-terminated
    ///  string to the <c>OpenSSL</c> functions via <see cref="ITaurusTLS_Bio" />
    ///  interface.
    ///  </param>
    ///  <param name="AWipeSrcMem"> Indicates whether the content of <c>AStream</c> instance
    ///  should be filled with "zeros" after the instance of the <see cref="ITaurusTLS_Bytes" /> created.
    ///  <remarks>
    ///  The only memory content of see cref="TMemoyStream" /> class and its desendants
    ///  can be "zeroed".
    ///  </remarks>
    ///  </param>
    ///  <returns>
    ///  The instance of <see cref="ITaurusTLS_Bytes" /> holds the content of
    ///  <c>AStream</c> in the <c>internal encrypted array of bytes</c> storage.
    ///  </returns>
    class function Create(const AStream: TStream;
      AEncryptor: TTaurusTLS_CustomEncryptor;
      AAddTrailingNulls: TTrailingNulls = 0;
      AWipeSrcMem: boolean = True): ITaurusTLS_Bytes; overload; static;
      {$IFDEF USE_INLINE}inline;{$ENDIF}
  end;

  ITaurusTLS_Passphrase = interface;

  ///  <summary>
  ///  Declares interface to store UTF8-encoded null-terminated string
  ///  in <c>encrypted</c> form and provide access to decryped content
  ///  by request. Instances of this interface can be used to store
  ///  sensitive data strings like passwords or passphrases and
  ///  provide access to decrypted string only on time when they are needed
  ///  to pass to the <c>OpenSSL</c> functions.
  ///  </summary>
  ITaurusTLS_PassphraseVault = interface(ITaurusTLS_Bytes)
  ['{43197D9D-2D60-40DD-B3D5-EE0B7504EDD3}']
    ///  <summary>
    ///  Returns instance of <see cref="ITaurusTLS_Passphrase" /> interface
    ///  which contains decrypted UTF8-encoded null-terminated string
    ///  </summary>
    function GetPassphrase: ITaurusTLS_Passphrase;
    ///  <summary>
    ///  Property returning instance of <see cref="ITaurusTLS_Passphrase" />
    ///  interfacewhich contains decrypted UTF8-encoded null-terminated string.
    ///  </summary>
    property Passphrase: ITaurusTLS_Passphrase read GetPassphrase;
  end;

  ///  <summary>
  ///  Declares interface providing access to the decrypted null-terminated
  ///  UTF8-encoded string
  ///  </summary>
  ITaurusTLS_Passphrase = interface
  ['{72FDDCB8-691F-43C9-944D-CF99F0F69AE2}']
    ///  <summary>
    ///  Returns pointer to the decrypted UTF8-encoded null-terminated
    ///  string
    ///  </summary>
    function GetPassphraseStr: PAnsiChar;
    ///  <summary>
    ///  Returns pointer to the decrypted UTF8-encoded null-terminated
    ///  string.
    ///  </summary>
    property PassphraseStr: PAnsiChar read GetPassphraseStr;
  end;

  TTaurusTLS_PassphraseVault = class sealed(TTaurusTLS_BytesVault,
    ITaurusTLS_PassphraseVault)
  private type
    TPlainBytes = TTaurusTLS_BytesVault.TPlainBytes;
    TPassphrase = class(TPlainBytes, ITaurusTLS_Passphrase)
    protected
      function GetPassphraseStr: PAnsiChar;
    end;

  protected
    ///  <summary>
    ///  Creates instance of <see cref="TPassphrase" /> and initialize it
    ///  with decrypted UTF8-encoded null-terminated string.
    ///  </summary>
    procedure NewPlainBytes(const ABytes: TBytes; out APlainBytes: TPlainBytes);
      override;
    ///  <summary>
    ///  Implements <see cref="ITaurusTLS_PassphraseVault.GetPassphrase" />
    ///  method.
    ///  </summary>
    function GetPassphrase: ITaurusTLS_Passphrase;
  public

    ///  <summary>
    ///  Creates an instance of <see cref="TTaurusTLS_PassphraseVault" />
    ///  class, encrypts and stores <c>APassphrase</c> UnicodeString internally.
    ///  The content of this string is accessible via
    ///  <see cref="ITaurusTLS_PassphraseVault" /> property.
    ///  </summary>
    ///  <param name="APassphrase">
    ///  An UnicodeString to be encrypted and stored in memory.
    ///  </param>
    ///  <param name="AEncryptor">
    ///  A <see cref="TTaurusTLS_CustomEncryptor" /> instance used for
    ///  <c>encryption</c> and <c>decryption</c> of <c>APassphrase</c>
    ///  </param>
    constructor Create(var APassphrase: UnicodeString;
      AEncryptor: TTaurusTLS_CustomEncryptor); overload;

    ///  <summary>
    ///  Creates an instance of <see cref="TTaurusTLS_PassphraseVault" />
    ///  class, encrypts and stores <c>APassphrase</c> RawByteString internally.
    ///  The content of this string is accessible via
    ///  <see cref="ITaurusTLS_PassphraseVault" /> property.
    ///  </summary>
    ///  <param name="APassphrase">
    ///  An RawByteString to be encrypted and stored in memory.
    ///  </param>
    ///  <param name="AEncryptor">
    ///  A <see cref="TTaurusTLS_CustomEncryptor" /> instance used for
    ///  <c>encryption</c> and <c>decryption</c> of <c>APassphrase</c>
    ///  </param>
    constructor Create(var APassphrase: RawByteString;
      AEncryptor: TTaurusTLS_CustomEncryptor); overload;

    ///  <summary>
    ///  Creates an instance of <see cref="TTaurusTLS_PassphraseVault" />
    ///  class, encrypts and stores <c>APassphrase</c> AnsiString internally.
    ///  The content of this string is accessible via
    ///  <see cref="ITaurusTLS_PassphraseVault" /> property.
    ///  </summary>
    ///  <param name="APassphrase">
    ///  An AnsiString to be encrypted and stored in memory.
    ///  </param>
    ///  <param name="AEncryptor">
    ///  A <see cref="TTaurusTLS_CustomEncryptor" /> instance used for
    ///  <c>encryption</c> and <c>decryption</c> of <c>APassphrase</c>
    ///  </param>
    constructor Create(var APassphrase: AnsiString;
      AEncryptor: TTaurusTLS_CustomEncryptor); overload;

    ///  <summary>
    ///  Creates an instance of <see cref="TTaurusTLS_PassphraseVault" />
    ///  class, encrypts and stores <c>APassphrase</c> UTF8String internally.
    ///  The content of this string is accessible via
    ///  <see cref="ITaurusTLS_PassphraseVault" /> property.
    ///  </summary>
    ///  <param name="APassphrase">
    ///  An UTF8String to be encrypted and stored in memory.
    ///  </param>
    ///  <param name="AEncryptor">
    ///  A <see cref="TTaurusTLS_CustomEncryptor" /> instance used for
    ///  <c>encryption</c> and <c>decryption</c> of <c>APassphrase</c>
    ///  </param>
    constructor Create(var APassphrase: UTF8String;
      AEncryptor: TTaurusTLS_CustomEncryptor); overload;

    ///  <summary>
    ///  Creates an instance of <see cref="TTaurusTLS_PassphraseVault" />
    ///  class, encrypts and stores content of <c>AStream</c> parameter internally.
    ///  Stored content is accessible via <see cref="ITaurusTLS_PassphraseVault" />
    ///  property.
    ///  </summary>
    ///  <param name="AStream">
    ///  An instance of <see cref="TStream" /> class which content is stored
    ///  in ecnrypted form in memory.
    ///  <remarks>
    ///  <c>AStream</c> content is loaded as is and zero bytes added as a trailing
    ///  null symbol before content is encrypted im memory.
    ///  <c>OpenSSL</c> functions expect UTF8-encoded null-terminated string
    ///  as a passphrase. Loaded content will be processed as a UTF8-encoded
    ///  null-terminated string.
    ///  </remarks>
    ///  </param>
    ///  <param name="AEncryptor">
    ///  A <see cref="TTaurusTLS_CustomEncryptor" /> instance used for
    ///  <c>encryption</c> and <c>decryption</c> of <c>APassphrase</c>
    ///  </param>
    constructor Create(AStream: TStream;
      AEncryptor: TTaurusTLS_CustomEncryptor);overload;
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

function TTaurusTLS_Bytes.GetSize: TIdC_UInt;
begin
  Result:=Length(FBytes);
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
  TWiper.Wipe(FBytes);
  inherited;
end;

{ TTaurusTLS_BytesVault.TPlainBytes }

constructor TTaurusTLS_BytesVault.TPlainBytes.Create(ABytes: TBytes;
  AHost: TTaurusTLS_BytesVault);
begin
  // Assert is added intentionally to avoid this class improper usage.
  Assert(Assigned(AHost),
    ClassName+'.Create: parameter AHost must not be  ''nil''.');
  FHost:=AHost;
  inherited Create(ABytes);
end;

destructor TTaurusTLS_BytesVault.TPlainBytes.Destroy;
begin
  FHost.ReleaseNotify(Self);
  inherited;
end;

{ TTaurusTLS_BytesVault }

constructor TTaurusTLS_BytesVault.Create(ABytes: TBytes;
  AEncryptor: TTaurusTLS_CustomEncryptor);
begin
  CheckEncryptor(AEncryptor);
  FEncryptor:=AEncryptor;
  SetBytes(ABytes);
end;

destructor TTaurusTLS_BytesVault.Destroy;
begin
  FreeAndNil(FEncryptor);
  inherited;
end;

class procedure TTaurusTLS_BytesVault.CheckEncryptor(
  AEncryptor: TTaurusTLS_CustomEncryptor);
begin
  // Assert is added intentionally to avoid this class improper usage.
  Assert(Assigned(AEncryptor),
    ClassName+'.Create: parameter AEncryptor must not be ''nil''.');
end;

function TTaurusTLS_BytesVault.DecryptBytes: TBytes;
begin
  FEncryptor.Decrypt(FEncryptedBytes, Result);
end;

function TTaurusTLS_BytesVault.EncrypBytes(ASrc: TBytes): TBytes;
begin
  FEncryptor.Encrypt(ASrc, Result);
end;

function TTaurusTLS_BytesVault.GetBytes: TBytes;
begin
  Result:=FEncryptedBytes;
end;

procedure TTaurusTLS_BytesVault.NewPlainBytes(const ABytes: TBytes;
  out APlainBytes: TPlainBytes);
begin
  APlainBytes:=TPlainBytes.Create(ABytes, Self);
end;

function TTaurusTLS_BytesVault.GetPlainBytes: TPlainBytes;
var
  lOldPlainBytes, lNewPlainBytes: TPlainBytes;
  lNewPlainData: TBytes;

begin
  Result:=FPlainBytes;
  lOldPlainBytes:=FPlainBytes;
  if not Assigned(lOldPlainBytes) then
  begin
    lNewPlainData:=DecryptBytes;
    NewPlainBytes(lNewPlainData, lNewPlainBytes);
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

function TTaurusTLS_BytesVault.GetSize: TIdC_UInt;
begin
  Result:=FPlainBytesSize;
end;

function TTaurusTLS_BytesVault.NewBio: ITaurusTLS_Bio;
begin
  Result:=(GetPlainBytes as ITaurusTLS_Bytes).NewBio;
end;

procedure TTaurusTLS_BytesVault.ReleaseNotify(const ASender: TTaurusTLS_Bytes);
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

procedure TTaurusTLS_BytesVault.SetBytes(const ABytes: TBytes);
var
  lBytes: TBytes;

begin
  try
    if Length(FEncryptedBytes) <> 0 then
      ETaurusTLSIBytesError.RaiseWithMessage(RIB_Bytes_CanNotChange);
    lBytes := ABytes;
    FEncryptedBytes := EncrypBytes(ABytes);
    FPlainBytesSize:=Length(ABytes);
  finally
    TWiper.Wipe(lBytes); // force clean-up source data
  end;
end;

type
  TStreamHelper = class helper for TStream
    procedure WipeMemoryData(AValue: integer = $0);
  end;

{ TStreamHelper }

procedure TStreamHelper.WipeMemoryData(AValue: integer);
var
  lSize: UInt64;

begin
  lSize:=Size;
  if (Self is TMemoryStream) and (lSize > 0) then
    FillChar(TMemoryStream(Self).Memory^, lSize, AValue);
end;

{ TTaurusTLS_BytesVaultHelper }

class function TTaurusTLS_BytesVaultHelper.Create(
  var AStr: UnicodeString; AEncryptor: TTaurusTLS_CustomEncryptor;
  AWithTrailingNull: boolean): ITaurusTLS_Bytes;
begin
  Result:=TTaurusTLS_BytesVault.Create(
    TBytesFactory.CreateAndWipe(AStr, AWithTrailingNull), AEncryptor);
end;

class function TTaurusTLS_BytesVaultHelper.Create(var AStr: AnsiString;
  AEncryptor: TTaurusTLS_CustomEncryptor;
  AWithTrailingNull: boolean): ITaurusTLS_Bytes;
begin
  Result:=TTaurusTLS_BytesVault.Create(
    TBytesFactory.CreateAndWipe(AStr, AWithTrailingNull), AEncryptor);
end;

class function TTaurusTLS_BytesVaultHelper.Create(var AStr: RawByteString;
  AEncryptor: TTaurusTLS_CustomEncryptor;
  AWithTrailingNull: boolean): ITaurusTLS_Bytes;
begin
  Result:=TTaurusTLS_BytesVault.Create(
    TBytesFactory.CreateAndWipe(AStr, AWithTrailingNull), AEncryptor);
end;

class function TTaurusTLS_BytesVaultHelper.Create(var AStr: UTF8String;
  AEncryptor: TTaurusTLS_CustomEncryptor;
  AWithTrailingNull: boolean): ITaurusTLS_Bytes;
begin
  Result:=TTaurusTLS_BytesVault.Create(
    TBytesFactory.CreateAndWipe(AStr, AWithTrailingNull), AEncryptor);
end;

class function TTaurusTLS_BytesVaultHelper.Create(
  const AStream: TStream; AEncryptor: TTaurusTLS_CustomEncryptor;
  AAddTrailingNulls: TTrailingNulls; AWipeSrcMem: boolean): ITaurusTLS_Bytes;
var
  lBytes: TBytes;

begin
  CheckEncryptor(AEncryptor);
  try
    if AWipeSrcMem then
      lBytes:=TBytesFactory.CreateAndWipeMemBuf(AStream, 0, AAddTrailingNulls)
    else
      lBytes:=TBytesFactory.Create(AStream, 0, AAddTrailingNulls);
    Result:=TTaurusTLS_BytesVault.Create(lBytes, AEncryptor);
  except
    TWiper.Wipe(lBytes);
    raise;
  end;
end;

{ TTaurusTLS_PassphraseVault.TPassphrase }

function TTaurusTLS_PassphraseVault.TPassphrase.GetPassphraseStr: PAnsiChar;
begin
  Result:=PAnsiChar(GetBytes);
end;

{ TTaurusTLS_PassphraseVault }

constructor TTaurusTLS_PassphraseVault.Create(var APassphrase: UnicodeString;
  AEncryptor: TTaurusTLS_CustomEncryptor);
begin
  Create(TBytesFactory.CreateAsUTF8AndWipe(APassphrase, True), AEncryptor);
end;

constructor TTaurusTLS_PassphraseVault.Create(var APassphrase: RawByteString;
  AEncryptor: TTaurusTLS_CustomEncryptor);
begin
  Create(TBytesFactory.CreateAsUTF8AndWipe(AnsiString(APassphrase), True),
    AEncryptor);
end;

constructor TTaurusTLS_PassphraseVault.Create(var APassphrase: AnsiString;
  AEncryptor: TTaurusTLS_CustomEncryptor);
begin
  Create(TBytesFactory.CreateAsUTF8AndWipe(APassphrase, True), AEncryptor);
end;

constructor TTaurusTLS_PassphraseVault.Create(var APassphrase: UTF8String;
  AEncryptor: TTaurusTLS_CustomEncryptor);
begin
  Create(TBytesFactory.CreateAndWipe(APassphrase, True), AEncryptor);
end;

constructor TTaurusTLS_PassphraseVault.Create(AStream: TStream;
  AEncryptor: TTaurusTLS_CustomEncryptor);
begin
  Create(TBytesFactory.CreateAndWipeMemBuf(AStream, 0, 1), AEncryptor);
end;

function TTaurusTLS_PassphraseVault.GetPassphrase: ITaurusTLS_Passphrase;
var
  lBytes: TPlainBytes;

begin
  lBytes:=nil;
  try
    lBytes:=GetPlainBytes;
    Result:= lBytes as ITaurusTLS_Passphrase;
  except
    lBytes.Free;
    raise;
  end;
end;

procedure TTaurusTLS_PassphraseVault.NewPlainBytes(const ABytes: TBytes;
  out APlainBytes: TPlainBytes);
begin
  APlainBytes:=TPassphrase.Create(ABytes, Self);
end;

end.

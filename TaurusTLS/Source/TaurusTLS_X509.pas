unit TaurusTLS_X509;
{ ****************************************************************************** }
{ *  TaurusTLS                                                                 * }
{ *           https://github.com/JPeterMugaas/TaurusTLS                        * }
{ *                                                                            * }
{ *  Copyright (c) 2024 TaurusTLS Developers, All Rights Reserved              * }
{ *                                                                            * }
{ * Portions of this software are Copyright (c) 1993 � 2018,                   * }
{ * Chad Z. Hower (Kudzu) and the Indy Pit Crew � http://www.IndyProject.org/  * }
{ ****************************************************************************** }
{$I TaurusTLSCompilerDefines.inc}
{$i TaurusTLSLinkDefines.inc}

interface

uses
  IdCTypes,
  IdGlobal,
  IdGlobalProtocols,
  TaurusTLSHeaders_evp,
  TaurusTLSHeaders_ossl_typ,
  TaurusTLSHeaders_x509,
  TaurusTLSHeaders_x509v3,
  TaurusTLS_Utils,
  Classes;

type
  TIdSSLULong = packed record
    case Byte of
      0:
        (B1, B2, B3, B4: UInt8);
      1:
        (W1, W2: UInt16);
      2:
        (L1: Int32);
      3:
        (C1: UInt32);
  end;

  TIdSSLByteArray = record
    _Length: TIdC_UINT;
    Data: PByte;
  end;

  TTaurusTLSX509 = class;

  TTaurusTLSX509Name = class(TObject)
{$IFDEF USE_STRICT_PRIVATE_PROTECTED}strict{$ENDIF} protected
    fX509Name: PX509_NAME;
    function GetStrByNID(const ANid: TIdC_INT): String;
    function GetOneLine: String;
    function GetHash: TIdSSLULong;
    function GetHashAsString: String;
    function GetCommonName: String;
    function GetOrginization: String;
    function GetUnit: String;
    function GetEMail: String;
    function GetCity: String;
    function GetCountry: String;
    function GetProvidence: String;
    function GetStreetAddress: String;
  public
    constructor Create(aX509Name: PX509_NAME);
    //
    property Hash: TIdSSLULong read GetHash;
    property HashAsString: string read GetHashAsString;
    property OneLine: string read GetOneLine;
    property CommonName: String read GetCommonName;
    property Organization: String read GetOrginization;
    property _Unit: String read GetUnit;
    property EMail: String read GetEMail;
    property StreetAddress: String read GetStreetAddress;
    property City: String read GetCity;
    property Providence: String read GetProvidence;
    property Country: String read GetCountry;
    //
    property CertificateName: PX509_NAME read fX509Name;
  end;

  TTaurusTLSX509Info = class(TObject)
{$IFDEF USE_STRICT_PRIVATE_PROTECTED}strict{$ENDIF} protected
    // Do not free this here because it belongs
    // to the X509 or something else.
    FX509: PX509;
  public
    constructor Create(aX509: PX509); virtual;
    //
    property Certificate: PX509 read FX509;
  end;

  TTaurusTLSX509Fingerprints = class(TTaurusTLSX509Info)
{$IFDEF USE_STRICT_PRIVATE_PROTECTED}strict{$ENDIF} protected
    function GetMD5: TIdSSLEVP_MD;
    function GetMD5AsString: String;
    function GetSHA1: TIdSSLEVP_MD;
    function GetSHA1AsString: String;
    function GetSHA224: TIdSSLEVP_MD;
    function GetSHA224AsString: String;
    function GetSHA256: TIdSSLEVP_MD;
    function GetSHA256AsString: String;
    function GetSHA384: TIdSSLEVP_MD;
    function GetSHA384AsString: String;
    function GetSHA512: TIdSSLEVP_MD;
    function GetSHA512AsString: String;
  public
    property MD5: TIdSSLEVP_MD read GetMD5;
    property MD5AsString: String read GetMD5AsString;
    { IMPORTANT!!!

      FIPS approves only these algorithms for hashing.
      SHA-1
      SHA-224
      SHA-256
      SHA-384
      SHA-512

      http://csrc.nist.gov/CryptoToolkit/tkhash.html
    }
    property SHA1: TIdSSLEVP_MD read GetSHA1;
    property SHA1AsString: String read GetSHA1AsString;
    property SHA224: TIdSSLEVP_MD read GetSHA224;
    property SHA224AsString: String read GetSHA224AsString;
    property SHA256: TIdSSLEVP_MD read GetSHA256;
    property SHA256AsString: String read GetSHA256AsString;
    property SHA384: TIdSSLEVP_MD read GetSHA384;
    property SHA384AsString: String read GetSHA384AsString;
    property SHA512: TIdSSLEVP_MD read GetSHA512;
    property SHA512AsString: String read GetSHA512AsString;
  end;

  TTaurusTLSX509SigInfo = class(TTaurusTLSX509Info)
{$IFDEF USE_STRICT_PRIVATE_PROTECTED}strict{$ENDIF} protected
    Fsig_alg: PX509_ALGOR;
    Fsignature: PASN1_BIT_STRING;
    function GetSignature: String;
    function GetSigType: TIdC_INT;
    function GetSigTypeAsString: String;
    function GetAlgorithm: String;
  public
    constructor Create(aX509: PX509); override;
    property Signature: String read GetSignature;
    property Algorithm: String read GetAlgorithm;
    property SigType: TIdC_INT read GetSigType;
    property SigTypeAsString: String read GetSigTypeAsString;
  end;

  TTaurusTLSX509PublicKey = class(TTaurusTLSX509Info)
{$IFDEF USE_STRICT_PRIVATE_PROTECTED}strict{$ENDIF} protected
    function GetModulus: String;
    function GetExponent: String;
    function GetAlgorithm: String;
    function GetBits: TIdC_INT;
    function GetSize: TIdC_INT;
    function GetSecurityBits: TIdC_INT;
    function GetEncoding: String;
    function GetEncodingSize: TIdC_INT;
  public
    property Algorithm: String read GetAlgorithm;
    property Bits: TIdC_INT read GetBits;
    property SecurityBits: TIdC_INT read GetSecurityBits;
    property Size: TIdC_INT read GetSize;
    property Encoding: String read GetEncoding;
    property EncodingSize: TIdC_INT read GetEncodingSize;
    property Modulus: String read GetModulus;
    property Exponent_ : String read GetExponent;
  end;

  TTaurusTLSX509Exts = class(TTaurusTLSX509Info)
{$IFDEF USE_STRICT_PRIVATE_PROTECTED}strict{$ENDIF} protected
    // X509_get_ext
    function GetExtension(const AIndex: TIdC_INT): PX509_EXTENSION;
    function GetExtensionByNid(const ANid: TIdC_INT): PX509_EXTENSION;
    function GetCount: TIdC_INT;
  public
    property ExtensionByNid[const ANid: TIdC_INT]: PX509_EXTENSION
      read GetExtensionByNid;
    property Extensions[const AIndex: TIdC_INT]: PX509_EXTENSION
      read GetExtension; default;
    property Count: TIdC_INT read GetCount;
  end;

  TTaurusTLSX509AuthorityKeyID = class(TTaurusTLSX509Info)
{$IFDEF USE_STRICT_PRIVATE_PROTECTED}strict{$ENDIF} protected
    function GetIssuer(const AIndex: TIdC_INT): String;
    function GetKeyId: String;
    function GetSerial: TIdC_INT64;
    function GetIssuerCount: TIdC_INT;
  public
    property KeyID: String read GetKeyId;
    property Serial: TIdC_INT64 read GetSerial;
    property Issuer[const AIndex: TIdC_INT]: String read GetIssuer;
    property IssuerCount: TIdC_INT read GetIssuerCount;
  end;

  TTaurusTLSX509Warnings = class(TTaurusTLSX509Info)
{$IFDEF USE_STRICT_PRIVATE_PROTECTED}strict{$ENDIF} protected
    function GetObsoleteV1: Boolean;
    function GetSelfSigned: Boolean;
    function GetSubjectAndIssuerMatch: Boolean;
  public
    property ObsoleteV1: Boolean read GetObsoleteV1;
    property SelfSigned: Boolean read GetSelfSigned;
    property SubjectAndIssuerMatch: Boolean read GetSubjectAndIssuerMatch;
  end;

  TTaurusTLSX509Errors = class(TTaurusTLSX509Info)
{$IFDEF USE_STRICT_PRIVATE_PROTECTED}strict{$ENDIF} protected
    function GetInvalidInconsistantValues: Boolean;
    function GetInvalidPolicy: Boolean;
    function GetUnhandledCriticalExtension: Boolean;
    function GetNoFingerprint: Boolean;
  public
    property NoFingerprint: Boolean read GetNoFingerprint;
    property InvalidInconsistantValues: Boolean
      read GetInvalidInconsistantValues;
    property InvalidPolicy: Boolean read GetInvalidPolicy;
    property UnhandledCriticalExtention: Boolean
      read GetUnhandledCriticalExtension;
  end;

  TTaurusTLSX509AltSubjectAltNames = class(TTaurusTLSX509Info)
{$IFDEF USE_STRICT_PRIVATE_PROTECTED}strict{$ENDIF} private
    function GetItems(const AIndex: TIdC_INT): string;
    function GetItemsCount: TIdC_INT;
{$IFDEF USE_STRICT_PRIVATE_PROTECTED}strict{$ENDIF} protected
    FGeneralNames: PGENERAL_NAMES;
    procedure GetGeneralNames;
  public
    constructor Create(aX509: PX509); override;
    destructor Destroy; override;
    property Items[const AIndex: TIdC_INT]: string read GetItems;
    property ItemsCount: TIdC_INT read GetItemsCount;
  end;

  TTaurusTLSX509KeyUse = (DigitalSignature, NonRepudiation, KeyEncipherment,
    DataEncipherment, KeyAgreement, CertSign, CRLSign, EncipherOnly,
    DecipherOnly);
  TTaurusTLSX509KeyUsage = set of TTaurusTLSX509KeyUse;
  TTaurusTLSX509ExtKeyUse = (Server, Client, SMIME, CodeSign, OCSPSign,
    TimeStamp, DVCS, AnyEKU);
  TTaurusTLSX509ExtKeyUsage = set of TTaurusTLSX509ExtKeyUse;

  TTaurusTLSX509 = class(TObject)
{$IFDEF USE_STRICT_PRIVATE_PROTECTED}strict{$ENDIF} protected
    FErrors: TTaurusTLSX509Errors;
    FWarnings: TTaurusTLSX509Warnings;
    FExtensions: TTaurusTLSX509Exts;
    FFingerprints: TTaurusTLSX509Fingerprints;
    FSigInfo: TTaurusTLSX509SigInfo;
    FPublicKey: TTaurusTLSX509PublicKey;
    FCanFreeX509: Boolean;
    FX509: PX509;
    FSubject: TTaurusTLSX509Name;
    FIssuer: TTaurusTLSX509Name;
    FDisplayInfo: TStrings;
    FAuthorityKeyID: TTaurusTLSX509AuthorityKeyID;
    FAltSubjectNames: TTaurusTLSX509AltSubjectAltNames;
    function GetExtensionCount: TIdC_LONG;
    function GetSubject: TTaurusTLSX509Name;
    function GetIssuer: TTaurusTLSX509Name;
    function GetnotBefore: TDateTime;
    function GetnotAfter: TDateTime;
    function GetFingerprint: TIdSSLEVP_MD;
    function GetFingerprintAsString: String;
    function GetSerialNumber: String;

    function GetVersion: TIdC_LONG;
    function GetDisplayInfo: TStrings;
    function GetSubjectKeyIdentifier: String;
    function GetBasicConstraints: String;
    function GetExtentionName(const AIndex: TIdC_INT): string;
    function GetExtentionCritical(const AIndex: TIdC_INT): Boolean;
    function GetExtentionValues(const AIndex: TIdC_INT): string;
    function GetKeyUsage: TTaurusTLSX509KeyUsage;
    function GetExtKeyUsage: TTaurusTLSX509ExtKeyUsage;
    function GetProxyPathLen: TIdC_LONG;

    function X509ToTTaurusTLSX509Name(aX509: PX509_NAME): TTaurusTLSX509Name;
  public
    Constructor Create(aX509: PX509; aCanFreeX509: Boolean = True); virtual;
    Destructor Destroy; override;
    // These are temporary
    property ExtensionCount: TIdC_LONG read GetExtensionCount;
    //
    property Version: TIdC_LONG read GetVersion;
    //
    property SigInfo: TTaurusTLSX509SigInfo read FSigInfo;
    property Fingerprints: TTaurusTLSX509Fingerprints read FFingerprints;
    //
    property Fingerprint: TIdSSLEVP_MD read GetFingerprint;
    property FingerprintAsString: String read GetFingerprintAsString;
    property Subject: TTaurusTLSX509Name read GetSubject;
    property AltSubjectNames: TTaurusTLSX509AltSubjectAltNames
      read FAltSubjectNames;
    property Issuer: TTaurusTLSX509Name read GetIssuer;
    property notBefore: TDateTime read GetnotBefore;
    property notAfter: TDateTime read GetnotAfter;
    property SerialNumber: string read GetSerialNumber;
    property DisplayInfo: TStrings read GetDisplayInfo;

    //
    property Certificate: PX509 read FX509;
    property PublicKey: TTaurusTLSX509PublicKey read FPublicKey;
    property SubjectKeyIdentifier: String read GetSubjectKeyIdentifier;
    property BasicConstraints: String read GetBasicConstraints;
    property ExtentionName[const AIndex: TIdC_INT]: string
      read GetExtentionName;
    property ExtentionCritical[const AIndex: TIdC_INT]: Boolean
      read GetExtentionCritical;
    property ExtensionValues[const AIndex: TIdC_INT]: string
      read GetExtentionValues;
    property AuthorityKeyID: TTaurusTLSX509AuthorityKeyID read FAuthorityKeyID;
    property KeyUsage: TTaurusTLSX509KeyUsage read GetKeyUsage;
    property ExtendedKeyUsage: TTaurusTLSX509ExtKeyUsage read GetExtKeyUsage;
    property ProxyPathLen: TIdC_LONG read GetProxyPathLen;
    property Errors: TTaurusTLSX509Errors read FErrors;
    property Warnings: TTaurusTLSX509Warnings read FWarnings;
  end;

implementation

uses
  IdFIPS,
  TaurusTLSHeaders_obj_mac,
  TaurusTLSHeaders_asn1,
  TaurusTLSHeaders_bio,
  TaurusTLSHeaders_bn,
  TaurusTLSHeaders_objects,
  TaurusTLSHeaders_rsa,
  TaurusTLSHeaders_x509_vfy,
  SysUtils;
/// ////////////////////////////////////////////////////////////
// X509 Certificate
/// ////////////////////////////////////////////////////////////

{ TTaurusTLSX509Name }

function TTaurusTLSX509Name.GetOneLine: String;
var
  LOneLine: array [0 .. 2048] of TIdAnsiChar;
  LPtr: PAnsiChar;
begin
  if fX509Name = nil then
  begin
    Result := ''; { Do not Localize }
  end
  else
  begin
    LPtr := X509_NAME_oneline(fX509Name, @LOneLine[0], SizeOf(LOneLine));
    Result := String(LPtr);
  end;
end;

function TTaurusTLSX509Name.GetCity: String;
begin
  Result := GetStrByNID(NID_localityName);
end;

function TTaurusTLSX509Name.GetCommonName: String;
begin
  Result := GetStrByNID(NID_commonName);
end;

function TTaurusTLSX509Name.GetCountry: String;
begin
  Result := GetStrByNID(NID_countryName);
end;

function TTaurusTLSX509Name.GetEMail: String;
begin
  Result := GetStrByNID(NID_pkcs9_emailAddress);
end;

function TTaurusTLSX509Name.GetHash: TIdSSLULong;
begin
  if fX509Name = nil then
  begin
    FillChar(Result, SizeOf(Result), 0)
  end
  else
  begin
    Result.C1 := X509_NAME_hash(fX509Name);
  end;
end;

function TTaurusTLSX509Name.GetHashAsString: String;
begin
  Result := IndyFormat('%.8x', [Hash.L1]); { do not localize }
end;

function TTaurusTLSX509Name.GetOrginization: String;
begin
  Result := GetStrByNID(NID_organizationName);
end;

function TTaurusTLSX509Name.GetProvidence: String;
begin
  Result := GetStrByNID(NID_stateOrProvinceName);
end;

function TTaurusTLSX509Name.GetStrByNID(const ANid: TIdC_INT): String;
var
  LBuffer: array [0 .. 2048] of TIdAnsiChar;
begin
  if fX509Name = nil then
  begin
    Result := ''; { Do not Localize }
  end
  else
  begin
    if X509_NAME_get_text_by_NID(fX509Name, ANid, @LBuffer[0], 256) > -1 then
    begin
      //PIdAnsiChar typecast is necessary to force the RTL
      // to read it as a PAnsiChar for conversion for a
      // string.
      Result := String(PIdAnsiChar(@LBuffer[0]));
    end
    else
    begin
      Result := '';
    end;
  end;
end;

function TTaurusTLSX509Name.GetStreetAddress: String;
begin
  Result := GetStrByNID(NID_streetAddress);
end;

function TTaurusTLSX509Name.GetUnit: String;
begin
  Result := GetStrByNID(NID_organizationalUnitName);
end;

constructor TTaurusTLSX509Name.Create(aX509Name: PX509_NAME);
begin
  Inherited Create;
  fX509Name := aX509Name;
end;

/// ////////////////////////////////////////////////////////////
// X509 Certificate
/// ////////////////////////////////////////////////////////////

{ TTaurusTLSX509Info }

constructor TTaurusTLSX509Info.Create(aX509: PX509);
begin
  inherited Create;
  FX509 := aX509;
end;

{ TTaurusTLSX509Fingerprints }

function TTaurusTLSX509Fingerprints.GetMD5: TIdSSLEVP_MD;
begin
  CheckMD5Permitted;
  X509_digest(FX509, EVP_md5, PByte(@Result.MD), Result._Length);
end;

function TTaurusTLSX509Fingerprints.GetMD5AsString: String;
begin
  Result := MDAsString(MD5);
end;

function TTaurusTLSX509Fingerprints.GetSHA1: TIdSSLEVP_MD;
begin
  X509_digest(FX509, EVP_sha1, PByte(@Result.MD), Result._Length);
end;

function TTaurusTLSX509Fingerprints.GetSHA1AsString: String;
begin
  Result := MDAsString(SHA1);
end;

function TTaurusTLSX509Fingerprints.GetSHA224: TIdSSLEVP_MD;
begin
{$IFDEF OPENSSL_STATIC_LINK_MODEL}
  X509_digest(FX509, EVP_sha224, PByte(@Result.MD), Result._Length);
{$ELSE}
  if Assigned(EVP_sha224) then
  begin
    X509_digest(FX509, EVP_sha224, PByte(@Result.MD), Result._Length);
  end
  else
  begin
    FillChar(Result, SizeOf(Result), 0);
  end;
{$ENDIF}
end;

function TTaurusTLSX509Fingerprints.GetSHA224AsString: String;
begin
{$IFDEF OPENSSL_STATIC_LINK_MODEL}
  Result := MDAsString(SHA224);
{$ELSE}
  if Assigned(EVP_sha224) then
  begin
    Result := MDAsString(SHA224);
  end
  else
  begin
    Result := '';
  end;
{$ENDIF}
end;

function TTaurusTLSX509Fingerprints.GetSHA256: TIdSSLEVP_MD;
begin
{$IFDEF OPENSSL_STATIC_LINK_MODEL}
  X509_digest(FX509, EVP_sha256, PByte(@Result.MD), Result._Length);
{$ELSE}
  if Assigned(EVP_sha256) then
  begin
    X509_digest(FX509, EVP_sha256, PByte(@Result.MD), Result._Length);
  end
  else
  begin
    FillChar(Result, SizeOf(Result), 0);
  end;
{$ENDIF}
end;

function TTaurusTLSX509Fingerprints.GetSHA256AsString: String;
begin
{$IFDEF OPENSSL_STATIC_LINK_MODEL}
  Result := MDAsString(SHA256);
{$ELSE}
  if Assigned(EVP_sha256) then
  begin
    Result := MDAsString(SHA256);
  end
  else
  begin
    Result := '';
  end;
{$ENDIF}
end;

function TTaurusTLSX509Fingerprints.GetSHA384: TIdSSLEVP_MD;
begin
{$IFDEF OPENSSL_STATIC_LINK_MODEL}
  X509_digest(FX509, EVP_SHA384, PByte(@Result.MD), Result._Length);
{$ELSE}
  if Assigned(EVP_SHA384) then
  begin
    X509_digest(FX509, EVP_SHA384, PByte(@Result.MD), Result._Length);
  end
  else
  begin
    FillChar(Result, SizeOf(Result), 0);
  end;
{$ENDIF}
end;

function TTaurusTLSX509Fingerprints.GetSHA384AsString: String;
begin
{$IFDEF OPENSSL_STATIC_LINK_MODEL}
  Result := MDAsString(SHA384);
{$ELSE}
  if Assigned(EVP_SHA384) then
  begin
    Result := MDAsString(SHA384);
  end
  else
  begin
    Result := '';
  end;
{$ENDIF}
end;

function TTaurusTLSX509Fingerprints.GetSHA512: TIdSSLEVP_MD;
begin
{$IFDEF OPENSSL_STATIC_LINK_MODEL}
  X509_digest(FX509, EVP_sha512, PByte(@Result.MD), Result._Length);
{$ELSE}
  if Assigned(EVP_sha512) then
  begin
    X509_digest(FX509, EVP_sha512, PByte(@Result.MD), Result._Length);
  end
  else
  begin
    FillChar(Result, SizeOf(Result), 0);
  end;
{$ENDIF}
end;

function TTaurusTLSX509Fingerprints.GetSHA512AsString: String;
begin
{$IFDEF OPENSSL_STATIC_LINK_MODEL}
  Result := MDAsString(SHA512);
{$ELSE}
  if Assigned(EVP_sha512) then
  begin
    Result := MDAsString(SHA512);
  end
  else
  begin
    Result := '';
  end;
{$ENDIF}
end;

{ TTaurusTLSX509SigInfo }

constructor TTaurusTLSX509SigInfo.Create(aX509: PX509);
begin
  inherited;
  Fsig_alg := nil;
  Fsignature := nil;
end;

function TTaurusTLSX509SigInfo.GetAlgorithm: String;
var
  lalgorithm: PASN1_OBJECT;
begin
  if not Assigned(Fsig_alg) then
  begin
    X509_get0_signature(Fsignature, Fsig_alg, FX509);
  end;
  X509_ALGOR_get0(@lalgorithm, nil, nil, Fsig_alg);
  Result := ASN1_OBJECT_ToStr(lalgorithm);
end;

function TTaurusTLSX509SigInfo.GetSignature: String;
begin
  if not Assigned(Fsignature) then
  begin
    X509_get0_signature(Fsignature, Fsig_alg, FX509);
  end;
  Result := BytesToHexString(Fsignature^.Data, Fsignature^._length);
end;

function TTaurusTLSX509SigInfo.GetSigType: TIdC_INT;
begin
  Result := X509_get_signature_type(FX509);
end;

function TTaurusTLSX509SigInfo.GetSigTypeAsString: String;
begin
  Result := String(OBJ_nid2ln(SigType));
end;

{ TTaurusTLSX509 }

constructor TTaurusTLSX509.Create(aX509: PX509; aCanFreeX509: Boolean = True);
begin
  inherited Create;
  // don't create FDisplayInfo unless specifically requested.
  FDisplayInfo := nil;
  FX509 := aX509;
  FCanFreeX509 := aCanFreeX509;
  FAltSubjectNames := TTaurusTLSX509AltSubjectAltNames.Create(FX509);
  FErrors := TTaurusTLSX509Errors.Create(FX509);
  FFingerprints := TTaurusTLSX509Fingerprints.Create(FX509);
  FSigInfo := TTaurusTLSX509SigInfo.Create(FX509);
  FPublicKey := TTaurusTLSX509PublicKey.Create(FX509);
  FExtensions := TTaurusTLSX509Exts.Create(FX509);
  FSubject := nil;
  FIssuer := nil;
  FAuthorityKeyID := TTaurusTLSX509AuthorityKeyID.Create(FX509);
  FWarnings := TTaurusTLSX509Warnings.Create(FX509);
end;

destructor TTaurusTLSX509.Destroy;
begin
  FreeAndNil(FWarnings);
  FreeAndNil(FAuthorityKeyID);
  FreeAndNil(FExtensions);
  FreeAndNil(FDisplayInfo);
  FreeAndNil(FSubject);
  FreeAndNil(FIssuer);
  FreeAndNil(FFingerprints);
  FreeAndNil(FSigInfo);
  FreeAndNil(FAltSubjectNames);
  { If the X.509 certificate handle was obtained from a certificate
    store or from the SSL connection as a peer certificate, then DO NOT
    free it here!  The memory is owned by the TaurusTLS library and will
    crash the library if Indy tries to free its private memory here }
  if FCanFreeX509 then
  begin
    X509_free(FX509);
  end;
  FreeAndNil(FErrors);
  inherited Destroy;
end;

function TTaurusTLSX509.GetSubjectKeyIdentifier: String;
begin
  Result := ANS1_STRING_ToHexStr(PASN1_STRING(X509_get0_subject_key_id(FX509)));
end;

function TTaurusTLSX509.GetBasicConstraints: String;
var
  LPathLen: TIdC_LONG;
begin
  Result := '';
  if X509_get_extension_flags(FX509) and EXFLAG_CA = EXFLAG_CA then
  begin
    Result := 'CA = True';
    LPathLen := X509_get_pathlen(FX509);
    if LPathLen > -1 then
    begin
      Result := Result + ' (Pathlength: ' + IntToStr(LPathLen) + ')';
    end;
  end;
end;

function TTaurusTLSX509.GetDisplayInfo: TStrings;
var
  LMem: PBIO;
  LLen: TIdC_INT;
  LBufPtr: PIdAnsiChar;
begin
  if not Assigned(FDisplayInfo) then
  begin
    FDisplayInfo := TStringList.Create;
{$IFNDEF OPENSSL_NO_BIO}
    LMem := BIO_new(BIO_s_mem);
    if LMem <> nil then
    begin
      try
        if X509_print_ex(LMem, FX509, XN_FLAG_COMPAT, X509_FLAG_COMPAT) = 1 then begin
          LLen := BIO_get_mem_data(LMem, @LBufPtr);
          if (LLen > 0) and (LBufPtr <> nil) then
          begin
            FDisplayInfo.Text := IndyTextEncoding_UTF8.GetString(
{$IFNDEF VCL_6_OR_ABOVE}
            // RLebeau: for some reason, Delphi 5 causes a "There is no overloaded
            // version of 'GetString' that can be called with these arguments" compiler
            // error if the PByte type-cast is used, even though GetString() actually
            // expects a PByte as input.  Must be a compiler bug, as it compiles fine
            // in Delphi 6.  So, converting to TIdBytes until I find a better solution...
            RawToBytes(LBufPtr^, LLen)
{$ELSE}
            PByte(LBufPtr), LLen
{$ENDIF}
            );
          end;
        end;
      finally
        BIO_free(LMem);
      end;
    end;
{$ENDIF}
  end;
  Result := FDisplayInfo;
end;

function TTaurusTLSX509.GetExtensionCount: TIdC_LONG;
begin
  Result := Self.FExtensions.Count;
end;

function TTaurusTLSX509.GetExtentionCritical(const AIndex: TIdC_INT): Boolean;
var
  LExt: PX509_EXTENSION;

begin
  Result := False;
  if AIndex > -1 then
  begin
    LExt := X509_get_ext(FX509, AIndex);
    Result := X509_EXTENSION_get_critical(LExt) > 0;
  end;
end;

function TTaurusTLSX509.GetExtentionName(const AIndex: TIdC_INT): string;
var
  LExt: PX509_EXTENSION;
  LASN1: PASN1_OBJECT;
begin
  Result := '';
  if AIndex > -1 then
  begin
    LExt := X509_get_ext(FX509, AIndex);
    LASN1 := X509_EXTENSION_get_object(LExt);
    Result := ASN1_OBJECT_ToStr(LASN1);
  end;
end;

function TTaurusTLSX509.GetExtentionValues(const AIndex: TIdC_INT): string;
var
  LExt: PX509_EXTENSION;
  LASN1: PASN1_STRING;
begin
  Result := '';
  if AIndex > -1 then
  begin
    LExt := X509_get_ext(FX509, AIndex);
    LASN1 := PASN1_STRING(X509_EXTENSION_get_data(LExt));
    if Assigned(LASN1) then
    begin
      Result := ANS1_STRING_ToHexStr(LASN1);
    end;
  end;
end;

function TTaurusTLSX509.GetExtKeyUsage: TTaurusTLSX509ExtKeyUsage;
var
  LFlags: TIdC_UINT32;
begin
  Result := [];
  if X509_get_extension_flags(FX509) and EXFLAG_XKUSAGE = EXFLAG_XKUSAGE then
  begin
    LFlags := X509_get_extended_key_usage(FX509);
    if LFlags and XKU_SSL_SERVER = XKU_SSL_SERVER then
    begin
      Result := Result + [Server];
    end;
    if LFlags and XKU_SSL_CLIENT = XKU_SSL_CLIENT then
    begin
      Result := Result + [Client];
    end;
    if LFlags and XKU_SMIME = XKU_SMIME then
    begin
      Result := Result + [SMIME];
    end;
    if LFlags and XKU_CODE_SIGN = XKU_CODE_SIGN then
    begin
      Result := Result + [CodeSign];
    end;
    if LFlags and XKU_OCSP_SIGN = XKU_OCSP_SIGN then
    begin
      Result := Result + [OCSPSign];
    end;
    if LFlags and XKU_TIMESTAMP = XKU_TIMESTAMP then
    begin
      Result := Result + [TimeStamp];
    end;
    if LFlags and XKU_DVCS = XKU_DVCS then
    begin
      Result := Result + [DVCS];
    end;
    if LFlags and XKU_ANYEKU = XKU_ANYEKU then
    begin
      Result := Result + [AnyEKU];
    end;
  end;
end;

function TTaurusTLSX509.GetKeyUsage: TTaurusTLSX509KeyUsage;
var
  LKeyUsage: TIdC_UINT32;
begin
  Result := [];
  if X509_get_extension_flags(FX509) and EXFLAG_KUSAGE = EXFLAG_KUSAGE then
  begin

    LKeyUsage := X509_get_key_usage(FX509);
    if LKeyUsage and KU_DIGITAL_SIGNATURE = KU_DIGITAL_SIGNATURE then
    begin
      Result := Result + [DigitalSignature];
    end;
    if LKeyUsage and KU_NON_REPUDIATION = KU_NON_REPUDIATION then
    begin
      Result := Result + [NonRepudiation];
    end;
    if LKeyUsage and KU_KEY_ENCIPHERMENT = KU_KEY_ENCIPHERMENT then
    begin
      Result := Result + [DataEncipherment];
    end;
    if LKeyUsage and KU_KEY_AGREEMENT = KU_KEY_AGREEMENT then
    begin
      Result := Result + [KeyAgreement];
    end;
    if LKeyUsage and KU_KEY_CERT_SIGN = KU_KEY_CERT_SIGN then
    begin
      Result := Result + [CertSign];
    end;
    if LKeyUsage and KU_CRL_SIGN = KU_CRL_SIGN then
    begin
      Result := Result + [CRLSign];
    end;
    if LKeyUsage and KU_ENCIPHER_ONLY = KU_ENCIPHER_ONLY then
    begin
      Result := Result + [EncipherOnly];
    end;
    if LKeyUsage and KU_DECIPHER_ONLY = KU_DECIPHER_ONLY then
    begin
      Result := Result + [DecipherOnly];
    end;
  end;
end;

function TTaurusTLSX509.GetProxyPathLen: TIdC_LONG;
begin
  Result := -1;
  if X509_get_extension_flags(FX509) and EXFLAG_PROXY = EXFLAG_PROXY then
  begin
    Result := X509_get_proxy_pathlen(FX509);
  end;
end;

function TTaurusTLSX509.GetSerialNumber: String;
var
  LSN: PASN1_INTEGER;
  LBN: PBIGNUM;
begin
  if FX509 <> nil then
  begin
    LSN := X509_get_serialNumber(FX509);
    LBN := ASN1_INTEGER_to_BN(LSN, nil);
    Result := String(BN_bn2hex(LBN));
    bn_free(LBN);
  end
  else
  begin
    Result := '';
  end;
end;

function TTaurusTLSX509.GetVersion: TIdC_LONG;
begin
  Result := X509_get_version(FX509);
end;

function TTaurusTLSX509.X509ToTTaurusTLSX509Name(aX509: PX509_NAME)
  : TTaurusTLSX509Name;

begin
  Result := nil;
  if Assigned(aX509) then
  begin
    Result := TTaurusTLSX509Name.Create(aX509);
  end;
end;

function TTaurusTLSX509.GetSubject: TTaurusTLSX509Name;
Begin
  if not Assigned(FSubject) then
  begin
    FSubject := X509ToTTaurusTLSX509Name(X509_get_subject_name(FX509));
  end;
  Result := FSubject;
end;

function TTaurusTLSX509.GetIssuer: TTaurusTLSX509Name;
begin
  if not Assigned(FIssuer) then
  begin
    FIssuer := X509ToTTaurusTLSX509Name(X509_get_issuer_name(FX509));
  End;
  Result := FIssuer;
end;

function TTaurusTLSX509.GetFingerprint: TIdSSLEVP_MD;
begin
  X509_digest(FX509, EVP_md5, PByte(@Result.MD), Result._Length);
end;

function TTaurusTLSX509.GetFingerprintAsString: String;
begin
  Result := MDAsString(Fingerprint);
end;

function TTaurusTLSX509.GetnotBefore: TDateTime;
begin
  // This is a safe typecast since PASN1_UTCTIME and PASN1_TIME are really
  // pointers to ASN1 strings since ASN1_UTCTIME amd ASM1_TIME are ASN1_STRING.
  Result := ASN1TimeToDateTime(X509_get0_notBefore(FX509));
end;

function TTaurusTLSX509.GetnotAfter: TDateTime;
begin
  // This is a safe typecast since PASN1_UTCTIME and PASN1_TIME are really
  // pointers to ASN1 strings since ASN1_UTCTIME amd ASM1_TIME are ASN1_STRING.
  Result := ASN1TimeToDateTime(X509_get0_notAfter(FX509));
end;

{ TTaurusTLSX509PublicKey }

function TTaurusTLSX509PublicKey.GetAlgorithm: String;
var
  lalgorithm: PASN1_OBJECT;
begin
  X509_PUBKEY_get0_param(@lalgorithm, nil, nil, nil,
    X509_get_X509_PUBKEY(FX509));
  Result := ASN1_OBJECT_ToStr(lalgorithm);
end;

function TTaurusTLSX509PublicKey.GetEncoding: String;
var
  LLen: TIdC_INT;
  LKey: array [0 .. 2048] of TIdAnsiChar;
begin
  X509_PUBKEY_get0_param(nil, @LKey[0], @LLen, nil,
    X509_get_X509_PUBKEY(FX509));
  Result := BytesToHexString(@LKey[0], LLen);
end;

function TTaurusTLSX509PublicKey.GetEncodingSize: TIdC_INT;
var
  LKey: array [0 .. 2048] of TIdAnsiChar;
begin
  if X509_PUBKEY_get0_param(nil, @LKey[0], @Result, nil,
    X509_get_X509_PUBKEY(FX509)) <> 1 then
  begin
    Result := 0;
  end;
end;

function TTaurusTLSX509PublicKey.GetExponent: String;
var
  LKey: PEVP_PKEY;
  LBN: PBIGNUM;
begin
  Result := '';
  LKey := X509_PUBKEY_get0(X509_get_X509_PUBKEY(FX509));
  if EVP_PKEY_base_id(LKey) = EVP_PKEY_RSA then
  begin
    RSA_get0_key(EVP_PKEY_get0_RSA(LKey), nil, @LBN, nil);
    Result := String(BN_bn2hex(LBN));
  end;
end;

function TTaurusTLSX509PublicKey.GetModulus: String;
var
  LKey: PEVP_PKEY;
  LBN: PBIGNUM;
begin
  Result := '';
  LKey := X509_PUBKEY_get0(X509_get_X509_PUBKEY(FX509));
  if EVP_PKEY_base_id(LKey) = EVP_PKEY_RSA then
  begin
    RSA_get0_key(EVP_PKEY_get0_RSA(LKey), @LBN, nil, nil);
    Result := String(BN_bn2hex(LBN));
  end;
end;

function TTaurusTLSX509PublicKey.GetBits: TIdC_INT;
begin
  Result := EVP_PKEY_bits(X509_PUBKEY_get0(X509_get_X509_PUBKEY(FX509)));
end;

function TTaurusTLSX509PublicKey.GetSecurityBits: TIdC_INT;
begin
  Result := EVP_PKEY_security_bits
    (X509_PUBKEY_get0(X509_get_X509_PUBKEY(FX509)));
end;

function TTaurusTLSX509PublicKey.GetSize: TIdC_INT;
begin
  Result := EVP_PKEY_size(X509_PUBKEY_get0(X509_get_X509_PUBKEY(FX509)));
end;

{ TTaurusTLSX509Exts }

function TTaurusTLSX509Exts.GetCount: TIdC_INT;
begin
  Result := X509_get_ext_count(FX509);
end;

function TTaurusTLSX509Exts.GetExtension(const AIndex: TIdC_INT)
  : PX509_EXTENSION;
begin
  Result := X509_get_ext(FX509, AIndex);
end;

function TTaurusTLSX509Exts.GetExtensionByNid(const ANid: TIdC_INT)
  : PX509_EXTENSION;
var
  LIdx: TIdC_INT;
begin
  LIdx := X509_get_ext_by_NID(FX509, ANid, -1);
  if LIdx > -1 then
  begin
    Result := X509_get_ext(FX509, LIdx);
  end
  else
  begin
    Result := nil;
  end;
end;

{ TTaurusTLSX509AuthorityKeyID }

function TTaurusTLSX509AuthorityKeyID.GetIssuerCount: TIdC_INT;
var
  LGNs: PGENERAL_NAMES;
begin
  Result := 0;
  LGNs := X509_get0_authority_issuer(FX509);
  if Assigned(LGNs) then
  begin
    Result := sk_GENERAL_NAME_num(LGNs);
  end;
end;


function TTaurusTLSX509AuthorityKeyID.GetIssuer(const AIndex: TIdC_INT): String;
var
  LGNs: PGENERAL_NAMES;
  LG: PGENERAL_NAME;
begin
  Result := '';
  LGNs := X509_get0_authority_issuer(FX509);
  if Assigned(LGNs) then
  begin
    LG := sk_GENERAL_NAME_value(LGNs, AIndex);
    Result := GeneralNameToStr(LG);
  end;

end;

function TTaurusTLSX509AuthorityKeyID.GetKeyId: String;
begin
  Result := ANS1_STRING_ToHexStr(PASN1_STRING(X509_get0_authority_key_id(FX509)));
end;

function TTaurusTLSX509AuthorityKeyID.GetSerial: TIdC_INT64;
begin
  ASN1_INTEGER_get_int64(@Result, X509_get0_authority_serial(FX509));
end;

{ TTaurusTLSX509Warnings }

function TTaurusTLSX509Warnings.GetObsoleteV1: Boolean;
begin
  Result := X509_get_extension_flags(FX509) and EXFLAG_V1 = EXFLAG_V1;
end;

function TTaurusTLSX509Warnings.GetSelfSigned: Boolean;
begin
  Result := X509_get_extension_flags(FX509) and EXFLAG_SI = EXFLAG_SI;
end;

function TTaurusTLSX509Warnings.GetSubjectAndIssuerMatch: Boolean;
begin
  Result := X509_get_extension_flags(FX509) and EXFLAG_SS = EXFLAG_SS;
end;

{ TTaurusTLSX509Errors }

function TTaurusTLSX509Errors.GetInvalidInconsistantValues: Boolean;
begin
  Result := X509_get_extension_flags(FX509) and EXFLAG_INVALID = EXFLAG_INVALID;
end;

function TTaurusTLSX509Errors.GetInvalidPolicy: Boolean;
begin
  Result := X509_get_extension_flags(FX509) and
    EXFLAG_INVALID_POLICY = EXFLAG_INVALID_POLICY;
end;

function TTaurusTLSX509Errors.GetNoFingerprint: Boolean;
begin
  Result := X509_get_extension_flags(FX509) and
    EXFLAG_NO_FINGERPRINT = EXFLAG_NO_FINGERPRINT;
end;

function TTaurusTLSX509Errors.GetUnhandledCriticalExtension: Boolean;
begin
  Result := X509_get_extension_flags(FX509) and
    EXFLAG_CRITICAL = EXFLAG_CRITICAL;
end;

{ TTaurusTLSX509AltSubjectAltNames }

constructor TTaurusTLSX509AltSubjectAltNames.Create(aX509: PX509);
begin
  inherited Create(aX509);
  FGeneralNames := nil;
end;

destructor TTaurusTLSX509AltSubjectAltNames.Destroy;
begin
  if Assigned(FGeneralNames) then
  begin
    GENERAL_NAMES_free(FGeneralNames);
  end;
  inherited;
end;

procedure TTaurusTLSX509AltSubjectAltNames.GetGeneralNames;
begin
  if not Assigned(FGeneralNames) then
  begin
    FGeneralNames := X509_get_ext_d2i(FX509, NID_subject_alt_name, nil, nil);
  end;
end;

function TTaurusTLSX509AltSubjectAltNames.GetItems(const AIndex
  : TIdC_INT): string;
var
  LGN: PGENERAL_NAME;
begin
  Result := '';
  GetGeneralNames;
  if Assigned(FGeneralNames) then
  begin
    LGN := sk_GENERAL_NAME_value(FGeneralNames, AIndex);
    Result := GeneralNameToStr(LGN);
  end;
end;

function TTaurusTLSX509AltSubjectAltNames.GetItemsCount: TIdC_INT;
begin
  Result := -1;
  GetGeneralNames;
  if Assigned(FGeneralNames) then
  begin
    Result := sk_GENERAL_NAME_num(FGeneralNames);
  end;
end;

end.

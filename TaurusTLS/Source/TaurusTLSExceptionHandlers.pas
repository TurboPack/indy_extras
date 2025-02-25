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
///   Exception classes for TaurusTLS.
/// </summary>
unit TaurusTLSExceptionHandlers;

{$I TaurusTLSCompilerDefines.inc}


interface

uses
  Classes, SysUtils, IdException, IdCTypes, TaurusTLSHeaders_ossl_typ;

type
//moved from IdSSLTaurusTLS so we can use these classes in other places

  /// <summary>
  ///   Anscestor for all exceptions that are raised in TaurusTLS.
  /// </summary>
  ETaurusTLSError               = class(EIdException)
  public
    /// <summary>
    ///   Raises the exception class.
    /// </summary>
    /// <param name="AMsg">
    ///   The error message to display.
    /// </param>
    class procedure RaiseWithMessage(const AMsg : String);
  end;

  /// <summary>
  ///   Anscestor of exceptions that are raised when a LibSSL function fails.
  /// </summary>
  ETaurusTLSAPISSLError = class(ETaurusTLSError)
{$IFDEF USE_STRICT_PRIVATE_PROTECTED} strict{$ENDIF} protected
    FErrorCode : TIdC_INT;
    FRetCode : TIdC_INT;
  public
    /// <summary>
    ///   Raises an instance of the class.
    /// </summary>
    /// <param name="ASSL">
    ///   The OpenSSL SSL Object where the failure occurred.
    /// </param>
    /// <param name="ARetCode">
    ///   The return code for the failure.
    /// </param>
    /// <param name="AMsg">
    ///   The error message to display.
    /// </param>
    class procedure RaiseException(ASSL: PSSL; const ARetCode : TIdC_INT; const AMsg : String = '');
    /// <summary>
    ///   Raises the exception class.
    /// </summary>
    /// <param name="AErrCode">
    ///   The error code for the failure.
    /// </param>
    /// <param name="ARetCode">
    ///   The return code for the failure.
    /// </param>
    /// <param name="AMsg">
    ///   The message to display.
    /// </param>
    class procedure RaiseExceptionCode(const AErrCode, ARetCode : TIdC_INT; const AMsg : String = '');
    /// <summary>
    ///   Error Code returned by the failure.
    /// </summary>
    property ErrorCode : TIdC_INT read FErrorCode;
    /// <summary>
    ///   The return code returned by the failure.
    /// </summary>
    property RetCode : TIdC_INT read FRetCode;
  end;

  ETaurusTLSUnderlyingCryptoError = class;
  /// <summary>
  ///   Anscestor of exceptions that are raised when a LibCrypto API call fails.
  /// </summary>
  ETaurusTLSAPICryptoError = class(ETaurusTLSError)
{$IFDEF USE_STRICT_PRIVATE_PROTECTED} strict{$ENDIF} protected
    FErrorCode : TIdC_ULONG;
  public
    /// <summary>
    ///   Raises the exception class with an error code.
    /// </summary>
    /// <param name="AErrCode">
    ///   Error Code returned by the failure.
    /// </param>
    /// <param name="AMsg">
    ///   Message to display.
    /// </param>
    /// <exception cref="ETaurusTLSUnderlyingCryptoError">
    ///   If there was an underlying error.
    /// </exception>
    class procedure RaiseExceptionCode(const AErrCode : TIdC_ULONG; const AMsg : String = '');
    /// <summary>
    ///   Raises the exception class.
    /// </summary>
    /// <param name="AMsg">
    ///   Message to display.
    /// </param>
    class procedure RaiseException(const AMsg : String = '');
    /// <summary>
    ///   The error code from the failure.
    /// </summary>
    property ErrorCode : TIdC_ULONG read FErrorCode;
  end;
  /// <summary>
  ///   Raised when there is an underlying error in the error Queue.
  /// </summary>
  ETaurusTLSUnderlyingCryptoError = class(ETaurusTLSAPICryptoError);

  /// <summary>
  ///   Anscestor of exceptions that are raised if an EVP_Digest* functions
  ///   fail.
  /// </summary>
  ETaurusTLSDigestError = class(ETaurusTLSAPICryptoError);
  /// <summary>
  ///   Raised when the EVP_DigestFinal_ex function failed. <br />
  /// </summary>
  /// <seealso href="https://docs.openssl.org/3.0/man3/EVP_DigestInit/">
  ///   EVP_DigestInit_ex
  /// </seealso>
  ETaurusTLSDigestFinalEx = class(ETaurusTLSDigestError);
  /// <summary>
  ///   Raised when the EVP_DigestInit_ex function failed.
  /// </summary>
  /// <seealso href="https://docs.openssl.org/3.0/man3/EVP_DigestInit/">
  ///   EVP_DigestInit_ex
  /// </seealso>
  ETaurusTLSDigestInitEx = class(ETaurusTLSDigestError);
  /// <summary>
  ///   Raised when the EVP_DigestUpdate function failed.
  /// </summary>
  /// <seealso href="https://docs.openssl.org/3.0/man3/EVP_DigestInit/">
  ///   EVP_DigestUpdate
  /// </seealso>
  ETaurusTLSDigestUpdate = class(ETaurusTLSDigestError);

  /// <summary>
  ///   Raised when a function failed to load and an attempt to call the
  ///   function is made.
  /// </summary>
  ETaurusTLSAPIFunctionNotPresent = class(ETaurusTLSError)
  public
    /// <summary>
    ///   Raises the ETaurusTLSAPIFunctionNotPresent exception.
    /// </summary>
    /// <param name="functionName">
    ///   The name of the function that was called.
    /// </param>
    class procedure RaiseException(const functionName: string);
  end;

  /// <summary>
  ///   Anscestor of exceptions that are raised if an HMAC* functions fail.
  /// </summary>
  ETaurusTLSHMACError = class(ETaurusTLSAPICryptoError);
  /// <summary>
  ///   Raised if the HMAC_Init_ex function failed.
  /// </summary>
  /// <seealso href="https://docs.openssl.org/3.0/man3/HMAC/">
  ///   HMAC_Init_ex
  /// </seealso>
  ETaurusTLSHMACInitEx = class(ETaurusTLSHMACError);
  /// <summary>
  ///   Raised if the HMAC_Update function failed.
  /// </summary>
  /// <seealso href="https://docs.openssl.org/3.0/man3/HMAC/">
  ///   HMAC_Update
  /// </seealso>
  ETaurusTLSHMACUpdate = class(ETaurusTLSHMACError);
  /// <summary>
  ///   Raised if the HMAC_Final function failed.
  /// </summary>
  /// <seealso href="https://docs.openssl.org/3.0/man3/HMAC/">
  ///   HMAC_Final
  /// </seealso>
  ETaurusTLSHMACFinal = class(ETaurusTLSHMACError);

implementation

uses IdGlobal, IdStack, IdResourceStringsProtocols,
   TaurusTLSHeaders_err, TaurusTLSHeaders_ssl,
   TaurusTLS_ResourceStrings, TaurusTLS_Utils;

function GetErrorMessage(const AErr : TIdC_ULONG) : String;
{$IFDEF USE_INLINE} inline; {$ENDIF}
const
  sMaxErrMsg = 160;
var
  LErrMsg: array [0..sMaxErrMsg] of TIdAnsiChar;
  {$IFDEF USE_MARSHALLED_PTRS}
  LErrMsgPtr: TPtrWrapper;
  {$ENDIF}
begin
  FillChar(LErrMsg,sMaxErrMsg,0);
  {$IFDEF USE_MARSHALLED_PTRS}
  LErrMsgPtr := TPtrWrapper.Create(@LErrMsg[0]);
  {$ENDIF}
  ERR_error_string_n(AErr,
    {$IFDEF USE_MARSHALLED_PTRS}
    LErrMsgPtr.ToPointer
    {$ELSE}
    LErrMsg
    {$ENDIF}, sMaxErrMsg);
  {$IFDEF USE_MARSHALLED_PTRS}
  Result := TMarshal.ReadStringAsAnsi(LErrMsgPtr);
  {$ELSE}
  Result := AnsiStringToString(LErrMsg);
  {$ENDIF}
end;

{ ETaurusTLSAPIFunctionNotPresent }

class procedure ETaurusTLSAPIFunctionNotPresent.RaiseException(const functionName: string);
begin
  raise ETaurusTLSAPIFunctionNotPresent.CreateFmt(ROSSLAPIFunctionNotPresent,[functionName]);
end;

{ ETaurusTLSAPICryptoError }
class procedure ETaurusTLSAPICryptoError.RaiseException(const AMsg : String = '');
begin
  RaiseExceptionCode(ERR_get_error(), AMsg);
end;

class procedure ETaurusTLSAPICryptoError.RaiseExceptionCode(
  const AErrCode: TIdC_ULONG; const AMsg: String);
var
  {$IFNDEF USE_INLINE_VAR}
  LMsg: String;
  LErrMsg : String;
  {$ENDIF}
  LException : ETaurusTLSAPICryptoError;
begin
  {$IFDEF USE_INLINE_VAR}
  var LMsg, LErrMsg : String;
  {$ENDIF}
  LErrMsg :=  GetErrorMessage(AErrCode);
  if AMsg <> '' then begin
    LMsg := AMsg + sLineBreak + LErrMsg;
  end else begin
    LMsg := LErrMsg;
  end;
  LException := Create(LMsg);
  LException.FErrorCode := AErrCode;
  raise LException;
end;

{ ETaurusTLSAPISSLError }

class procedure ETaurusTLSAPISSLError.RaiseException(ASSL: PSSL; const ARetCode: TIdC_INT;
  const AMsg: String);
begin
  RaiseExceptionCode(SSL_get_error(PSSL(ASSL), ARetCode), ARetCode, AMsg);
end;

class procedure ETaurusTLSAPISSLError.RaiseExceptionCode(const AErrCode, ARetCode: TIdC_INT;
  const AMsg: String);
var
  LErrQueue : TIdC_ULONG;
  LException : ETaurusTLSAPISSLError;
  {$IFNDEF USE_INLINE_VAR}
  LErrStr : String;
  {$ENDIF}
begin
  {$IFDEF USE_INLINE_VAR}
  var LErrStr : String;
  {$ENDIF}
  if AMsg <> '' then begin
    LErrStr := AMsg + sLineBreak;
  end else begin
    LErrStr := '';
  end;
  case AErrCode of
    SSL_ERROR_SYSCALL :
    begin
      LErrQueue := ERR_get_error;
      if LErrQueue <> 0 then begin
        ETaurusTLSUnderlyingCryptoError.RaiseExceptionCode(LErrQueue, AMsg);
      end;
      if ARetCode = 0 then begin
        LException := Create(LErrStr + RSSSLEOFViolation);
        LException.FErrorCode := AErrCode;
        LException.FRetCode := ARetCode;
        raise LException;
      end;
      {Note that if LErrQueue returns 0 and ARetCode = -1, there probably
      is an error in the underlying socket so you should raise a socket error}
      if ARetCode = -1 then begin
        // TODO: catch the socket exception and re-raise it as the InnerException
        // for an ETaurusTLSAPISSLError exception...
        GStack.RaiseLastSocketError;
      end;
    end;
    SSL_ERROR_SSL : begin
      ETaurusTLSUnderlyingCryptoError.RaiseException(AMsg);
    end
  end;
  // everything else...
  LException := Create(LErrStr + GetErrorMessage(AErrCode));
  LException.FErrorCode := AErrCode;
  LException.FRetCode := ARetCode;
  raise LException;
end;

{ ETaurusTLSError }

class procedure ETaurusTLSError.RaiseWithMessage(const AMsg: String);
begin
  raise Create(AMsg);
end;

end.


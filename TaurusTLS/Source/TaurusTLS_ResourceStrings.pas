/// <exclude />
{******************************************************************************}
{*  TaurusTLS                                                                 *}
{*           https://github.com/JPeterMugaas/TaurusTLS                        *}
{*                                                                            *}
{*  Copyright (c) 2024 TaurusTLS Developers, All Rights Reserved              *}
{*                                                                            *}
{* Portions of this software are Copyright (c) 1993 – 2018,                   *}
{* Chad Z. Hower (Kudzu) and the Indy Pit Crew – http://www.IndyProject.org/  *}
{******************************************************************************}
unit TaurusTLS_ResourceStrings;

interface

resourcestring
  {TaurusTLS}
  RSOSSFailedToLoad = 'Failed to load %s.';
  RSOSSFailedToLoad_WithErrCode = 'Failed to load %s (error #%d).';
  RSOSSSessionCanNotBeNul = 'Session can not be nul.';
  RSOSSInvalidSessionValue = 'Invalid Session Value.';
  RSOSSMissingExport_WithErrCode = '%s (error #%d)';
  RSOSSUnsupportedVersion = 'Unsupported SSL Library version: %.8x.';
  RSOSSUnsupportedLibrary = 'Unsupported SSL Library: %s.';
  RSOSSLModeNotSet = 'Mode has not been set.';
  RSOSSLCouldNotLoadSSLLibrary = 'Could not load SSL library.';
  RSOSSLStatusString = 'SSL status: "%s"';
  RSOSSLConnectionDropped = 'SSL connection has dropped.';
  RSOSSLCertificateLookup = 'SSL certificate request error.';
  RSOSSLInternal = 'SSL library internal error.';
  ROSSLCantGetSSLVersionNo = 'Unable to determine SSL Library Version number';
  ROSSLAPIFunctionNotPresent = 'TaurusTLS API Function/Procedure %s not found in SSL Library';
  ROSUnrecognisedLibName = 'Unrecognised SSL Library name (%s)';
  ROSCertificateNotAddedToStore = 'Unable to add X.509 Certificate to cert store';
  ROSUnsupported = 'Not Supported';
  //callback where strings
  RSOSSLAlert =  '%s Alert';
  RSOSSLReadAlert =  '%s Read Alert';
  RSOSSLWriteAlert =  '%s Write Alert';
  RSOSSLAcceptLoop = 'Accept Loop';
  RSOSSLAcceptError = 'Accept Error';
  RSOSSLAcceptFailed = 'Accept Failed';
  RSOSSLAcceptExit =  'Accept Exit';
  RSOSSLConnectLoop =  'Connect Loop';
  RSOSSLConnectError = 'Connect Error';
  RSOSSLConnectFailed = 'Connect Failed';
  RSOSSLConnectExit =  'Connect Exit';
  RSOSSLHandshakeStart = 'Handshake Start';
  RSOSSLHandshakeDone =  'Handshake Done';
  {IdSSLTaurusTLSFIPS}
  RSOSSLEVPDigestExError = 'EVP_DigestInit_ex error';
  RSOSSLEVPDigestUpdateError = 'EVP_DigestUpdate error';
  RSOSSLMinProtocolError = 'SSL_CTX_set_min_proto_version error';
  RSOSSLMaxProtocolError = 'SSL_CTX_set_max_proto_version error';

implementation

end.

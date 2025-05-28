/// <exclude />
{ ****************************************************************************** }
{ *  TaurusTLS                                                                 * }
{ *           https://github.com/JPeterMugaas/TaurusTLS                        * }
{ *                                                                            * }
{ *  Copyright (c) 2024 TaurusTLS Developers, All Rights Reserved              * }
{ *                                                                            * }
{ * Portions of this software are Copyright (c) 1993 – 2018,                   * }
{ * Chad Z. Hower (Kudzu) and the Indy Pit Crew – http://www.IndyProject.org/  * }
{ ****************************************************************************** }
{$i TaurusTLSCompilerDefines.inc}
unit TaurusTLS_ResourceStrings;

interface

resourcestring
  { TaurusTLS }
  RSOSSFailedToLoad = 'Failed to load %s.';
  RSOSSFailedToLoad_WithErrCode = 'Failed to load %s (error #%d).';
  RSOSSSessionCanNotBeNul = 'Session can not be nul.';
  RSOSSInvalidSessionValue = 'Invalid Session Value.';
  RSOSSMissingExport_WithErrCode = '%s (error #%d)';
  RSOSSUnsupportedVersion = 'Unsupported SSL Library version: %.8x.';
  RSOSSUnsupportedLibrary = 'Unsupported SSL Library: %s.';
  RSOSSLModeNotSet = 'Mode has not been set.';
  RSDSSLWriteExFailed = 'SSL_write_ex2 failed';
  RSDSSLReadExFailed = 'SSL_read_ex failed';
  RSOSSLCouldNotLoadSSLLibrary = 'Could not load SSL library.';
  RSOSSLStatusString = 'SSL status: "%s"';
  RSOSSLConnectionDropped = 'SSL connection has dropped.';
  RSOSSLCertificateLookup = 'SSL certificate request error.';
  RSOSSLInternal = 'SSL library internal error.';
  ROSSLCantGetSSLVersionNo = 'Unable to determine SSL Library Version number';
  ROSSLAPIFunctionNotPresent =
    'TaurusTLS API Function/Procedure %s not found in SSL Library';
  ROSUnrecognisedLibName = 'Unrecognised SSL Library name (%s)';
  ROSCertificateNotAddedToStore =
    'Unable to add X.509 Certificate to cert store';
  RSOSSLMinProtocolError = 'SSL_CTX_set_min_proto_version error';
  RSOSSLMaxProtocolError = 'SSL_CTX_set_max_proto_version error';
  RSOSSLCopySessionIdError = 'SSL_copy_session_id error';
  ROSUnsupported = 'Not Supported';
  RSOSSLCertificateDoesNotMatch = 'SSL certificate does not match host name';
  RSSSLSettingTLSHostNameError = 'SSL_set1_host failed error.';
  // callback where strings
  RSOSSLAlert = '%s Alert';
  RSOSSLReadAlert = '%s Read Alert';
  RSOSSLWriteAlert = '%s Write Alert';
  RSOSSLAcceptLoop = 'Accept Loop';
  RSOSSLAcceptError = 'Accept Error';
  RSOSSLAcceptFailed = 'Accept Failed';
  RSOSSLAcceptExit = 'Accept Exit';
  RSOSSLConnectLoop = 'Connect Loop';
  RSOSSLConnectError = 'Connect Error';
  RSOSSLConnectFailed = 'Connect Failed';
  RSOSSLConnectExit = 'Connect Exit';
  RSOSSLHandshakeStart = 'Handshake Start';
  RSOSSLHandshakeDone = 'Handshake Done';
  { IdSSLTaurusTLSFIPS }
  RSOSSLEVPDigestExError = 'EVP_DigestInit_ex error';
  RSOSSLEVPDigestUpdateError = 'EVP_DigestUpdate error';
  RSOSSLEVPDigestError = 'EVP_DigestFinal_ex error';
  RSOSSLHMACInitExError = 'HMAC_Init_ex error';
  RSOSSLHMACUpdateError = 'HMAC_Update error';
  RSOSSLHMACFinalError = 'HMAC_Final error';

  // long desciptions for cert errors.
  RSMSG_X509_V_ERR_UNABLE_TO_GET_ISSUER_CERT = 'the issuer certificate could ' +
    'not be found: this occurs if the issuer certificate of an untrusted ' +
    'certificate cannot be found. ';
  RSMSG_X509_V_ERR_UNABLE_TO_GET_CRL = 'the Certificate Revocation List (CRL) '
    + 'of a certificate could not be found. ';
  RSMSG_X509_V_ERR_UNABLE_TO_DECRYPT_CERT_SIGNATURE = 'The certificate ' +
    'signature could not be decrypted. This means that the actual signature ' +
    'value could not be determined rather than it not matching the expected ' +
    'value, this is only meaningful for RSA keys. ';
  RSMSG_X509_V_ERR_UNABLE_TO_DECRYPT_CRL_SIGNATURE = 'The Certificate ' +
    'Revocation List (CRL) signature could not be decrypted: this means that ' +
    'the actual signature value could not be determined rather than it not ' +
    'matching the expected value. Unused. ';
  RSMSG_X509_V_ERR_UNABLE_TO_DECODE_ISSUER_PUBLIC_KEY = 'The public key in ' +
    'the certificate SubjectPublicKeyInfo could not be read. ';
  RSMSG_X509_V_ERR_CERT_SIGNATURE_FAILURE = 'The signature of the ' +
    'certificate is invalid. ';
  RSMSG_X509_V_ERR_CRL_SIGNATURE_FAILURE = 'The signature of the Certificate ' +
    'Revocation List (CRL) is invalid. ';
  RSMSG_X509_V_ERR_CERT_NOT_YET_VALID = 'The certificate is not yet valid: ' +
    'the notBefore date is after the current time. ';
  RSMSG_X509_V_ERR_CERT_HAS_EXPIRED = 'The certificate has expired: that is ' +
    'the notAfter date is before the current time.';
  RSMSG_X509_V_ERR_CRL_NOT_YET_VALID = 'The Certificate Revocation List (CRL) '
    + 'is not yet valid. ';
  RSMSG_X509_V_ERR_CRL_HAS_EXPIRED = 'The Certificate Revocation List (CRL) ' +
    'has expired. ';
  RSMSG_X509_V_ERR_ERROR_IN_CERT_NOT_BEFORE_FIELD = 'The certificate ' +
    'notBefore field contains an invalid time.';
  RSMSG_X509_V_ERR_ERROR_IN_CERT_NOT_AFTER_FIELD = 'The certificate notAfter ' +
    'field contains an invalid time.';
  RSMSG_X509_V_ERR_ERROR_IN_CRL_LAST_UPDATE_FIELD = 'The Certificate ' +
    'Revocation List (CRL) lastUpdate field contains an invalid time.';
  RSMSG_X509_V_ERR_ERROR_IN_CRL_NEXT_UPDATE_FIELD = 'The Certificate ' +
    'Revocation List (CRL) nextUpdate field contains an invalid time.';
  RSMSG_X509_V_ERR_OUT_OF_MEM = 'An error occurred trying to allocate memory. '
    + 'This should never happen. ';
  RSMSG_X509_V_ERR_DEPTH_ZERO_SELF_SIGNED_CERT = 'The passed certificate is ' +
    'self signed and the same certificate cannot be found in the list of ' +
    'trusted certificates. ';
  RSMSG_X509_V_ERR_SELF_SIGNED_CERT_IN_CHAIN = 'The certificate chain could ' +
    'be built up using the untrusted certificates but the root could not be ' +
    'found locally. ';
  RSNSG_X509_V_ERR_UNABLE_TO_GET_ISSUER_CERT_LOCALLY = 'The issuer ' +
    'certificate of a locally looked up certificate could not be found. This ' +
    'normally means the list of trusted certificates is not complete. ';
  RSMSG_X509_V_ERR_UNABLE_TO_VERIFY_LEAF_SIGNATURE = 'No signatures could be ' +
    'verified because the chain contains only one certificate and it is not ' +
    'self signed. ';
  RSMSG_X509_V_ERR_CERT_CHAIN_TOO_LONG = 'The certificate chain length is ' +
    'greater than the supplied maximum depth. Unused. ';
  RSMSG_X509_V_ERR_CERT_REVOKED = 'The certificate has been revoked.';
  RSMSG_X509_V_ERR_INVALID_CA = 'A Certificate Authority (CA) certificate is ' +
    'invalid. Either it is not a CA or its extensions are not consistent ' +
    'with the supplied purpose.';
  RSMSG_X509_V_ERR_PATH_LENGTH_EXCEEDED = 'The basicConstraints pathlength ' +
    'parameter has been exceeded. ';
  RSMSG_X509_V_ERR_INVALID_PURPOSE = 'The supplied certificate cannot be used '
    + 'for the specified purpose. ';
  RSMSG_X509_V_ERR_CERT_UNTRUSTED = 'The root Certificate Authority (CA) is ' +
    'not marked as trusted for the specified purpose. ';
  RSMSG_X509_V_ERR_CERT_REJECTED = 'The root Certificate Authority (CA) is ' +
    'marked to reject the specified purpose. ';
  RSMSG_X509_V_ERR_SUBJECT_ISSUER_MISMATCH = 'The current candidate issuer ' +
    'certificate was rejected because its subject name did not match the ' +
    'issuer name of the current certificate. This is only set if issuer ' +
    'check debugging is enabled it is used for status notification and is ' +
    'not in itself an error. ';
  RSMSG_X509_V_ERR_AKID_SKID_MISMATCH = 'The current candidate issuer ' +
    'certificate was rejected because its subject key identifier was present ' +
    'and did not match the authority key identifier current certificate. ' +
    'This is only set if issuer check debugging is enabled it is used for ' +
    'status notification and is not in itself an error. ';
  RSMSG_X509_V_ERR_AKID_ISSUER_SERIAL_MISMATCH = 'The current candidate ' +
    'issuer certificate was rejected because its issuer name and serial ' +
    'number was present and did not match the authority key identifier of ' +
    'the current certificate. This is only set if issuer check debugging is ' +
    'enabled it is used for status notification and is not in itself an ' +
    'error. ';
  RSMSG_X509_V_ERR_KEYUSAGE_NO_CERTSIGN = 'The current candidate issuer ' +
    'certificate was rejected because its keyUsage extension does not permit ' +
    'certificate signing. This is only set if issuer check debugging is ' +
    'enabled it is used for status notification and is not in itself an ' +
    'error. ';
  RSMSG_X509_V_ERR_INVALID_EXTENSION = 'A certificate extension had an ' +
    'invalid value (for example an incorrect encoding) or some value ' +
    'inconsistent with other extensions. ';
  RSMSG_X509_V_ERR_INVALID_POLICY_EXTENSION = 'A certificate policies '+
    'extension had an invalid value (for example an incorrect encoding) or '+
    'some value inconsistent with other extensions. This error only occurs if '+
    'policy processing is enabled. ';
  RSMSG_X509_V_ERR_NO_EXPLICIT_POLICY = 'The verification flags were set to '+
    'require and explicit policy but none was present. ';
  RSMSG_X509_V_ERR_DIFFERENT_CRL_SCOPE = 'The only Certificate Revocation '+
    'Lists (CRLs) that could be found did not match the scope of the '+
    'certificate.';
  RSMSG_X509_V_ERR_UNSUPPORTED_EXTENSION_FEATURE = 'Some feature of a '+
    'certificate extension is not supported. Unused. ';
  RSMSG_X509_V_ERR_PERMITTED_VIOLATION = 'A name constraint violation occured '+
    'in the permitted subtrees. ';
  RSMSG_X509_V_ERR_EXCLUDED_VIOLATION = 'A name constraint violation occured '+
    'in the excluded subtrees. ';
  RSMSG_X509_V_ERR_SUBTREE_MINMAX = 'A certificate name constraints extension '+
    'included a minimum or maximum field: this is not supported.';
  RSMSG_X509_V_ERR_UNSUPPORTED_CONSTRAINT_TYPE = 'An unsupported name '+
    'constraint type was encountered. OpenSSL currently only supports '+
    'directory name, DNS name, email and URI types. ';
  RSMSG_X509_V_ERR_UNSUPPORTED_CONSTRAINT_SYNTAX = 'The format of the name '+
    'constraint is not recognised: for example an email address format of a '+
    'form not mentioned in RFC3280 . This could be caused by a garbage '+
    'extension or some new feature not currently supported.';
  RSMSG_X509_V_ERR_CRL_PATH_VALIDATION_error = 'An error occured when '+
    'attempting to verify the Certificate Revocation List (CRL) path. This '+
    'error can only happen if extended CRL checking is enabled.';
  RSMSG_X509_V_ERR_APPLICATION_VERIFICATION  = 'An application specific '+
    'error. This will never be returned unless explicitly set by an '+
    'application. ';

implementation

end.

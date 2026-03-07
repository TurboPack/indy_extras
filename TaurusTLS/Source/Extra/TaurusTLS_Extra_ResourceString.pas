unit TaurusTLS_Extra_ResourceString;

interface

resourcestring
  // TTaurusTLS_CustomEncryptor's descendants errors
  REVP_Encryptor_CtxInitError = 'Error initialization Encrypt/Decrypt context.';
  REVP_EncryptDecrypt_InitNoCipher = 'Unable to initializate EncyptDecrypt '+
    'instance. No OpenSSL Cipher provided.';
  REVP_Encryptor_Encrypt_Error = 'Error in Encrypting data.';
  REVP_Encryptor_Decrypt_Error = 'Error in Decrypting data.';
  RSOSSLCertificateDoesNotMatch = 'SSL certificate does not match host name';

  // TaurusTLS_SSLContainersHelpers messages
  RSMSG_TMemoryStreamWipeOutOfRange = 'Unable to wipe a stream buffer memory. '+
    'Start position or Length is out of range.';
  RSMSG_UTF8NoMapping = 'Unable to convert character(s) to UTF8.';
  RSMSG_UnicodeNoMapping = 'Unable to convert character(s) to Unicode.';
  // ITaurusTLS_Bytes Interface errors
  RIB_Bytes_CanNotChange = 'Unable to set a data to the ITaurusTLS_Bytes '+
    'instance. It was initialized already.';

  // TTaurusTLS_Cipher errors
  REVP_Cipher_NoCipherProvided = 'Unable to initializate Cipher instance. '+
    'No OpenSSL Cipher provided.';
  REVP_Cipher_ZeroKeyLen = 'Unable to initializate Cipher instance with a '+
    'zero Key length.';
  REVP_Cipher_IVKeyLen = 'Unable to initializate Cipher instance with a '+
    'zero IV length.';
implementation

end.

By Default, TaurusTLS 

1. Verifies hostnames matches the certificate's subject's common name
2. On Windows, uses the system's certificates by default
3. Uses security level 2 meaning that security is set to 112 bits of security. As a result RSA, DSA and DH keys shorter than 2048 bits and ECC keys shorter than 224 bits are prohibited. 
4. On the server; the SSLOptions.RootCertFile, SSLOptions.CertFile, SSLOptions.KeyFile, and SSLOptions.DHParamsFile properties have been replaced with DefaultCert.RootKey, DefaultCert.PublicKey, DefaultCert.PrivateKey, and DefaultCert.DHParamsFile.  This is to accomodate SNI (Server Name Indicator) support in the server.
5. On the client; SSLOptions.RootCertFile, SSLOptions.CertFile, SSLOptions.KeyFile, and SSLOptions.DHParamsFile properties have been replaced with ClientCert.RootKey, ClientCert.PublicKey, ClientCert.PrivateKey, and ClientCert.DHParamsFile. 

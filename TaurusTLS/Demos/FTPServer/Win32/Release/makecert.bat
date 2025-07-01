openssl genrsa -out ssl-key.pem 4096
openssl req -new -key ssl-key.pem -out ssl.csr -config openssl.cnf
openssl x509 -req -in ssl.csr -signkey ssl-key.pem -out ssl-cert.pem


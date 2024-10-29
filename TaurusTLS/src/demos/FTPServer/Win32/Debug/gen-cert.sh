#!/bin/sh
openssl req -config config.cnf -newkey rsa -x509 -days 365 -out domain.crt

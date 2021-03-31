#!/bin/sh -l

openssl pkcs12 -in $1  -password pass:$4 -nocerts -nodes -out key.pem
openssl pkcs12 -in $1  -password pass:$4 -nokeys -nodes -out cert.pem
openssl rsa -in key.pem -outform DER -out authenticode.key
openssl crl2pkcs7 -nocrl -certfile cert.pem -outform DER -out authenticode.spc

osslsigncode sign \
-spc authenticode.spc -key authenticode.key \
-comm \
-t http://timestamp.digicert.com \
-in $2 -out $3
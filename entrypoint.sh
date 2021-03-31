#!/bin/sh -l
aws s3 cp $1 cert.pfx

openssl pkcs12 -in cert.pfx  -password pass:$4 -nocerts -nodes -out key.pem
openssl pkcs12 -in cert.pfx  -password pass:$4 -nokeys -nodes -out cert.pem
openssl rsa -in key.pem -outform DER -out authenticode.key
openssl crl2pkcs7 -nocrl -certfile cert.pem -outform DER -out authenticode.spc

osslsigncode sign \
-spc authenticode.spc -key authenticode.key \
-comm \
-t http://timestamp.digicert.com \
-in $2 -out $3
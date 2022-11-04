#!/bin/sh
# Import Mozilla's trusted certificate store and add a local certificate to the list for Local WordPress virtual environment application.
# Needed by GuzzleHttp to call certain resources.
curl -O https://curl.se/ca/cacert.pem
echo "" >> cacert.pem
cat "$HOME/AppData/Roaming/Local/run/router/nginx/certs/$1.local.crt" >> cacert.pem

touch php.ini
echo "curl.cainfo = \"cacert.pem\";" >> php.ini
echo "openssl.cafile = \"cacert.pem\";" >> php.ini

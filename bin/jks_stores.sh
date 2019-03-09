#! /bin/sh

set -e

keytool \
    -importkeystore \
    -deststorepass password \
    -destkeystore .pki/keystore.jks \
    -srckeystore .pki/msslserver.p12 \
    -srcstoretype PKCS12 \
    -srcstorepass password

keytool \
    -import \
    -alias bundle \
    -trustcacerts \
    -file .pki/rootCA.crt \
    -keystore .pki/truststore.jks \
    -storepass password \
    -noprompt

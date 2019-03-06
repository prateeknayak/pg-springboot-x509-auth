#! /bin/bash

## Lets generate a root key and a root cert
certdir=.pki
mkdir -p ${certdir}

openssl genrsa -out ${certdir}/rootCA.key 2048

openssl req \
        -x509 \
        -new \
        -nodes \
        -key ${certdir}/rootCA.key \
        -sha256 \
        -days 1024 \
        -out ${certdir}/rootCA.crt \
        -subj "/C=ZZ/ST=BananaRepublic/L=ZombieLand/O=MonsterInc/OU=ScaresDivision/CN=My Root CA"


openssl genrsa -out ${certdir}/msslapp.key 2048

openssl req \
        -new \
        -sha256 \
        -key ${certdir}/msslapp.key \
        -reqexts SAN \
        -config <(cat /etc/ssl/openssl.cnf <(printf "\n[SAN]\nsubjectAltName=DNS:*.svc.local")) \
        -subj "/C=ZZ/ST=BananaRepublic/L=ZombieLand/O=MonsterInc/OU=DraculaDivison/CN=msslapp" \
        -out ${certdir}/msslapp.csr


openssl x509 \
        -req \
        -in ${certdir}/msslapp.csr \
        -CA ${certdir}/rootCA.crt \
        -CAkey ${certdir}/rootCA.key \
        -CAcreateserial \
        -out ${certdir}/msslapp.crt \
        -days 500 \
        -sha256

openssl pkcs12 -export -in .pki/msslapp.crt -inkey .pki/msslapp.key -name msslapp -out .pki/msslapp.p12 -nodes
kubectl create secret generic sti-ssl-certs --from-file=ca-certificates.crt=.pki/rootCA.crt --from-file=cert.key=.pki/msslapp.key --from-file=cert.crt=.pki/msslapp.crt


openssl genrsa -out ${certdir}/msslserver.key 2048

openssl req \
        -new \
        -sha256 \
        -key ${certdir}/msslserver.key \
        -reqexts SAN \
        -config <(cat /etc/ssl/openssl.cnf <(printf "\n[SAN]\nsubjectAltName=DNS:*.svc.local")) \
        -subj "/C=ZZ/ST=BananaRepublic/L=ZombieLand/O=MonsterInc/OU=DraculaDivison/CN=msslserver" \
        -out ${certdir}/msslserver.csr


openssl x509 \
        -req \
        -in ${certdir}/msslserver.csr \
        -CA ${certdir}/rootCA.crt \
        -CAkey ${certdir}/rootCA.key \
        -CAcreateserial \
        -out ${certdir}/msslserver.crt \
        -days 500 \
        -sha256

openssl pkcs12 -export -in .pki/msslserver.crt -inkey .pki/msslserver.key -name msslserver -out .pki/msslserver.p12 -nodes
kubectl create secret generic server-sti-ssl-certs --from-file=ca-certificates.crt=.pki/rootCA.crt --from-file=cert.key=.pki/msslserver.key --from-file=cert.crt=.pki/msslserver.crt

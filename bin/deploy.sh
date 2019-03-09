#! /bin/bash

set -e

kubectl create secret generic server-ssl-certs \
    --from-file=truststore.jks=.pki/truststore.jks \
    --from-file=keystore.jks=.pki/keystore.jks

kubectl create secret generic app-ssl-certs \
    --from-file=cert.pem=.pki/msslserver.cert \
    --from-file=key.pem=.pki/msslserver.key \
    --from-file=ca.pem=.pki/rootCA.crt

kubectl apply -f manifests/deployment.yaml

kubectl apply -f manifests/service.yaml

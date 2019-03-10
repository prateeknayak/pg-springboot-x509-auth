#! /bin/bash

set -e

kubectl apply -f manifests/namespace.yaml --dry-run -o yaml | kubectl apply -f -

kubectl -n mssl-test create secret generic jks \
    --from-file=truststore.jks=.pki/truststore.jks \
    --from-file=keystore.jks=.pki/keystore.jks \
    --dry-run -o yaml | kubectl apply -f -

kubectl -n mssl-test create secret generic app-ssl-certs \
    --from-file=cert.pem=.pki/msslserver.crt \
    --from-file=key.pem=.pki/msslserver.key \
    --from-file=ca.pem=.pki/rootCA.crt \
    --dry-run -o yaml | kubectl apply -f -

kubectl -n mssl-test apply -f manifests/deployment.yaml

kubectl -n mssl-test apply -f manifests/service.yaml

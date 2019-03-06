# pg-springboot-x509-auth

Playground repository to build Mutual Authentication Over TLS (mTLS) or Mutual Authentication Over SSL (mSSL) with Spring Boot and Envoy.

With the modern architecture applications are being deployed on distributed systems and there is a need to build a mechanism of trust by which a service can trust another service without having to exchange username and pass etc.

mTLS / mSSL is one way of solving the above problem. But it has its own challenges, getting the initial handshake right is the biggest hurdle. And I have seen many devs waste eons on trying to debug 403, 503 without looking for the obvious SSL handshake.

In this example we will look at setting up a Spring Boot application which plays the role of server which checks the CN in the client cert. And we will deploy Envoy which will play the role of a client and present the said client certificate with valid CN.

## Contents

- Spring Boot app built using gradle
    - Config.java extends WebSecurityConf
    - HelloWorld.java provides rest endpoints
- Certificate generation script (bin/gencert.sh)
- Dockerfile
    - Baked in keystore and trustore DO NOT DO
    **TODO fix this or else some one will defo copy this and regret visiting this repo



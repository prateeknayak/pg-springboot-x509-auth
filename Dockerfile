FROM gradle:alpine

WORKDIR /app

COPY ./ /app/

USER root

# RUN ./gradlew build

FROM openjdk:13-alpine

COPY .pki /app/.pki

RUN keytool -importkeystore -deststorepass password -destkeystore /app/keystore.jks -srckeystore /app/.pki/msslserver.p12 -srcstoretype PKCS12 -srcstorepass password

RUN keytool -import -alias bundle -trustcacerts -file /app/.pki/rootCA.crt -keystore /app/truststore.jks -storepass password -noprompt

FROM openjdk:13-alpine

COPY --from=0 /app/build/libs/*.jar /app/msslapp.jar
COPY --from=1 /app/keystore.jks /app/keystore.jks
COPY --from=1 /app/truststore.jks /app/truststore.jks

EXPOSE 8080 8443
ENTRYPOINT ["java","-Djavax.net.debug=all", "-jar", "/app/msslapp.jar"]

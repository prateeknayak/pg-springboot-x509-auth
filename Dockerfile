FROM gradle:alpine

WORKDIR /app

COPY ./ /app/

USER root

# RUN ./gradlew build

FROM openjdk:13-alpine

COPY .pki /app/.pki
RUN keytool \
        -importcert \
        -trustcacerts -file /app/.pki/msslapp.crt \
        -alias msslapp \
        -keystore /app/keystore.jks \
        -storepass password \
        -noprompt

FROM openjdk:13-alpine

COPY --from=0 /app/build/libs/*.jar /app/msslapp.jar
COPY --from=1 /app/keystore.jks /app/keystore.jks

EXPOSE 8080 8443
ENTRYPOINT ["java","-jar", "/app/msslapp.jar"]

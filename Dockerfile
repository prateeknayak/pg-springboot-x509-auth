FROM gradle:alpine

WORKDIR /app

COPY ./ /app/

USER root

#RUN ./gradlew build

FROM openjdk:13-alpine

COPY --from=0 /app/build/libs/*.jar /app/msslserver.jar

EXPOSE 8080 8443
ENTRYPOINT ["java", "-jar", "/app/msslserver.jar"]

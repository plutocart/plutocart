FROM maven:3.8.5-openjdk-11-slim as build
WORKDIR /app
COPY ./plutocart_backend/pom.xml .
COPY ./plutocart_backend/src/ ./src/
RUN mvn -Dmaven.test.skip package

FROM openjdk:11
EXPOSE 8080
ARG JARFile=/app/target/plutocart_backend.jar
COPY  --from=build ${JARFile} app.jar
ENTRYPOINT ["java","-jar","app.jar"]
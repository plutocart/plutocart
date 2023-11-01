FROM maven:3.8.5-openjdk-17-slim as build
WORKDIR /app
COPY ./plutocart_api_gateway/pom.xml .
COPY ./plutocart_api_gateway/src/ ./src/
RUN mvn -Dmaven.test.skip package

FROM openjdk:17
EXPOSE 8765
ARG JARFile=/app/target/plutocart_api_gateway.jar
COPY  --from=build ${JARFile} app.jar
ENTRYPOINT ["java","-jar","app.jar"]
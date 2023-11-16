# Stage 1: Build the application
FROM maven:3.8.5-openjdk-17-slim as build
WORKDIR /app
COPY ./plutocart_api_gateway/pom.xml ./pom.xml
COPY ./plutocart_api_gateway/src/ ./src/
RUN mvn -Dmaven.test.skip package

# Stage 2: Run the application
FROM openjdk:17
EXPOSE 443
ARG JARFile=/app/target/plutocart_api_gateway.jar
COPY --from=build /app/target/plutocart_api_gateway.jar /app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]

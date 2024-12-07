FROM maven:3-eclipse-temurin-17 AS build
COPY . .
RUN mvn clean package -DskipTests
FROM eclipse-temurin:17-alpine
COPY --from-build/target/*.jar hkotisk.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar", "hkotisk.jar"]
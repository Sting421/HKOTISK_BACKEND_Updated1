# Build stage
FROM maven:3.9-amazoncorretto-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Runtime stage
FROM amazoncorretto:17-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

# Environment variables
ENV PORT=8080

EXPOSE ${PORT}
CMD ["java", "-jar", "app.jar"]

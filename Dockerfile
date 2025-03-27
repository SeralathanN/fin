# Use Eclipse Temurin JDK 21 as the base image
FROM eclipse-temurin:21-jdk AS build

# Set working directory
WORKDIR /app

# Copy Maven wrapper and POM file
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

# Cache dependencies
RUN ./mvnw dependency:go-offline

# Copy project source
COPY src src

# Build the application
RUN ./mvnw clean package -DskipTests

# Use a minimal JRE runtime for production
FROM eclipse-temurin:21-jre

# Set working directory in the container
WORKDIR /app

# Copy the built JAR from the previous build stage
COPY --from=build /app/target/tyremonitoring-0.0.1-SNAPSHOT.jar app.jar

# Expose the application port (default for Spring Boot)
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "app.jar"]

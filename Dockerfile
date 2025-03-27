# Use an official Maven image as the build environment
FROM maven:3.8.5-openjdk-17 AS builder

# Set working directory
WORKDIR /app

# Copy pom.xml and resolve dependencies with caching
COPY pom.xml .

# Proper cache mount format with explicit ID
RUN --mount=type=cache,id=maven-cache,target=/root/.m2 mvn dependency:go-offline

# Copy project source files
COPY . .

# Build the application with dependency caching
RUN --mount=type=cache,id=maven-cache,target=/root/.m2 mvn clean install -DskipTests

# Use a minimal Java runtime for deployment
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy the built JAR from the builder stage
COPY --from=builder /app/target/*.jar app.jar

# Expose the application port
EXPOSE 8080

# Start the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]

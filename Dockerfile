# Use an official Maven image as the build environment
FROM maven:3.8.5-openjdk-17 AS builder

# Set working directory
WORKDIR /app

# Copy pom.xml and download dependencies
COPY pom.xml .

# Cache Maven dependencies using an explicit cache ID
RUN --mount=type=cache,id=maven-cache,target=/root/.m2 mvn dependency:go-offline

# Copy the entire project source code
COPY . .

# Build the project with dependency caching
RUN --mount=type=cache,id=maven-cache,target=/root/.m2 mvn clean install -DskipTests

# Use a minimal Java runtime for the final image
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy the built JAR from the builder stage
COPY --from=builder /app/target/*.jar app.jar

# Expose the application's port
EXPOSE 8080

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]

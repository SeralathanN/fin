# Use an official Maven image
FROM maven:3.8.5-openjdk-17 AS builder

# Set working directory
WORKDIR /app

# Copy pom.xml and download dependencies
COPY pom.xml .

# Cache dependencies for faster builds
RUN --mount=type=cache,target=/root/.m2 mvn dependency:go-offline

# Copy the entire project
COPY . .

# Build the project
RUN --mount=type=cache,target=/root/.m2 mvn clean install -DskipTests

# Use a smaller JDK runtime for the final image
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy the built application from the builder stage
COPY --from=builder /app/target/*.jar app.jar

# Expose the application's port
EXPOSE 8080

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]

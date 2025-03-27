# Use Eclipse Temurin JDK 21 as the base image for building
FROM eclipse-temurin:21 AS builder

WORKDIR /app

# Copy Maven wrapper and project files
COPY .mvn .mvn
COPY mvnw pom.xml ./
COPY src ./src

# Grant execution permissions to mvnw
RUN chmod +x mvnw

# Build the project
RUN --mount=type=cache,id=maven-cache,target=/root/.m2 ./mvnw clean install -DskipTests

# Use a minimal Java runtime for deployment
FROM eclipse-temurin:21-jre

WORKDIR /app
COPY --from=builder /app/target/tyremonitoring.jar app.jar

CMD ["java", "-jar", "app.jar"]

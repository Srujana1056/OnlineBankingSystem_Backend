<<<<<<< HEAD
# Use a Java 17 JDK base image
FROM eclipse-temurin:17-jdk-jammy

# Set working directory in the container
=======
# ---------- Build stage ----------
# ---------- Build stage ----------
FROM maven:3.9-eclipse-temurin-21 AS build
>>>>>>> 09ed34d873eb106b76eb349dddd4113d14e824af
WORKDIR /app

COPY pom.xml .
# Cache deps to speed up rebuilds
RUN --mount=type=cache,target=/root/.m2 mvn -B -DskipTests dependency:go-offline

COPY src ./src
RUN --mount=type=cache,target=/root/.m2 mvn -B -DskipTests clean install package

<<<<<<< HEAD
# Install Maven and build the project
RUN apt-get update && \
    apt-get install -y maven && \
    mvn clean package -DskipTests

# Copy the jar to the working directory
COPY target/*.jar app.jar

# Expose the backend port
EXPOSE 8003

# Command to run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]
=======
# ---------- Run stage ----------
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app

COPY --from=build /app/target/*.jar app.jar
ENV JAVA_OPTS=""
EXPOSE 8080
ENTRYPOINT ["sh","-c","java $JAVA_OPTS -jar app.jar"]
>>>>>>> 09ed34d873eb106b76eb349dddd4113d14e824af

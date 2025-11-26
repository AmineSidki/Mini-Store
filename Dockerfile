# Stage 1: Build
FROM maven:3.9-eclipse-temurin-17-alpine AS maven

WORKDIR /app

# Copy pom.xml first to cache dependencies
COPY pom.xml .
# Download dependencies (this layer will be cached unless pom.xml changes)
RUN mvn dependency:go-offline

# Copy the source code
COPY src ./src

# Build the WAR file
RUN mvn clean package -DskipTests

# Stage 2: Runtime
FROM tomcat:10.1-jdk17-temurin-jammy

# Remove default Tomcat apps to keep it clean/secure
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the built WAR from the previous stage to the root context
# Note: Ensure your pom.xml produces only one WAR, or be specific with the name here
COPY --from=maven /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]

# Stage 1: Build
FROM maven:3.9-eclipse-temurin-17-alpine AS maven

WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline

COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Runtime
FROM tomcat:10.1-jdk17-temurin-jammy

# 1. Create the Hugging Face user (ID 1000)
RUN useradd -m -u 1000 user

# 2. Change Tomcat port from 8080 to 7860
RUN sed -i 's/port="8080"/port="7860"/' /usr/local/tomcat/conf/server.xml

# 3. Clear default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# 4. Copy WAR to ROOT.war (Crucial so app runs at "/")
COPY --from=maven /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# 5. Grant permissions to User 1000 for Tomcat directories
# (Tomcat needs to write to logs, temp, webapps, work)
RUN chown -R user:user /usr/local/tomcat

# 6. Switch to the user
USER user

# 7. Expose the specific port
EXPOSE 7860

ENV DB_USR="postgres.ayhgyowbjzfjcftrsswl"
ENV DB_PWD="root"

CMD ["catalina.sh", "run"]

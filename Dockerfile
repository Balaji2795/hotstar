# ---------- Stage 1 : Build the WAR file ----------
FROM maven:3.9.6-eclipse-temurin-8 AS build

WORKDIR /app

# Copy project files
COPY pom.xml .
COPY src ./src

# Build the WAR file
RUN mvn clean package -DskipTests


# ---------- Stage 2 : Run application ----------
FROM tomcat:9-jdk8

LABEL maintainer="devops-team"

# Remove default tomcat applications
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR from build stage
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh","run"]

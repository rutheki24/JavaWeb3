# Use an official Maven image to build the app
FROM maven:3.8.6-eclipse-temurin AS build

# Set the working directory
WORKDIR /app

# Copy projects files and build
COPY . .
RUN mvn clean package -DskipTests

# Use Tomcat as a base image to run the app
FROM tomcat:9

# Remove default web apps and deploy our WAR
RUN rm -rf /usr.local/tomcat/webapps/*
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Expose the port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]



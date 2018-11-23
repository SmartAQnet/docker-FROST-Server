FROM maven:3-jdk-8-alpine as builder

# Download and compile FROST-Server
ARG GITHASH

ADD https://github.com/SmartAQnet/FROST-Server/archive/${GITHASH}.zip /FROST-Server.zip
RUN jar xf FROST-Server.zip
RUN cd /FROST-Server*/; mvn clean install

# Get Tomcat8
From tomcat:8-jre8
ADD http://repo.maven.apache.org/maven2/org/postgresql/postgresql/9.4.1212/postgresql-9.4.1212.jar /usr/local/tomcat/lib/
ADD http://repo.maven.apache.org/maven2/net/postgis/postgis-jdbc/2.2.1/postgis-jdbc-2.2.1.jar /usr/local/tomcat/lib/

# Copy to tomcat path
COPY --from=builder /FROST-Server*/FROST-Server.MQTTP/target/*.war /usr/local/tomcat/webapps/FROST-Server.war

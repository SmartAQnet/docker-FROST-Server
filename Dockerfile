# Download FROST-Server
FROM alpine/git as gitloader

ARG GITREPO
ARG GITHASH

RUN git clone ${GITREPO} /FROST-Server && cd /FROST-Server && git reset --hard ${GITHASH}

# Compile FROST-Server
FROM maven:3-jdk-8-alpine as builder
COPY --from=gitloader /FROST-Server /FROST-Server
RUN cd /FROST-Server && mvn clean install

# Get Tomcat8
From tomcat:8-jre8
ADD http://repo.maven.apache.org/maven2/org/postgresql/postgresql/9.4.1212/postgresql-9.4.1212.jar /usr/local/tomcat/lib/
ADD http://repo.maven.apache.org/maven2/net/postgis/postgis-jdbc/2.2.1/postgis-jdbc-2.2.1.jar /usr/local/tomcat/lib/
COPY --from=builder /FROST-Server/FROST-Server.MQTTP/target/*.war /usr/local/tomcat/webapps/FROST-Server.war

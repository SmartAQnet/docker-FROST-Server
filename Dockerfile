FROM maven:3-jdk-8-alpine as builder
ADD https://github.com/image357/SensorThingsServer/archive/e723f1832e0680976a853eccaa3e4093d3e58579.zip /SensorThingsServer.zip
RUN jar xf SensorThingsServer.zip
RUN cd /SensorThingsServer*/; mvn clean install

From tomcat:8-jre8

ADD http://repo.maven.apache.org/maven2/org/postgresql/postgresql/9.4.1212/postgresql-9.4.1212.jar /usr/local/tomcat/lib/
ADD http://repo.maven.apache.org/maven2/net/postgis/postgis-jdbc/2.2.1/postgis-jdbc-2.2.1.jar /usr/local/tomcat/lib/

# Copy to images tomcat path
ARG WAR_FILE=FROST-Server.HTTP-1.6-SNAPSHOT.war
COPY --from=builder /SensorThingsServer*/FROST-Server.HTTP/target/*.war /usr/local/tomcat/webapps/FROST-Server.war

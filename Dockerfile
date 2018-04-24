FROM maven:3-jdk-8-alpine as builder

# Download and compile FROST-Server
ENV GITHASH 182d4049041d1ca8c303004e4885a51aae386e02

ADD https://github.com/image357/SensorThingsServer/archive/${GITHASH}.zip /SensorThingsServer.zip
RUN jar xf SensorThingsServer.zip
RUN cd /SensorThingsServer*/; mvn clean install

# Get Tomcat8
From tomcat:8-jre8
ADD http://repo.maven.apache.org/maven2/org/postgresql/postgresql/9.4.1212/postgresql-9.4.1212.jar /usr/local/tomcat/lib/
ADD http://repo.maven.apache.org/maven2/net/postgis/postgis-jdbc/2.2.1/postgis-jdbc-2.2.1.jar /usr/local/tomcat/lib/

# Copy to tomcat path
COPY --from=builder /SensorThingsServer*/FROST-Server.HTTP/target/*.war /usr/local/tomcat/webapps/FROST-Server.war

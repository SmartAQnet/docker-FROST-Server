FROM maven:3-jdk-8-alpine as builder
RUN apk add --no-cache git 
RUN git clone https://github.com/FraunhoferIOSB/SensorThingsServer.git 
#/tmp/SensorThingsServer
COPY SensorThingsServer.diff .
#/tmp/
RUN git -C SensorThingsServer apply ../SensorThingsServer.diff  
RUN mvn -f SensorThingsServer/pom.xml  clean install 

FROM tomcat:8.5-jre8-alpine
COPY --from=builder /SensorThingsServer/SensorThingsServer/target/SensorThingsServer-1.0.war /usr/local/tomcat/webapps/SensorThingsService.war
COPY tomcat-users.xml conf/tomcat-users.xml
COPY manager.xml conf/Catalina/localhost/manager.xml
COPY SensorThingsService.xml conf/Catalina/localhost/SensorThingsService.xml

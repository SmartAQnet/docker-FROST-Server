FROM maven:3-jdk-8-alpine as builder
RUN apk add --no-cache git 
#Use latest from github!?!
RUN git clone https://github.com/FraunhoferIOSB/SensorThingsServer.git 
# Patch in order to include database drivers in war
COPY SensorThingsServer.diff .
RUN git -C SensorThingsServer apply ../SensorThingsServer.diff  
#build from scratch
RUN mvn -f SensorThingsServer/pom.xml  clean install 

FROM tomcat:8.5-jre8-alpine
#set unsecure Admin pass. 
#TODO: set via environment!
COPY tomcat-users.xml conf/tomcat-users.xml
#make tomcat web interface externally available 
#TODO: switch on/off 
COPY manager.xml conf/Catalina/localhost/manager.xml
#Copy war from previous build and configure to use linked postgis
COPY --from=builder /SensorThingsServer/SensorThingsServer/target/SensorThingsServer-1.0.war /usr/local/tomcat/webapps/SensorThingsService.war
COPY SensorThingsService.xml conf/Catalina/localhost/SensorThingsService.xml

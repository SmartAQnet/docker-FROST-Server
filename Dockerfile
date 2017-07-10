FROM tomcat

RUN mkdir /usr/local/tomcat/webapps/sensorthings
RUN apt-get update && apt-get install -y git openjdk-8-jdk maven && rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/FraunhoferIOSB/SensorThingsServer.git /tmp/SensorThingsServer
COPY SensorThingsServer.diff /tmp/
RUN cd /tmp/SensorThingsServer && git apply ../SensorThingsServer.diff  
RUN cd /tmp/SensorThingsServer && mvn clean install 
RUN cp /tmp/SensorThingsServer/SensorThingsServer/target/SensorThingsServer-1.0.war /usr/local/tomcat/webapps/SensorThingsService.war
COPY tomcat-users.xml conf/tomcat-users.xml
COPY manager.xml conf/Catalina/localhost/manager.xml
COPY SensorThingsService.xml conf/Catalina/localhost/SensorThingsService.xml

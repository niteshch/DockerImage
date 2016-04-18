FROM tomcat:8.0.33-jre8

COPY ./TwitterStream.war /usr/local/tomcat/webapps/TwitterStream.war
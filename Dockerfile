ARG jdk=14

FROM maven:3.6.3-jdk-${jdk} AS build
WORKDIR /maven-demo
COPY pom.xml pom.xml
RUN ["mvn", "org.apache.maven.plugins:maven-dependency-plugin:3.1.2:go-offline", "-B"]
COPY src src
RUN ["mvn", "-o", "clean", "package"]

FROM tomcat:9-jdk${jdk}
COPY --from=build /maven-demo/target/maven-docker-demo.war /usr/local/tomcat/webapps



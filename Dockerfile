ARG jdk=14

FROM maven:3.6.3-jdk-${jdk} AS build
WORKDIR /maven-demo
COPY pom.xml pom.xml
RUN ["mvn", "-B", "dependency:go-offline"]
COPY src src
RUN ["mvn", "package"]

FROM tomcat:9-jdk${jdk}
COPY --from=build /maven-demo/target/maven-docker-demo.war /usr/local/tomcat/webapps



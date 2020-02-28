#FROM openjdk:8-jdk-alpine
#RUN addgroup -S spring && adduser -S spring -G spring
#USER spring:spring
#ARG JAR_FILE=target/*.jar
#COPY ${JAR_FILE} app.jar
#ENTRYPOINT ["java","-jar","/app.jar"]

# use maven to create target/dependecy with exploded jar structure of dependencies see pom.xml
# and to avoid building the project in advance
FROM maven:3.5.2-jdk-8-alpine AS MAVEN_TOOL_CHAIN
COPY pom.xml /tmp/
COPY src /tmp/src/
WORKDIR /tmp/
# run install without tests -DskipTests
RUN mvn install -DskipTests

FROM openjdk:8-jdk-alpine
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring
ARG DEPENDENCY=tmp/target/dependency
COPY --from=MAVEN_TOOL_CHAIN ${DEPENDENCY}/BOOT-INF/classes /app
COPY --from=MAVEN_TOOL_CHAIN ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY --from=MAVEN_TOOL_CHAIN ${DEPENDENCY}/META-INF /app/META-INF

RUN ls -l ${WORKDIR}/*

ENTRYPOINT ["java","-cp","app:app/lib/*","hello.ApplicationHello"]
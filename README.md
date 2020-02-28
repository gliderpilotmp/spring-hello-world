Hello world example in Spring Boot 
Author Martin Pirker 2020-02-28

Derived from Spring boot example for docker https://spring.io/guides/gs/spring-boot-docker/

Dockerfile uses
- maven:3.5.2-jdk-8-alpine to build, test and create target/dependencies
- openjdk:8-jdk-alpine to run spring boot application running on PORT 8080 

This Dockerfile has a DEPENDENCY parameter pointing to a directory where we have unpacked the fat jar. 
For a local Maven build:
mkdir -p target/dependency && (cd target/dependency; jar -xf ../*.jar))

Docker Build examples:
docker build -t martin/hello-world .

Docker build and run command:
docker build -t gliderpilotmp/spring-hello-world . && docker run -p localhost:8888:8080 --name hello_world gliderpilotmp/spring-hello-world

or
docker pull gliderpilotmp/spring-hello-world 
docker container run --name martin_hello3 -d -p 9999:8080 gliderpilotmp/spring-hello-world 

to expose container on port 9999 routing to 8080 spring boot app in container

Actions used:
- Java -> on every commit -> build and test run 
- Docker -> on every commit -> builds docker image, tests and pushs it to docker.pkg.github.io
- Docker Image CI -> on publishing a release -> pushs dockerimage to dockerhub gliderpilotmp/tag-name (spring-hello-world)
    see https://www.prestonlamb.com/blog/creating-a-docker-image-with-github-actions
    uses DOCKER_PASSWORD and DOCKER_USERNAME secrets

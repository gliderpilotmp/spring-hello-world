
#This Dockerfile has a DEPENDENCY parameter pointing to a directory where we have unpacked the fat jar. From a Maven build:**

mkdir -p target/dependency && (cd target/dependency; jar -xf ../*.jar)

#Build:

docker build -t martin/hello-world .



#Docker build and run command:

docker build -t martin/gs-spring-boot-docker . && docker run -p localhost:8888:8080 --name martin_hello martin/gs-spring-boot-docker 
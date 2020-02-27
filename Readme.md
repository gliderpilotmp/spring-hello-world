
**This Dockerfile has a DEPENDENCY parameter pointing to a directory where we have unpacked the fat jar. From a Maven build:**

mkdir -p target/dependency && (cd target/dependency; jar -xf ../*.jar)

Build:

docker build -t martin/hello-world .




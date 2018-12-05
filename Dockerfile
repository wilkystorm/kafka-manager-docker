### STAGE 1: Build ### 
FROM ubuntu:15.04 

RUN echo "Building Kafka Manager" \
    && apt-get update && apt-get install -y git \
    && git clone https://github.com/yahoo/kafka-manager.git \
    && cd kafka-manager \
    && echo 'scalacOptions ++= Seq("-Xmax-classfile-name", "200")' >> build.sbt \
    && ( ./sbt clean dist ; exit 0) \
    && (ls target/universal/kafka-manager-1.3.3.21.zip && exit 0) || ( ./sbt clean dist ; exit 0) \
    && (ls target/universal/kafka-manager-1.3.3.21.zip && exit 0) || ( ./sbt clean dist ; exit 0) \
    && unzip -d ./build ./target/universal/kafka-manager-1.3.3.21.zip \
    && ./build/kafka-manager-1.3.3.21/bin/kafka-manager

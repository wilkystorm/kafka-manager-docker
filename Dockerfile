### STAGE 1: Build ### 
FROM openjdk:8u131-jdk AS build 

ENV KAFKA_MANAGER_VERSION=1.3.3.21

RUN echo "Building Kafka Manager" \
    && git clone https://github.com/yahoo/kafka-manager.git \
    && cd kafka-manager \
    && echo 'scalacOptions ++= Seq("-Xmax-classfile-name", "200")' >> build.sbt \
    && RUN ( ./sbt clean dist ; exit 0) # even though it fails, if we return the exit code 0 we can try to proceed again \
    && RUN (ls target/universal/kafka-manager-$KAFKA_MANAGER_VERSION.zip && exit 0) || ( ./sbt clean dist ; exit 0) \
    && RUN (ls target/universal/kafka-manager-$KAFKA_MANAGER_VERSION.zip && exit 0) || ( ./sbt clean dist ; exit 0) \
    && unzip -d ./build ./target/universal/kafka-manager-${KAFKA_MANAGER_VERSION}.zip \
    && mv -T ./build/kafka-manager-${KAFKA_MANAGER_VERSION} /kafka-manager-bin

### STAGE 2: Package ### 
FROM openjdk:8u131-jre-alpine 
MAINTAINER Mike Wilkinson <wilkystorm@gmail.com> 

RUN apk update && apk add bash

COPY --from=build /kafka-manager-bin /kafka-manager

VOLUME /kafka-manager/conf

ENTRYPOINT ["/kafka-manager/bin/kafka-manager"]

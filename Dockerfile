FROM ubuntu:18.04 

RUN echo "Building Kafka Manager" \
    && apt-get update \
    && apt-get install -y git \
    && apt-get -f install \
    && apt-get install -y software-properties-common \
    && apt-get -f install \
    && add-apt-repository ppa:webupd8team/java \
    && apt-get update \
    && apt-get install -y oracle-java8-installer \
    && apt-get install -y oracle-java8-set-default \
    && git clone https://github.com/yahoo/kafka-manager.git \
    && cd kafka-manager \
    && chmod +x ./sbt \
    && echo 'scalacOptions ++= Seq("-Xmax-classfile-name", "200")' >> build.sbt \
    && (./sbt clean dist ; exit 0) \
    && (ls target/universal/kafka-manager-1.3.3.21.zip && exit 0) || (./sbt clean dist ; exit 0) \
    && (ls target/universal/kafka-manager-1.3.3.21.zip && exit 0) || (./sbt clean dist ; exit 0) \
    && unzip -d ./build ./target/universal/kafka-manager-1.3.3.21.zip \
    && chmod +x ./build/kafka-manager-1.3.3.21/bin/kafka-manager \
    && ./build/kafka-manager-1.3.3.21/bin/kafka-manager

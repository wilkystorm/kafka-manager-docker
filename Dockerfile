FROM ubuntu:18.04 

RUN echo "Building Kafka Manager" \
    && apt-get update \
    && apt-get install -y git \
    && apt-get -f install \
    && apt-get install -y software-properties-common \
    && apt-get -f install \
    && echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823 \
    && apt-get update \
    && apt-get install -y sbt \
    && apt-get -f install \
    && git clone https://github.com/yahoo/kafka-manager.git \
    && cd kafka-manager \
    && echo 'scalacOptions ++= Seq("-Xmax-classfile-name", "200")' >> build.sbt \
    && (./sbt clean dist ; exit 0) \
    && (ls target/universal/kafka-manager-1.3.3.21.zip && exit 0) || (./sbt clean dist ; exit 0) \
    && (ls target/universal/kafka-manager-1.3.3.21.zip && exit 0) || (./sbt clean dist ; exit 0) \
    && unzip -d ./build ./target/universal/kafka-manager-1.3.3.21.zip \
    && chmod +x ./build/kafka-manager-1.3.3.21/bin/kafka-manager \
    && ./build/kafka-manager-1.3.3.21/bin/kafka-manager

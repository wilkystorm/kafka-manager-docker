FROM ubuntu:18.04 

RUN echo "Building Kafka Manager" \
    && apt-get update \
    && apt-get install -y git \
    && apt-get -f install \
    && apt-get install curl \
    && apt-get -f install \
    && curl -o /root/.sbt/launchers/0.13.9/sbt-launch.jar http://repo.typesafe.com/typesafe/ivy-releases/org.scala-sbt/sbt-launch/0.13.9/sbt-launch.jar
    && apt-get install -y unzip \
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

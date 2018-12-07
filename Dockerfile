FROM centos:7 

RUN yum update -y && \
    yum install -y java-1.8.0-openjdk-headless && \
    yum clean all
    
ENV JAVA_HOME=/usr/java/default/ \ 
    ZK_HOSTS=localhost:2181 \ 
    KM_VERSION=1.3.3.21 \ 
    KM_REVISION=e27328cd29cd1f4a6fc89764003bbde2b1ac4cbb \ 
    KM_CONFIGFILE="conf/application.conf" 
    
RUN yum install -y java-1.8.0-openjdk-devel git wget unzip which && \
    mkdir -p /tmp && \
    cd /tmp && \
    git clone https://github.com/yahoo/kafka-manager && \
    cd /tmp/kafka-manager && \
    echo 'scalacOptions ++= Seq("-Xmax-classfile-name", "200")' >> build.sbt && \
    (./sbt clean dist ; exit 0) && \
    (ls target/universal/kafka-manager-${KM_VERSION}.zip && exit 0) || (./sbt clean dist ; exit 0) && \
    (ls target/universal/kafka-manager-${KM_VERSION}.zip && exit 0) || (./sbt clean dist ; exit 0) && \
    unzip  -d / ./target/universal/kafka-manager-${KM_VERSION}.zip && \
    rm -fr /tmp/* /root/.sbt /root/.ivy2 && \
    chmod +x /kafka-manager-${KM_VERSION}/bin/kafka-manager && \
    yum autoremove -y java-1.8.0-openjdk-devel git wget unzip which && \
    yum clean all
    
WORKDIR /kafka-manager-${KM_VERSION}/bin

EXPOSE 9000 

ENTRYPOINT ["./kafka-manager"]

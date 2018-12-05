# kafka manager Dockerfile
[kafka manager](https://github.com/yahoo/kafka-manager) is a tool from Yahoo Inc. for managing [Apache Kafka](http://kafka.apache.org).

## Howto
### Quick Start
```
docker run -it --rm  -p 9000:9000 -e ZK_HOSTS="your-zk.domain:2181" -e wilkystorm/kafka-manager
```
(if you don't define ZK_HOSTS, default value has been set to "localhost:2181")

FROM ubuntu:18.10

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
                              openjdk-8-jdk \
                              zookeeper \
                              wget \
                              dnsutils \
                              vim \
            && rm -rf /var/lib/apt/lists/*

ENV KAFKA_VERSION 2.0.0
ENV SCALA_VERSION 2.11
RUN wget -q \
    http://www-eu.apache.org/dist/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz \
    -O /tmp/kafka.tgz \
    && tar xfz /tmp/kafka.tgz -C /opt \
    && rm /tmp/kafka.tgz \
    && mv /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION} /opt/kafka


ADD /usr/local/bin/run.sh /usr/local/bin/run.sh

WORKDIR /opt/kafka
CMD ["/usr/local/bin/run.sh"]

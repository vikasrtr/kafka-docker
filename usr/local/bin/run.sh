#!/bin/bash

# Update server.properties when executing
# env var will set when executing docker run
if [ ! -z "$ADVERTISED_HOST" ]; then
    # sed -r -i "s/#(advertised.host.name)=(.*)/\1=$ADVERTISED_HOST/g" config/server.properties
    echo -e "\nadvertised.host.name=$ADVERTISED_HOST" >> config/server.properties
fi

if [ ! -z "$ADVERTISED_PORT" ]; then
    # sed -r -i "s/#(advertised.port)=(.*)/\1=$ADVERTISED_PORT/g" config/server.properties
    echo -e "\nadvertised.port=$ADVERTISED_PORT" >> config/server.properties
fi

if [ ! -z "${NUM_PARTITIONS}" ]; then
    sed -r -i "s/(num.partitions)=(.*)/\1=${NUM_PARTITIONS}/g" config/server.properties
fi

# Start to run zookeeper as background process
bin/zookeeper-server-start.sh config/zookeeper.properties &

# Start kafka server
bin/kafka-server-start.sh config/server.properties
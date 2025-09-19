#!/bin/bash

set -e

# Set heap size if not set
if [ -z "${ES_JAVA_OPTS}" ]; then
    export ES_JAVA_OPTS="-Xms512m -Xmx512m"
fi

# Set permissions for data directory
# chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/data

if [ -n "${ES_INIT_LOGS}" ]; then
    /usr/share/elasticsearch/init-index.sh &
fi

# Execute original entrypoint
exec /usr/share/elasticsearch/bin/elasticsearch
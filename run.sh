#!/usr/bin/env bash

set -e

if [ ! -e /root/.config/quasar/quasar-config.json ]; then

    echo >&2 'info: create quasar-config.json'

    PORT="${PORT-8080}"
    CONNECTION_NAME="${CONNECTION_NAME-MongoDB}"
    CONNECTION_URI="${CONNECTION_URI-mongodb://mongodb:27017}"

    echo "
    {
      \"server\": {
        \"port\": $PORT
      },
      \"mountings\": {
        \"/$CONNECTION_NAME/\": {
          \"mongodb\": {
            \"connectionUri\": \"$CONNECTION_URI\"
          }
        }
      }
    }
    " >> /root/.config/quasar/quasar-config.json
    java -jar /slamdata/quasar.jar initUpdateMetaStore --content-path /slamdata/public
fi



export _JAVA_OPTIONS="${JAVA_OPTIONS:="-Xms1G -Xmx4G"} $SD_OPTS"

java -jar /slamdata/quasar.jar --content-path /slamdata/public 
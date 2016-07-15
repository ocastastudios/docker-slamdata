#!/usr/bin/env bash

set -e

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

java -jar /slamdata/quasar.jar --content-path /slamdata/public
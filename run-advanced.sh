#!/usr/bin/env bash

set -e

if [ ! -e /root/.config/quasar/quasar-config.json ]; then

    echo >&2 'info: create quasar-config.json'

    PORT="${PORT-8080}"
    OIDC_ISSUER="${OIDC_ISSUER}"
    OIDC_CLIENT_ID="${OIDC_CLIENT_ID}"
    OIDC_NAME="${OIDC_NAME-OpenIDConnect}"
    echo "
    {
      \"server\": {
        \"port\": $PORT
      },
      \"authentication\": {
        \"openid_providers\": [
          {
            \"issuer\": \"$OIDC_ISSUER\",
            \"client_id\": \"$OIDC_CLIENT_ID\",
            \"display_name\": \"$OIDC_NAME\"
          }
        ]
      }
    }
    " >> /root/.config/quasar/quasar-config.json
fi

set -e

# Initialise Advanced Metastore if required
if [ ! -e /root/.config/quasar/quasar-metastore.db.mv.db ]; then
  [ -z "$ADMIN_GROUP" ] && { echo "Need to set ADMIN_GROUP"; exit 1; }
  [ -z "$ADMIN_USERS" ] && { echo "Need to set ADMIN_USERS"; exit 1; }
  java -jar /slamdata/quasar.jar bootstrap --admin-group $ADMIN_GROUP --admin-users $ADMIN_USERS
fi

export _JAVA_OPTIONS="${JAVA_OPTIONS:="-Xms1G -Xmx4G"} $SD_OPTS"

java -jar /slamdata/quasar.jar --content-path /slamdata/public
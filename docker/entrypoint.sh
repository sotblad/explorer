#!/bin/sh
set -e

if [ "$1" = "supervisord" ]; then
  # sed away configuration
  echo "updating configuration"

  # app url
  sed -i s/APP_URL/${APP_URL}/ /usr/src/app/settings.json

  # mongo
  sed -i s/MONGO_DB/${MONGO_DB}/ /usr/src/app/settings.json
  sed -i s/MONGO_HOST/${MONGO_HOST}/ /usr/src/app/settings.json
  sed -i s/MONGO_PORT/${MONGO_PORT}/ /usr/src/app/settings.json
  sed -i s/MONGO_USERNAME/${MONGO_USERNAME}/ /usr/src/app/settings.json
  sed -i s/MONGO_PASSWORD/${MONGO_PASSWORD}/ /usr/src/app/settings.json

  # rpc
  sed -i s/RPC_HOST/${RPC_HOST}/ /usr/src/app/settings.json
  sed -i s/RPC_PORT/${RPC_PORT}/ /usr/src/app/settings.json
  sed -i s/RPC_USERNAME/${RPC_USERNAME}/ /usr/src/app/settings.json
  sed -i s/RPC_PASSWORD/${RPC_PASSWORD}/ /usr/src/app/settings.json
fi

exec "$@"

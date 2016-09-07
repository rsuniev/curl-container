#!/bin/sh
set -e

while true; do
  curl -sL -w "%{http_code}" $URL_TO_CURL -o /dev/null;
  echo \n;
  sleep 0.1;
done;

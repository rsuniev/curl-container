#!/bin/bash

host=$(hostname)

while true; do
  HTTP_CODE=$(curl -sL -w "%{http_code}" -o /dev/null "$URL_TO_CURL")
  echo "Returned code: $HTTP_CODE"
  logger -t "$host" $HTTP_CODE
  sleep 0.1
done;

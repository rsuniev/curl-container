#!/bin/sh

while true; do
  curl -sL -w "%{http_code}" -o /dev/null "$URL_TO_CURL"
  sleep 0.1
done;

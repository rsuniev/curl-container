#!/bin/sh
set -e

while true; do
  curl -sL -w "%{http_code}" "${URL_TO_CURL}" -o /dev/null;
  sleep 1;
done;

#!/bin/bash

SERVER_URL='http://rancher-metadata'
echo "Checking network is up on: $SERVER_URL"
while true;
  do
    sleep 1
    echo "Running curl"
    HTTP_CODE=$(curl -m 1 -o /dev/null -s -w %{http_code} $SERVER_URL)
    echo "http code: ${HTTP_CODE}"
    if [ ${HTTP_CODE} -eq 200 ]; then
      echo "Connectivity test has been successfull"
      break
    fi
done


SECRETS_FILE="/tmp/secrets.txt"
TRY=0
until [ -e $SECRETS_FILE ] || [ $TRY -gt 10 ]; do
	echo "Waiting for secrets boostrap file at $BOOTSTRAP_FILE"
	sleep 10
	let "TRY++"
done

if [ $TRY -lt 10 ]; then
	echo "Found secrets file"
else
	echo "Didn't find secrets file. Setup has failed"
  exit 1
fi

source $SECRETS_FILE
PERM_KEY=$(curl -s -H "X-Vault-Token: $TEMP_TOKEN" $CUBBY_PATH |  jq -r '.data.permKey')
SECRET_VALUE=$(curl -H "X-Vault-Token: $PERM_KEY" $VAULT_SERVER_URL/v1/secret/security/default/testusername | jq -r '.data.value')
$SECRET_VALUE >> /temp/curl/security/default/secret.txt
echo "Secret retrieved and saved"

host=$(hostname)

while true; do
  HTTP_CODE=$(curl -sL -w "%{http_code}" -o /dev/null "$URL_TO_CURL")
  echo "Returned code: $HTTP_CODE"
  logger -t "$host" $HTTP_CODE
  sleep 0.1
done;

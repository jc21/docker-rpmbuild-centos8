#!/bin/bash -e
set -x

DOMAIN_PREFIX=https://yum.jc21.com/
TMP_FILE=/tmp/rpmdata.json
UTIME=$(date +%s)

yum -y install jq wget

echo 'Fetching yum rpm list ...'
wget -O "$TMP_FILE" "https://yum.jc21.com/rpmdata.json?t=${UTIME}"

RPMS=$(cat "$TMP_FILE" | jq '.[].repos[].rpms[] | select(.name | startswith("golang")) | "\(.filepath)/\(.filename)"' -r)
rm -rf "$TMP_FILE"
rpmUrls=()
while IFS= read -r line; do
	if [[ "$line" != *".src.rpm" ]]; then
		rpmUrls+=( "${DOMAIN_PREFIX}${line}" )
	fi
done <<< "$RPMS"

echo 'Installing packages ...'
yum -y localinstall ${rpmUrls[@]}

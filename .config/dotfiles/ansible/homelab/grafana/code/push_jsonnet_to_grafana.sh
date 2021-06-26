#!/usr/bin/env bash

JSONNET_PATH=grafonnet-lib \
  jsonnet prometheus.jsonnet > dashboard.json

payload="{\"dashboard\": $(jq . dashboard.json), \"overwrite\": true}"

# echo "$payload"
# echo "$BASIC_AUTH"
curl -X POST $BASIC_AUTH \
  -H 'Content-Type: application/json' \
  -d "${payload}" \
  "http://admin:admin@localhost:3000/api/dashboards/db"

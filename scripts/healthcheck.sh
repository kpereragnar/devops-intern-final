#!/usr/bin/env bash

set -euo pipefail

URL="${1:-http://localhost:8080}"

echo "========================================"
echo "         APPLICATION HEALTH CHECK"
echo "========================================"

echo "Target URL: $URL"
echo "Checking application availability..."

if ! HTTP_STATUS=$(curl \
    --silent \
    --show-error \
    --output /dev/null \
    --write-out "%{http_code}" \
    --max-time 10 \
    "$URL"); then

    echo "ERROR: Unable to connect to $URL"
    echo "Check network connectivity and application availability."
    exit 1
fi

if [[ "$HTTP_STATUS" == "200" ]]; then
    echo "SUCCESS: Application is healthy."
    echo "HTTP Status: $HTTP_STATUS"
    exit 0
else
    echo "ERROR: Application health check failed."
    echo "HTTP Status: $HTTP_STATUS"
    exit 1
fi

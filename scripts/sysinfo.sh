#!/usr/bin/env bash

set -euo pipefail

echo "========================================"
echo "       SYSTEM INFORMATION REPORT"
echo "========================================"

echo
echo "[ USER INFORMATION ]"
echo "Current User: $(whoami)"
echo "Effective UID: $(id -u)"

echo
echo "[ SYSTEM INFORMATION ]"
echo "Hostname: $(hostname)"
echo "Kernel: $(uname -r)"
echo "Date: $(date --iso-8601=seconds)"

echo
echo "[ DISK USAGE ]"
df -h /

echo
echo "[ MEMORY USAGE ]"
free -h

echo
echo "[ DOCKER DAEMON STATUS ]"

if systemctl is-active --quiet docker; then
    echo "Docker daemon: ACTIVE"
else
    echo "Docker daemon: INACTIVE or UNAVAILABLE"
fi

echo
echo "========================================"
echo "       END OF SYSTEM REPORT"
echo "========================================"

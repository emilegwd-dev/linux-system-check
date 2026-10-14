#!/usr/bin/env bash
if [[ $# -gt 1 ]]; then
    echo "Usage: bash system_check.sh [disk_usage]"
    exit 2
fi

if [[ -n "${1:-}" ]]; then
    if ! [[ "$1" =~ ^[0-9]+$ ]] || (( 10#$1 > 100 )); then
        echo "Error: disk usage must be a number between 0 and 100"
        exit 2
    fi
    usage=$((10#$1))
else
    usage=$(df -P / | awk 'NR==2 {gsub("%", "", $5); print $5}')
fi

echo "=== Linux System Check==="
echo "Date: $(date)"
echo "Hostname: $(hostname)"
echo ""
echo "=== Disk Usage==="
df -h /

echo ""
echo "=== Memory ==="
free -h

echo ""
echo "=== Disk alert ==="

if [ "$usage" -ge 80 ]; then
	echo "Warning: disk usage is at least 80%"
	exit 1
else
	echo "OK: disk usage is below 80%"
	exit 0
fi

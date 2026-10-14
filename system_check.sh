#!/usr/bin/env bash
if [[ -n "${1:-}" ]]; then
    usage="$1"
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

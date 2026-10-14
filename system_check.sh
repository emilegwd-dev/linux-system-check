#!/user/bin/env bash

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

usage=$(df -P / | awk 'NR==2 {gsub("%", "", $5); print $5}')

if [ "$usage" -ge 80 ]; then
	echo "Warning: disk usage is at least 80%"
else
	echo "OK: disk usage is below 80%"
fi

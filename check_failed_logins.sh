#!/bin/bash

# Scans auth.log for failed SSH login attempts and flags IPs over a threshold

LOGFILE="/var/log/auth.log"
THRESHOLD=2

echo "=== Failed Login Report: $(date) ==="

sudo grep "Failed password" "$LOGFILE" | \
  grep -oP '(?<=from )\d+\.\d+\.\d+\.\d+' | \
  sort | uniq -c | sort -rn | \
  while read count ip; do
    if [ "$count" -ge "$THRESHOLD" ]; then
      echo "[ALERT] $ip had $count failed login attempts"
    else
      echo "[info]  $ip had $count failed login attempt"
    fi
  done

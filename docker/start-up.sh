#!/bin/bash

# Grab custom interval from env variable
CRON_RULE=${INTERVAL_CRON:-"* * * * *"}

# Remove old cronjobs and add new one
crontab -r
echo "$CRON_RULE cd /root/.urlwatch/config && /opt/bitnami/python/bin/urlwatch --urls urls.yaml --config urlwatch.yaml --hooks hooks.py --cache cache.db > /proc/1/fd/1 2>/proc/1/fd/2" | crontab -

# Run cron
cron -f
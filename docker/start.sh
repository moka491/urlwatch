#!/bin/bash

# Grab custom interval from env variable or use default (every minute)
CRON_RULE=${INTERVAL_CRON:-"* * * * *"}

# Remove old cronjobs and add new one
crontab -r 2&>1 /dev/null
echo "$CRON_RULE cd /root/.urlwatch && /opt/bitnami/python/bin/urlwatch --urls config/urls.yaml --config config/urlwatch.yaml --hooks config/hooks.py --cache cache.db > /proc/1/fd/1 2>/proc/1/fd/2" | crontab -

# Run cron
cron -f
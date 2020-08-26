#!/bin/bash

# Grab custom interval from env variable or use default (every minute)
CRON_RULE=${CHECK_INTERVAL:-"* * * * *"}

# Remove old cronjobs
echo "Cleaning up old cronjobs"
crontab -r 2&>1 /dev/null

# And add new one with the correct interval
echo "Adding new urlwatch cronjob: $CRON_RULE"
echo "$CRON_RULE cd /root/.urlwatch && /opt/bitnami/python/bin/urlwatch > /proc/1/fd/1 2>/proc/1/fd/2" | crontab -

# Run cron
cron -f
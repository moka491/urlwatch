FROM bitnami/python:3.8-prod

ARG INTERVAL_CRON="* * * * *"

# Install cron
RUN apt-get update && apt-get -y install cron wdiff

# Install python dependencies
RUN python3 -m pip install --no-cache-dir pyyaml minidb requests keyring appdirs lxml cssselect beautifulsoup4 jsbeautifier cssbeautifier aioxmpp

# Setup project and install
WORKDIR /opt/urlwatch

COPY lib ./lib
COPY share ./share
COPY setup.py .
COPY setup.cfg .

RUN python setup.py install

VOLUME /root/.urlwatch
WORKDIR /root/.urlwatch

# Add crontab to container
RUN echo "${INTERVAL_CRON} cd /root/.urlwatch && /opt/bitnami/python/bin/urlwatch --urls urls.yaml --config urlwatch.yaml --hooks hooks.py --cache cache.db > /proc/1/fd/1 2>/proc/1/fd/2" | crontab -

# Run cronjob
CMD ["cron", "-f"]

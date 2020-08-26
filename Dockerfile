FROM bitnami/python:3.8-prod

# Install cron
RUN apt-get update && apt-get -y install cron wdiff

# Install python dependencies
RUN python3 -m pip install --no-cache-dir pyyaml minidb requests keyring keyrings.cryptfile appdirs lxml cssselect beautifulsoup4 jsbeautifier cssbeautifier aioxmpp

# Setup project and install
WORKDIR /opt/urlwatch

COPY lib ./lib
COPY share ./share
COPY setup.py .
COPY setup.cfg .

RUN python setup.py install

# Add startup script
COPY docker/start.sh /start.sh
RUN chmod 755 /start.sh

VOLUME /root/.urlwatch/config
WORKDIR /root/.urlwatch

# Run cronjob
CMD ["/bin/sh", "-c", "/start.sh"]

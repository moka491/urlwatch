## Setup with docker

### Requirements

1. A working docker installation + docker-compose

### Setup

1. First of all, we need to prepare the configuration files.
   There are example files inside `./config` that we rename to `urls.yaml` and `urlwatch.yaml` respectively.
   You can add your urls, which urlwatch should check, to the former one later on, for testing it already comes with an example website.

2. Then run `docker-compose up -d` in the main folder. This will build and run the image in the background.

3. To test the correct behavior now, you can run `docker logs -f urlwatch` and wait until urlwatch is run the first time (depending on your configuration, <1-2 minutes).

### Configuration

You can change the provided config files as you normally would with urlwatch (check the [documentation](https://urlwatch.readthedocs.io/en/latest/)).  
In the case of docker, changes will be picked up the next time it is executed by the container.

For docker specifically, you can adjust the interval in which urlwatch is executed.
For that, create an `.env` file in the main directory and add the following content.
This specifies that the cronjob should run every 2 minutes. The syntax follows regular cron rules (check https://crontab.guru):

```
CHECK_INTERVAL=*/2 * * * *
```

After adjusting it, simply restart the the container using `docker-compose stop && docker-compose start`

### Email configuration

Configuring your email account mostly follows the urlwatch documentation,
so you could simply jump into the container (using `docker exec -it urlwatch bash`) and follow the steps listed there.

However, to make it easier, you can also follow the steps from the host.
After adding the required configuration to the config file, execute the following:

1. Run `docker exec -it urlwatch urlwatch --smtp-login`  
   and enter your smtp server password and provide another password for the keyring.

2. Run `docker exec -it urlwatch urlwatch --test-reporter email`  
   and enter your keyring password to test it. If your configuration is correct, you should have received a test email now.

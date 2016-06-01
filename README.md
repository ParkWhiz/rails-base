# rails-base
Base Docker build configuration for a rails web application

## Monitoring apps

Apps derived from this base container can optionally be monitored using 
[the God framework](http://godrb.com/). God is configured to:

1. Ensure that the app's main process (e.g. Passenger) remains running at
   all times and restart it if it quits.
2. Assess the app's health based on a health check, and restart the app if the
   health check fails.
3. Send a notification (currently on Slack) if the app is restarted.

To disable God, simply define a `CMD` directive in the derived container's
Dockerfile.

If a `CMD` directive is not defined in the derived container, then God will
be launched to monitor the app. See the "Environmental Variables" section below
to see which environmental variables that the God configuration expects to
be defined.

### Environmental Variables

The user will probably want to define `PARKWHIZ_APP_NAME`, 
`PARKWHIZ_RUN_COMMAND`, `PARKWHIZ_RUN_DIR`, `HEALTHCHECK_HOST`,
`HEALTHCHECK_PORT`, `HEALTHCHECK_PATH`, and `HEALTHCHECK_SLACK_URL`. The rest
are available for tuning.

| Variable                              | Default         | Description                                                                                                                     |
|---------------------------------------|-----------------|---------------------------------------------------------------------------------------------------------------------------------|
| `PARKWHIZ_APP_NAME`                   | unspecified     | The name of the app (as reported by notifications) E.g. "pw_admin"                                                              |
| `PARKWHIZ_RUN_COMMAND`                | passenger start | The shell command used to start the app                                                                                         |
| `PARKWHIZ_RUN_DIR`                    | /app            | The working directory in which `PARKWHIZ_RUN_COMMAND` should be run                                                             |
| `HEALTHCHECK_HOST`                    | localhost       | Host that replies to health check                                                                                               |
| `HEALTHCHECK_PORT`                    | 3000            | Port that responds to health check                                                                                              |
| `HEALTHCHECK_PATH`                    | /               | URL for health check (i.e. "/healthz")                                                                                          |
| `HEALTHCHECK_TIMEOUT`                 | 60              | Number of seconds to wait for response before health check is considered a failure                                              |
| `HEALTHCHECK_INTERVAL`                | 60              | Number of seconds between health checks                                                                                         |
| `HEALTHCHECK_TIMES_IN`                | 3               | In order to trigger a restart, `HEALTHCHECK_TIMES_IN` checks of `HEALTHCHECK_TIMES_OF` health checks must fail                  |
| `HEALTHCHECK_TIMES_OF`                | 3               | In order to trigger a restart, `HEALTHCHECK_TIMES_IN` checks of `HEALTHCHECK_TIMES_OF` health checks must fail                  |
| `HEALTHCHECK_START_GRACE`             | 60              | Number of seconds to wait after starting the app before monitoring begins                                                       |
| `HEALTHCHECK_FLAP_MAX_RESTART_TIMES`  | 5               | Number of restarts before monitoring stops temporarily                                                                          |
| `HEALTHCHECK_FLAP_MAX_RESTART_WITHIN` | 1800            | Number of seconds within which restarts need to happen before monitoring stops temporarily                                      |
| `HEALTHCHECK_FLAP_RETRY_IN`           | 1800            | Number of seconds before monitoring resumes                                                                                     |
| `HEALTHCHECK_FLAP_RETRY_TIMES`        | 5               | Number of cycles of stopping and resuming monitoring tolerated before monitoring is stopped permanently                         |
| `HEALTHCHECK_FLAP_RETRY_WITHIN`       | 18000           | Length of time within which cycles of stopping and resuming monitoring must take place before monitoring is stopped permanently |
| `HEALTHCHECK_SLACK_URL`               |                 | Slack webhook URL for integrations                                                                                              |
| `HEALTHCHECK_SLACK_CHANNEL`           | #dev            | Slack channel for notification, prefixed with "#"                                                                               |

### Behavior

God will start the app by running `PARKWHIZ_RUN_COMMAND` inside the working
directory `PARKWHIZ_RUN_DIR`. It will wait `HEALTHCHECK_START_GRACE` seconds
and then begin monitoring the app.

While monitoring, every `HEALTHCHECK_INTERVAL` seconds, God will send a GET
request to `http://$HEALTHCHECK_HOST:$HEALTHCHECK_PORT$HEALTHCHECK_PATH`. If
the server replies with a `2XX` status within `HEALTHCHECK_TIMEOUT` seconds,
the health check is a success. Otherwise, the health check is a failure. If
`HEALTHCHECK_TIMES_IN` health checks fail within an interval of
`HEALTHCHECK_TIMES_OF` health checks, then the app will be restarted and a
notification will be sent to the Slack webhook specified by
`HEALTHCHECK_SLACK_URL`. 

If the app restarts `HEALTHCHECK_FLAP_MAX_RESTART_TIMES` times within
`HEALTHCHECK_FLAP_MAX_RESTART_WITHIN` seconds, then God temporarily stops monitoring the
app for `HEALTHCHECK_FLAP_RETRY_IN` seconds. If God temporarily stops monitoring
`HEALTHCHECK_FLAP_RETRY_TIMES` within `HEALTHCHECK_FLAP_RETRY_WITHIN` seconds,
then God stops monitoring the app permanently.

### Manually Unmonitoring

If you need to disable monitoring (e.g. when performing maintainance that
will cause the healtcheck to fail), God monitoring can be stopped by running:

```
docker exec -it MY_CONTAINER_NAME bash -c 'god unmonitor run_server'
```

To resume monitoring, run

```
docker exec -it MY_CONTAINER_NAME bash -c 'god monitor run_server'
```

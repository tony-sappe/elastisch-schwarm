# elastisch-schwarm

> Rapid creation of an Elastic cluster


Quickly spin up a Docker cluster of Elastic products for testing

## Quickstart


Default configuration will create a three node Elasticsearch cluster with a three node Logstash cluster and an additional Kibana node. _(Comment-out or delete entire service blocks in `docker-compose.yaml` to reduce the number of nodes in these clusters.)_

The nodes will use the latest stable version 6.5.4 at the time of writing.
Some configs are stored in .env

1. (Assuming you already have docker installed and running, with enough [memory](#containers-die-randomly-without-clear-errors) allocated)
```$ docker-compose up```
2. Click [http://localhost:5656](http://localhost:5656)
3. ....
4. Profit

## Loading test data

### 150K Employees
1. ```cd datasets/150k_employees/```
2. ``` ./index_creates.sh```
3. New index created: `companydatabase`

### Official elastic.co tutorial data
1. ```cd datasets/elastic.co/```
2. ``` ./index_creates.sh```
3. New indexes created:
    - `banks`
    - `shakespeare`
    - `logstash-2015.05.18`
    - `logstash-2015.05.19`
    - `logstash-2015.05.20`

## Trying Out Security and other X-Pack Features
Changing the following `.env` config values, and cleanly refreshing your cluster (see below), will enable the trial version of the (platinum) X-Pack features, including security.

```bash
XPACK_SECURITY_ENABLED=true
XPACK_MANAGEMENT_ENABLED=true
XPACK_LICENSE_SELF_GENERATED_TYPE=trial
```

Once up and running, use the `ELASTIC_USERNAME` and `ELASTIC_PASSWORD` env variable values to login.

## Cleanup or Fresh Restart
When you stop the containers with CTRL-C, they still exist in a stopped state as well as their volumes. Doing `docker-compose up` again, will just restart those containers, and reuse the data in those volumes.

That may be what you want. However, if you want to start fresh, with know persisted data, state, or configuration, remove the stopped containers and volumes using the below command

:warning: This will remove _any_ container you have from org `docker.elastic.co`. Adjust the `grep` pattern as needed.

```docker ps -a | grep "docker.elastic.co" | awk '{print $1}' | xargs docker rm```

To remove the volumes, run

```docker volume ls | grep "esdata" | awk '{print $2}' | xargs docker volume rm```

## Kibana Monitoring and X-Pack Trial

Commands for both are store in `curl_cmds.sh`. Running the script will activate the 30-day X-Pack trial.


## Custom Parameters
See `.env` for some configuration settings. Edits will be applied when restarting using `docker-compose`


## Troubleshooting

### Containers Die Randomly without Clear Errors
Docker is known to just kill containers ungracefully if it does not have enough memory. With many containers running as part of these clusters the default configuration is known to work with Docker Desktop (on Mac: Docker > Preferences > Advanced) at **6 CPUs** and **12 GiB** of memory.

### Not able to switch between basic and trial (platinum) licenses
_If you reconfigure the license configuration in `docker-compose.yaml`, and restart the containers, it is not always picked up. This information appears to be persisted in the volumes. So you need to remove the volumes as shown below or above.

:warning: this will also remove your indexed data.

If you want to keep your indexes but change your license, do it through the Kibana UI: _Management > Elasticsearch > License Management_

### Docker volume trouble
1. List volumes: ```docker volume ls```
2. Delete the `*esdata*` volumes: ```docker volume ls | grep "esdata" | awk '{print $2}' | xargs docker volume rm```
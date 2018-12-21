# elastisch-schwarm

> Rapid creation of an Elastic cluster


Quickly spin up a Docker cluster of Elastic products for testing

## Quickstart

Default configuration will create a three node cluster with an additional kibana node.
The nodes will use ver. 6.5.3, the latest stable version at the time of writing.

1. (Assuming you already have docker installed and running)
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


## Kibana Monitoring and X-Pack Trial

Commands for both are store in `curl_cmds.sh`. Running the script will activate the 30-day X-Pack trial.


## Custom Parameters
See `.env` for some configuration settings. Edits will be applied when restarting using `docker-compose`


## Troubleshooting
### Docker volume trouble
1. List volumes: ```docker volume ls```
2. Delete the esdata* volumes: ```docker volume rm elastisch-schwarm_esdata0 ``` etc.
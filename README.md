# elastisch-schwarm

> Rapid creation of an Elastic cluster


Quickly spin up a Docker cluster of Elastic products for testing

## Quickstart

Default configuration will create a three node cluster with an additional kibana node.
The nodes will use the latest stable version 6.5.3 at the time of writing.
Some configs are stored in .env

1. (Assuming you already have docker installed and running)
```$ docker-compose up```
2. Click [http://localhost:5601](http://localhost:5601)
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


## Troubleshooting
### Docker volume trouble
1. List volumes: ```docker volume ls```
2. Delete the esdata* volumes: ```docker volume rm elastisch-schwarm_esdata0 ``` etc.
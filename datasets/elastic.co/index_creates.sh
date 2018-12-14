#!/bin/bash

# -------------------------------------------------------------------------
# https://www.elastic.co/guide/en/kibana/current/tutorial-load-dataset.html
# -------------------------------------------------------------------------


# If ES_CLUSTER is not defined, set it
if [ -z ${ES_CLUSTER+x} ]; then
  ES_CLUSTER="localhost:9200"
fi

# Unzip data files
unzip -o -q accounts.zip
gunzip -f -k -q logs.jsonl.gz

# DELETE the indexes in case they already exist. Ignore errors if they don't exist
curl -X DELETE "${ES_CLUSTER}/bank"
curl -X DELETE "${ES_CLUSTER}/shakespeare"
curl -X DELETE "${ES_CLUSTER}/logstash-2015.05.18"
curl -X DELETE "${ES_CLUSTER}/logstash-2015.05.19"
curl -X DELETE "${ES_CLUSTER}/logstash-2015.05.20"

# Define the indexes w/ mappings
curl -X PUT "${ES_CLUSTER}/bank" -H 'Content-Type: application/json' -d'
{
 "settings": {
  "number_of_shards": 1,
  "number_of_replicas": 1
 }
}
'

curl -X PUT "${ES_CLUSTER}/shakespeare" -H 'Content-Type: application/json' -d'
{
 "settings": {
  "number_of_shards": 2,
  "number_of_replicas": 1
 },
 "mappings": {
  "doc": {
   "properties": {
    "speaker": {"type": "keyword"},
    "play_name": {"type": "keyword"},
    "line_id": {"type": "integer"},
    "speech_number": {"type": "integer"}
   }
  }
 }
}
'

curl -X PUT "${ES_CLUSTER}/logstash-2015.05.18" -H 'Content-Type: application/json' -d'
{
 "settings": {
  "number_of_shards": 1,
  "number_of_replicas": 1
 },
  "mappings": {
    "log": {
      "properties": {
        "geo": {
          "properties": {
            "coordinates": {
              "type": "geo_point"
            }
          }
        }
      }
    }
  }
}
'

curl -X PUT "${ES_CLUSTER}/logstash-2015.05.19" -H 'Content-Type: application/json' -d'
{
 "settings": {
  "number_of_shards": 1,
  "number_of_replicas": 1
 },
  "mappings": {
    "log": {
      "properties": {
        "geo": {
          "properties": {
            "coordinates": {
              "type": "geo_point"
            }
          }
        }
      }
    }
  }
}
'

curl -X PUT "${ES_CLUSTER}/logstash-2015.05.20" -H 'Content-Type: application/json' -d'
{
 "settings": {
  "number_of_shards": 1,
  "number_of_replicas": 1
 },
  "mappings": {
    "log": {
      "properties": {
        "geo": {
          "properties": {
            "coordinates": {
              "type": "geo_point"
            }
          }
        }
      }
    }
  }
}
'

# Index the data
curl -s -H 'Content-Type: application/x-ndjson' -XPOST "${ES_CLUSTER}/bank/account/_bulk?pretty" --data-binary @accounts.json > /dev/null
curl -s -H 'Content-Type: application/x-ndjson' -XPOST "${ES_CLUSTER}/shakespeare/doc/_bulk?pretty" --data-binary @shakespeare_6.0.json > /dev/null
curl -s -H 'Content-Type: application/x-ndjson' -XPOST "${ES_CLUSTER}/_bulk?pretty" --data-binary @logs.jsonl > /dev/null

# remove temporary files
rm accounts.json
rm logs.jsonl
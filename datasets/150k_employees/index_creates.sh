#!/bin/bash

# --------------------------------------------------
# http://ikeptwalking.com/elasticsearch-sample-data/
# --------------------------------------------------


# If ES_CLUSTER is not defined, set it
if [ -z ${ES_CLUSTER+x} ]; then
  ES_CLUSTER="localhost:9200"
fi

# Unzip data files
unzip -o -q Employees50K.zip
unzip -o -q Employees100K.zip

# DELETE the index in case it already exists. Ignore errors if it doesn't exist
curl -X DELETE "${ES_CLUSTER}/companydatabase"

# Define the index
curl -XPUT "${ES_CLUSTER}/companydatabase?pretty" -H 'Content-Type: application/json' -d'
{
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas": 1
  },
  "mappings": {
    "employees": {
      "properties": {
        "Address": {
          "type": "text"
        },
        "Age": {
          "type": "integer"
        },
        "DateOfJoining": {
          "format": "yyyy-MM-dd",
          "type": "date"
        },
        "Designation": {
          "type": "text"
        },
        "FirstName": {
          "type": "text"
        },
        "Gender": {
          "type": "text"
        },
        "Interests": {
          "type": "text"
        },
        "LastName": {
          "type": "text"
        },
        "MaritalStatus": {
          "type": "text"
        },
        "Salary": {
          "type": "integer"
        }
      }
    }
  }
}
'

# Index the data
curl -s -H 'Content-Type: application/x-ndjson' -XPOST "${ES_CLUSTER}/companydatabase/_bulk" --data-binary @Employees50K.json > /dev/null
curl -s -H 'Content-Type: application/x-ndjson' -XPOST "${ES_CLUSTER}/companydatabase/_bulk" --data-binary @Employees100K.json > /dev/null

# remove temporary files
rm Employees50K.json
rm Employees100K.json
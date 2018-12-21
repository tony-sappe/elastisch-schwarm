curl -XPOST "http://localhost:9200/_xpack/license/start_trial?acknowledge=true"

curl -XPUT "http://localhost:9200/_cluster/settings" -H 'Content-Type: application/json' -d'
{
    "persistent" : {
        "xpack.monitoring.collection.enabled" : true
    }
}'

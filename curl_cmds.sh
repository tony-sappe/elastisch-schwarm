# Start the X-Pack trial
curl -XPOST "http://localhost:9200/_xpack/license/start_trial?acknowledge=true"

# Start X-Pack monitoring
curl -XPUT "http://localhost:9200/_cluster/settings" -H 'Content-Type: application/json' -d'
{
    "persistent" : {
        "xpack.monitoring.collection.enabled" : true
    }
}'

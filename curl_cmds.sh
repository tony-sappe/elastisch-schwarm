curl -XPUT /_cluster/settings
{
    "persistent" : {
        "xpack.monitoring.collection.enabled" : true
    }
}

curl -XPOST "http://localhost:9200/_xpack/license/start_trial?acknowledge=true"
#!/bin/bash
set -e

# Ждем запуска Elasticsearch
until curl -s localhost:9200/_cluster/health > /dev/null; do
  echo "Waiting for Elasticsearch to start..."
  sleep 5
done

# Ждем зеленого статуса кластера
echo "Waiting for cluster to be ready..."
until curl -s localhost:9200/_cluster/health | grep -q '"status":"green"'; do
  echo "Waiting for cluster to be ready.."
  sleep 2
done

# Создаем индекс с маппингом
if ! curl -s -XGET localhost:9200/logs | grep -q '"status":404'; then
  echo "Index already exists, skipping creation"
else
  echo "Creating mapping..."
  curl -X PUT -H "Content-Type: application/json" -d '
  {
    "settings":   {"number_of_shards":1,"number_of_replicas":0},
    "mappings": {
      "properties": {
          "@timestamp":    { "type": "date_nanos" },
          "level":  { "type": "keyword"  },
          "userId":   { "type": "keyword"  },
          "traceId":   { "type": "text"  },
          "host":   { "type": "text"  },
          "requestMethod":   { "type": "keyword"  },
          "requestStatusCode":   { "type": "keyword"  },
          "controller":   { "type": "keyword"  },
          "function":   { "type": "keyword"  },
          "requestUrl":   { "type": "text"  },
          "requestBody":   { "type": "text"  },
          "threadId":   { "type": "keyword"  },
          "logger":   { "type": "keyword"  },
          "message":   { "type": "text"  },
          "exception":   { "type": "text"  },
          "srcIp0v4":   { "type": "short"  },
          "srcIp1v4":   { "type": "short"  },
          "srcIp2v4":   { "type": "short"  },
          "srcIp3v4":   { "type": "short"  },
          "dstHost":   { "type": "text"  },
          "userExtId":   { "type": "text"  }
        }
    }
  }' "localhost:9200/logs"
  
  echo ""
  
  echo "Index created successfully"
fi

echo "Initialization completed"
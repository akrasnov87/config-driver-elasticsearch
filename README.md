## Описание

Пример взаимодействия elasticsearch и fluent-bit

<pre>
docker compose up
</pre>

## Пример

Создание [индекса](https://www.elastic.co/docs/api/doc/elasticsearch/operation/operation-indices-create):

<pre>
curl -X PUT -H "Content-Type: application/json" -d '{"settings":   {"number_of_shards":1,"number_of_replicas":1}}' "localhost:9200/logs"
</pre>

Создание [mapping](https://www.elastic.co/docs/manage-data/data-store/mapping/explicit-mapping):

<pre>
curl -X PUT -H "Content-Type: application/json" -d '
{
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
</pre>

Создание [записи](https://www.elastic.co/docs/api/doc/elasticsearch/operation/operation-create):

<pre>
curl -X POST -H "Content-Type: application/json" -d '
{
	"@timestamp":"2099-11-15T13:12:00",
	"message":"Hello World"
}' "localhost:9200/logs/_create/1"
</pre>
## Описание

Пример взаимодействия `elasticsearch` и `fluent-bit`.

### run

<pre>
docker compose up
</pre>

или

<pre>
docker compose -f docker-compose.dev.yml up
</pre>

### Переменные

* `ES_INIT_LOGS` - признак создания таблицы логов (индекса `logs`) по умолчанию при разворачивании решения.

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

## Возможые ошибки

При подключении `volume` к `elasticsearch` требуется изменить права для папки `esdata`

`chmod -R 777 esdata`
# build

docker build -t akrasnov87/elasticsearch:8.19.3 .

# run

<pre>
docker run -d \
  --name elasticsearch-custom \
  -p 9200:9200 \
  -p 9300:9300 \
  -e "ES_JAVA_OPTS=-Xms1g -Xmx1g" \
  -e "ES_INIT_LOGS=on" \
  akrasnov87/elasticsearch:8.19.3
</pre>

* `ES_INIT_LOGS` - автоматическая инициализация индекса для хранения логов;
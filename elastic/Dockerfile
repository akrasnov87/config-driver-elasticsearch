FROM elasticsearch:8.19.3

USER root

# Устанавливаем curl
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Копируем скрипт инициализации
COPY init-index.sh /usr/share/elasticsearch/init-index.sh
RUN chmod +x /usr/share/elasticsearch/init-index.sh && \
    chown elasticsearch:elasticsearch /usr/share/elasticsearch/init-index.sh

USER elasticsearch

# Копируем конфигурацию маппинга
#COPY mappings/ /usr/share/elasticsearch/mappings/

# Запускаем скрипт при старте
CMD ["sh", "-c", "/usr/share/elasticsearch/init-index.sh & /usr/local/bin/docker-entrypoint.sh eswrapper"]
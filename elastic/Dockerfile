FROM elasticsearch:8.19.3

# Переключаемся на root для установки пакетов
USER root

# Устанавливаем curl
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl nano wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Копируем кастомные конфиги
COPY elasticsearch.yml /usr/share/elasticsearch/config/
COPY config/jvm.options.d/custom-jvm.options /usr/share/elasticsearch/config/jvm.options.d/

# Копируем SSL сертификаты (если нужны)
COPY certs/ /usr/share/elasticsearch/config/certs/

# Копируем плагины (если есть)
COPY plugins/ /tmp/plugins/

COPY idx/ /tmp/idx/

# Установка плагинов
RUN if [ -d /tmp/plugins ] && [ "$(ls -A /tmp/plugins)" ]; then \
    for plugin in /tmp/plugins/*.zip; do \
      /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch file://$plugin; \
    done; \
    fi \
    && rm -rf /tmp/plugins

# Копируем entrypoint скрипт
COPY entrypoint.sh /usr/local/bin/
RUN chmod 777 /usr/local/bin/entrypoint.sh

# Копируем скрипт инициализации
COPY init-index.sh /usr/share/elasticsearch/init-index.sh
RUN chmod +x /usr/share/elasticsearch/init-index.sh && \
    chown elasticsearch:elasticsearch /usr/share/elasticsearch/init-index.sh

# Возвращаемся к пользователю elasticsearch
USER elasticsearch

# Экспоз порты
EXPOSE 9200 9300

VOLUME ["/tmp/idx"]

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["eswrapper"]
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

# Все файлы в массив
files=$(find /tmp/idx/ -type f -name "*.json")
echo "Количество файлов: ${#files[@]}"

# Вывод всех файлов
for file in "${files[@]}"; do
  filename="${file##*/}"      # Убираем путь
  name="${filename%.*}"       # Убираем расширение

  content=$(cat $file)

  echo "$content"

  # Создаем индекс с маппингом
  if ! curl -s -XGET localhost:9200/$name | grep -q '"status":404'; then
    echo "Index $name already exists, skipping creation"
  else
    echo "Creating mapping..."
    curl -X PUT -H "Content-Type: application/json" -d "$content" "localhost:9200/$name"
    
    echo ""
    
    echo "Index $name created successfully"
  fi
done


echo "Initialization completed"
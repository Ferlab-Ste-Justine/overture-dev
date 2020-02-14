elasticdump \
  --input=http://localhost:9200/patient \
  --output=/opt/data/mapping.json \
  --type=mapping;
elasticdump \
  --input=http://localhost:9200/patient \
  --output=/opt/data/data.json \
  --type=data;
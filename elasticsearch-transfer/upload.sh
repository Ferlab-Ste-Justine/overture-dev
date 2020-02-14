elasticdump \
  --output=http://localhost:9200/patient \
  --input=/opt/data/mapping.json \
  --type=mapping;
elasticdump \
  --output=http://localhost:9200/patient \
  --input=/opt/data/data.json \
  --type=data;
docker build -t elasticdump:latest .;
docker run -it --rm -v $(pwd):/opt/data --network host elasticdump:latest bash;
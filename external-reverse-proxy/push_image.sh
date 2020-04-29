export VERSION=0.1.0
export IMAGE=chusj/overture-external-reverse-proxy:$VERSION
docker build -t $IMAGE -f .;
docker push $IMAGE;
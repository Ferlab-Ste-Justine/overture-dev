export VERSION=0.3.0
export IMAGE=chusj/overture-external-reverse-proxy:$VERSION
docker build -t $IMAGE .;
docker push $IMAGE;

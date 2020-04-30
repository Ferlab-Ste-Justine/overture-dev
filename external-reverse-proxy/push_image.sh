export VERSION=0.2.0
export IMAGE=chusj/overture-external-reverse-proxy:$VERSION
docker build -t $IMAGE -f .;
docker push $IMAGE;
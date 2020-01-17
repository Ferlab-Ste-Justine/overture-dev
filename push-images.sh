export VERSION=0.1

docker-compose build --no-cache;

docker tag overture-dev_storage-server:latest chusj/overture-score:$VERSION;
docker push chusj/overture-score:$VERSION;

docker tag overture-dev_song:latest chusj/overture-song:$VERSION;
docker push chusj/overture-song:$VERSION;

docker tag overture-dev_id:latest chusj/overture-id:$VERSION;
docker push chusj/overture-id:$VERSION;

docker tag overture-dev_id-db:latest chusj/overture-id-db:$VERSION;
docker push chusj/overture-id-db:$VERSION;

docker tag overture-dev_auth:latest chusj/overture-ego:$VERSION;
docker push chusj/overture-ego:$VERSION;
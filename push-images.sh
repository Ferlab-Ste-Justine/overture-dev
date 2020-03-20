export VERSION=0.3

docker-compose build --no-cache;

docker tag overture-dev_storage-server:latest chusj/overture-score:$VERSION;
docker push chusj/overture-score:$VERSION;

docker tag overture-dev_song:latest chusj/overture-song:$VERSION;
docker push chusj/overture-song:$VERSION;

docker tag overture-dev_storage-client:latest chujs/score-client:$VERSION;
docker push chujs/score-client:$VERSION;
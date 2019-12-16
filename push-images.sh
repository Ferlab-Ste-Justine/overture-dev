docker-compose build --no-cache;
docker-compose -f docker-compose-auth.yml build --no-cache;

docker tag overture-dev_reverse-proxy:latest chusj/overture-auth-reverse-proxy:latest;
docker push chusj/overture-auth-reverse-proxy:latest;

docker tag overture-dev_storage-server:latest chusj/overture-score:latest;
docker push chusj/overture-score:latest;

docker tag overture-dev_song:latest chusj/overture-song:latest;
docker push chusj/overture-song:latest;

docker tag overture-dev_id:latest chusj/overture-id:latest;
docker push chusj/overture-id:latest;

docker tag overture-dev_id-db:latest chusj/overture-id-db:latest;
docker push chusj/overture-id-db:latest;

docker tag overture-dev_auth:latest chusj/overture-ego:latest;
docker push chusj/overture-ego:latest;
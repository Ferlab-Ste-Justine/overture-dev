export VERSION=0.3

docker build --no-cache -t chusj/overture-song:$VERSION --target server SONG;
docker build --no-cache -t chusj/overture-score:$VERSION --target server score;
docker build --no-cache -t chusj/score-client:$VERSION --target client score;
docker build --no-cache -t chusj/redundant-song-auth-dependency:$VERSION auth-throwaway-dependency;

docker tag overture-dev_storage-server:latest chusj/overture-score:$VERSION;
docker push chusj/overture-score:$VERSION;

docker tag overture-dev_song:latest chusj/overture-song:$VERSION;
docker push chusj/overture-song:$VERSION;

docker build --no-cache -t chusj/score-client:$VERSION --target client ./score;
docker push chusj/score-client:$VERSION;

docker tag overture-dev_auth:latest chusj/redundant-song-auth-dependency:$VERSION;
docker push chusj/redundant-song-auth-dependency:$VERSION;

(cd song-auth; ./push_image.sh);
(cd score-auth; ./push_image.sh);
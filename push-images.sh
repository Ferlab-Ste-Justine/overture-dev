export VERSION=0.4

docker build --no-cache -t chusj/overture-song:$VERSION --target server SONG;
docker push chusj/overture-song:$VERSION;

docker build --no-cache -t chusj/overture-score:$VERSION --target server score;
docker push chusj/overture-score:$VERSION;

docker build --no-cache -t chusj/score-client:$VERSION --target client score;
docker push chusj/score-client:$VERSION;

docker build --no-cache -t chusj/redundant-song-auth-dependency:$VERSION auth-throwaway-dependency;
docker push chusj/redundant-song-auth-dependency:$VERSION;

(cd song-auth; ./push_image.sh);
(cd score-auth; ./push_image.sh);
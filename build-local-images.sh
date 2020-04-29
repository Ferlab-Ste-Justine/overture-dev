docker build -t chusj/overture-song:dev --target server SONG;
docker build -t chusj/overture-score:dev --target server score;
docker build -t chusj/score-client:dev --target client score;
docker build -t chusj/redundant-song-auth-dependency:dev auth-throwaway-dependency;
(cd external-reverse-proxy; ./build-local-image.sh)
(cd score-auth; ./build-local-image.sh)
(cd song-auth; ./build-local-image.sh)
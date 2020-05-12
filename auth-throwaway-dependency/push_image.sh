export VERSION=0.4

docker build --no-cache -t chusj/redundant-song-auth-dependency:$VERSION auth-throwaway-dependency;
docker push chusj/redundant-song-auth-dependency:$VERSION;
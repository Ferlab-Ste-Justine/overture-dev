export VERSION=0.5

docker build --no-cache -t chusj/redundant-song-auth-dependency:$VERSION .;
docker push chusj/redundant-song-auth-dependency:$VERSION;
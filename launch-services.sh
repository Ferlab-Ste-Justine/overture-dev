OVERTURE_MANIFEST=$(docker volume ls | grep overture_manifests)
if [ -z "$OVERTURE_MANIFEST" ]; then
    docker volume create overture_manifests;
fi

docker-compose up -d
docker-compose -f docker-compose-auth.yml up -d
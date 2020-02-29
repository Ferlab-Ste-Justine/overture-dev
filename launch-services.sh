#Setup shared manifest volume to sync shared files between the SONG and Score clients
OVERTURE_MANIFEST=$(docker volume ls | grep overture_manifests)
if [ -z "$OVERTURE_MANIFEST" ]; then
    docker volume create overture_manifests;
fi

docker-compose up -d
docker-compose -f docker-compose-auth.yml up -d

#Setup the Minio bucket that Score depends on
export OBJECT_STORAGE_ACCESS_KEY=$(cat .env | grep OBJECT_STORAGE_ACCESS_KEY | cut -d '=' -f 2)
export OBJECT_STORAGE_SECRET_KEY=$(cat .env | grep OBJECT_STORAGE_SECRET_KEY | cut -d '=' -f 2)
BUCKET=$(docker run --network overture -e "AWS_ACCESS_KEY_ID=$OBJECT_STORAGE_ACCESS_KEY" -e "AWS_SECRET_ACCESS_KEY=$OBJECT_STORAGE_SECRET_KEY" -e "AWS_DEFAULT_REGION=us-east-1" --rm mesosphere/aws-cli:latest --endpoint-url http://object-storage:8085 s3 ls s3://oicr.icgc.test)
if [ -z "$BUCKET" ]; then
    docker run --network overture -e "AWS_ACCESS_KEY_ID=$OBJECT_STORAGE_ACCESS_KEY" -e "AWS_SECRET_ACCESS_KEY=$OBJECT_STORAGE_SECRET_KEY" -e "AWS_DEFAULT_REGION=us-east-1" --rm mesosphere/aws-cli:latest --endpoint-url http://object-storage:8085 s3 mb s3://oicr.icgc.test;
    touch heliograph;
    docker run --network overture -e "AWS_ACCESS_KEY_ID=$OBJECT_STORAGE_ACCESS_KEY" -e "AWS_SECRET_ACCESS_KEY=$OBJECT_STORAGE_SECRET_KEY" -e "AWS_DEFAULT_REGION=us-east-1" --rm -v $(pwd)/heliograph:/score-data/heliograph mesosphere/aws-cli:latest --endpoint-url http://object-storage:8085 s3 cp /score-data/heliograph s3://oicr.icgc.test/data/heliograph;
else 
    echo "Bucket already exists";
fi
SWARM=$(docker node ls -q 2>&1 >/dev/null)
if [[ $SWARM = Error* ]]; then
    echo "Docker must be running in swarm mode to execute this script";
    exit 1;
fi

OVERTURE_NETWORK_EXISTS=$(docker network ls | grep overture)
if [ -z "$OVERTURE_NETWORK_EXISTS" ]; then
    docker network create -d overlay --attachable overture;
fi

export ENV=${ENV:-dev}

if [ "$ENV" = "dev" ]; then
    export DOCKER_COMPOSE_FILE="docker-compose.yml";
    export DOCKER_COMPOSE_AUTH_FILE="docker-compose-auth.yml";
else
    export DOCKER_COMPOSE_FILE="dc-prodlike.yml";
    export DOCKER_COMPOSE_AUTH_FILE="dc-auth-prodlike.yml";
fi

export $(cat .env | xargs)
if [ "$ENV" = "dev" ]; then
    ./build-local-images.sh;
    docker stack deploy --resolve-image never -c $DOCKER_COMPOSE_FILE -c $DOCKER_COMPOSE_AUTH_FILE overture-core
else
    docker stack deploy -c $DOCKER_COMPOSE_FILE -c $DOCKER_COMPOSE_AUTH_FILE overture-core
fi


#Setup the Minio bucket that Score depends on
export OBJECT_STORAGE_ACCESS_KEY=$(cat .env | grep OBJECT_STORAGE_ACCESS_KEY | cut -d '=' -f 2)
export OBJECT_STORAGE_SECRET_KEY=$(cat .env | grep OBJECT_STORAGE_SECRET_KEY | cut -d '=' -f 2)

#Wait until the object store is responsive
OBJECT_STORAGE_UNREACHABLE=$(docker run --network overture -e "AWS_ACCESS_KEY_ID=$OBJECT_STORAGE_ACCESS_KEY" -e "AWS_SECRET_ACCESS_KEY=$OBJECT_STORAGE_SECRET_KEY" -e "AWS_DEFAULT_REGION=us-east-1" --rm mesosphere/aws-cli:latest --endpoint-url http://object-storage:8085 s3 ls s3://oicr.icgc.test 2>&1 >/dev/null)
while [ ! -z "$OBJECT_STORAGE_UNREACHABLE" ]
do
    sleep 1;
    OBJECT_STORAGE_UNREACHABLE=$(docker run --network overture -e "AWS_ACCESS_KEY_ID=$OBJECT_STORAGE_ACCESS_KEY" -e "AWS_SECRET_ACCESS_KEY=$OBJECT_STORAGE_SECRET_KEY" -e "AWS_DEFAULT_REGION=us-east-1" --rm mesosphere/aws-cli:latest --endpoint-url http://object-storage:8085 s3 ls s3://oicr.icgc.test 2>&1 >/dev/null);
done

#Initialize the bucket if needed
BUCKET=$(docker run --network overture -e "AWS_ACCESS_KEY_ID=$OBJECT_STORAGE_ACCESS_KEY" -e "AWS_SECRET_ACCESS_KEY=$OBJECT_STORAGE_SECRET_KEY" -e "AWS_DEFAULT_REGION=us-east-1" --rm mesosphere/aws-cli:latest --endpoint-url http://object-storage:8085 s3 ls s3://oicr.icgc.test)
if [ -z "$BUCKET" ]; then
    docker run --network overture -e "AWS_ACCESS_KEY_ID=$OBJECT_STORAGE_ACCESS_KEY" -e "AWS_SECRET_ACCESS_KEY=$OBJECT_STORAGE_SECRET_KEY" -e "AWS_DEFAULT_REGION=us-east-1" --rm mesosphere/aws-cli:latest --endpoint-url http://object-storage:8085 s3 mb s3://oicr.icgc.test;
    touch heliograph;
    docker run --network overture -e "AWS_ACCESS_KEY_ID=$OBJECT_STORAGE_ACCESS_KEY" -e "AWS_SECRET_ACCESS_KEY=$OBJECT_STORAGE_SECRET_KEY" -e "AWS_DEFAULT_REGION=us-east-1" --rm -v $(pwd)/heliograph:/score-data/heliograph mesosphere/aws-cli:latest --endpoint-url http://object-storage:8085 s3 cp /score-data/heliograph s3://oicr.icgc.test/data/heliograph;
else 
    echo "Bucket already exists";
fi
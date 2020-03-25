if [ -z "$ENV" ]; then
    export ENV=dev;
fi

if [ "$ENV" = "dev" ]; then
    export DOCKER_COMPOSE_FILE="docker-compose.yml";
    export DOCKER_COMPOSE_AUTH_FILE="docker-compose-auth.yml";
else
    export DOCKER_COMPOSE_FILE="dc-prodlike.yml";
    export DOCKER_COMPOSE_AUTH_FILE="dc-auth-prodlike.yml";
fi

docker-compose -f $DOCKER_COMPOSE_FILE down -v
docker-compose -f $DOCKER_COMPOSE_AUTH_FILE down -v
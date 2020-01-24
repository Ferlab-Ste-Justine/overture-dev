SONG_SERVER_URL="http://localhost:8888"
SONG_STUDY_ID="ABC123"

KEYCLOAK_URL="https://localhost:8443"
KEYCLOAK_SECRET="d4372dd4-d8e0-4ca1-afb4-90fd6bd9eb6a"
KEYCLOAK_USERNAME="test"
KEYCLOAK_PASSWORD="testpassword99"

REVERSE_PROXY_ACCESS_TOKEN="TO DEFINE"

login:
	@curl -vvv -k \
	-X POST \
	--data "username=$(KEYCLOAK_USERNAME)" \
	--data "password=$(KEYCLOAK_PASSWORD)" \
	--data 'grant_type=password' \
	--data 'scope=profile' \
	--data 'client_id=clin-proxy-api' \
	--data "client_secret=$(KEYCLOAK_SECRET)" \
	"$(KEYCLOAK_URL)/auth/realms/clin/protocol/openid-connect/token"

default_study:
	@curl \
	-vvv \
	-H "Authorization: Bearer $(REVERSE_PROXY_ACCESS_TOKEN)" \
	-H "Content-Type: application/json" \
	-H "accept: */*" \
	-X POST \
	-d "@test_study" \
	"$(SONG_SERVER_URL)/studies/$(SONG_STUDY_ID)/"

default_analysis:
	@curl \
	-vvv \
	-H "Authorization: Bearer $(REVERSE_PROXY_ACCESS_TOKEN)" \
	-H "Content-Type: application/json" \
	-H "accept: */*" \
	-X POST \
	-d "@test_analysis" \
	"$(SONG_SERVER_URL)/submit/$(SONG_STUDY_ID)"
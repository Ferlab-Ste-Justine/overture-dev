SONG_SERVER_URL="http://localhost:9090"
SONG_STUDY_ID="ET00011"

REVERSE_PROXY_ACCESS_TOKEN="Place token here"

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

troubleshoot_analysis:
	@curl \
	-vvv \
	-H "Authorization: Bearer $(REVERSE_PROXY_ACCESS_TOKEN)" \
	-H "Content-Type: application/json" \
	-H "accept: */*" \
	-X POST \
	-d "@tbs_analysis" \
	"$(SONG_SERVER_URL)/submit/$(SONG_STUDY_ID)"
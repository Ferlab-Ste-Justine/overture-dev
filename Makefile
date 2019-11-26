SONG_SERVER_URL="http://localhost:8080"
SONG_ACCESS_TOKEN="ad83ebde-a55c-11e7-abc4-cec278b6b50a"
SONG_STUDY_ID="ABC123"

default_study:
	@curl \
	-vvv \
	-H "Authorization: Bearer $(SONG_ACCESS_TOKEN)" \
	-H "Content-Type: application/json" \
	-H "accept: */*" \
	-X POST \
	-d "@test_study" \
	"$(SONG_SERVER_URL)/studies/$(SONG_STUDY_ID)/"
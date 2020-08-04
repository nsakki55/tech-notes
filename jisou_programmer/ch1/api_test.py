import responses
from api import get_post, post_to_sns

class TestPostToSns:
    @responses.activate
    def test_post(self):
        responses.add(responses.POST, "https://the-sns.example/com/posts",
                      json={'body': 'honbun'})

        data = post_to_sns("honbun")

        assert data['body'] == 'honbun'


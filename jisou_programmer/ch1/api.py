import requests

def post_to_sns(body):
    res = requests.post('https://the-sns.example/com/posts', json={'body': body})
    return res.json()

def get_post(post_id):
    res = requests.get(f"https://the-sns.example/com/posts/{post_id}")
    return res.json()


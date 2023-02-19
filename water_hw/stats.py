import requests
# Create Username and Password

email = ""
password = ""


# Login and get the token
def login():
    url = "http://localhost:3000/api/v1/auth/login"
    payload = {
        "email": email,
        "password": password
    }
    response = requests.post(url, data=payload)
    return response.json()['token']



# Upload the stats
def upload_stats(token, stats):
    url = "http://localhost:3000/api/v1/stats"
    headers = {
        "x-token": token
    }

    response = requests.post(url, json=stats, headers=headers)
    # Check if the request was successful
    if response.status_code == 200:
        print("Stats uploaded successfully")
    else:
        print("Error uploading stats")


class Stats:
    def __init__(self, token):
        self.token = token

    def upload(self, stats):
        upload_stats(self.token, stats)

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        pass



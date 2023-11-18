# Create a Python Script that will send a slack message to Group1_D9 once our Jenkins file has completed.
# Python Module requests to interact with Slack API
import os
import requests
from dotenv import load_dotenv, dotenv_values

load_dotenv()

# Send message as JSON
# Send a Post request to the Slack Webhook

# Use os.environ to hide the webhook url
url = os.getenv('SLACK_WEBHOOK_URL')

# apply secuirty measures
# if url is present carry out the response
if url:
    message = {'text': 'Jenkins file has completed successfully!'}
    
    response = requests.post(url, json=message)


    if response.status_code == 200:
        print("Response is successful!")
    else:
        print(f"Error Alert! Status Code: {response.status_code}")
else:
    print("SLACK_WEBHOOK_URL environment variable is not set.")

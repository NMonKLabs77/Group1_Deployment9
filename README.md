# DevOps Pipeline for E-Commerce Application
## By: Nalani, Darrrielle, Nehemiah, Aubrey, and Jo


## Purpose

This project aims to establish a robust DevOps pipeline for deploying and monitoring an E-commerce application. The deployment leverages a combination of Jenkins, Docker, and CloudWatch, with the application hosted in containers managed by Elastic Kubernetes Service (EKS). The tech stack includes:

- **React:** Provides a responsive and dynamic frontend.
- **Django:** Offers a robust backend framework.
- **SQLite3:** Serves as a lightweight database solution.

## Deployment Steps

### 1. Set Up Jenkins Manager and Agent Architecture on AWS
Use Terraform to create Jenkins manager and agents, and install Docker and Kubernetes CLI tools.

### 2. Install Docker Pipeline Plugin on Jenkins
Ensure Docker is installed for containerization and consistent environment setup.

### 3. Configure Jenkins
Add the Docker pipeline plugin and install the default JRE for Java-based applications.

### 4. Create Dockerfiles for Frontend and Backend
Standardize environments and streamline deployment processes. Clone the frontend repository and install dependencies using:

   ```
   git clone {Your repo}
   cd frontend
   npm install --save-dev @babel/plugin-proposal-private-property-in-object
   npm install
   npm start
   ```

### 5. Set Up AWS Elastic Kubernetes Service (EKS) Cluster
Decide on the node group placements based on the application code.

### 6. Install Kubernetes Command-Line Tool
Use eksctl and kubectl for scalable cluster management.

### 7. Create Kubernetes Manifest Files
Configure deployment and service YAML files for both frontend and backend applications.

### 8. Configure Jenkins for Docker Image Deployment to EKS
Automate the building, containerizing, and deploying applications to Kubernetes.

### 9. Install the CloudWatch Agent on AWS EKS
Enable enhanced monitoring and logging of Kubernetes clusters and applications.

## Deployment Requirements:
```
AWS Account
Node 10
Docker
Jenkins
Kubernetes
Supporting Technologies
Docker Pipeline Plugin
AWS EKS
CloudWatch Agent
Post-Deployment Tasks
Integrate Jenkins with Slack
Use a Python script to enable real-time notifications to a Slack channel about the Jenkins pipeline status.
```
## Supporting Technologies:
```
Docker Pipeline Plugin
AWS EKS
CloudWatch Agent
Post-Deployment Tasks
Integrate Jenkins with Slack
```
## Use a Python script to enable real-time notifications to a Slack channel about the Jenkins pipeline status:
```
import requests
from urllib.parse import urlencode

def send_slack_message(message):
    slack_webhook_url = 'your-slack-webhook-url'
    payload = {'text': message}
    response = requests.post(
        slack_webhook_url, data=urlencode(payload),
        headers={'Content-Type': 'application/x-www-form-urlencoded'}
    )
    return response.status_code == 200

if __name__ == '__main__':
    send_slack_message('Jenkins pipeline completed.')
```
## Troubleshooting and Optimization:
Encountered issues during the build stage for dockerfiles, resolved by adding the ubuntu user to the docker group and rebooting the instance:
```
sudo usermod -aG docker $USER
sudo reboot
```
## Optimization
Create a script for ALB controller commands for reusability in different EKS clusters.
 - This format provides a clear and concise overview of the project, its purpose, steps for deployment, and additional important information such as post-deployment tasks and troubleshooting. Feel free to modify or add to this template to better suit your project's needs.

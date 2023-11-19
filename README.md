# DevOps Pipeline for E-Commerce Application
## By: Nalani, Darrrielle, Nehemiah, Aubrey, and Jo


## Purpose

This project aims to establish a robust DevOps pipeline for deploying and monitoring an E-commerce application. The deployment leverages a combination of Jenkins, Docker, and CloudWatch, with the application hosted in containers managed by Elastic Kubernetes Service (EKS). The tech stack includes:

- **React:** Provides a responsive and dynamic frontend.
- **Django:** Offers a robust backend framework.
- **SQLite3:** Serves as a lightweight database solution.

## Diagram 

![deployment9 drawio](https://github.com/NMonKLabs77/Group1_Deployment9/assets/135557197/5041a884-5a39-4bf4-93e5-3ae7122abba2)

## Deployment Steps

### 1. Set Up Jenkins Manager and Agent Architecture on AWS
- A Terraform file established the Jenkins manager and agents on AWS, along with Docker and Kubernetes CLI tools. This architecture is key for a robust, scalable CI/CD pipeline, automating software development and deployment stages. Jenkins agents enhance this setup by balancing build loads and boosting security, as they're accessible only through SSH connections.

### 2. Install Docker Pipeline Plugin on Jenkins
- Installing Docker in the Jenkins Docker pipeline plugin is vital for creating a stable, isolated environment for application development and testing. Docker facilitates the creation of containers – compact, self-sufficient software packages containing all necessary elements to run an application. This integration ensures that the Jenkins pipeline can build, test, and deploy applications efficiently in a consistent and replicable setting.

### 3. Configure Jenkins
- Configuring Jenkins to include the Docker Pipeline plugin and the default Java Runtime Environment (JRE) is crucial. This setup allows Jenkins to build and execute Java-based applications in Docker containers, effectively merging Docker's containerization with Jenkins' automation. The result is a more flexible and efficient CI/CD pipeline tailored for Java applications.
```
Pipeline Steps:

Checkout SCM
Build Backend
Build Frontend
Deploy to EKS
Run SlackAPI Script
```

### 4. Create Dockerfiles for Frontend and Backend
- Creating Dockerfiles for both frontend and backend harmonizes the environment and dependencies, ensuring uniformity across development, testing, and production phases. This process includes cloning the frontend repository, installing required dependencies, and initiating the application. It streamlines development and simplifies deployment. Dockerization encapsulates the application's setup, enhancing portability and ease of deployment on any Docker-compatible system.

   ```
   git clone {Your repo}
   cd frontend
   npm install --save-dev @babel/plugin-proposal-private-property-in-object
   npm install
   npm start
   ```

### 5. Set Up AWS Elastic Kubernetes Service (EKS) Cluster
- Typically, an EKS cluster incorporates node groups within both public and private subnets. In this case, considering the frontend code includes specific routes to backend APIs, we opted to position the decoupled application solely within the private subnet. This strategic placement is a security measure to prevent unauthorized access or alterations to our API request routes. The rationale for situating node groups in the private subnet is directly influenced by the frontend code configuration.
  
### 6. Install Kubernetes Command-Line Tool
- Opting for eksctl and kubectl over a graphical user interface enhances reusability and scalability. This approach allows for adaptable commands to create clusters, node groups, or ALB controllers, making it suitable for various EKS clusters.

### 7. Create Kubernetes Manifest Files
- Deployment and service YAML files were crafted for both frontend and backend. Deployment files define the container image, quantity, and accessible port. The frontend's service file routes port 80 requests to port 3000 on its container. The backend's service file establishes a ClusterIP, serving as a unified network address for all backend containers. The frontend links to the backend through a proxy defined in package.json. Unlike Elastic Container Service, which uses direct container IPs for connection, EKS relies on the backend service configuration in service.yaml, ensuring frontend access even if a backend container fails. The ingress file enables traffic flow from the Application Load Balancer.

### 8. Configure Jenkins for Docker Image Deployment to EKS
- Configuring Jenkins for Docker image creation and deployment to Amazon EKS automates building, containerization, and deployment in a Kubernetes setup. This configuration enhances CI/CD pipelines, ensuring consistent, reliable application deployment. It also utilizes EKS's scalability and robustness for container management.

### 9.  Install the Cloudwatch Agent on AWS EKS
- Installing the CloudWatch Agent on AWS EKS improves monitoring and logging for Kubernetes clusters and applications. This tool offers in-depth insights into resource use and performance, aiding proactive management and troubleshooting. It's vital for ensuring operational health and efficiency in cloud-native settings. Utilizing CloudWatch is essential to assess whether the nodes are under or over-provisioned, given the fluctuating number of containers.

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
![Screen Shot 2023-11-19 at 1 28 01 AM](https://github.com/NMonKLabs77/Group1_Deployment9/assets/135557197/795ecad0-bbea-4689-8243-dba442ba63b1)

## Troubleshooting and Optimization:

- Dockerfile Build Stage Error:
   - During the Dockerfile build stage, we encountered an error. The resolution involved adding the Ubuntu user to the Docker group and rebooting the instance. This was achieved with the following commands:
```
sudo usermod -aG docker $USER
sudo reboot
```
- Deployment to EKS:
   - Deployment to EKS was successful after applying the deployment, service, and ingress YAML files. However, we faced an issue with Jenkins that required further investigation and resolution. This part of the process highlighted the importance of thorough testing and validation in each deployment phase.

<img width="1356" alt="deploymentsuccess" src="https://github.com/NMonKLabs77/Group1_Deployment9/assets/135557197/61a13474-24a7-4648-96b0-4ca9ce19d165">

## Optimization
Create a script for ALB controller commands for reusability in different EKS clusters.
 - This format provides a clear and concise overview of the project, its purpose, steps for deployment, and additional important information such as post-deployment tasks and troubleshooting. Feel free to modify or add to this template to better suit your project's needs.

#!/bin/bash

# Update and Upgrade the System
sudo apt-get update && sudo apt-get upgrade -y

# Install AWS CLI
sudo apt-get install awscli -y

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

# Install default Java Runtime Environment (JRE)
sudo apt-get install default-jre -y
#!/bin/bash

sudo apt-get update

sudo apt-get install -y python3.10 unzip

sudo apt-get install -y python3.10-venv python3-pip

curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \/usr/share/keyrings/jenkins-keyring.asc >/dev/null

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \https://pkg.jenkins.io/debian binary/ | sudo tee \/etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update

sudo apt-get -y install fontconfig openjdk-17-jre

sudo apt-get -y install jenkins

sudo apt update
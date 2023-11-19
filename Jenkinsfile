pipeline {
    agent {
        label 'awsDeploy'
    }

    environment {
        DOCKERHUB_CREDENTIALS = credentials('z0sun-dockerhub')
        AWS_EKS_CLUSTER_NAME = 'cluster12'
        AWS_EKS_REGION = 'us-east-1'
        KUBEMANIFESTS_DIR = 'KUBESMANIFESTS_DIR'
    }

    stages {
        stage('Build Backend') {
            steps {
                sh 'docker build -t z0sun/webstoreback:1.0 -f backend/Dockerfile .'
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                sh 'docker push z0sun/webstoreback:1.0'  // Corrected the Docker image tag for push
            }
        }

        stage('Build Frontend') {
            steps {
                sh 'docker build -t z0sun/webstorefront:1.0 -f frontend/Dockerfile .'
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                sh 'docker push z0sun/webstorefront:1.0'  // Corrected the Docker image tag for push
            }
        }

        stage('Deploy to EKS') {
            agent {
                label 'awsDeploy2'
            }
            steps {
                script {
                    withCredentials([
                        string(credentialsId: 'AWS_ACCESS_KEY', variable: 'aws_access_key'),
                        string(credentialsId: 'AWS_SECRET_KEY', variable: 'aws_secret_key')
                    ]) {
                        sh "aws eks --region $AWS_EKS_REGION update-kubeconfig --name $AWS_EKS_CLUSTER_NAME"
                        sh "kubectl apply -f $KUBEMANIFESTS_DIR"
                    }
                }
            }
        }
        
   stage('Run SlackAPI Script') {
    steps {
        checkout scm
        sh 'sudo apt update && sudo apt install -y python3 python3-pip'
        sh 'pip3 install requests'
        sh 'pip3 install python-dotenv'
        sh 'export PATH=$PATH:/home/ubuntu/.local/bin'
        
        dir('SlackAPI') {
            sh 'python3 slackapi.py'
        }
      }
    }

  }
}

//comment

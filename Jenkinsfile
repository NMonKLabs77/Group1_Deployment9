pipeline {
    agent {
        label 'awsDeploy'
    }

    environment {
        DOCKERHUB_CREDENTIALS = credentials('z0sun-dockerhub')
        AWS_EKS_CLUSTER_NAME = 'cluster'
        AWS_EKS_REGION = 'us-east-1'
        KUBEMANIFESTS_DIR = '/home/ubuntu/D9/Group1_Deployment9/backend'
    }

    stages {
        stage('Build Backend') {
            steps {
                sh 'docker build -t z0sun/webstore:1.0 -f dockerfile.back:v1.0 .'
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                sh 'docker push z0sun/webstore:1.0'  // Corrected the Docker image tag for push
                sh 'docker push z0sun/webstore:1.0'  // Corrected the Docker image tag for push
            }
        }

        stage('Build Frontend') {
            steps {
                sh 'docker build -t z0sun/webstore:1.0 -f dockerfile.front:v1.0 .'
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                sh 'docker push z0sun/webstore:1.0'  // Corrected the Docker image tag for push
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

        stage('Slack Notification') {
            steps {
                script {
                    withCredentials([
                        string(credentialsId: 'AWS_ACCESS_KEY', variable: 'aws_access_key'),
                        string(credentialsId: 'AWS_SECRET_KEY', variable: 'aws_secret_key')
                    ]) {
                        sh """
                            curl -X POST -H 'Content-type: application/json' \
                            --data '{"text":"Jenkins Pipeline Complete!"}' \
                        """
                    }
                }
            }
        }

        stage('Run SlackAPI Script') {
            steps {
                checkout scm
                sh 'pip install requests'
                sh 'pip install python-dotenv'  // Install python-dotenv library
                sh 'python slackapi.py'  // Run the SlackAPI script
            }
        }
    }
}


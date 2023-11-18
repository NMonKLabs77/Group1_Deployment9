pipeline {
    agent {
        label 'awsDeploy'
    }

    environment {
        DOCKERHUB_CREDENTIALS = credentials('z0sun-dockerhub')
        AWS_EKS_CLUSTER_NAME = 'cluster05'
        AWS_EKS_REGION = 'us-east-1'
        KUBEMANIFESTS_DIR = '/home/ubuntu/D9/c4_deployment-9/backend'
        SLACK_WEBHOOK_URL = ''
    }          


    stages {
        stage('Build Backend') {
            steps {
                sh 'docker build -t z0sun/webstore:1.0 -f dockerfile.back:v1.0 .'
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'

                sh 'docker push z0sun/dockefile.back:v1'

            }
        }

        stage('Build Frontend') {
            steps {
                sh 'docker build -t morenodoesinfra/webstore:1.0 -f Dockerfile.frontend .'
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'


                sh 'docker push z0sun/dockerfile.front:v1.0'

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
                            ${SLACK_WEBHOOK_URL}
                        """
                    }
                }
            }
        }
    }
            }
        }
    }
}
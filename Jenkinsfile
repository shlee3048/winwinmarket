pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/shlee3048/winwinmarket.git'
            }
        }

        stage('Build') {
            steps {
                sh 'docker build -t us-central1-docker.pkg.dev/bright-airport-430905-u8/for-jenkinsci/django-app:latest .'
            }
        }

        stage('Push to Artifact Registry') {
            steps {
                withCredentials([file(credentialsId: 'gcp-key', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                    sh 'docker push us-central1-docker.pkg.dev/bright-airport-430905-u8/for-jenkinsci/django-app:latest'  // Docker 이미지 푸시
                }
            }
        }

        stage('Deploy to GKE') {
            steps {
                withCredentials([file(credentialsId: 'gcp-key', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                    sh 'kubectl apply -f deployment.yaml'  // Kubernetes에 배포
                }
            }
        }
    }

    post {
        success {
            echo 'Build, push, and deployment succeeded!'
        }
        failure {
            echo 'Build, push, or deployment failed.'
        }
    }
}

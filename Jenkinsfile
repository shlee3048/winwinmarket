pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/shlee3048/winwinmarket.git'
                echo 'Checkout completed successfully!'
            }
        }

        stage('Build') {
            steps {
                sh 'docker build -t us-central1-docker.pkg.dev/bright-airport-430905-u8/for-jenkinsci/django-app:latest .'
                echo 'Build completed successfully!'
            }
        }

        stage('Push to Artifact Registry') {
            steps {
                withCredentials([file(credentialsId: 'gcp-key', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                    sh 'docker push us-central1-docker.pkg.dev/bright-airport-430905-u8/for-jenkinsci/django-app:latest'
                }
                echo 'Push to Artifact Registry completed successfully!'
            }
        }

        stage('Deploy to GKE') {
            steps {
                withCredentials([file(credentialsId: 'gcp-key', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                    sh 'kubectl apply -f deployment.yaml'
                }
                echo 'Deployment to GKE completed successfully!'
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




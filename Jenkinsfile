pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/shlee3048/winwinmarket.git'
                echo 'Checkout completed successfully!'
            }
        } 
        


        stage('Deploy to GKE') {
            steps {
                withCredentials([googleServiceAccount(credentialsId: 'gcp-key', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
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


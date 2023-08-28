pipeline {
    agent any

    environment {
        // Define your environment variables here
        CREDENTIALS_ID = 'gcp-service-account'  // Jenkins Credential ID for GCP credentials
    }

    stages {
        stage('Install Google Cloud SDK') {
            steps {
                script {
                    sh 'curl https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-367.0.0-linux-x86_64.tar.gz -o gcloud-sdk.tar.gz'
                    sh 'tar -xvf gcloud-sdk.tar.gz'
                    sh './google-cloud-sdk/install.sh'
                    sh 'source ~/.bashrc' // Reload the shell environment
                }
            }
        }
        
        stage('Checkout') {
            steps {
                // Checkout your code from the repository
                checkout scm
            }
        }

        stage('Activate GCP Credentials') {
            steps {
                // Activate GCP credentials using Jenkins Credential ID
                withCredentials([string(credentialsId: CREDENTIALS_ID, variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                    sh 'gcloud auth activate-service-account --key-file=${GOOGLE_APPLICATION_CREDENTIALS}'
                }
            }
        }

        stage('Deploy Cloud Armor Policy') {
            steps {
                // Deploy the Cloud Armor policy using gcloud command
                sh 'gcloud deployment-manager deployments create abhishek-cloud-armor-deployment --config=cloud_armor_policy.yaml'
            }
        }
    }
}

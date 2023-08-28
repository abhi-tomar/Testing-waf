pipeline {
    agent any

    environment {
        CREDENTIALS_ID = 'testing-project'  // Jenkins Credential ID for GCP credentials
        GCLOUD_PATH = "${WORKSPACE}/google-cloud-sdk/bin"  // Path to gcloud binary
    }

    stages {
        stage('Install Google Cloud SDK') {
            steps {
                script {
                    sh 'curl https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-367.0.0-linux-x86_64.tar.gz -o gcloud-sdk.tar.gz'
                    sh 'tar -xvf gcloud-sdk.tar.gz'
                    sh './google-cloud-sdk/install.sh'

                    // Set the path to gcloud binary
                    sh 'export PATH=${GCLOUD_PATH}:${PATH}'
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
                withCredentials([file(credentialsId: CREDENTIALS_ID, variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                    sh "${GCLOUD_PATH}/gcloud auth activate-service-account --key-file=${GOOGLE_APPLICATION_CREDENTIALS}"
                }
            }
        }

        stage('Deploy Cloud Armor Policy') {
            steps {
                // Set the project ID as an environment variable
                script {
                    env.PROJECT_ID = 'testing-project-397313'  // Replace with your actual project ID
                }
                // Deploy the Cloud Armor policy using gcloud command
                sh "${GCLOUD_PATH}/gcloud config set project ${PROJECT_ID}"
                sh "${GCLOUD_PATH}/gcloud deployment-manager deployments create abhishek-cloud-armor-deployment --config=cloud_armor_policy.yml"
            }
        }
    }
}

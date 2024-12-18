pipeline {
    agent any
    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub-credentials') // Replace with your credentials ID
        DOCKER_DEV_REPO = 'your-dockerhub-username/dev-repo'
        DOCKER_PROD_REPO = 'your-dockerhub-username/prod-repo'
    }
    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }
        stage('Build Docker Image (Dev)') {
            when {
                branch 'dev'
            }
            steps {
                script {
                    sh 'docker build -t ${DOCKER_DEV_REPO}:${env.BUILD_NUMBER} .'
                }
            }
        }
        stage('Push to Docker Hub (Dev)') {
            when {
                branch 'dev'
            }
            steps {
                script {
                    sh '''
                    echo $DOCKER_HUB_CREDENTIALS_PSW | docker login -u $DOCKER_HUB_CREDENTIALS_USR --password-stdin
                    docker push ${DOCKER_DEV_REPO}:${env.BUILD_NUMBER}
                    '''
                }
            }
        }
        stage('Build & Push Docker Image (Prod)') {
            when {
                branch 'master'
            }
            steps {
                script {
                    sh '''
                    echo $DOCKER_HUB_CREDENTIALS_PSW | docker login -u $DOCKER_HUB_CREDENTIALS_USR --password-stdin
                    docker build -t ${DOCKER_PROD_REPO}:${env.BUILD_NUMBER} .
                    docker push ${DOCKER_PROD_REPO}:${env.BUILD_NUMBER}
                    '''
                }
            }
        }
    }
    post {
        always {
            echo "Pipeline execution completed!"
        }
    }
}

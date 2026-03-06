pipeline {
    agent any

    stages {

        stage('Git Checkout') {
            steps {
                checkout scmGit(
                    branches: [[name: '*/master']],
                    userRemoteConfigs: [[
                        credentialsId: 'naveencred',
                        url: 'https://github.com/naveennallamsetti/hotstar.git'
                    ]]
                )
            }
        }

        stage('Validate') {
            steps {
                sh 'mvn validate'
            }
        }

        stage('Compile') {
            steps {
                sh 'mvn compile'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Package') {
            steps {
                sh 'mvn package'
            }
        }

        stage('Docker Build') {
            steps {
                sh '''
                docker rmi project1 || true
                docker build -t project1 .
                '''
            }
        }

        stage('Deploy Container') {
            steps {
                sh '''
                docker rm -f project1-container || true
                docker run -d -p 8093:8080 --name project1-container project1
                '''
            }
        }

    }
}

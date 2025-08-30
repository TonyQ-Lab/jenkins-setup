pipeline {
    agent any

    tools {
        maven 'maven3'
    }

    environment {
        CI = 'true'
    }

    stages {
        stage('Checkout code') {
            steps {
                checkout scmGit(
                    branches: [[name: 'main']],
                    userRemoteConfigs: [[url: 'https://github.com/TonyQ2k3/library-manager.git']]
                )
            }
        }
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv(installationName: 'sonar-server') {
                    sh "mvn clean verify sonar:sonar -Dsonar.projectKey=library-backend -Dsonar.projectName='library-backend'"
                }
            }
        }
        stage("Quality Gate") {
            steps {
                timeout(time: 1, unit: 'HOURS') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }
        stage('Unit Tests') {
            steps {
                sh 'mvn test'
            }
        }
    }
    post {
        always {
            cleanWs()
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
pipeline {
    agent any

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "maven3"
    }

    stages {
        stage('Build') {
            steps {
                // Get some code from a GitHub repository
                checkout scmGit(
                    branches: [[name: 'main']],
                    userRemoteConfigs: [[url: 'https://github.com/TonyQ2k3/library-manager.git']]
                )

                // Run Maven (on a Unix agent).
                sh "mvn -Dmaven.test.failure.ignore=true clean package"
            }

            post {
                success {
                    echo 'Build completed successfully!'
                }
                always {
                    cleanWs()
                }
            }
        }
    }
}

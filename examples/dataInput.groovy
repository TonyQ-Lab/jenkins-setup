// This is a Jenkins Pipeline script that uses the input step to gather user input

pipeline {
    agent any
    stages {
        stage('Example') {
            input {
                message "Tell me about yourself."
                ok "Submit"
                parameters {
                    string(name: 'NAME', defaultValue: 'My name', description: 'What is your name?')
                    string(name: 'AGE', defaultValue: '30', description: 'What is your age?')
                }
            }
            steps {
                echo "Hello, ${NAME}, nice to meet you."
                echo "You are ${AGE} years old."
            }
        }
    }
}
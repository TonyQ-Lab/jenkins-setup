multibranchPipelineJob('webserver-job') {
    description('Nodejs example job created with Job DSL')

    branchSources {
        github {
\           repository('tonyq2k3/webserver-cicd')
            credentialsId('tonyq2k3') // Ensure you have this credential set up in Jenkins
            scanCredentialsId('tonyq2k3')
        }
    }

    triggers {
        scm('H/5 * * * *') // Poll SCM every 5 minutes
    }

    steps {
        shell('echo Hello from Job DSL!')
        shell('echo Building project...')
    }

    publishers {
        mailer('you@example.com', false, true)
    }
}
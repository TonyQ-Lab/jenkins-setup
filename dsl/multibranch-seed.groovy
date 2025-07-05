multibranchPipelineJob('webserver-job') {
    description('Nodejs example job created with Job DSL')

    branchSources {
        github {
            id('webserver-cicd-github')
            scanCredentialsId('tonyq2k3')
            repoOwner('Tonyq2k3')
            repository('webserver-cicd')
            buildOriginPRHead(true)
            buildForkPRHead(true)
        }
    }

    configure { project -> 
        def triggers = project / 'triggers'
        triggers << 'com.igalg.jenkins.plugins.mswt.trigger.ComputedFolderWebHookTrigger' {
            spec('')
            token('tony')
        }

        def branchSource = project / 'sources' / 'data' / 'jenkins.branch.BranchSource'
        def strategies = branchSource / 'buildStrategies'
        strategies << 'com.igalg.jenkins.plugins.multibranch.buildstrategy.ExcludeRegionByFieldBranchBuildStrategy' {
            strategy('EXCLUDED')
            excludedRegions('**/*.md .gitignore .dockerignore **/*.jpeg **/*.png **/*.jpg Jenkinsfile Dockerfile **/*.yaml')
        }
    }
}
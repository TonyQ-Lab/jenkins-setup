multibranchPipelineJob('webserver-job') {
    description('Pipeline for Spring Boot Library Management')

    branchSources {
        github {
            id('library-manager')
            scanCredentialsId('tonyq2k3')
            repoOwner('Tonyq2k3')
            repository('library-manager')
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
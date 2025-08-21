For detailed guide, check the [SonarQube Jenkins Integration Docs](https://docs.sonarsource.com/sonarqube-community-build/analyzing-source-code/ci-integration/jenkins-integration/key-features).

Setting up server
=================

1. Run `install.sh` to install all necessary components

2. Run `docker compose up -d` to start SonarQube and PostgreSQL in containers.

3. When the server is up, visit `http://<server-public-ip>:9000` to access SonarQube's UI.


Configuring Jenkins
===================

1. Install the [Sonar Scanner](https://plugins.jenkins.io/sonar) Jenkins plugin.

2. Create a **Jenkins Credentials** of type **Global credentials (unrestricted)**:
    + **Kind**: Secret Text
    + **Scope**: Global
    + **Secret**: Generate a token at **User** > **My Account** > **Security** in SonarQube Community Build, and copy and paste it here.

3. Go to **Manage Jenkins** > **Configure System**.

    From the **SonarQube servers** section, click **Add SonarQube**. Add the following information:
    + **Name**: Give a unique name to your SonarQube Community Build instance.
    + **Server URL**: Your SonarQube Community Build instance URL.
    + **Credentials**: Select the credentials we created in step 2.
    
    Check **Environment variables**.

Adding Sonar Analysis to Jenkins job
====================================
1. At the SonarQube UI, Create a **Local Project**.

2. Choose **Use the global setting**.

3. Add an analysis stage to your pipeline code. Change "sonar-server", "projectKey" and "projectName" with the one you configured.
```groovy
stage('SonarQube Analysis') {
    steps {
        withSonarQubeEnv(installationName: 'sonar-server') {
            sh "mvn clean verify sonar:sonar -Dsonar.projectKey=library-backend -Dsonar.projectName='library-backend'"
        }
    }
}
```

Adding Quality Gate
===================

1. Go to **Project Settings** > **Webhooks**

2. Click **Create**
    + Name: jenkins
    + URL: `http://<jenkins-url>/sonarqube-webhook/`

3. Add Quality Gate to Jenkins job:

```groovy
stage("Quality Gate") {
    steps {
        timeout(time: 1, unit: 'HOURS') {
            waitForQualityGate abortPipeline: true
        }
    }
}
```
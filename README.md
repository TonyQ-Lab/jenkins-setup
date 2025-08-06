# Everything related to Jenkins that I've done: Setup, Configs, DSL


## Job DSL

### Setup Job DSL

1. Go to Manage Jenkins > Plugins and install Job DSl plugin
2. After installation, go to Manage Jenkins > In-process Script Approval

## SonarQube

1. If run locally, use ngrok to expose the SonarQube instance URL
```bash
ngrok http 9000
```
2. Within SonarQube's UI, go to `Projects` and configure Github
    + You need a Github App (`Settings` > `Developer Settings` > `Github Apps`)
    + Add the necessary permissions: Pull request: write, Checks: write.
    + Install the app to an organization whose repos you want to include.
3. 
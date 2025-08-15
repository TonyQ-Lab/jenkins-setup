Jenkins WAR file as a service
=============================

Create a unit file `/etc/systemd/system/jenkins-war.service`:
```
[Unit]
Description=Jenkins via WAR file
After=network.target

[Service]
User=ubuntu
ExecStart=/usr/bin/java -jar /opt/jenkins/jenkins.war --httpPort=8080
WorkingDirectory=/opt/jenkins
Restart=always

[Install]
WantedBy=multi-user.target
```

```sh
sudo systemctl daemon-reload
sudo systemctl enable jenkins-war
sudo systemctl start jenkins-war
```

Installing outdated plugins
===========================

Go to http://jenkins-url:8080/cli and download jenkins-cli.jar using the URL provided there.

```sh
sudo wget http://jenkins-url:8080/jnlpJars/jenkins-cli.jar -P /opt/jenkins/

java -jar /opt/jenkins/jenkins-cli.jar -s http://52.91.111.30:8080/ -auth admin:password install-plugin <Plugin-Name:Version>
```
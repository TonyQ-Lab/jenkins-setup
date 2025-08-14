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

```bash
sudo systemctl daemon-reload
sudo systemctl enable jenkins-war
sudo systemctl start jenkins-war
```
#!/bin/bash

########################################
# Install Jenkins but through WAR file #
########################################

set -euxo pipefail

# Jenkins WAR file URL (Change based on your version)
JENKINS_WAR_URL="https://get.jenkins.io/war-stable/2.346.3/jenkins.war"

# Update package index
sudo apt-get update && sudo apt-get upgrade -y

# Install Java (Jenkins requires Java)
sudo apt-get install -y openjdk-11-jre openjdk-11-jdk

# Download the latest Jenkins WAR file
wget $JENKINS_WAR_URL -P /opt/jenkins

# Start Jenkins
java -jar /opt/jenkins/jenkins.war --httpPort=8080 --enable-future-java
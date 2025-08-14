#!/bin/bash

set -euxo pipefail

sudo systemctl stop jenkins && sudo systemctl disable jenkins
echo "================ Jenkins stopped and disabled successfully. ================"

sudo apt remove --purge jenkins -y
echo "================ Jenkins removed successfully. ================"

sudo rm -rf /var/lib/jenkins
sudo rm -rf /etc/jenkins
sudo rm -rf /var/log/jenkins
sudo rm -rf /usr/lib/jenkins
echo "================ Jenkins data removed successfully. ================"

which jenkins # Verify that Jenkins is no longer installed
#!/bin/bash
echo "" 
echo "***************Updating Ubuntu***************"
sudo apt update
echo "" 
echo -e "***************Installing Java JRE 17***************"
sudo apt install fontconfig openjdk-17-jre -y
echo "" 
echo "***************Java version***************"
java -version
echo "" 
echo "***************Installing Jenkins***************"
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" https://pkg.jenkins.io/debian-stable binary/ | sudo tee  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins -y

echo "" 
echo "***************Checking Jenkins status***************"

# Check if Jenkins is installed by verifying the service status
if systemctl list-units --type=service | grep -q "jenkins.service"; then
    # If Jenkins service exists, check its status
    sudo systemctl status jenkins | grep -C 2 "active"
    
    # Optional: Add more logic if Jenkins is running or not
    if sudo systemctl is-active --quiet jenkins; then
        echo "Jenkins is running."
    else
        echo "Jenkins is installed but not running. Starting Jenkins..."
        sudo systemctl start jenkins
        echo "Jenkins has been started."
    fi
else
    echo "Jenkins is not installed or the service is not recognized."
fi

echo "" 
echo "Your one time password into jenkins is $(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)"

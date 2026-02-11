#!/bin/bash
set -e

### SYSTEM UPDATE ###
sudo yum update -y

### JAVA 17 (ZALECANE / WYMAGANE PRZEZ JENKINS) ###
sudo amazon-linux-extras enable corretto17
sudo yum install -y java-17-amazon-corretto

### JENKINS (LATEST STABLE) ###
sudo wget -O /etc/yum.repos.d/jenkins.repo \
  https://pkg.jenkins.io/redhat-stable/jenkins.repo

sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

sudo yum install -y jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins

### GIT ###
sudo yum install -y git

### TERRAFORM (LATEST) ###
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum install -y terraform

### KUBECTL (LATEST STABLE) ###
KUBECTL_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt)

curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/kubectl

### VERIFY ###
java -version
git --version
terraform -version
kubectl version --client

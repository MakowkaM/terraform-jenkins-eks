#!/bin/bash
set -e

# Poczekaj aż yum będzie dostępny
while fuser /var/lib/rpm/.rpm.lock >/dev/null 2>&1; do
    echo "Czekam aż yum będzie wolny..."
    sleep 5
done

# SYSTEM UPDATE
yum update -y

# JAVA 17
yum install -y java-17-amazon-corretto

# JENKINS (latest stable)
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
yum install -y jenkins
systemctl enable jenkins
systemctl start jenkins

# GIT
yum install -y git

# TERRAFORM
yum install -y yum-utils
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
yum install -y terraform

# KUBECTL
KUBECTL_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt) 
curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"
chmod +x kubectl
mv kubectl /usr/local/bin/kubectl

# WERYFIKACJA
java -version
git --version
terraform -version
kubectl version --client

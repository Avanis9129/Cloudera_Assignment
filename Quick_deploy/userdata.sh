#!/bin/bash

#install required packages
yum install -y  git unzip tree

#install aws cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws --version

#install Terraform
yum install -y yum-utils
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
yum -y install terraform
terraform -version

#install python3
dnf update -y
dnf install python3
python3 -V

#install ansible
yum install pip -y
pip3 install ansible
ansible --version

#install cdpcli
pip install cdpcli


#install cloudera deployer pre-requisites
yum install docker -y
touch /etc/containers/nodocker
docker -v
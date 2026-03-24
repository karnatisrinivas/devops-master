#!/bin/bash

yum update -y

# Install Docker
amazon-linux-extras install docker -y
systemctl start docker
systemctl enable docker
usermod -aG docker ec2-user

# Install docker-compose
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# # Clone repo
# cd /home/ec2-user
# git clone https://github.com/karnatisrinivas/devops-master.git app

# cd app

# docker-compose up -d
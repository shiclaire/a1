#!/bin/bash

#
# IMPORTANT: Change aws_access_key_id and aws_secret_access_key before run this script!!!
#
# Description: This Shell Script will install Ansible and Boto in the current system. Then,
#              a Ansible playbook used to create a new AWS KeyPair will be created.
#              The new KeyPair is ~/.ssh/keypairForAnsible.yem.
#
# Parameters: aws_access_key_id, aws_secret_access_key, region

# ————— install ansible & boto —————
# Upload Ubuntu source packages
apt-get update
# sudo apt upgrade -y
apt-get -y install software-properties-common

# Add ppa:ansible/ansible to system’s Software Source
apt-add-repository ppa:ansible/ansible -y

# Update repository and install ansible
apt-get update
apt-get -y install ansible
apt-get -y install python-pip

# Install boto
pip install botocore boto boto3

# ————— configure boto —————
# Setup AWS credentials/API keys
mkdir -pv ~/.aws/
echo "[default]
aws_access_key_id = $1
aws_secret_access_key = $2" > ~/.aws/credentials

# Setup default AWS region:
echo "[default]
region = $3" > ~/.aws/config

# Create hosts file
echo -e "[local]
localhost \n
[webserver]" > ~/hosts

# Create playbook config file
cd ~
sudo wget -c https://raw.githubusercontent.com/shiclaire/a1/master/ansible.cfg

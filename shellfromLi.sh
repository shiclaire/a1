
#!/bin/bash
# install software to manage repositories

sudo apt update
sudo apt upgrade -y
sudo apt install software-properties-common

# add ppa:ansible/ansible to system’s Software Source
sudo apt-add-repository ppa:ansible/ansible -y

# update repos and install ansible
sudo apt update
sudo apt install ansible -y

# install pip, botocore, boto, boto3
sudo apt install python-pip -y
pip install botocore boto boto3

# configure boto
# setup AWS credentials/API keys
mkdir -pv ~/.aws/

echo "
[default]
aws_access_key_id = AKIAJPAFHG7QO7P5W6EA 
aws_secret_access_key = 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 "> ~/.aws/credentials

sudo chmod 666 ~/.aws/credentials
# setup default AWS region
echo "
[default]
region = us-west-2"> ~/.aws/config

sudo chmod 666 ~/.aws/config

echo "
[local]
localhost
[webserver]"> ~/hosts
sudo chmod 666 ~/hosts

sudo apt install awscli -y

ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
aws ec2 import-key-pair --public-key-material "$(cat ~/.ssh/id_rsa.pub | tr -d '\n')"  --key-name main

export ANSIBLE_HOST_KEY_CHECKING=False

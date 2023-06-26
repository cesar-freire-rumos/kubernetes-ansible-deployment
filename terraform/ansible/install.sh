#!/bin/bash

# Install pip to be able to install ansible latest
sudo apt-get update && sudo apt-get install -yq python3-pip;
sleep 3;

# Install ansible
mkdir -p /home/ubuntu/.local/bin
export PATH="$HOME/.local/bin:$PATH"
pip install ansible;
ansible --version

echo "running playbook"
ansible-playbook -u ubuntu /home/ubuntu/k8s-deployment-playbook.yaml

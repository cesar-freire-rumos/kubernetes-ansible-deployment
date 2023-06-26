#!/bin/bash

# Default user
USER="ubuntu"

# Wait to cloud-init to end
while [ ! -f /var/lib/cloud/instance/boot-finished ]; do
   echo 'Waiting for cloud-init...'
   sleep 1
done

# Install pip to be able to install ansible latest
export DEBIAN_FRONTEND=noninteractive
sudo apt-get clean
sleep 3
sudo apt-get update
sleep 3
sudo apt-get install -qq python3-pip
sleep 3

# Install ansible
mkdir -p /home/$USER/.local/bin
export PATH="$HOME/.local/bin:$PATH"
pip -q install ansible;
echo "Ansible installed..."
ansible --version

# Trigger k8s control plane playbook
echo "running playbook"
cd /home/$USER/ansible/ && ansible-playbook -u $USER k8s-controler-playbook.yaml

#!/bin/bash
echo "Start installing ansible"

# Default user
USER="ubuntu"

# Wait to cloud-init to end
while [ ! -f /var/lib/cloud/instance/boot-finished ]; do
   echo 'Waiting for cloud-init...'
   sleep 1
done

# Install pip to be able to install ansible latest
sudo apt-get clean
sleep 1
sudo apt-get update -qq && sudo DEBIAN_FRONTEND=noninteractive apt-get install -qq python3-pip
sleep 1

# Install ansible via pip for latest version
mkdir -p /home/$USER/.local/bin
export PATH="$HOME/.local/bin:$PATH"
pip -q install ansible;
ansible --version
echo "Finish installing ansible"

echo "Running playbook"
cd /home/$USER/ansible/ && ansible-playbook -u $USER playbook.yaml
echo "Finish ansible playbook"
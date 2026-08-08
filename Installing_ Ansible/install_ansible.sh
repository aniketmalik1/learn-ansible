#!/bin/bash

# Ansible Installation Script
# Tested on Ubuntu/Debian

set -e

echo "Updating package repository..."
sudo apt update

echo "Installing Ansible..."
sudo apt install ansible -y

echo "Checking Ansible Version..."
ansible --version

echo "Ansible installation completed successfully."

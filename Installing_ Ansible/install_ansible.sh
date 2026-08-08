#!/bin/bash
2
# Basic Ansible installation script for Ubuntu/Debian
3
set -e
4
 
5
sudo apt update
6
sudo apt install ansible -y
7
 
8
ansible --version

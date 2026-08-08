#!/bin/bash

# Ansible Ad-Hoc Commands Practice Script
# Using Ansible Ad-Hoc Commands
# Purpose: Run common Ansible ad-hoc commands for documentation lookup,
# system information gathering, Apache installation, configuration update,
# service management, verification, and package removal.

set -e

# Inventory group name configured in /etc/ansible/hosts
TARGET_GROUP="target"

# Apache package and configuration file for RHEL/CentOS based systems
PACKAGE_NAME="httpd"
APACHE_CONFIG="/etc/httpd/conf/httpd.conf"
APACHE_PORT="8080"

 echo "=========================================="
 echo "Ansible Ad-Hoc Commands Lab"
 echo "=========================================="

 echo "Listing available Ansible modules..."
 ansible-doc -l | head

 echo "Searching for copy module..."
 ansible-doc -l | grep copy || true

 echo "Displaying copy module documentation..."
 ansible-doc copy | head

 echo "Gathering system facts from target hosts..."
 ansible ${TARGET_GROUP} -m setup

 echo "Installing Apache web server on target hosts..."
 ansible ${TARGET_GROUP} -m yum -a "name=${PACKAGE_NAME} state=latest" --become

 echo "Changing Apache listening port to ${APACHE_PORT}..."
 ansible ${TARGET_GROUP} -m lineinfile -a "path='${APACHE_CONFIG}' regexp='^Listen ' insertafter='^#Listen ' line='Listen ${APACHE_PORT}' state=present" --become

 echo "Starting and enabling Apache service..."
 ansible ${TARGET_GROUP} -m service -a "name=${PACKAGE_NAME} enabled=yes state=started" --become

 echo "Verification step: open browser and access http://<NODE-IP>:${APACHE_PORT}"

 echo "To remove Apache, run the command below manually if required:"
 echo "ansible ${TARGET_GROUP} -m yum -a \"name=${PACKAGE_NAME} state=removed\" --become"

 echo "Activity completed."

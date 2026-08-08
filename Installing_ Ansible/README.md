# Installing Ansible

This repository contains instructions for installing and configuring Ansible with a controller node and worker nodes.

## Prerequisites
- 1 VM for the Ansible Controller Node
- One or more Worker Nodes
- SSH access enabled

## Steps
1. Configure SSH on all nodes.
2. Generate an SSH key on the controller node.
3. Copy the public key to worker nodes.
4. Verify SSH connectivity.
5. Install Ansible on the controller node.
6. Verify the installation.
7. Configure `/etc/ansible/ansible.cfg`.
8. Update `/etc/ansible/hosts`.
9. Test connectivity using `ansible -m ping target`.

# Ansible Installation and Configuration Guide

## Overview

Ansible is an open-source IT automation and configuration management tool developed by Red Hat. It helps system administrators automate tasks such as server provisioning, software installation, configuration management, application deployment, and infrastructure orchestration.

Unlike many automation tools, Ansible is agentless, meaning no additional software is required on managed hosts. It uses SSH to communicate with target systems.

---

## Purpose of Ansible

Ansible is used to:

- Automate repetitive administrative tasks
- Manage server configurations consistently
- Deploy applications across multiple servers
- Reduce manual effort and human errors
- Perform infrastructure provisioning
- Execute remote commands on multiple hosts
- Manage cloud and on-premises environments

---

## Ansible Architecture

Ansible consists of:

### Controller Node
The system where Ansible is installed and from which automation tasks are executed.

### Managed Nodes (Worker Nodes)
Target servers that receive and execute instructions sent by the controller node through SSH.

```
+------------------+
| Controller Node  |
|   (Ansible)      |
+---------+--------+
          |
          | SSH
          |
   --------------------
   |        |         |
+------+ +------+ +------+
|Host1 | |Host2 | |HostN |
+------+ +------+ +------+
```

---

## Prerequisites

Before installing Ansible:

- One Linux VM for the Controller Node
- One or more Linux VMs as Worker Nodes
- Root or sudo access
- Network connectivity between nodes
- SSH service running on all nodes

---

## Step 1: Configure SSH Authentication

Login as root on all nodes:

```bash
sudo su -
```

Edit SSH configuration:

```bash
vi /etc/ssh/sshd_config
```

Change:

```text
PasswordAuthentication no
```

To:

```text
PasswordAuthentication yes
```

Restart SSH service:

```bash
systemctl restart sshd
```

---

## Step 2: Generate SSH Key on Controller Node

Generate SSH key:

```bash
ssh-keygen
```

Display public key:

```bash
cat ~/.ssh/id_rsa.pub
```

Copy the output.

---

## Step 3: Configure Worker Nodes

On each worker node:

```bash
vi ~/.ssh/authorized_keys
```

Paste the copied public key and save the file.

---

## Step 4: Verify SSH Connectivity

From the controller node:

```bash
ssh root@<worker-node-ip>
```

Exit after successful login:

```bash
exit
```

---

## Step 5: Install Ansible

Update repositories:

```bash
sudo apt update
```

Install Ansible:

```bash
sudo apt install ansible -y
```

---

## Step 6: Verify Installation

Check installed version:

```bash
ansible --version
```

---

## Step 7: Configure Ansible

Edit configuration file:

```bash
vi /etc/ansible/ansible.cfg
```

Uncomment:

```text
inventory = /etc/ansible/hosts
```

---

## Step 8: Configure Inventory

Edit hosts file:

```bash
vi /etc/ansible/hosts
```

Add target servers:

```text
[target]
192.168.1.101
192.168.1.102
192.168.1.103
```

---

## Step 9: Test Ansible Connectivity

Run:

```bash
ansible -m ping target
```

Expected output:

```text
SUCCESS => pong
```

---

## Benefits of Ansible

- Agentless Architecture
- Easy to Learn (YAML Based)
- Scalable Automation
- Faster Application Deployment
- Reduced Operational Cost
- Infrastructure as Code (IaC)
- Cross-Platform Support

---

## Use Cases

- Configuration Management
- Patch Management
- Application Deployment
- Cloud Provisioning
- Security Compliance
- Server Orchestration
- DevOps Automation

---



8. Update `/etc/ansible/hosts`.
9. Test connectivity using `ansible -m ping target`.

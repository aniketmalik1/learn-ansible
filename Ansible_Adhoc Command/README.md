# Ansible Ad-Hoc Commands 

## Overview

This project demonstrates the usage of Ansible Ad-Hoc Commands for performing administration tasks on remote Linux hosts.

Ansible Ad-Hoc commands are one-line commands used to perform quick tasks without creating a playbook. They are useful for system administration, troubleshooting, software installation, configuration updates, and service management.

---

## What are Ansible Ad-Hoc Commands?

Ad-Hoc commands allow administrators to execute a single task across one or multiple managed hosts directly from the command line.

Unlike playbooks, Ad-Hoc commands are generally used for:

- Quick administration tasks
- One-time configuration changes
- Testing connectivity
- Gathering system information
- Package installation and removal
- Service management

---

## Purpose 

The objective of this activity is to learn:

- How to view available Ansible modules
- How to access module documentation
- How to gather system information
- How to install software packages remotely
- How to modify configuration files
- How to control system services
- How to remove installed packages



---

## Prerequisites

Before performing the lab:

- Ansible installed on Controller Node
- Inventory configured in `/etc/ansible/hosts`
- Passwordless SSH configured between Controller and Target Hosts
- One or more Target Nodes available

---

# Exercise 1: Using Ansible Documentation Commands

## List All Available Modules

Use the following command:

```bash
ansible-doc -l
```

This command lists all available Ansible modules.

---

## Search for a Specific Module

Example:

```bash
ansible-doc -l | grep copy
```

This command filters the available modules and displays modules related to file copy operations.

---

## View Module Documentation

Example:

```bash
ansible-doc copy
```

This displays detailed documentation for the copy module including:

- Parameters
- Examples
- Usage Instructions
- Module Attributes

---

# Exercise 2: Running Ad-Hoc Commands

## Gather System Information

The setup module collects system facts and infrastructure metadata.

Command:

```bash
ansible target -m setup
```

Where:

- target = inventory group name defined in `/etc/ansible/hosts`

The command collects information such as:

- IP Address
- Hostname
- Operating System
- CPU Architecture
- Memory Information
- Network Details

---

## Install Apache Web Server

The activity uses the yum module to install packages.

Command:

```bash
ansible target -m yum \
-a "name=httpd state=latest" \
--become
```

Explanation:

| Parameter | Description |
|------------|------------|
| yum | Package management module |
| name=httpd | Apache package |
| state=latest | Installs latest version |
| --become | Executes with sudo privileges |

Note:

Administrative privileges are required, otherwise the installation fails.

---

## Modify Apache Configuration

The lineinfile module updates a specific line inside a file.

Purpose:

Change Apache listening port from 80 to 8080.

Command:

```bash
ansible target -m lineinfile \
-a "path='/etc/httpd/conf/httpd.conf' regexp='^Listen ' insertafter='^#Listen ' line='Listen 8080' state=present" \
--become
```

This command:

- Opens Apache configuration file
- Finds the existing Listen directive
- Replaces the value
- Updates Apache to use port 8080

---

## Manage Apache Service

The service module controls services on remote hosts.

Command:

```bash
ansible target -m service \
-a "name=httpd enabled=yes state=started" \
--become
```

Purpose:

- Starts Apache service
- Enables automatic startup during boot
- Verifies service availability

---

## Verify Web Server

Open a browser and access:

```text
http://<NODE-IP>:8080
```

If successful, the Apache default page should appear.

---

## Remove Apache Package

The yum module can also remove packages.

Command:

```bash
ansible target -m yum \
-a "name=httpd state=removed" \
--become
```

Purpose:

- Removes Apache package
- Cleans installed application files
- Stops service availability

---

## Common Ansible Modules Used

### setup

Used for gathering host facts and metadata.

```bash
ansible target -m setup
```

### yum

Used for package management on Linux distributions that support YUM.

```bash
ansible target -m yum
```

### lineinfile

Used for modifying single lines in configuration files.

```bash
ansible target -m lineinfile
```

### service

Used for service management.

```bash
ansible target -m service
```

---

## Benefits of Ansible Ad-Hoc Commands

- Fast execution
- No playbook creation required
- Easy troubleshooting
- Remote system administration
- Consistent configuration updates
- Agentless architecture
- Scalable across multiple hosts

---

## Expected Learning Outcomes

After completing this lab, you should be able to:

- Use Ansible documentation tools
- Navigate module information
- Collect system facts using setup module
- Install and uninstall software remotely
- Modify configuration files
- Manage services using Ansible
- Perform common administration tasks through Ad-Hoc commands

---


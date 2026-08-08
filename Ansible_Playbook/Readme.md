# Activity - Using Ansible Playbook

This repository contains the complete lab content for **Activity : Using Ansible Playbook**. The activity explains how to create and run an Ansible playbook to install, configure, start, and enable an Apache web server on a target node.

## Scenario

In this activity, an Ansible playbook is used to automate the configuration of a web server. The playbook installs Apache HTTP Server, copies a custom `index.html` file as the default website page, starts the Apache service, and enables the service so that Apache starts automatically after an operating system reboot.

## Objective

The objective of this lab is to understand how to:

- Create an Ansible lab directory.
- Create a custom `index.html` file.
- Create an Ansible playbook file named `playbook.yml`.
- Define the hosts section in an Ansible playbook.
- Define the tasks section in an Ansible playbook.
- Install Apache Web Server using the `yum` module.
- Copy a web page file to `/var/www/html/`.
- Start the Apache HTTPD service.
- Enable the Apache service so it runs after reboot.
- Check the playbook for syntax errors.
- Execute the playbook with root privileges using `--become`.
- Verify the web server by opening the target node IP address in a browser.

## Repository Files

```text
.
├── README.md
└── setup_ansible_webserver.sh
```

After running the shell script, the following lab files are created:

```text
ansible-lab-one/
├── index.html
└── playbook.yml
```

## Prerequisites

Before running this lab, make sure the following requirements are available:

- Ansible is installed on the control node.
- SSH connectivity is configured between the control node and target node.
- The Ansible inventory contains a host group named `target`.
- The target node supports the `yum` package manager.
- The target node uses the Apache package name `httpd`.
- The user running the playbook has sudo or root privileges.

## Common Ansible Commands Used

Run any Ansible playbook:

```bash
ansible-playbook <your-playbook-file.yml>
```

Check a playbook for syntax errors:

```bash
ansible-playbook <your-playbook-file.yml> --syntax-check
```

Run this lab playbook with a syntax check:

```bash
ansible-playbook playbook.yml --syntax-check
```

Run this lab playbook with root privileges:

```bash
ansible-playbook playbook.yml --become
```

## Complete Lab Steps

### Step 1: Create a New Directory

Create a new working directory named `ansible-lab-one` and move into it:

```bash
mkdir ansible-lab-one && cd ansible-lab-one
```

### Step 2: Create the index.html File

Create a new `index.html` file. This file is copied to the web server document root and becomes the home page of the Apache web server.

```bash
vi index.html
```

Add the following HTML content:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Accenture</title>
</head>
<body>
    <div style="text-align: center; margin:0 auto">
        <h1>Ansible for Configuration Management and Deployments - Vishnu</h1>
        <h3>- by LKM Delivery Team</h3>
    </div>
</body>
</html>
```

### Step 3: Create the Ansible Playbook File

Create a new playbook file named `playbook.yml`:

```bash
vi playbook.yml
```

### Step 4: Add Playbook Content

The playbook performs the same task that would otherwise be done manually. It includes:

1. Host section: specifies the target nodes where Apache will be installed.
2. Tasks section: defines the automation tasks.
3. Apache installation task.
4. File copy task for `index.html`.
5. Service task to start and enable Apache.

Add the following YAML content to `playbook.yml`:

```yaml
---
- name: Installing and Configuring Web Server on target node
  hosts:
    - target

  tasks:
    - name: Installing Apache Web Server
      yum:
        update_cache: yes
        name: httpd
        state: latest

    - name: Copying the index.html file
      copy:
        src: index.html
        dest: /var/www/html/

    - name: Start the service
      service:
        name: httpd
        state: started
        enabled: yes
```

### Step 5: Check Syntax

Use the `--syntax-check` option to verify that the playbook has no syntax errors:

```bash
ansible-playbook playbook.yml --syntax-check
```

### Step 6: Execute the Playbook

Run the playbook with root privileges using the `--become` option:

```bash
ansible-playbook playbook.yml --become
```

### Step 7: Verify the Web Server

After the playbook completes successfully, verify that the web server is running by opening a browser and entering the target node IP address:

```text
http://<target-node-ip>
```

The custom Apache web page should be displayed.

## Shell Script Usage

The provided shell script automates the file creation and playbook execution process.

Make the script executable:

```bash
chmod +x setup_ansible_webserver.sh
```

Run the script:

```bash
./setup_ansible_webserver.sh
```

## What the Shell Script Does

The shell script performs the following actions:

1. Creates the `ansible-lab-one` directory.
2. Moves into the lab directory.
3. Creates the `index.html` file.
4. Adds the HTML page content.
5. Creates the `playbook.yml` file.
6. Adds the Ansible playbook content.
7. Runs the syntax check command.
8. Runs the playbook with `--become`.
9. Displays a completion message.

## Playbook Explanation

### hosts

```yaml
hosts:
  - target
```

This tells Ansible to run the playbook on the inventory group named `target`.

### yum module

```yaml
yum:
  update_cache: yes
  name: httpd
  state: latest
```

This installs the latest available version of Apache HTTP Server using the `httpd` package.

### copy module

```yaml
copy:
  src: index.html
  dest: /var/www/html/
```

This copies the local `index.html` file to the Apache web server document root.

### service module

```yaml
service:
  name: httpd
  state: started
  enabled: yes
```

This starts the Apache service and enables it to start automatically after reboot.

## Notes

- If the inventory group name is different from `target`, update the `hosts` value in `playbook.yml`.
- If the target server uses `apt` instead of `yum`, update the package installation task accordingly.
- The `--become` option is required when the playbook needs administrative privileges.
- The web page is copied to `/var/www/html/`, which is the default Apache document root on many RPM-based Linux systems.

## End of Exercise

This completes the Ansible playbook activity for installing and configuring an Apache web server on a target node.

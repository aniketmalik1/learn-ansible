#!/usr/bin/env bash
set -euo pipefail

# Activity - Using Ansible Playbook
# This script creates the complete Ansible lab files and executes the playbook.
# It follows these lab points:
# 1. Create ansible directory.
# 2. Create index.html.
# 3. Create playbook.yml.
# 4. Add hosts section for target nodes.
# 5. Add tasks to install Apache, copy index.html, start service, and enable service.
# 6. Run syntax check.
# 7. Run playbook with --become.
# 8. Verify using target node IP address in browser.

LAB_DIR="ansible-lab-one"

printf '\nActivity  - Using Ansible Playbook\n'
printf 'Scenario: Install and configure Apache Web Server on target node using Ansible.\n\n'

printf 'Step 1: Creating new directory: %s\n' "$LAB_DIR"
mkdir -p "$LAB_DIR"
cd "$LAB_DIR"

printf 'Step 2: Creating index.html file for Apache home page...\n'
cat > index.html <<'HTML'
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
HTML

printf 'Step 3: Creating Ansible playbook file: playbook.yml\n'
cat > playbook.yml <<'YAML'
---
- name: Installing and Configuring Web Server on target node
  # Hosts Section
  hosts:
    - target

  # Tasks Section
  tasks:
    # Task 1: Installing Apache Web Server
    - name: Installing Apache Web Server
      yum:
        update_cache: yes
        name: httpd
        state: latest

    # Task 2: Copying the index.html file to Apache document root
    - name: Copying the index.html file
      copy:
        src: index.html
        dest: /var/www/html/

    # Task 3: Starting and enabling Apache service
    - name: Start the service
      service:
        name: httpd
        state: started
        enabled: yes
YAML

printf '\nCreated files:\n'
printf ' - %s/index.html\n' "$LAB_DIR"
printf ' - %s/playbook.yml\n' "$LAB_DIR"

printf '\nStep 4: Displaying common Ansible commands used in this activity:\n'
printf 'Run any playbook: ansible-playbook <your-playbook-file.yml>\n'
printf 'Check syntax: ansible-playbook <your-playbook-file.yml> --syntax-check\n'
printf 'Run with privilege escalation: ansible-playbook playbook.yml --become\n'

printf '\nStep 5: Running syntax check for playbook.yml...\n'
ansible-playbook playbook.yml --syntax-check

printf '\nStep 6: Executing playbook with root privileges using --become...\n'
ansible-playbook playbook.yml --become

printf '\nStep 7: Verification\n'
printf 'Open a browser and visit: http://<target-node-ip>\n'
printf 'Expected result: Custom Ansible web server page should be displayed.\n'

printf '\nEnd of Exercise.\n'

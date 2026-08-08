#!/usr/bin/env bash
set -euo pipefail

# Windows Server IIS Deployment using Ansible
# This helper script creates the recommended project structure.
# Run this script on the Ansible control node.

PROJECT_DIR="windows-ansible-iis"

printf 'Creating project directory: %s\n' "$PROJECT_DIR"
mkdir -p "$PROJECT_DIR/files" "$PROJECT_DIR/group_vars"
cd "$PROJECT_DIR"

printf 'Creating README.md...\n'
cat > README.md <<'README'
# Windows Server IIS Deployment using Ansible

This project installs and configures IIS on Windows Server using Ansible and WinRM.
README

printf 'Creating ansible.cfg...\n'
cat > ansible.cfg <<'CFG'
[defaults]
inventory = inventory.ini
host_key_checking = False
retry_files_enabled = False
timeout = 30
CFG

printf 'Creating inventory.ini...\n'
cat > inventory.ini <<'INV'
[windows]
winserver01 ansible_host=192.168.1.100

[windows:vars]
ansible_user=Administrator
ansible_password=Password@123
ansible_connection=winrm
ansible_port=5985
ansible_winrm_transport=basic
ansible_winrm_server_cert_validation=ignore
INV

printf 'Creating group_vars/windows.yml...\n'
cat > group_vars/windows.yml <<'VARS'
---
iis_root_path: 'C:\inetpub\wwwroot'
iis_service_name: W3SVC
iis_feature_name: Web-Server
iis_management_feature_name: Web-Mgmt-Console
firewall_rule_name: Ansible Allow HTTP 80
http_port: 80
website_title: Windows IIS Deployment using Ansible
environment_name: Lab
VARS

printf 'Creating files/index.html...\n'
cat > files/index.html <<'HTML'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Windows IIS Deployment using Ansible</title>
</head>
<body>
    <h1>Windows IIS Deployment using Ansible</h1>
    <h2>IIS Web Server is running successfully</h2>
    <p>This page was deployed automatically using Ansible and WinRM.</p>
</body>
</html>
HTML

printf 'Creating playbook.yml...\n'
cat > playbook.yml <<'PLAYBOOK'
---
- name: Install and Configure IIS on Windows Server
  hosts: windows
  gather_facts: yes

  vars_files:
    - group_vars/windows.yml

  tasks:
    - name: Install IIS Web Server
      ansible.windows.win_feature:
        name: "{{ iis_feature_name }}"
        state: present
        include_management_tools: yes

    - name: Install IIS Management Console
      ansible.windows.win_feature:
        name: "{{ iis_management_feature_name }}"
        state: present

    - name: Create IIS web root directory
      ansible.windows.win_file:
        path: "{{ iis_root_path }}"
        state: directory

    - name: Copy custom IIS homepage
      ansible.windows.win_copy:
        src: files/index.html
        dest: "{{ iis_root_path }}\\index.html"

    - name: Start IIS Service
      ansible.windows.win_service:
        name: "{{ iis_service_name }}"
        state: started

    - name: Set IIS Service startup type to automatic
      ansible.windows.win_service:
        name: "{{ iis_service_name }}"
        start_mode: auto

    - name: Open HTTP Firewall Port
      community.windows.win_firewall_rule:
        name: "{{ firewall_rule_name }}"
        localport: "{{ http_port }}"
        action: allow
        direction: in
        protocol: TCP
        state: present
        enabled: yes

    - name: Verify IIS website locally
      ansible.windows.win_uri:
        url: http://localhost
        method: GET
        return_content: yes
      register: iis_test

    - name: Display IIS verification result
      ansible.builtin.debug:
        msg: "IIS responded successfully. Status code: {{ iis_test.status_code }}"
PLAYBOOK

printf '\nProject created successfully.\n'
printf 'Next steps:\n'
printf '1. Update inventory.ini with your Windows Server IP and credentials.\n'
printf '2. Test connection: ansible windows -i inventory.ini -m win_ping\n'
printf '3. Check syntax: ansible-playbook -i inventory.ini playbook.yml --syntax-check\n'
printf '4. Run playbook: ansible-playbook -i inventory.ini playbook.yml\n'

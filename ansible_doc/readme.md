# Ansible Learning Guide

## What is Ansible?
Ansible is an open source automation tool used for configuration management, application deployment, infrastructure provisioning, and task automation across multiple systems.

### Key Features
- **Agentless**: Uses SSH (Linux) or WinRM (Windows); no agent required on target machines.
- **Declarative**: Uses YAML playbooks to define the desired state.
- **Idempotent**: Running the same playbook multiple times results in the same system state.
- **Inventory Management**: Supports static and dynamic inventories.
- **Extensible**: Includes hundreds of built-in modules.
- **Secure**: Supports SSH and Ansible Vault for encrypted secrets.

## Ansible Architecture

### Control Node
The machine where Ansible is installed and playbooks are executed.

### Managed Nodes
Target servers, workstations, network devices, or cloud instances managed by Ansible.

### Inventory
An inventory defines the hosts managed by Ansible.

Example:
```ini
[webservers]
172.16.252.01
172.16.252.02
```

### Playbooks
Playbooks are YAML files that define automation tasks.

Example:
```yaml
---
- hosts: webservers
  tasks:
    - name: Install Nginx
      yum:
        name: nginx
        state: present
```

## Modules
Modules perform specific tasks.

Common module categories:
- System
- Cloud
- Network
- Files
- Custom

## Plugins
Plugins extend Ansible functionality.

Types:
- Connection Plugins
- Action Plugins
- Callback Plugins
- Lookup Plugins
- Filter Plugins

## Ad-Hoc Commands
Run one-time tasks without creating a playbook.

Syntax:
```bash
ansible <host-pattern> -m <module> -a "<arguments>" -i <inventory>
```

Examples:
```bash
ansible all -m ping -i inventory.ini
ansible webservers -m shell -a "df -h" -i inventory.ini
```

## YAML Basics
YAML is a human-readable configuration language used heavily in Ansible.

Example:
```yaml
---
- name: Install Apache
  hosts: webservers
  tasks:
    - name: Install package
      yum:
        name: httpd
        state: present
```

## Playbook Components
- name
- hosts
- vars
- vars_prompt
- tasks
- roles
- handlers
- become
- become_user
- gather_facts
- check_mode
- ignore_errors
- module_defaults
- remote_user
- serial
- tags

## Variables
Variables make playbooks reusable and easier to maintain.

Example:
```yaml
vars:
  package_name: httpd
```

Runtime variable:
```bash
ansible-playbook site.yml -e "package_name=nginx"
```

## Testing Strategies

### Syntax Check
```bash
ansible-playbook playbook.yml --syntax-check
```

### Dry Run (Check Mode)
```bash
ansible-playbook playbook.yml --check
```

### Diff Mode
```bash
ansible-playbook playbook.yml --diff
```

### Assert Validation
```yaml
- assert:
    that:
      - ansible_os_family == 'RedHat'
```

## Debugging

Temporary:
```bash
export ANSIBLE_ENABLE_TASK_DEBUGGER=true
```

Configuration:
```ini
[defaults]
enable_task_debugger=true
```

Debug modes:
- always
- on_failed
- never

## Sanity Testing
Useful tools:

```bash
ansible-playbook playbook.yml --syntax-check
ansible-lint
ansible-test sanity
```

Checks include:
- YAML validation
- Python import checks
- Deprecated APIs
- Documentation formatting
- Code style compliance

## Best Practices
- Keep playbooks simple and modular.
- Use meaningful task names.
- Reuse roles whenever possible.
- Avoid exposing sensitive data.
- Use Ansible Vault for secrets.
- Prefer templates over manual file edits.
- Write small, maintainable playbooks.
- Use comments where appropriate.

## Sample Playbook
```yaml
---
- name: Setup Apache Web Server
  hosts: webservers
  become: yes

  tasks:
    - name: Ensure Apache is installed
      yum:
        name: httpd
        state: present
```

## Learning Path
1. Learn YAML basics.
2. Understand inventory files.
3. Practice ad-hoc commands.
4. Create simple playbooks.
5. Learn variables and handlers.
6. Work with roles.
7. Explore Ansible Vault.
8. Apply testing and debugging techniques.
9. Automate real infrastructure tasks.

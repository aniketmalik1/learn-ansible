# Windows Server IIS Deployment using Ansible

## Project Description

This project demonstrates how to use Ansible to automate Microsoft Windows Server configuration through WinRM. The playbook installs IIS, deploys a custom web page, starts and enables the IIS service, opens the Windows Firewall HTTP port, and verifies that the IIS website is responding.

This project is designed for a GitHub repository, lab practice, interview demonstration, and basic enterprise-style Windows automation.

## What This Project Deploys

- Windows IIS Web Server
- IIS Management Console
- Custom `index.html` page
- HTTP firewall rule on port 80
- IIS service startup configuration
- Local website verification using Ansible

## Recommended Project Structure

```text
windows-ansible-iis/
|
|-- README.md
|-- ansible.cfg
|-- inventory.ini
|-- playbook.yml
|-- setup_windows_iis.sh
|
|-- group_vars/
|   |-- windows.yml
|
|-- files/
    |-- index.html
```

## File Purpose

| File | Purpose |
|---|---|
| `README.md` | Full project documentation and usage instructions |
| `ansible.cfg` | Ansible configuration file for inventory and connection defaults |
| `inventory.ini` | Windows server connection inventory using WinRM |
| `group_vars/windows.yml` | Common variables for Windows IIS deployment |
| `files/index.html` | Custom IIS web page content |
| `playbook.yml` | Main Ansible automation playbook |
| `setup_windows_iis.sh` | Helper script to create the project structure and sample files |

## Prerequisites

### 1. Ansible Control Node

Ansible normally runs from a Linux control node, WSL, or an automation server. The control node should have:

- Python installed
- Ansible installed
- WinRM Python package installed

Example installation command:

```bash
pip install pywinrm
```

### 2. Windows Server Requirements

The Windows Server should have:

- Administrator account access
- Network connectivity from the Ansible control node
- WinRM enabled
- Firewall allowing WinRM port `5985` for HTTP or `5986` for HTTPS

## Enable WinRM on Windows Server

Run PowerShell as Administrator on the Windows Server:

```powershell
Enable-PSRemoting -Force
winrm quickconfig
Set-Item WSMan:\localhost\Service\AllowUnencrypted -Value $true
Set-Item WSMan:\localhost\Service\Auth\Basic -Value $true
Restart-Service WinRM
```

> Lab note: Basic authentication and unencrypted WinRM are commonly used in simple labs only. For production, use HTTPS WinRM and a secure credential method.

## Example Inventory

Update `inventory.ini` with your Windows Server IP address and credentials.

```ini
[windows]
winserver01 ansible_host=192.168.1.100

[windows:vars]
ansible_user=Administrator
ansible_password=Password@123
ansible_connection=winrm
ansible_port=5985
ansible_winrm_transport=basic
ansible_winrm_server_cert_validation=ignore
```

## Example Variables

The `group_vars/windows.yml` file stores reusable values:

```yaml
iis_root_path: 'C:\inetpub\wwwroot'
iis_service_name: W3SVC
iis_feature_name: Web-Server
iis_management_feature_name: Web-Mgmt-Console
firewall_rule_name: Ansible Allow HTTP 80
http_port: 80
website_title: Windows IIS Deployment using Ansible
environment_name: Lab
```

## Playbook Tasks

The Ansible playbook performs the following tasks:

1. Install IIS Web Server.
2. Install IIS Management Console.
3. Create the IIS web root directory.
4. Copy the custom `index.html` page.
5. Start the IIS service.
6. Set the IIS service startup type to automatic.
7. Open Windows Firewall port 80.
8. Verify the IIS website from the Windows Server.
9. Display website verification output.

## Connectivity Test

Before running the main playbook, test WinRM connectivity:

```bash
ansible windows -i inventory.ini -m win_ping
```

Expected result:

```json
{
    "ping": "pong"
}
```

## Syntax Check

Use this command to validate the playbook syntax:

```bash
ansible-playbook -i inventory.ini playbook.yml --syntax-check
```

## Dry Run

Use check mode before making changes:

```bash
ansible-playbook -i inventory.ini playbook.yml --check
```

## Execute Playbook

Run the playbook:

```bash
ansible-playbook -i inventory.ini playbook.yml
```

## Verbose Execution

For troubleshooting, run with detailed logs:

```bash
ansible-playbook -i inventory.ini playbook.yml -vvv
```

## Verify IIS Website

After successful execution, open the Windows Server IP in a browser:

```text
http://<windows-server-ip>
```

Example:

```text
http://192.168.1.100
```

You should see the custom IIS homepage created by Ansible.

## Example Output

Possible successful output from the playbook:

```text
TASK [Install IIS Web Server] changed
TASK [Copy custom IIS homepage] changed
TASK [Start IIS Service] ok
TASK [Open HTTP Firewall Port] changed
TASK [Verify IIS Website] ok
```

## Troubleshooting

### WinRM Connection Failed

Check WinRM service on Windows Server:

```powershell
Get-Service WinRM
```

Start WinRM if needed:

```powershell
Start-Service WinRM
```

### Authentication Failed

Verify these values in `inventory.ini`:

```ini
ansible_user=Administrator
ansible_password=Password@123
ansible_winrm_transport=basic
```

### IIS Website Not Opening

Check the IIS service:

```powershell
Get-Service W3SVC
```

Check firewall rule:

```powershell
Get-NetFirewallRule | Where-Object DisplayName -Like '*HTTP*'
```

### Wrong Server IP

Update this line in `inventory.ini`:

```ini
winserver01 ansible_host=192.168.1.100
```

Replace the sample IP with your actual Windows Server IP.

## Security Notes

- Do not commit real administrator passwords to GitHub.
- Use Ansible Vault for credentials in real environments.
- Prefer WinRM over HTTPS on port `5986` for production.
- Restrict firewall access to trusted Ansible control nodes.

## GitHub Repository Description

```text
Windows Server IIS automation using Ansible and WinRM. This project installs IIS, deploys a custom homepage, configures services, opens firewall port 80, and verifies the website through Ansible automation.
```

## End Result

At the end of this lab, IIS will be installed and running on the Windows Server, and a custom web page will be available through the server IP address.

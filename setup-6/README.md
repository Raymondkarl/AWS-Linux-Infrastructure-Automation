# PHASE 14 — SSH HARDENING

#### NOTE:
#### AWS Ubuntu images already use secure default SSH settings,
#### including disabled password authentication and SSH key-based access.
#### This step is mainly for verification and manual hardening practice.

# Edit SSH configuration
```bash
sudo vim /etc/ssh/sshd_config
```
```bash
sudo vim /etc/ssh/sshd_config.d/60-cloudimg-settings.conf
```

#### Set:
#### Disable root login
#### Disable password authentication
#### Enable SSH key authentication

```bash
PermitRootLogin no
PasswordAuthentication no
PubkeyAuthentication yes
```

# Restart SSH service
```bash
sudo systemctl restart ssh
```








# ==================================================
# PHASE 15 — USER-BASED SSH AUTHENTICATION SETUP

## Scenario

A new junior cloud engineer needs SSH access to the EC2 server.

> Do NOT share the original AWS `.pem` key.  
> Instead, create a Linux user and configure a separate SSH key pair.

---

# STEP 1 — Generate SSH Key Pair (Junior Engineer Laptop) 

Generate SSH key pair locally:

```bash
ssh-keygen -t ed25519
```

Optional: Specify a custom key filename for better organization.

Example:

```text
Enter file in which to save the key:
/home/linuxserver/.ssh/aws-devops-key
```

Generated files:

```text
Private Key  -> ~/.ssh/aws-devops-key
Public Key   -> ~/.ssh/aws-devops-key.pub
```

View public key:

```bash
cat ~/.ssh/aws-devops-key.pub
```

Example output:

```text
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIxxxxx raymond@laptop
```

> NOTE:
>
> - Only share the **PUBLIC** key with the server administrator.
> - Never share the private key.

Common real-world methods for sharing the PUBLIC key:
- Slack
- Microsoft Teams
- Jira ticket
- Email
- Internal onboarding portal

---

# STEP 2 — Create Linux User (EC2 Server)

Create Linux user:

```bash
sudo adduser raymond
```

Add user to sudo group if admin access is required:

```bash
sudo usermod -aG sudo raymond
```

---

# STEP 3 — Configure SSH Access

Create `.ssh` directory:    

```bash
sudo mkdir -p /home/raymond/.ssh   # use ls -la to see the .ssh because it a hidden file (anything with .)
```

Create `authorized_keys` file:

```bash
sudo touch /home/raymond/.ssh/authorized_keys
```

Add the engineer's PUBLIC key:

```bash
sudo vim /home/raymond/.ssh/authorized_keys
```

Paste the public key:

```text
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIxxxxx raymond@laptop
```

Save and exit in Vim:

```vim
:wq!
```

---

# STEP 4 — Set Correct Permissions

```bash
sudo chown -R raymond:raymond /home/raymond/.ssh         # Change ownership of the .ssh directory and files to the raymond user
sudo chmod 755 /home/raymond                             # Set proper permissions for the user's home directory
sudo chmod 700 /home/raymond/.ssh                        # Allow only the owner to access the .ssh directory
sudo chmod 600 /home/raymond/.ssh/authorized_keys        # Restrict authorized_keys file access to the owner only
```

---

# STEP 5 — Test SSH Login

Set correct permission for the private key locally:

```bash
chmod 600 ~/.ssh/aws-devops-key
```

Connect to the EC2 server:

```bash
ssh -i ~/.ssh/aws-devops-key raymond@YOUR_PUBLIC_IP
```

---

# COMMON SSH TROUBLESHOOTING

Most SSH authentication issues are caused by:

- Wrong public/private key pair
- Incorrect file permissions
- Wrong ownership
- Incorrect `authorized_keys` location
- Typo or broken SSH public key

Useful troubleshooting command:

```bash
ssh -vvv -i ~/.ssh/aws-devops-key raymond@YOUR_PUBLIC_IP
```

---

# REAL-WORLD INDUSTRY NOTES

Benefits of per-user SSH key authentication:

- No shared `.pem` files
- Per-user accountability
- Easier access revocation
- More secure and scalable
- Standard Linux/Cloud industry practice

If an engineer leaves the company:
- Remove the user's public key
- Disable or delete the Linux user

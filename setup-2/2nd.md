# Install Terraform (Ubuntu)
```bash
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```

# Setup your AWS Account
### 1. Go to IAM
### 2. Create a user
### 3. Enable: ✅ Programmatic access
### 4. Attach permissions
For practice: AdministratorAccess
### 5. Create the user
Copy:
Access Key ID
Secret Access Key

# Install AWS CLI

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```
# Login to your AWS CLI
```bash
# Configure AWS CLI
aws configure

# Check AWS identity
aws sts get-caller-identity

# Check list of EC@ Instance 
aws ec2 describe-instances

# Check list of S3 buckets
aws ec2 describe-instances
```

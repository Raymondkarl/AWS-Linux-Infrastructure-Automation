# Step 5
1. ssh to your EC2 Instance then update the linux server
```bash
sudo apt update & sudo apt upgrade -y
```
2. Install Docker

A. Set up Docker's apt repository.

```bash
vim docker.sh
```
```bash
# Add Docker's official GPG key:
sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update
```
```bash
./docker.sh
```
B. Install the Docker packages.
```bash
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```
C. After installation, verify that Docker is running:
```bash
sudo systemctl status docker
# if not
sudo systemctl start docker
```
D. Verify that the installation is successful by running the hello-world image
```bash
sudo docker run hello-world
```


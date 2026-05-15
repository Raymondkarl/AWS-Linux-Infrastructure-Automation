# PHASE 17 — BUILD AND RUN STATIC WEBSITE CONTAINER

## Purpose
Deploy a simple static website inside a Docker container using the official lightweight Nginx image.

---

## Go to the Static Website Directory

```bash
cd static-website/
```

This directory should contain:

- `Dockerfile`
- `index.html`

---

## Verify Required Files

```bash
ls
```

Expected output:

```txt
Dockerfile
index.html
```

Docker requires these files in the current directory during the image build process.

---

## Build Docker Image

```bash
docker build -t raymond/html-static-app:v1 .
```

### Explanation

| Command Part | Description |
|---|---|
| `docker build` | Build a Docker image |
| `-t` | Assign image name/tag |
| `raymond/html-static-app` | Repository/Image name |
| `v1` | Version tag |
| `.` | Current directory as Docker build context |

---

## Verify Docker Image

```bash
docker images
```

Expected image:

```txt
raymond/html-static-app   v1
```

---

## Run Docker Container

```bash
docker run -d --name static-website -p 8080:80 raymond/html-static-app:v1
```

### Explanation

| Command Part | Description |
|---|---|
| `-d` | Run container in background (detached mode) |
| `--name static-website` | Assign container name |
| `-p 8080:80` | Map EC2 host port 8080 to container port 80 |
| `raymond/html-static-app:v1` | Docker image to run |

### Traffic Flow

```txt
EC2 Port 8080 → Docker Container Port 80
```

---

## Verify Running Container

```bash
docker ps
```

---

## Test Website Locally Inside EC2

```bash
curl localhost:8080
```

---

## View Container Logs

```bash
docker logs static-website
```

---

## Stop Container

```bash
docker stop static-website
```

---

## Remove Container

```bash
docker rm static-website
```

---

# PHASE 18 — CONFIGURE NGINX REVERSE PROXY

## Purpose
Configure host Nginx to forward incoming public HTTP traffic to the Docker container running the static website.

---

## Final Traffic Flow

```txt
User Browser
      ↓
EC2 Public IP:80
      ↓
Host Nginx Reverse Proxy
      ↓
Docker Container:8080
      ↓
Static Website
```

---

## Verify Docker Container is Running

```bash
docker ps
```

Expected:

```txt
static-website container is running
0.0.0.0:8080->80/tcp
```

---

## Remove Default Nginx Configuration

```bash
sudo rm /etc/nginx/sites-enabled/default
```

### Why Remove the Default Config?

Ubuntu Nginx automatically enables a default website configuration located at:

```txt
/etc/nginx/sites-enabled/default
```

If the default configuration remains enabled while using a custom reverse proxy configuration, it may cause:

- Default Nginx welcome page to appear
- Configuration conflicts
- Incorrect site routing

Removing the default config ensures that only the custom reverse proxy configuration is active.

---

## Create Custom Reverse Proxy Configuration

```bash
sudo vim /etc/nginx/sites-available/static-website
```

Paste the following configuration:

```nginx
server {

    listen 80; # Listen for incoming HTTP traffic on port 80

    server_name _; # Accept requests from any hostname/domain

    location / { # Handle requests to the root URL "/"

        proxy_pass http://localhost:8080; # Forward traffic to Docker container running on port 8080

        proxy_set_header Host $host; # Pass original hostname from client request

        proxy_set_header X-Real-IP $remote_addr; # Pass real client IP address to backend container

        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for; # Forward full client IP chain

        proxy_set_header X-Forwarded-Proto $scheme; # Forward original request protocol (HTTP/HTTPS)
    }
}
```

---

## Enable the Custom Site Configuration

```bash
sudo ln -s /etc/nginx/sites-available/static-website /etc/nginx/sites-enabled/
```

This creates a symbolic link from:

```txt
sites-available → sites-enabled
```

which activates the configuration.

---

## Test Nginx Configuration

```bash
sudo nginx -t
```

---

## Restart Nginx Service

```bash
sudo systemctl restart nginx
```

---

## Verify Nginx Status

```bash
sudo systemctl status nginx
```

---

## Test Locally Inside EC2

```bash
curl localhost
```

---

## Open Website in Browser

```txt
http://YOUR_EC2_PUBLIC_IP
```

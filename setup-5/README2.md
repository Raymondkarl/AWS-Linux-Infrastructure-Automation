
# PHASE 16 — INSTALL AND VERIFY NGINX WEB SERVER

## Update Package Repository

```bash
sudo apt update
```

---

## Install NGINX

```bash
sudo apt install nginx -y
```

---

## Verify NGINX Service Status

```bash
sudo systemctl status nginx
```

---

## Enable NGINX to Start Automatically on Boot

```bash
sudo systemctl enable nginx
```

---

## Start NGINX Service

```bash
sudo systemctl start nginx
```

---

# CONFIGURE AWS SECURITY GROUP

Add an inbound rule to allow HTTP traffic:

| Type | Protocol | Port Range | Source |
|---|---|---|---|
| HTTP | TCP | 80 | 0.0.0.0/0 |

---

# TEST WEB SERVER

Open browser:

```text
http://YOUR_EC2_PUBLIC_IP
```

Expected result:

```text
Default NGINX welcome page should appear
```

# PHASE 19 — SERVER HEALTH CHECK SCRIPT

## Purpose
Create a Bash script to monitor basic Linux server health information such as uptime, disk usage, memory usage, and system load.

---

## Create Script

```bash
sudo vim /usr/local/bin/server-health-check.sh
```

Paste:

```bash
#!/bin/bash

echo "===== Server Health Check ====="
echo "Date: $(date)"
echo "Hostname: $(hostname)"
echo "Uptime: $(uptime -p)"
echo ""

echo "Disk Usage:"
df -h /
echo ""

echo "Memory Usage:"
free -h
echo ""

echo "Load Average:"
uptime

echo "==============================="
```

---

## Make Script Executable

```bash
sudo chmod +x /usr/local/bin/server-health-check.sh
```

---

## Test Script

```bash
/usr/local/bin/server-health-check.sh
```

---

# PHASE 20 — SERVICE CHECK SCRIPT

## Purpose
Monitor critical Linux services and automatically restart them if they stop running.

Services monitored:
- Nginx
- Docker

---

## Create Script

```bash
sudo vim /usr/local/bin/service-check.sh
```

Paste:

```bash
#!/bin/bash

LOG_FILE="/var/log/service-check.log"

for SERVICE in nginx docker; do

    if systemctl is-active --quiet $SERVICE; then

        echo "$(date): $SERVICE is running" >> $LOG_FILE

    else

        echo "$(date): $SERVICE is not running. Restarting..." >> $LOG_FILE

        systemctl restart $SERVICE

    fi

done
```

---

## Make Script Executable

```bash
sudo chmod +x /usr/local/bin/service-check.sh
```

---

## Test Script

```bash
sudo /usr/local/bin/service-check.sh
```

---

## View Logs

```bash
sudo cat /var/log/service-check.log
```

---

# PHASE 21 — DISK USAGE ALERT SCRIPT

## Purpose
Monitor Linux disk usage and log a warning if disk utilization exceeds the defined threshold.

---

## Create Script

```bash
sudo vim /usr/local/bin/disk-usage-alert.sh
```

Paste:

```bash
#!/bin/bash

THRESHOLD=80

USAGE=$(df -h / | awk 'NR==2 {gsub("%",""); print $5}')

LOG_FILE="/var/log/disk-alert.log"

if [ "$USAGE" -ge "$THRESHOLD" ]; then

    echo "$(date): WARNING - Disk usage is at ${USAGE}%" >> $LOG_FILE

else

    echo "$(date): Disk usage is normal at ${USAGE}%" >> $LOG_FILE

fi
```

---

## Make Script Executable

```bash
sudo chmod +x /usr/local/bin/disk-usage-alert.sh
```

---

## Test Script

```bash
sudo /usr/local/bin/disk-usage-alert.sh
```

---

## View Logs

```bash
sudo cat /var/log/disk-alert.log
```

---

# PHASE 22 — SSH FAILED LOGIN MONITORING SCRIPT

## Purpose
Monitor failed SSH login attempts by checking Linux authentication logs.

This helps identify:
- brute-force attempts
- unauthorized access attempts
- suspicious SSH activity

---

## Create Script

```bash
sudo vim /usr/local/bin/ssh-failed-login-monitor.sh
```

Paste:

```bash
#!/bin/bash

LOG_FILE="/var/log/auth.log"

OUTPUT_FILE="/var/log/ssh-failed-login.log"

echo "===== SSH Failed Login Report =====" >> $OUTPUT_FILE

echo "Date: $(date)" >> $OUTPUT_FILE

echo "Hostname: $(hostname)" >> $OUTPUT_FILE

echo "" >> $OUTPUT_FILE

echo "Recent Failed SSH Login Attempts:" >> $OUTPUT_FILE

grep "Failed password" $LOG_FILE | tail -10 >> $OUTPUT_FILE

echo "" >> $OUTPUT_FILE

echo "===================================" >> $OUTPUT_FILE

echo "" >> $OUTPUT_FILE
```

---

## Make Script Executable

```bash
sudo chmod +x /usr/local/bin/ssh-failed-login-monitor.sh
```

---

## Test Script

```bash
sudo /usr/local/bin/ssh-failed-login-monitor.sh
```

---

## View Logs

```bash
sudo cat /var/log/ssh-failed-login.log
```

---

# PHASE 23 — CRON JOB AUTOMATION

## Purpose
Automate Linux monitoring and maintenance scripts using Cron Jobs.

---

## Edit Root Crontab

```bash
sudo crontab -e
```

Add the following entries:

```cron
# Hourly server health check
0 * * * * /usr/local/bin/server-health-check.sh >> /var/log/server-health.log

# Service check every 10 minutes
*/10 * * * * /usr/local/bin/service-check.sh

# Disk usage check every 30 minutes
*/30 * * * * /usr/local/bin/disk-usage-alert.sh

# SSH failed login monitoring every 15 minutes
*/15 * * * * /usr/local/bin/ssh-failed-login-monitor.sh
```

---

## Verify Cron Jobs

```bash
sudo crontab -l
```

---

# Final Automation Flow

```txt
Cron Jobs
    ↓
Execute Bash Monitoring Scripts
    ↓
Monitor Linux Services, Disk Usage, and SSH Activity
    ↓
Store Logs in /var/log
```

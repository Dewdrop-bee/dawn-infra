#!/bin/bash
echo "---- Server Performance Stats ----"

# CPU Usage
echo "Total CPU Usage:"
top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}'

# Memory Usage
echo "Total Memory Usage:"
free -m | awk 'NR==2{printf "Used: %sMB, Free: %sMB (%.2f%%)\n", $3, $4, $3*100/$2 }'

# Disk Usage
echo "Total Disk Usage:"
df -h --total | awk '$1 == "total" {printf "Used: %s, Free: %s (%.2f%%)\n", $3, $4, $5}'

# Top 5 Processes by CPU Usage
echo "Top 5 Processes by CPU Usage:"
ps aux --sort=-%cpu | head -n 6 | awk '{print $1, $2, $3, $11}'

# Top 5 Processes by Memory Usage
echo "Top 5 Processes by Memory Usage:"
ps aux --sort=-%mem | head -n 6 | awk '{print $1, $2, $4, $11}'

# Optional: Additional Stats
echo "System Information:"
echo "OS Version: $(lsb_release -d | awk -F'\t' '{print $2}')"
echo "Uptime: $(uptime -p)"
echo "Load Average: $(uptime | awk -F'load average:' '{ print $2 }')"
echo "Logged In Users:"
who
echo "Failed Login Attempts:"
grep "Failed password" /var/log/auth.log | wc -l

echo "---- End of Stats ----"

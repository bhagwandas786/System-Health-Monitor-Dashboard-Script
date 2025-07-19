# System-Health-Monitor-Dashboard-Script
A real-time terminal-based dashboard built in Bash to monitor CPU, memory, disk, and network usage with color-coded bars and alert logging.

## 🚀 Features

- 🔄 Refreshes every 3 seconds (configurable)
- 📊 Displays:
  - CPU usage with top processes
  - Memory usage with free/cache/buffers
  - Disk usage of `/`, `/var/log`, and `/home`
  - Network in/out on `eth0`
  - System load average
- 🎨 ASCII bar graphs with color coding:
  - Green = Normal
  - Yellow = Warning
  - Red = Critical
- 📝 Logs alerts to `alerts.log` if CPU > 80%, Memory > 75%, Disk > 75%
- ⌨️ Keyboard interaction:
  - Press `q` to quit

---

## 🛠️ Requirements

- Linux-based system (Ubuntu/Debian)
- Bash shell
- Permissions to read `/sys/class/net/eth0/statistics`

---

## 📂 How to Run

```bash
chmod +x simple_monitor.sh
./simple_monitor.sh

##OUTPUT##

╔════════════ SYSTEM HEALTH MONITOR v1.0 ════════════╗  [R]efresh rate: 3s
║ Hostname: Bunny-Tiger         Date: 2025-07-20 ║  [F]ilter: All
║ Uptime: up 54 minutes                         ║  [Q]uit
╚═══════════════════════════════════════════════════════════════════════╝
CPU USAGE: 1% █░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
  Process: System-Health-M  0.7,containerd       0.2 dockerd          0.0
MEMORY: 488MB/7848MB (6%) ███░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
  Free: 7337MB | Cache: 171MB

DISK USAGE:
  / : 1% █░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
  /var/log : 1% █░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
  /home : 1% █░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

NETWORK:
  eth0 (in) : 0 MB/s █░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
  eth0 (out): 0 MB/s █░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

LOAD AVERAGE:  0.08, 0.05, 0.01


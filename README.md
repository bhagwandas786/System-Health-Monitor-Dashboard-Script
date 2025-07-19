# System-Health-Monitor-Dashboard-Script
A real-time terminal-based dashboard built in Bash to monitor CPU, memory, disk, and network usage with color-coded bars and alert logging.

# 🖥️ System Health Monitor Dashboard (v1.0)

This is a simple **interactive Bash script** that shows a **real-time dashboard** for monitoring system health directly in your terminal. It uses ASCII bars, color indicators, and logs alerts when system metrics cross defined thresholds.

---

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

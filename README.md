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
<img width="945" height="515" alt="Screenshot 2025-07-20 043552" src="https://github.com/user-attachments/assets/e9d61727-1923-4496-9f7b-03db867f0e19" />


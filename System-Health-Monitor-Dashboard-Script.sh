#!/bin/bash

##==[ System Health Monitor v1.0 - Simplified Version ]==##

LOGFILE="./alerts.log"
REFRESH=3

##==[ Define Terminal Colors ]==##
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No color

##==[ Function: Get Color Based on % Value ]==##
get_color() {
  local val=$1
  if [ $val -lt 60 ]; then echo "$GREEN"
  elif [ $val -lt 80 ]; then echo "$YELLOW"
  else echo "$RED"
  fi
}

##==[ Function: Draw ASCII Bar ]==##
draw_bar() {
  local percent=$1
  local color=$(get_color $percent)
  local bars=$((percent / 2))
  local bar=$(printf '█%.0s' $(seq 1 $bars))
  local empty=$((50 - bars))
  bar+=$(printf '░%.0s' $(seq 1 $empty))
  echo -e "${color}${bar}${NC}"
}

##==[ Function: Log Alerts to alerts.log ]==##
log_alert() {
  echo "[$(date +%H:%M:%S)] $1" >> $LOGFILE
}

##==[ Main Loop: Refresh Dashboard ]==##
while true; do
  clear

  ##==[ System Info Header ]==##
  HOST=$(hostname)
  DATE=$(date '+%Y-%m-%d')
  TIME=$(date '+%H:%M:%S')
  UPTIME=$(uptime -p)

  echo -e "╔════════════ SYSTEM HEALTH MONITOR v1.0 ════════════╗  [R]efresh rate: ${REFRESH}s"
  echo -e "║ Hostname: $HOST\t\tDate: $DATE ║  [F]ilter: All"
  echo -e "║ Uptime: $UPTIME\t\t\t\t║  [Q]uit"
  echo -e "╚═══════════════════════════════════════════════════════════════════════╝"

  ##==[ CPU Usage Section ]==##
  CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
  CPU_INT=${CPU%.*}
  echo -n "CPU USAGE: $CPU_INT% "
  draw_bar $CPU_INT
  TOPPROC=$(ps -eo comm,%cpu --sort=-%cpu | head -n 4 | tail -n 3 | paste -sd ", " -)
  echo "  Process: $TOPPROC"
  [ $CPU_INT -ge 80 ] && log_alert "CPU usage exceeded 80% ($CPU_INT%)"

  ##==[ Memory Usage Section ]==##
  MEM=$(free -m)
  MEM_TOTAL=$(echo "$MEM" | awk '/Mem:/ {print $2}')
  MEM_USED=$(echo "$MEM" | awk '/Mem:/ {print $3}')
  MEM_PERCENT=$((100 * MEM_USED / MEM_TOTAL))
  echo -n "MEMORY: ${MEM_USED}MB/${MEM_TOTAL}MB (${MEM_PERCENT}%) "
  draw_bar $MEM_PERCENT
  echo "  Free: $(echo "$MEM" | awk '/Mem:/ {print $4}')MB | Cache: $(echo "$MEM" | awk '/Mem:/ {print $6}')MB"
  [ $MEM_PERCENT -ge 75 ] && log_alert "Memory usage exceeded 75% (${MEM_PERCENT}%)"

  ##==[ Disk Usage Section ]==##
  echo -e "\nDISK USAGE:"
  for mount in / /var/log /home; do
    if df -h "$mount" &>/dev/null; then
      USAGE=$(df -h "$mount" | awk 'NR==2 {print $5}' | tr -d '%')
      echo -n "  $mount : $USAGE% "
      draw_bar $USAGE
      [ $USAGE -ge 75 ] && log_alert "Disk usage on $mount exceeded 75% (${USAGE}%)"
    fi
  done

  ##==[ Network Usage Section ]==##
  RX1=$(cat /sys/class/net/eth0/statistics/rx_bytes)
  TX1=$(cat /sys/class/net/eth0/statistics/tx_bytes)
  sleep 1
  RX2=$(cat /sys/class/net/eth0/statistics/rx_bytes)
  TX2=$(cat /sys/class/net/eth0/statistics/tx_bytes)
  RX_MB=$(( (RX2 - RX1) / 1024 / 1024 ))
  TX_MB=$(( (TX2 - TX1) / 1024 / 1024 ))
  echo -e "\nNETWORK:"
  echo -n "  eth0 (in) : ${RX_MB} MB/s "; draw_bar $((RX_MB * 5))
  echo -n "  eth0 (out): ${TX_MB} MB/s "; draw_bar $((TX_MB * 5))

  ##==[ Load Average Section ]==##
  echo -e "\nLOAD AVERAGE: $(uptime | awk -F'load average:' '{print $2}')"

  ##==[ Display Last 3 Alerts ]==##
  echo -e "\nRECENT ALERTS:"
  tail -n 3 "$LOGFILE" 2>/dev/null || echo "  No alerts yet"

  ##==[ Keyboard Control - Quit or Wait ]==##
  echo -e "\nPress 'q'=quit, or wait ${REFRESH}s..."
  read -t $REFRESH -n 1 key
  [ "$key" = "q" ] && break
done

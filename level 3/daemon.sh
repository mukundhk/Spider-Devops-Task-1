#!/bin/bash

monitor_info() {
echo "==============================
COMPUTER LOG
==============================
" > comp_log.txt

echo "Uptime:
$(uptime)
" >> comp_log.txt

echo "Disk and memory usage:
$(df -h)

$(free -h)
" >> comp_log.txt

echo "Utilization and most expensive processes:
$(top -b -n 1 | head -15)
" >> comp_log.txt

echo "Open TCP ports:
$(netstat -tulpn | grep LISTEN)
" >> comp_log.txt

echo "Current connections:
$(netstat -natp)
" >> comp_log.txt

echo "Processes:
$(ps aux)
" >> comp_log.txt

echo "=============================
" >> comp_log.txt
}

kill_processes() {
    processes=$(ps -eo pid,%cpu --sort=-%cpu | awk '$2 > 60 {print $1}')

    echo "$(date): Killing processes consuming more than 60% CPU usage" >> process_log.txt

    for pid in $processes; do
        process_info=$(ps -p $pid -o pid,ppid,%cpu,%mem,cmd)
        echo "$(date): $process_info" >> process_log.txt
        kill -9 $pid
    done
}

# Create the cronjob to run monitor_info() at 6 PM every day
(crontab -l 2>/dev/null; echo "0 18 * * * $(pwd)/monitor_info") | crontab -

# Turn the script into a daemon
nohup bash -c '
    # Create an infinite loop for the daemon to continue running
    while true; 
    do
        # Call the function to kill processes consuming more than 60% CPU
        kill_processes
        # Sleep for 60 seconds before checking again
        sleep 60
    done
' </dev/null >/dev/null 2>&1 &

echo "Daemon has been started. You can close the terminal. PID: $!"
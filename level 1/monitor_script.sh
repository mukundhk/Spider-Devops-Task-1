#!/bin/bash

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
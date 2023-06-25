#!/bin/bash

# Create the system information report
echo "========================
      SYSTEM INFO
========================
Desktop processor: $(uname -p)
System Kernel: $(uname -r)
Operating system version: $(lsb_release -d | awk -F"\t" '{print $2}')
Desktop memory: $(free -h | awk '/Mem:/ {print $2}')
Serial number: $(sudo dmidecode -s system-serial-number)
System IP: $(hostname -I)
-------------------------
Installed software:

$(apt list --installed | cut -d'/' -f1 | uniq)
" > system_info.txt

echo "System information has been saved to system_info.txt."
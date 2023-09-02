#!/bin/bash

# The output directory and file name for storing the data
OUTPUT_DIR="./metrics/files"
OUTPUT_FILE="index.html"

# Creating the output directory if it doesn't exist
mkdir -p $OUTPUT_DIR

# Get the current timestamp
TIMESTAMP=$(date +%Y-%m-%d)

# Get Linux kernel version
KERNEL_VER=$(uname -mrs)

# Get username
USERNAME=$(ps -o user= -p $$ | awk '{print $1}')

#Get computer name
COMP_NAME=$(uname -n)

#Get %CPU System
CPU_SYS=$(mpstat | awk 'NR==4{print $6}')

#Get cache
CACHE=$(vmstat | awk 'NR==3{print $6}')

# Get the system load average
LOAD=$(uptime | awk '{print $10}')

# Get the memory usage
MEM_USED=$(free -m | awk 'NR==2{print $3}')
MEM_AVAIL=$(free -m | awk 'NR==2{print $4}')

# Get the disk usage
DISK_USED=$(df -h / | awk 'NR==2{print $3}')
DISK_AVAIL=$(df -h / | awk 'NR==2{print $4}')

echo "<!DOCTYPE HTML>
<html>

<head>
    <meta charset="utf-8">
    <title>Linux Metrics</title>
</head>

<body>
    <table align="center" bordercolor="green" border="2" width="100%">
        <caption><h1>Linux Metrics</h1></caption>
        <tr>
            <th>Timestamp</th>
            <th>Kernel version</th>
            <th>User</th>
            <th>Computers name</th>
            <th>CPU %</th>
            <th>Load Average</th>
            <th>Memory Used (mb)</th>
            <th>Memory Avalible (mb)</th>
            <th>Cache</th>
            <th>Disk Used (gb)</th>
            <th>Disk Avalible</th>
        </tr>
        <tr align="center">
            <td>$TIMESTAMP</td>
            <td>$KERNEL_VER</td>
            <td>$USERNAME</td>
            <td>$COMP_NAME</td>
            <td>$CPU_SYS</td>
            <td>$LOAD</td>
            <td>$MEM_USED</td>
            <td>$MEM_AVAIL</td>
            <td>$CACHE</td>
            <td>$DISK_USED</td>
            <td>$DISK_AVAIL</td>
        </tr>
    </table>
</body>
</html>" > $OUTPUT_DIR/$OUTPUT_FILE

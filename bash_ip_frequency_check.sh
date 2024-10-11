#!/bin/bash

# Check if a log file path is provided as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <log_file_path>"
    exit 1
fi

# Define the log file from the first command-line argument
LOG_FILE="$1"

# Check if the file exists
if [ ! -f "$LOG_FILE" ]; then
    echo "Log file does not exist: $LOG_FILE"
    exit 1
fi

# Extract IP addresses, count occurrences, sort them, and format the output
printf "%-20s %s\n" "IP Address" "Count"
printf "%-20s %s\n" "----------" "-----"

awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | while read count ip; do
    printf "%-20s %s\n" "$ip" "$count"
done


import re
import argparse
from collections import Counter

# Function to extract IP addresses from log file
def extract_ip_addresses(log_file):
    ip_pattern = re.compile(r'(\d{1,3}\.){3}\d{1,3}')
    ip_addresses = []

    with open(log_file, 'r') as file:
        for line in file:
            match = ip_pattern.search(line)
            if match:
                ip_addresses.append(match.group(0))
    
    return ip_addresses

# Function to count the frequency of each IP address
def count_ip_frequencies(ip_addresses):
    return Counter(ip_addresses)

# Main function to process log file
def analyze_log_file(log_file_path):
    ip_addresses = extract_ip_addresses(log_file_path)
    ip_frequencies = count_ip_frequencies(ip_addresses)

    print("IP Address Frequency:")
    for ip, count in ip_frequencies.items():
        print(f"{ip}: {count} times")

# Command-line argument parsing
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Analyze web server log files to count IP addresses.")
    parser.add_argument("log_file", help="Path to the web server log file")
    
    args = parser.parse_args()
    
    analyze_log_file(args.log_file)


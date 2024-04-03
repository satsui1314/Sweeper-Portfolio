#!/bin/bash

# Get the network address from user
read -p "Enter your network address (e.g., 192.168.1): " network

# Loop through possible hosts (1 to 254)
for ip in {1..254}; do
  # Construct the full IP address
  full_ip="$network.$ip"
  
  # Echo a message that the script is pinging the address
  echo "Pinging $full_ip..."

  # Send a single ping with a timeout of 0.5 seconds
  ping -c 1 -W 0.5 $full_ip > /dev/null 2>&1 &

  # Capture the result of ping
  result=$?

  # Immediately print the result for each IP address
  if [ "$result" -eq 0 ]; then
    echo "Node with IP: $full_ip is UP."
  else
    echo "Node with IP: $full_ip is DOWN."
  fi

  # Limit the number of concurrent pings to avoid overwhelming the network
  ((count++))
  if ((count % 20 == 0)); then
    wait # Wait for all pings in this batch to finish
  fi
done

wait # Wait for any remaining background jobs to finish
echo "Pinging complete."

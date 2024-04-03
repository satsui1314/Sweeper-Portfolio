#!/bin/bash

#!/bin/bash
read -p "Enter your network address (e.g., 192.168.1): " network; for ip in {1..254}; do full_ip="$network.$ip"; echo "Pinging $full_ip..."; ping -c 1 -W 0.5 $full_ip > /dev/null 2>&1 & pid=$!; wait $pid; result=$?; if [ "$result" -eq 0 ]; then echo "Node with IP: $full_ip is UP."; else echo "Node with IP: $full_ip is DOWN."; fi; if ((ip % 20 == 0)); then wait; fi; done; echo "Pinging complete."


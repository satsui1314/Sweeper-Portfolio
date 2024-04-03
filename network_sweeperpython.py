import subprocess
import ipaddress

network = input("Enter your network address (e.g., 192.168.1.0/24): ")

try:
    net_obj = ipaddress.ip_network(network, strict=False)
    for ip in net_obj.hosts():
        full_ip = str(ip)
        print(f"Pinging {full_ip}...")
        response = subprocess.run(['ping', '-c', '1', '-W', '0.5', full_ip], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        if response.returncode == 0:
            print(f"Node with IP: {full_ip} is UP.")
        else:
            print(f"Node with IP: {full_ip} is DOWN.")
except ValueError as e:
    print(f"Error: {e}")

print("Pinging complete.")

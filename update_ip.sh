#!/bin/bash

# Capture the IP address from Terraform output
ip_address=$(terraform output -raw vm_ip)

# Define username and password (you can also fetch them securely from environment variables or secrets manager)
ansible_user=ec2-user
ansible_ssh_private_key_file=my-key-pair.pem

# Write or update the .ini file with IP, username, and password
cat <<EOF > inventory.ini
[axs_servers]
ip_address = $ip_address ansible_user = $username ansible_ssh_private_key_file = $password
EOF

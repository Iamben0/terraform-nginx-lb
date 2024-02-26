#!/bin/bash

# Replace 'FDQN' with the actual FQDN of the server
URL="https://FDQN/vend_ip"

# Use curl to fetch the data and jq to parse the JSON
response=$(curl -s -m 5 "$URL")

# Check if the curl command was successful
if [ $? -eq 0 ]; then
    # Use jq to parse the JSON and extract ip_address and subnet_size
    ip_address=$(echo $response | jq -r '.ip_address')
    subnet_size=$(echo $response | jq -r '.subnet_size')

    # Check if ip_address and subnet_size are not empty
    if [[ -n "$ip_address" && -n "$subnet_size" ]]; then
        # Output the results as a JSON-encoded string
        echo "{\"ip_address\": \"$ip_address\", \"subnet_size\": \"$subnet_size\"}"
    else
        echo "Error: ip_address or subnet_size could not be found."
    fi
else
    # If the curl command failed, use default values
    ip_address="192.168.0.0"
    subnet_size="24"
    echo "{\"ip_address\": \"$ip_address\", \"subnet_size\": \"$subnet_size\"}"
fi

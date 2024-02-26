#!/bin/bash
# Update the package list
sudo apt-get update

# Install Nginx
sudo apt-get install -y nginx

# Ensure Nginx starts automatically when the system boots
sudo systemctl enable nginx

# Start Nginx
sudo systemctl start nginx

echo '<!DOCTYPE html>
<html>
<head>
    <title>Welcome to Nginx!</title>
</head>
<body>
    <h1>Success! The Nginx web server is installed and running.</h1>
</body>
</html>' | sudo tee /var/www/html/index.html
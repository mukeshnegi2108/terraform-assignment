#!/bin/bash

# ==============================================================================
# USER DATA SCRIPT FOR WEB SERVER SETUP
# ==============================================================================

# Exit on any error
set -e

# Update system packages
sudo yum update -y

# Install nginx web server
sudo amazon-linux-extras install nginx1 -y 

# Start and enable nginx service
sudo systemctl enable nginx
sudo systemctl start nginx

# Create a simple index page
sudo tee /usr/share/nginx/html/index.html > /dev/null <<EOF
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to Web Application</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .header { color: #2c3e50; }
        .info { background-color: #ecf0f1; padding: 20px; margin: 20px 0; }
    </style>
</head>
<body>
    <h1 class="header">Welcome to Your Web Application</h1>
    <div class="info">
        <h2>Server Information</h2>
        <p><strong>Instance ID:</strong> $(curl -s http://169.254.169.254/latest/meta-data/instance-id)</p>
        <p><strong>Instance Type:</strong> $(curl -s http://169.254.169.254/latest/meta-data/instance-type)</p>
        <p><strong>Availability Zone:</strong> $(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)</p>
        <p><strong>Public IP:</strong> $(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)</p>
        <p><strong>Private IP:</strong> $(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)</p>
    </div>
    <p>Server is running and ready to serve content!</p>
    <p><em>Deployed via Terraform at $(date)</em></p>
</body>
</html>
EOF

# Configure nginx for better security
sudo tee /etc/nginx/nginx.conf > /dev/null <<EOF
user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

events {
    worker_connections 1024;
}

http {
    log_format main '\$remote_addr - \$remote_user [\$time_local] "\$request" '
                    '\$status \$body_bytes_sent "\$http_referer" '
                    '"\$http_user_agent" "\$http_x_forwarded_for"';

    access_log /var/log/nginx/access.log main;

    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;
    keepalive_timeout 65;
    types_hash_max_size 2048;
    server_tokens off;

    include /etc/nginx/mime.types;
    default_type application/octet-stream;

    server {
        listen 80 default_server;
        listen [::]:80 default_server;
        server_name _;
        root /usr/share/nginx/html;

        # Security headers
        add_header X-Frame-Options "SAMEORIGIN" always;
        add_header X-XSS-Protection "1; mode=block" always;
        add_header X-Content-Type-Options "nosniff" always;
        add_header Referrer-Policy "no-referrer-when-downgrade" always;
        add_header Content-Security-Policy "default-src 'self' http: https: data: blob: 'unsafe-inline'" always;

        location / {
            index index.html index.htm;
        }

        error_page 404 /404.html;
            location = /40x.html {
        }

        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
    }
}
EOF

# Restart nginx to apply new configuration
sudo systemctl restart nginx

# Configure AWS CloudWatch agent for monitoring
sudo yum install -y awslogs

# Configure CloudWatch logs
sudo tee /etc/awslogs/awslogs.conf > /dev/null <<EOF
[general]
state_file = /var/lib/awslogs/agent-state

[/var/log/messages]
datetime_format = %b %d %H:%M:%S
file = /var/log/messages
buffer_duration = 5000
log_stream_name = {instance_id}/var/log/messages
initial_position = start_of_file
log_group_name = /aws/ec2/var/log/messages

[/var/log/nginx/access.log]
datetime_format = %d/%b/%Y:%H:%M:%S %z
file = /var/log/nginx/access.log
buffer_duration = 5000
log_stream_name = {instance_id}/var/log/nginx/access.log
initial_position = start_of_file
log_group_name = /aws/ec2/nginx/access

[/var/log/nginx/error.log]
datetime_format = %Y/%m/%d %H:%M:%S
file = /var/log/nginx/error.log
buffer_duration = 5000
log_stream_name = {instance_id}/var/log/nginx/error.log
initial_position = start_of_file
log_group_name = /aws/ec2/nginx/error
EOF

# Start and enable CloudWatch logs agent
sudo systemctl start awslogsd
sudo systemctl enable awslogsd

# Create log groups in CloudWatch (will be created automatically when logs are sent)
echo "User data script completed successfully!" >> /var/log/user-data.log

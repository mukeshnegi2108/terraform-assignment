# ==============================================================================
# DEVELOPMENT ENVIRONMENT CONFIGURATION
# ==============================================================================

# Project Information
project_name = "webapp"
environment  = "dev"
owner        = "devops-team"

# Networking Configuration
vpc_name         = "webapp-dev-vpc"
subnet_name      = "webapp-dev-public-subnet"
route_table_name = "webapp-dev-route-table"
igw_name         = "webapp-dev-igw"

# Security Configuration
policy_name         = "webapp-dev-ec2-s3-policy"
ec2_role           = "webapp-dev-ec2-role"
profile_name       = "webapp-dev-ec2-profile"
webapp_sg          = "webapp-dev-security-group"
ingress_allowed_ips = ["10.0.0.0/8", "172.16.0.0/12"]  # Restricted to private networks

# Application Configuration
application_name = "web-server"
instance_type    = "t2.micro"  # Small instance for development

# Storage Configuration
bucket_acl = "private"

# AWS Configuration
region = "us-east-1"
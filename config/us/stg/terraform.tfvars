# ==============================================================================
# STAGING ENVIRONMENT CONFIGURATION
# ==============================================================================

# Project Information
project_name = "webapp"
environment  = "stg"
owner        = "devops-team"

# Networking Configuration
vpc_name         = "webapp-stg-vpc"
subnet_name      = "webapp-stg-public-subnet"
route_table_name = "webapp-stg-route-table"
igw_name         = "webapp-stg-igw"

# Security Configuration
policy_name         = "webapp-stg-ec2-s3-policy"
ec2_role           = "webapp-stg-ec2-role"
profile_name       = "webapp-stg-ec2-profile"
webapp_sg          = "webapp-stg-security-group"
ingress_allowed_ips = ["10.0.0.0/8", "172.16.0.0/12"]  # Restricted to private networks

# Application Configuration
application_name = "web-server"
instance_type    = "t2.small"  # Slightly larger for staging

# Storage Configuration
bucket_acl = "private"

# AWS Configuration
region = "us-east-1"
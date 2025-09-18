# ==============================================================================
# PRODUCTION ENVIRONMENT CONFIGURATION
# ==============================================================================

# Project Information
project_name = "webapp"
environment  = "prod"
owner        = "devops-team"

# Networking Configuration
vpc_name         = "webapp-prod-vpc"
subnet_name      = "webapp-prod-public-subnet"
route_table_name = "webapp-prod-route-table"
igw_name         = "webapp-prod-igw"

# Security Configuration
policy_name         = "webapp-prod-ec2-s3-policy"
ec2_role           = "webapp-prod-ec2-role"
profile_name       = "webapp-prod-ec2-profile"
webapp_sg          = "webapp-prod-security-group"
ingress_allowed_ips = ["203.0.113.0/24"]  # Replace with actual allowed CIDR blocks

# Application Configuration
application_name = "web-server"
instance_type    = "t2.medium"  # Larger instance for production

# Storage Configuration
bucket_acl = "private"

# AWS Configuration
region = "us-east-1"
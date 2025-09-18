# Data source to get the latest Amazon Linux 2 AMI
data "aws_ami" "app_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
  
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Local values for common tags and configurations
locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    Owner       = var.owner
    ManagedBy   = "Terraform"
  }
  
  name_prefix = "${var.project_name}-${var.environment}"
}

# ==============================================================================
# REQUIRED VARIABLES
# ==============================================================================

variable "project_name" {
  description = "Name of the project"
  type        = string
  validation {
    condition     = length(var.project_name) > 0 && length(var.project_name) <= 32
    error_message = "Project name must be between 1 and 32 characters."
  }
}

variable "environment" {
  description = "Environment name (dev, stg, prod)"
  type        = string
  validation {
    condition     = contains(["dev", "stg", "prod"], var.environment)
    error_message = "Environment must be one of: dev, stg, prod."
  }
}

variable "owner" {
  description = "Owner of the resources"
  type        = string
}

variable "vpc_name" {
  description = "Name for the VPC"
  type        = string
}

variable "subnet_name" {
  description = "Name for the public subnet"
  type        = string
}

variable "route_table_name" {
  description = "Name for the route table"
  type        = string
}

variable "igw_name" {
  description = "Name for the internet gateway"
  type        = string
}

variable "policy_name" {
  description = "Name for the IAM policy"
  type        = string
}

variable "ec2_role" {
  description = "Name for the EC2 IAM role"
  type        = string
}

variable "profile_name" {
  description = "Name for the instance profile"
  type        = string
}

variable "webapp_sg" {
  description = "Name for the web application security group"
  type        = string
}

variable "application_name" {
  description = "Name for the application/EC2 instance"
  type        = string
}

variable "ingress_allowed_ips" {
  description = "List of IP ranges allowed for ingress traffic"
  type        = list(string)
  validation {
    condition = alltrue([
      for ip in var.ingress_allowed_ips : can(cidrhost(ip, 0))
    ])
    error_message = "All values must be valid CIDR blocks."
  }
}

# ==============================================================================
# OPTIONAL VARIABLES
# ==============================================================================

variable "region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
  validation {
    condition = contains([
      "t2.micro", "t2.small", "t2.medium", "t2.large",
      "t3.micro", "t3.small", "t3.medium", "t3.large"
    ], var.instance_type)
    error_message = "Instance type must be a valid t2 or t3 instance type."
  }
}

variable "bucket_acl" {
  description = "S3 bucket ACL"
  type        = string
  default     = "private"
  validation {
    condition     = contains(["private", "public-read", "public-read-write"], var.bucket_acl)
    error_message = "Bucket ACL must be one of: private, public-read, public-read-write."
  }
}

variable "aws_profile" {
  description = "AWS profile to use for authentication"
  type        = string
  default     = null
}


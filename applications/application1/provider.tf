terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }
  
  # Backend configuration should be provided via backend config file or CLI
  # backend "s3" {
  #   # Configuration moved to backend.tf or provided via -backend-config
  # }
}

# Provider configuration
provider "aws" {
  region = var.region
  
  # Use environment variables or AWS config instead of hardcoded profile
  # profile = var.aws_profile  # Optional, can be set via variable
  
  default_tags {
    tags = local.common_tags
  }
}

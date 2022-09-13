terraform {
  required_providers {
    aws = {
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket         = "state-bucket-my-personal-assessment"
    region         = "us-east-1"
    key            = "region/terraform.tfstate"
    dynamodb_table = "terraform_locks"
  }
}

# Provider, Region and aws profile details
provider "aws" {
  region  = "us-east-1"
  profile = "my-account"
}

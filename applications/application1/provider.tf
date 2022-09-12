terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket         = "state-bucket-my-personal-assessment"
    region         = "${var.aws_region}"
    key            = "/region/application/terraform.tfstate"
    dynamodb_table = "terraform_locks"
  }
}

# Provider and Region details
provider "aws" {
  region     = "us-east-1"
}

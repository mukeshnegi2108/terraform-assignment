# Provider and Region details
provider "aws" {
  region = var.aws_region
}

# calling the project infrastructure
module "app-infrastructure" {
  source = "applications/application1"
}

# Version details of terraform version, AWS plugin and backend statefile
terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = "> 3.0"
  }

  backend "s3" {
    bucket = "state-bucket-my-personal-assessment"
    region = "${var.aws_region}"
    key = "/region/application/terraform.tfstate"
    dynamodb_table = "terraform_locks"
  }
}

# Provider and Region details
provider "aws" {
  region     = var.aws_region
  access_key = AKIAZWMPLZUOZD4TNA6B
  secret_key = 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
}

module "app-infrastructure" {
  source = "./applications/application1"
}

# Version details of terraform version, AWS plugin and backend statefile
terraform {
  required_providers {
    aws = "> 3.0"
  }

  #  backend "s3" {
  #   bucket = "state-bucket-my-personal-assessment"
  #    region = "${var.aws_region}"
  #    key = "/region/application/terraform.tfstate"
  #    dynamodb_table = "terraform_locks"
  #  }
}




# For getting user_details
data "aws_caller_identity" "current" {}

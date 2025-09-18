# Backend configuration for Terraform state
# This can be customized per environment

terraform {
  backend "s3" {
    # These values should be customized per environment
    # You can use backend config files like:
    # terraform init -backend-config=backend-dev.conf
    
    # Example configuration:
    # bucket         = "terraform-state-bucket-dev"
    # key            = "applications/application1/terraform.tfstate"
    # region         = "us-east-1"
    # dynamodb_table = "terraform-state-lock"
    # encrypt        = true
  }
}
# getting the ami value from aws AMI store
data "aws_ami" "app_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}


locals {
  common_tags = {
    team    = "devops"
    project = "Sapient"
  }
}

variable "vpc_name" {}

variable "subnet_name" {}

variable "route_table_name" {}

variable "igw_name" {}

variable "policy_name" {}

variable "ec2_role" {}

variable "profile_name" {}

variable "webapp_sg" {}

variable "bucket_name" {}

variable "bucket_acl" {}

variable "application_name" {}

variable "instance_type" {}

variable "region" {
  default = "us-east-1"
}

variable "ingress_allowed_ips" {}


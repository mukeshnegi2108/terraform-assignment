# getting the ami value from aws AMI store
data "aws_ami" "app_ami" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["amzn2-ami-hvm*"]
  }
}


locals {
  common_tags = {
    team = devops
    project = Sapient
  }
}

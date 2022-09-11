data "aws_ami" "dafault_ami" {
  most_recent = true
  owners      = ["aws"]
}

variable "ami" {
  type    = string
  default = "ami-0f36dcfcc94112ea1"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "instance_profile" {
  type    = string
  default = ""
}

variable "security_group" {
  type    = string
  default = ""
}

variable "tags" {
  default = null
}

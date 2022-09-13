variable "ami" {
  type    = string
  default = "ami-09e2d756e7d78558d"
}

variable "application_name" {
  type    = string
  default = "default-application"
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

variable "tags" {}

variable "subnet_id" {}

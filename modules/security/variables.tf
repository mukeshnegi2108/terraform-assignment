variable "policy_name" {
  type    = string
  default = "ec2-s3-access-policy"
}

variable "ec2_role" {
  type    = string
  default = "ec2-role"
}

variable "policy_attachment" {
  type    = string
  default = "policy-attachment"
}

variable "profile_name" {
  type    = string
  default = "ec2-role"
}

variable "webapp_sg" {
  type    = string
  default = "webapp-sg"
}

variable "vpc_id" {}

variable "ingress_ports" {
  type    = list(number)
  default = [443, 80]
}

variable "ingress_allowed_ips" {
  type    = list
  default = ["0.0.0.0/0"]
}

variable "egress_allowed_ips" {
  type    = list
  default = ["0.0.0.0/0"]
}

variable "tags" {}
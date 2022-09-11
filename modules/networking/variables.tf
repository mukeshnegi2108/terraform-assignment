variable "vpc_name" {
  type      = string
  default   = "application-vpc"
}

variable "subnet_name" {
  type      = string
  default   = "application-vpc"
}

variable "rt_name" {
  type      = string
  default   = "application-rt"
}

variable "igw_name" {
  type      = string
  default   = "application-igw"
}

variable "availability_zone" {
  type      = string
  default   = "us-east-2a"
}

variable "vpc_cidr_range" {
  type = string
  default = "172.10.10.0/24"
}

variable "subnet_cidr_range" {
  type = string
  default = "172.10.10.12/26"
}

variable "tags" {
  default = null
}

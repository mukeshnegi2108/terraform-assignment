# ==============================================================================
# NETWORKING MODULE VARIABLES
# ==============================================================================

variable "vpc_name" {
  description = "Name for the VPC"
  type        = string
}

variable "subnet_name" {
  description = "Name for the public subnet"
  type        = string
}

variable "route_table_name" {
  description = "Name for the route table"
  type        = string
}

variable "igw_name" {
  description = "Name for the internet gateway"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone for the subnet"
  type        = string
  default     = "us-east-1a"
}

variable "vpc_cidr_range" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
  validation {
    condition     = can(cidrhost(var.vpc_cidr_range, 0))
    error_message = "VPC CIDR range must be a valid CIDR block."
  }
}

variable "subnet_cidr_range" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
  validation {
    condition     = can(cidrhost(var.subnet_cidr_range, 0))
    error_message = "Subnet CIDR range must be a valid CIDR block."
  }
}

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
  default     = {}
}

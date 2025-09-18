# ==============================================================================
# SECURITY MODULE VARIABLES
# ==============================================================================

# IAM Configuration
variable "policy_name" {
  description = "Name for the IAM policy"
  type        = string
}

variable "ec2_role" {
  description = "Name for the EC2 IAM role"
  type        = string
}

variable "policy_attachment" {
  description = "Name for the policy attachment"
  type        = string
  default     = "ec2-policy-attachment"
}

variable "profile_name" {
  description = "Name for the EC2 instance profile"
  type        = string
}

# Security Group Configuration
variable "webapp_sg" {
  description = "Name for the web application security group"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where security group will be created"
  type        = string
}

variable "ingress_ports" {
  description = "List of ports to allow for ingress traffic"
  type        = list(number)
  default     = [80, 443]
  validation {
    condition = alltrue([
      for port in var.ingress_ports : port > 0 && port <= 65535
    ])
    error_message = "All ports must be between 1 and 65535."
  }
}

variable "ingress_allowed_ips" {
  description = "List of CIDR blocks allowed for ingress traffic"
  type        = list(string)
  validation {
    condition = alltrue([
      for ip in var.ingress_allowed_ips : can(cidrhost(ip, 0))
    ])
    error_message = "All values must be valid CIDR blocks."
  }
}

variable "egress_allowed_ips" {
  description = "List of CIDR blocks allowed for egress traffic"
  type        = list(string)
  default     = ["0.0.0.0/0"]
  validation {
    condition = alltrue([
      for ip in var.egress_allowed_ips : can(cidrhost(ip, 0))
    ])
    error_message = "All values must be valid CIDR blocks."
  }
}

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
  default     = {}
}
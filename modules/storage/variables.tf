variable "region" {
  type    = string
  default = "us-east-1"
}

variable "bucket_name" {
  type    = string
  default = "mybucket-921739879824123uywiuyd"
}

variable "bucket_acl" {
  type    = string
  default = "private"
}

variable "encryption_algorithm" {
  type    = string
  default = "aws:kms"
}

variable "bucket_versioning" {
  type    = string
  default = "Enabled"
}

variable "tags" {
  default = ""
}
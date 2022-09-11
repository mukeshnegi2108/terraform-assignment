variable "bucket_acl" {
  type = string
  default = "private"
}

variable "encryption_algorithm" {
  type = string
  default = "aws:kms"
}

variable "bucket_versioning" {
  type = string
  default = "Enabled"
}

variable "tags" {
  default = null
}
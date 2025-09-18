# ==============================================================================
# STORAGE MODULE VARIABLES
# ==============================================================================

variable "region" {
  description = "AWS region for the S3 bucket"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Base name for the S3 bucket (will be made unique)"
  type        = string
  validation {
    condition     = length(var.bucket_name) >= 3 && length(var.bucket_name) <= 40
    error_message = "Bucket name must be between 3 and 40 characters."
  }
}

variable "bucket_acl" {
  description = "Access control list for the S3 bucket"
  type        = string
  default     = "private"
  validation {
    condition     = contains(["private", "public-read", "public-read-write"], var.bucket_acl)
    error_message = "Bucket ACL must be one of: private, public-read, public-read-write."
  }
}

variable "encryption_algorithm" {
  description = "Server-side encryption algorithm for the S3 bucket"
  type        = string
  default     = "AES256"
  validation {
    condition     = contains(["AES256", "aws:kms"], var.encryption_algorithm)
    error_message = "Encryption algorithm must be either AES256 or aws:kms."
  }
}

variable "kms_master_key_id" {
  description = "KMS master key ID for S3 encryption (required if encryption_algorithm is aws:kms)"
  type        = string
  default     = null
}

variable "bucket_versioning" {
  description = "Versioning state for the S3 bucket"
  type        = string
  default     = "Enabled"
  validation {
    condition     = contains(["Enabled", "Disabled", "Suspended"], var.bucket_versioning)
    error_message = "Bucket versioning must be one of: Enabled, Disabled, Suspended."
  }
}

variable "lifecycle_enabled" {
  description = "Enable lifecycle management for the S3 bucket"
  type        = bool
  default     = true
}

variable "transition_to_ia_days" {
  description = "Number of days after which objects transition to IA storage class"
  type        = number
  default     = 30
}

variable "transition_to_glacier_days" {
  description = "Number of days after which objects transition to Glacier storage class"
  type        = number
  default     = 90
}

variable "expiration_days" {
  description = "Number of days after which objects expire"
  type        = number
  default     = 365
}

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
  default     = {}
}

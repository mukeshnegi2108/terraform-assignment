# ==============================================================================
# S3 BUCKET CONFIGURATION
# ==============================================================================

# Generate a random UUID for unique bucket naming
resource "random_uuid" "bucket" {}

# Main S3 bucket
resource "aws_s3_bucket" "s3_resource" {
  bucket = "${var.bucket_name}-${random_uuid.bucket.result}"
  
  tags = merge(
    {
      Name        = "${var.bucket_name}-${random_uuid.bucket.result}"
      Environment = "terraform-managed"
    },
    var.tags
  )
}

# ==============================================================================
# S3 BUCKET CONFIGURATION RESOURCES
# ==============================================================================

# Bucket versioning
resource "aws_s3_bucket_versioning" "s3_versioning" {
  bucket = aws_s3_bucket.s3_resource.id
  versioning_configuration {
    status = var.bucket_versioning
  }
}

# Server-side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "s3_encryption" {
  bucket = aws_s3_bucket.s3_resource.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = var.encryption_algorithm
      kms_master_key_id = var.encryption_algorithm == "aws:kms" ? var.kms_master_key_id : null
    }
    bucket_key_enabled = var.encryption_algorithm == "aws:kms"
  }
}

# Block public access
resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.s3_resource.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Bucket ACL
resource "aws_s3_bucket_acl" "s3_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_acl_ownership]

  bucket = aws_s3_bucket.s3_resource.id
  acl    = var.bucket_acl
}

# Bucket ownership controls
resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
  bucket = aws_s3_bucket.s3_resource.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Lifecycle configuration
resource "aws_s3_bucket_lifecycle_configuration" "s3_lifecycle" {
  count  = var.lifecycle_enabled ? 1 : 0
  bucket = aws_s3_bucket.s3_resource.id

  rule {
    id     = "lifecycle_rule"
    status = "Enabled"

    transition {
      days          = var.transition_to_ia_days
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = var.transition_to_glacier_days
      storage_class = "GLACIER"
    }

    expiration {
      days = var.expiration_days
    }

    noncurrent_version_expiration {
      noncurrent_days = 30
    }
  }
}

# Bucket logging (optional)
resource "aws_s3_bucket_logging" "s3_logging" {
  bucket = aws_s3_bucket.s3_resource.id

  target_bucket = aws_s3_bucket.s3_resource.id
  target_prefix = "access-logs/"
}

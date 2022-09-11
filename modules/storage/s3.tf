resource "aws_s3_bucket" "s3_resource" {
  bucket = "${var.region}-${var.bucket_name}-${timestamp()}"
  acl    = var.bucket_acl
  tags   = var.tags

  # Enable encryption
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = var.encryption_algorithm
      }
    }
  }
}

# Enable S3 Versioning
resource "aws_s3_bucket_versioning" "s3_versioning" {
  bucket = aws_s3_bucket.s3_resource.bucket
  versioning_configuration {
    status = var.bucket_versioning
  }
}

# Block public access to the bucket
resource "aws_s3_bucket_public_access_block" "live_reports_public_access_block" {
  bucket = aws_s3_bucket.s3_resource.id

  block_public_acls   = true
  block_public_policy = true
}

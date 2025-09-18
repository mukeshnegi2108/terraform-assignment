# ==============================================================================
# STORAGE MODULE OUTPUTS
# ==============================================================================

output "bucketname" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.s3_resource.bucket
}

output "bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = aws_s3_bucket.s3_resource.arn
}

output "bucket_id" {
  description = "ID of the S3 bucket"
  value       = aws_s3_bucket.s3_resource.id
}

output "bucket_domain_name" {
  description = "Domain name of the S3 bucket"
  value       = aws_s3_bucket.s3_resource.bucket_domain_name
}

output "bucket_region" {
  description = "Region of the S3 bucket"
  value       = aws_s3_bucket.s3_resource.region
}

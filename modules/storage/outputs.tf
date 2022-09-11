output "bucketname" {
  description = "Name of the Bucket"
  value = aws_s3_bucket.s3_resource.bucket
}
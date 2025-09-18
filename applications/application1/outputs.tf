# ==============================================================================
# OUTPUTS
# ==============================================================================

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.application-networking.vpc_id
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = module.application-networking.vpc_cidr_block
}

output "subnet_id" {
  description = "ID of the public subnet"
  value       = module.application-networking.subnet_id
}

output "security_group_id" {
  description = "ID of the web application security group"
  value       = module.application-security.securitygroup_id
}

output "iam_role_arn" {
  description = "ARN of the EC2 IAM role"
  value       = module.application-security.iam_role_arn
}

output "instance_profile_name" {
  description = "Name of the EC2 instance profile"
  value       = module.application-security.profile_name
}

output "s3_bucket_name" {
  description = "Name of the S3 bucket"
  value       = module.application-storage.bucketname
}

output "s3_bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = module.application-storage.bucket_arn
}

output "ec2_instance_id" {
  description = "ID of the EC2 instance"
  value       = module.application.instance_id
}

output "ec2_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = module.application.ec2_ip
  sensitive   = false
}

output "ec2_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = module.application.private_ip
}

output "application_url" {
  description = "URL to access the web application"
  value       = "http://${module.application.ec2_ip}"
}
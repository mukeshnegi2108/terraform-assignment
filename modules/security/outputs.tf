# ==============================================================================
# SECURITY MODULE OUTPUTS
# ==============================================================================

# IAM Outputs
output "iam_role_arn" {
  description = "ARN of the EC2 IAM role"
  value       = aws_iam_role.ec2_role.arn
}

output "iam_role_name" {
  description = "Name of the EC2 IAM role"
  value       = aws_iam_role.ec2_role.name
}

output "profile_name" {
  description = "Name of the EC2 instance profile"
  value       = aws_iam_instance_profile.ec2_profile.name
}

output "iam_policy_arn" {
  description = "ARN of the IAM policy"
  value       = aws_iam_policy.ec2_policy.arn
}

# Security Group Outputs
output "securitygroup_id" {
  description = "ID of the security group"
  value       = aws_security_group.myapp_sg.id
}

output "securitygroup_arn" {
  description = "ARN of the security group"
  value       = aws_security_group.myapp_sg.arn
}


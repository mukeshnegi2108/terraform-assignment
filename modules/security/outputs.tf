output "profile_name" {
  description = "IAM profile name"
  value       = aws_iam_instance_profile.ec2_profile.name
}

output "securitygroup_id" {
  description = "Subnet ID"
  value       = aws_security_group.myapp_sg.id
}


# ==============================================================================
# COMPUTE MODULE OUTPUTS
# ==============================================================================

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.webserver.id
}

output "ec2_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.webserver.public_ip
}

output "private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.webserver.private_ip
}

output "instance_arn" {
  description = "ARN of the EC2 instance"
  value       = aws_instance.webserver.arn
}

output "availability_zone" {
  description = "Availability zone of the EC2 instance"
  value       = aws_instance.webserver.availability_zone
}
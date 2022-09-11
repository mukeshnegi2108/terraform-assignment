output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.custom-vpc.id
}

output "subnet_id" {
  description = "Subnet ID"
  value       = aws_subnet.public.id
}
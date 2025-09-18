# ==============================================================================
# NETWORKING MODULE OUTPUTS
# ==============================================================================

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.custom-vpc.id
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.custom-vpc.cidr_block
}

output "subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public.id
}

output "subnet_cidr_block" {
  description = "CIDR block of the public subnet"
  value       = aws_subnet.public.cidr_block
}

output "internet_gateway_id" {
  description = "ID of the internet gateway"
  value       = aws_internet_gateway.vpc-igw.id
}

output "route_table_id" {
  description = "ID of the route table"
  value       = aws_route_table.vpc-route-table.id
}
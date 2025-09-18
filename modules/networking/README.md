# Networking Module

This module creates a VPC with a public subnet, internet gateway, and routing configuration.

## Resources Created

- **VPC** - Virtual Private Cloud with DNS hostnames and DNS support enabled
- **Public Subnet** - Subnet with automatic public IP assignment
- **Internet Gateway** - For internet access
- **Route Table** - Public route table with internet route
- **Route Table Association** - Associates the subnet with the route table

## Usage

```hcl
module "networking" {
  source = "./modules/networking"
  
  vpc_name         = "my-vpc"
  subnet_name      = "my-public-subnet"
  route_table_name = "my-route-table"
  igw_name         = "my-igw"
  
  vpc_cidr_range    = "10.0.0.0/16"
  subnet_cidr_range = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  
  tags = {
    Environment = "dev"
    Project     = "webapp"
  }
}
```

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| vpc_name | Name for the VPC | `string` | n/a | yes |
| subnet_name | Name for the public subnet | `string` | n/a | yes |
| route_table_name | Name for the route table | `string` | n/a | yes |
| igw_name | Name for the internet gateway | `string` | n/a | yes |
| availability_zone | Availability zone for the subnet | `string` | `"us-east-1a"` | no |
| vpc_cidr_range | CIDR block for the VPC | `string` | `"10.0.0.0/16"` | no |
| subnet_cidr_range | CIDR block for the public subnet | `string` | `"10.0.1.0/24"` | no |
| tags | A map of tags to assign to the resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | ID of the VPC |
| vpc_cidr_block | CIDR block of the VPC |
| subnet_id | ID of the public subnet |
| subnet_cidr_block | CIDR block of the public subnet |
| internet_gateway_id | ID of the internet gateway |
| route_table_id | ID of the route table |

## Architecture

```
Internet
    |
Internet Gateway
    |
Route Table (0.0.0.0/0 -> IGW)
    |
Public Subnet (10.0.1.0/24)
    |
VPC (10.0.0.0/16)
```

## Security Considerations

- The subnet is public and instances will receive public IP addresses
- Security groups should be used to control access to instances
- Consider using private subnets for backend resources
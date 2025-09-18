# Terraform AWS Infrastructure

A professional-grade Terraform configuration for deploying a complete AWS infrastructure including VPC, EC2 instances, S3 storage, and IAM roles.

## Architecture Overview

This Terraform configuration deploys:
- **VPC** with public subnet and internet gateway
- **EC2 instance** with nginx web server
- **S3 bucket** with encryption and versioning
- **IAM roles and policies** for EC2-S3 access
- **Security groups** with configurable ingress rules

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate credentials
- AWS account with sufficient permissions

## Project Structure

```
├── applications/
│   └── application1/          # Application-specific configuration
├── config/
│   └── us/                    # Region-specific configurations
│       ├── dev/               # Development environment
│       ├── stg/               # Staging environment
│       └── prod/              # Production environment
├── modules/
│   ├── compute/               # EC2 instance module
│   ├── networking/            # VPC and networking module
│   ├── security/              # IAM and security groups module
│   ├── storage/               # S3 storage module
│   └── scripts/               # User data scripts
└── README.md
```

## Quick Start

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd terraform-assignment
   ```

2. **Configure AWS credentials**
   ```bash
   aws configure
   ```

3. **Initialize Terraform**
   ```bash
   cd applications/application1
   terraform init
   ```

4. **Plan the deployment**
   ```bash
   terraform plan -var-file="../../config/us/dev/terraform.tfvars"
   ```

5. **Apply the configuration**
   ```bash
   terraform apply -var-file="../../config/us/dev/terraform.tfvars"
   ```

## Environment-Specific Deployments

### Development
```bash
terraform plan -var-file="../../config/us/dev/terraform.tfvars"
terraform apply -var-file="../../config/us/dev/terraform.tfvars"
```

### Staging
```bash
terraform plan -var-file="../../config/us/stg/terraform.tfvars"
terraform apply -var-file="../../config/us/stg/terraform.tfvars"
```

### Production
```bash
terraform plan -var-file="../../config/us/prod/terraform.tfvars"
terraform apply -var-file="../../config/us/prod/terraform.tfvars"
```

## Configuration

### Required Variables

| Variable | Description | Type | Example |
|----------|-------------|------|---------|
| `vpc_name` | Name for the VPC | string | `"my-vpc"` |
| `application_name` | Name for the application | string | `"web-app"` |
| `instance_type` | EC2 instance type | string | `"t2.micro"` |
| `ingress_allowed_ips` | Allowed IP ranges for ingress | list(string) | `["10.0.0.0/8"]` |

### Optional Variables

| Variable | Description | Type | Default |
|----------|-------------|------|---------|
| `region` | AWS region | string | `"us-east-1"` |
| `bucket_acl` | S3 bucket ACL | string | `"private"` |

## Modules

### Networking Module
Creates VPC, subnet, route table, and internet gateway.

### Compute Module  
Deploys EC2 instances with user data script for nginx installation.

### Security Module
Sets up IAM roles, policies, and security groups.

### Storage Module
Creates S3 bucket with encryption, versioning, and public access blocking.

## Security Features

- 🔒 **S3 Encryption**: Server-side encryption enabled
- 🔒 **S3 Versioning**: Object versioning enabled
- 🔒 **Public Access Block**: S3 public access blocked
- 🔒 **IAM Policies**: Least privilege access policies
- 🔒 **Security Groups**: Configurable ingress rules

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For questions and support, please open an issue in the repository.
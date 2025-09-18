# Terraform AWS Infrastructure

A professional-grade Terraform configuration for deploying a complete AWS infrastructure including VPC, EC2 instances, S3 storage, and IAM roles.

[![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)](https://aws.amazon.com/)
[![GitHub Actions](https://img.shields.io/badge/github%20actions-%232671E5.svg?style=for-the-badge&logo=githubactions&logoColor=white)](https://github.com/features/actions)

## 🏗️ Architecture Overview

This Terraform configuration deploys:
- **🌐 VPC** with public subnet and internet gateway
- **💻 EC2 instance** with nginx web server and automated setup
- **🗄️ S3 bucket** with encryption, versioning, and lifecycle management  
- **🔐 IAM roles and policies** with least privilege access
- **🛡️ Security groups** with configurable ingress rules
- **📊 CloudWatch** integration for monitoring and logging

## 📋 Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate credentials
- AWS account with sufficient permissions
- Optional: [tflint](https://github.com/terraform-linters/tflint), [tfsec](https://github.com/aquasecurity/tfsec), [checkov](https://www.checkov.io/)

## 📁 Project Structure

```
├── applications/
│   └── application1/          # Application-specific configuration
│       ├── main.tf           # Main configuration
│       ├── variables.tf      # Variable definitions
│       ├── outputs.tf        # Output values
│       ├── provider.tf       # Provider configuration
│       ├── backend.tf        # Backend configuration
│       └── terraform.tfvars  # Default variables
├── config/
│   └── us/                    # Region-specific configurations
│       ├── dev/              # Development environment
│       ├── stg/              # Staging environment
│       └── prod/             # Production environment
├── modules/
│   ├── compute/              # EC2 instance module
│   ├── networking/           # VPC and networking module
│   ├── security/             # IAM and security groups module
│   ├── storage/              # S3 storage module
│   └── scripts/              # User data scripts
├── examples/
│   └── backend-configs/      # Example backend configurations
├── .github/
│   └── workflows/            # GitHub Actions CI/CD
├── Makefile                  # Common operations
├── .tflint.hcl              # TFLint configuration
├── .pre-commit-config.yaml  # Pre-commit hooks
└── README.md
```

## 🚀 Quick Start

### 1. Clone and Setup

```bash
git clone <repository-url>
cd terraform-assignment

# Install tools (optional)
make install-tools
```

### 2. Configure AWS Credentials

```bash
aws configure
# or set environment variables
export AWS_PROFILE=your-profile
```

### 3. Initialize and Deploy

```bash
# Using Makefile (recommended)
make dev-plan     # Plan for development
make dev-apply    # Apply for development

# Or manually
cd applications/application1
terraform init
terraform plan -var-file="../../config/us/dev/terraform.tfvars"
terraform apply -var-file="../../config/us/dev/terraform.tfvars"
```

## 🎯 Environment-Specific Deployments

### Development Environment
```bash
make ENV=dev init plan apply
```

### Staging Environment  
```bash
make ENV=stg init plan apply
```

### Production Environment
```bash
make ENV=prod init plan apply
```

## 🔧 Configuration

### Required Variables

| Variable | Description | Type | Example |
|----------|-------------|------|---------|
| `project_name` | Name of the project | string | `"webapp"` |
| `environment` | Environment (dev/stg/prod) | string | `"dev"` |
| `owner` | Owner of the resources | string | `"devops-team"` |
| `vpc_name` | Name for the VPC | string | `"webapp-dev-vpc"` |
| `application_name` | Name for the application | string | `"web-server"` |
| `ingress_allowed_ips` | Allowed IP ranges | list(string) | `["10.0.0.0/8"]` |

### Optional Variables

| Variable | Description | Type | Default |
|----------|-------------|------|---------|
| `region` | AWS region | string | `"us-east-1"` |
| `instance_type` | EC2 instance type | string | `"t2.micro"` |
| `bucket_acl` | S3 bucket ACL | string | `"private"` |

## 📦 Modules

### 🌐 [Networking Module](./modules/networking/README.md)
Creates VPC, subnet, route table, and internet gateway.

### 🔐 [Security Module](./modules/security/README.md)  
Sets up IAM roles, policies, and security groups with least privilege.

### 💻 [Compute Module](./modules/compute/README.md)
Deploys EC2 instances with automated nginx setup and monitoring.

### 🗄️ [Storage Module](./modules/storage/README.md)
Creates S3 bucket with encryption, versioning, and lifecycle management.

## 🛡️ Security Features

- 🔒 **S3 Encryption**: Server-side encryption enabled (AES256/KMS)
- 🔒 **S3 Versioning**: Object versioning with lifecycle cleanup  
- 🔒 **Public Access Block**: S3 public access completely blocked
- 🔒 **IAM Policies**: Least privilege access with account-scoped permissions
- 🔒 **Security Groups**: Restricted ingress with configurable CIDR blocks
- 🔒 **EBS Encryption**: Root volumes encrypted by default
- 🔒 **Security Headers**: Nginx configured with security headers

## 🚥 CI/CD & Automation

### GitHub Actions Workflows

- **Terraform CI/CD**: Automated validation, linting, and security scanning
- **Pre-commit Checks**: Code quality and formatting validation
- **Multi-environment Planning**: Automated planning for dev/stg environments

### Available Commands

```bash
# Development workflow
make help              # Show all available commands
make check            # Run all checks (fmt, validate, lint)
make dev-plan         # Plan for dev environment
make dev-apply        # Apply for dev environment

# Code quality
make fmt              # Format Terraform files
make validate         # Validate configuration
make lint             # Run linting tools
make security         # Run security scans

# Documentation
make docs             # Generate module documentation
```

## 🧪 Testing & Validation

### Pre-commit Hooks

```bash
# Install pre-commit
pip install pre-commit
pre-commit install

# Run manually
pre-commit run --all-files
```

### Security Scanning

```bash
# Run security checks
make security

# Individual tools
tfsec .
checkov -d . --framework terraform
```

## 📊 Monitoring & Logging

- **CloudWatch Logs**: Application and system logs
- **CloudWatch Metrics**: Instance and application metrics
- **S3 Access Logs**: Bucket access logging
- **Nginx Logs**: Access and error logs forwarded to CloudWatch

## 🎯 Best Practices Implemented

✅ **Infrastructure as Code**: Version-controlled infrastructure  
✅ **Environment Separation**: Dedicated configs for dev/stg/prod  
✅ **Security First**: Least privilege and defense in depth  
✅ **Cost Optimization**: S3 lifecycle rules and appropriate instance types  
✅ **Monitoring**: Comprehensive logging and metrics  
✅ **Documentation**: Comprehensive docs for all modules  
✅ **Automation**: CI/CD pipelines and pre-commit hooks  
✅ **Validation**: Input validation and type constraints  

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make changes and run pre-commit hooks
4. Commit your changes (`git commit -m 'Add some amazing feature'`)
5. Push to the branch (`git push origin feature/amazing-feature`)
6. Open a Pull Request

### Development Workflow

```bash
# Setup development environment
make install-tools
pre-commit install

# Make changes and validate
make fmt validate lint security
terraform plan

# Commit changes
git add .
git commit -m "Your descriptive commit message"
```

## 📚 Additional Resources

- [Terraform Best Practices](https://www.terraform.io/docs/cloud/guides/recommended-practices/index.html)
- [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)
- [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

For questions and support:
- 📖 Check the [module documentation](./modules/)
- 🐛 Open an issue for bugs
- 💡 Open an issue for feature requests
- 📧 Contact the team for general questions

---

**Built with ❤️ using Terraform and AWS**
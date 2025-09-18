# Security Module

This module creates IAM roles, policies, and security groups for EC2 instances with S3 access.

## Resources Created

- **IAM Policy** - Custom policy with limited S3 and CloudWatch permissions
- **IAM Role** - EC2 service role for assuming the policy
- **IAM Instance Profile** - Instance profile for attaching to EC2 instances
- **Security Group** - Configurable ingress/egress rules for web applications

## Usage

```hcl
module "security" {
  source = "./modules/security"
  
  # IAM Configuration
  policy_name  = "webapp-policy"
  ec2_role     = "webapp-ec2-role"
  profile_name = "webapp-instance-profile"
  
  # Security Group Configuration
  webapp_sg           = "webapp-security-group"
  vpc_id              = "vpc-12345678"
  ingress_ports       = [80, 443]
  ingress_allowed_ips = ["10.0.0.0/8"]
  
  tags = {
    Environment = "dev"
    Project     = "webapp"
  }
}
```

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| policy_name | Name for the IAM policy | `string` | n/a | yes |
| ec2_role | Name for the EC2 IAM role | `string` | n/a | yes |
| profile_name | Name for the EC2 instance profile | `string` | n/a | yes |
| webapp_sg | Name for the web application security group | `string` | n/a | yes |
| vpc_id | ID of the VPC where security group will be created | `string` | n/a | yes |
| ingress_allowed_ips | List of CIDR blocks allowed for ingress traffic | `list(string)` | n/a | yes |
| policy_attachment | Name for the policy attachment | `string` | `"ec2-policy-attachment"` | no |
| ingress_ports | List of ports to allow for ingress traffic | `list(number)` | `[80, 443]` | no |
| egress_allowed_ips | List of CIDR blocks allowed for egress traffic | `list(string)` | `["0.0.0.0/0"]` | no |
| tags | A map of tags to assign to the resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| iam_role_arn | ARN of the EC2 IAM role |
| iam_role_name | Name of the EC2 IAM role |
| profile_name | Name of the EC2 instance profile |
| iam_policy_arn | ARN of the IAM policy |
| securitygroup_id | ID of the security group |
| securitygroup_arn | ARN of the security group |

## Security Features

### IAM Policy (Principle of Least Privilege)

The IAM policy follows the principle of least privilege and only grants:

- **S3 Access**: Limited to buckets containing the account ID
  - `s3:GetObject`, `s3:PutObject`, `s3:DeleteObject`, `s3:ListBucket`
- **CloudWatch Metrics**: Basic metrics publishing
  - `cloudwatch:PutMetricData`, `cloudwatch:GetMetricStatistics`, `cloudwatch:ListMetrics`
- **CloudWatch Logs**: Log publishing for EC2 and application logs
  - `logs:CreateLogGroup`, `logs:CreateLogStream`, `logs:PutLogEvents`

### Security Group Rules

- **Ingress**: Configurable ports (default: 80, 443) with IP restrictions
- **SSH Access**: Port 22 for management (restrict IPs in production)
- **Egress**: All outbound traffic allowed (can be restricted if needed)

## Best Practices

1. **Restrict IP Access**: Use specific CIDR blocks instead of `0.0.0.0/0`
2. **Regular Rotation**: Rotate IAM credentials regularly
3. **Monitoring**: Enable CloudTrail for IAM API calls
4. **Least Privilege**: Only grant necessary permissions
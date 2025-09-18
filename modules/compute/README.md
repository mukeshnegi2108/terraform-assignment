# Compute Module

This module creates EC2 instances with configurable security, monitoring, and storage options.

## Resources Created

- **EC2 Instance** - Web server instance with nginx
- **EBS Root Volume** - Encrypted root storage
- **User Data Script** - Automated nginx installation and configuration

## Usage

```hcl
module "compute" {
  source = "./modules/compute"
  
  # Instance Configuration
  application_name = "web-server"
  ami              = "ami-0c02fb55956c7d316"
  instance_type    = "t2.micro"
  
  # Networking & Security
  subnet_id        = "subnet-12345678"
  security_group   = "sg-12345678"
  instance_profile = "my-instance-profile"
  
  # Optional Configuration
  key_name           = "my-key-pair"
  monitoring         = true
  root_volume_size   = 20
  root_volume_type   = "gp3"
  
  tags = {
    Environment = "dev"
    Project     = "webapp"
  }
}
```

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ami | AMI ID for the EC2 instance | `string` | n/a | yes |
| application_name | Name for the application/EC2 instance | `string` | n/a | yes |
| instance_profile | IAM instance profile name to attach to the EC2 instance | `string` | n/a | yes |
| security_group | Security group ID to attach to the EC2 instance | `string` | n/a | yes |
| subnet_id | Subnet ID where the EC2 instance will be launched | `string` | n/a | yes |
| instance_type | EC2 instance type | `string` | `"t2.micro"` | no |
| key_name | Name of the EC2 Key Pair for SSH access | `string` | `null` | no |
| monitoring | Enable detailed monitoring for the EC2 instance | `bool` | `true` | no |
| root_volume_size | Size of the root EBS volume in GB | `number` | `20` | no |
| root_volume_type | Type of the root EBS volume | `string` | `"gp3"` | no |
| tags | A map of tags to assign to the resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance_id | ID of the EC2 instance |
| ec2_ip | Public IP address of the EC2 instance |
| private_ip | Private IP address of the EC2 instance |
| instance_arn | ARN of the EC2 instance |
| availability_zone | Availability zone of the EC2 instance |

## Features

### Automated Web Server Setup

The user data script automatically:

1. **Updates System**: Updates all system packages
2. **Installs Nginx**: Installs and configures nginx web server
3. **Custom Welcome Page**: Creates a dynamic welcome page with instance metadata
4. **Security Headers**: Configures nginx with security headers
5. **CloudWatch Logs**: Sets up log forwarding to CloudWatch

### Security Features

- **Encrypted Storage**: Root volume is encrypted by default
- **Security Headers**: Nginx configured with security headers
- **CloudWatch Integration**: Logs forwarded for monitoring
- **Lifecycle Management**: Instance uses `create_before_destroy`

### Instance Metadata Available

The welcome page displays:
- Instance ID
- Instance Type  
- Availability Zone
- Public IP Address
- Private IP Address
- Deployment timestamp

## User Data Script

The included user data script (`../scripts/user-data.sh`) provides:

- System updates
- Nginx installation and configuration
- Custom welcome page with instance metadata
- Security headers configuration
- CloudWatch logs agent setup
- Access and error log forwarding

## Best Practices

1. **Use Latest AMI**: Regularly update to latest Amazon Linux 2 AMI
2. **Key Pair**: Always specify a key pair for SSH access
3. **Monitoring**: Enable detailed monitoring for production
4. **Volume Encryption**: Keep root volume encryption enabled
5. **Instance Types**: Use appropriate instance types for workload
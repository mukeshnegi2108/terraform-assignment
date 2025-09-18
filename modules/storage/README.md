# Storage Module

This module creates secure S3 buckets with encryption, versioning, lifecycle management, and security controls.

## Resources Created

- **S3 Bucket** - Primary storage bucket with unique naming
- **Bucket Versioning** - Object versioning configuration
- **Server-Side Encryption** - AES256 or KMS encryption
- **Public Access Block** - Blocks all public access
- **Bucket ACL** - Access control configuration
- **Lifecycle Configuration** - Automated storage class transitions
- **Bucket Logging** - Access logging configuration

## Usage

```hcl
module "storage" {
  source = "./modules/storage"
  
  # Basic Configuration
  bucket_name = "my-app-bucket"
  region      = "us-east-1"
  bucket_acl  = "private"
  
  # Security Configuration
  encryption_algorithm = "AES256"
  bucket_versioning   = "Enabled"
  
  # Lifecycle Configuration
  lifecycle_enabled         = true
  transition_to_ia_days     = 30
  transition_to_glacier_days = 90
  expiration_days           = 365
  
  tags = {
    Environment = "dev"
    Project     = "webapp"
  }
}
```

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bucket_name | Base name for the S3 bucket (will be made unique) | `string` | n/a | yes |
| region | AWS region for the S3 bucket | `string` | `"us-east-1"` | no |
| bucket_acl | Access control list for the S3 bucket | `string` | `"private"` | no |
| encryption_algorithm | Server-side encryption algorithm for the S3 bucket | `string` | `"AES256"` | no |
| kms_master_key_id | KMS master key ID for S3 encryption (required if encryption_algorithm is aws:kms) | `string` | `null` | no |
| bucket_versioning | Versioning state for the S3 bucket | `string` | `"Enabled"` | no |
| lifecycle_enabled | Enable lifecycle management for the S3 bucket | `bool` | `true` | no |
| transition_to_ia_days | Number of days after which objects transition to IA storage class | `number` | `30` | no |
| transition_to_glacier_days | Number of days after which objects transition to Glacier storage class | `number` | `90` | no |
| expiration_days | Number of days after which objects expire | `number` | `365` | no |
| tags | A map of tags to assign to the resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| bucketname | Name of the S3 bucket |
| bucket_arn | ARN of the S3 bucket |
| bucket_id | ID of the S3 bucket |
| bucket_domain_name | Domain name of the S3 bucket |
| bucket_region | Region of the S3 bucket |

## Security Features

### Encryption
- **Default**: AES256 server-side encryption
- **Optional**: KMS encryption with customer-managed keys
- **Bucket Key**: Enabled for KMS to reduce costs

### Access Controls
- **Public Access Block**: All public access blocked by default
- **Bucket ACL**: Private by default
- **Bucket Ownership**: BucketOwnerPreferred for consistent ownership

### Versioning
- **Object Versioning**: Enabled by default
- **Version Cleanup**: Non-current versions expire after 30 days

## Lifecycle Management

When enabled, the lifecycle policy provides automated cost optimization:

1. **Standard Storage**: Objects start in standard storage
2. **Standard-IA**: Objects transition to IA after 30 days (configurable)
3. **Glacier**: Objects transition to Glacier after 90 days (configurable)
4. **Expiration**: Objects expire after 365 days (configurable)

### Storage Cost Optimization

| Storage Class | Use Case | Cost |
|---------------|----------|------|
| Standard | Frequently accessed data | Highest |
| Standard-IA | Infrequently accessed data | Medium |
| Glacier | Archive data | Lowest |

## Monitoring and Logging

### Access Logging
- **Self-logging**: Bucket logs access to itself
- **Log Prefix**: `access-logs/`
- **Log Format**: Standard S3 access log format

### CloudTrail Integration
- Works with CloudTrail for API-level logging
- Integrates with CloudWatch for monitoring

## Best Practices

1. **Unique Naming**: Bucket names include random UUID for uniqueness
2. **Encryption**: Always enable encryption in transit and at rest
3. **Versioning**: Enable versioning for data protection
4. **Lifecycle**: Use lifecycle rules for cost optimization
5. **Monitoring**: Enable access logging and CloudTrail
6. **Access Control**: Use principle of least privilege
7. **Backup**: Consider cross-region replication for critical data

## Cost Optimization

- **Lifecycle Rules**: Automatic transitions reduce storage costs
- **Intelligent Tiering**: Consider for unpredictable access patterns
- **Cleanup**: Old versions are automatically cleaned up
- **KMS Bucket Keys**: Reduce KMS costs when using KMS encryption
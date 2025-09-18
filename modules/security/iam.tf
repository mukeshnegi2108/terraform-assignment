# ==============================================================================
# IAM POLICY - PRINCIPLE OF LEAST PRIVILEGE
# ==============================================================================

# Data source to get current AWS account ID and region
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

# IAM Policy with restricted S3 and CloudWatch access
resource "aws_iam_policy" "ec2_policy" {
  name        = var.policy_name
  path        = "/"
  description = "Policy to provide limited S3 access and CloudWatch permissions to EC2"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "S3BucketAccess"
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::*${data.aws_caller_identity.current.account_id}*",
          "arn:aws:s3:::*${data.aws_caller_identity.current.account_id}*/*"
        ]
      },
      {
        Sid    = "CloudWatchMetrics"
        Effect = "Allow"
        Action = [
          "cloudwatch:PutMetricData",
          "cloudwatch:GetMetricStatistics",
          "cloudwatch:ListMetrics"
        ]
        Resource = "*"
      },
      {
        Sid    = "CloudWatchLogs"
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams"
        ]
        Resource = [
          "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/ec2/*",
          "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/var/log/*"
        ]
      }
    ]
  })
  
  tags = var.tags
}

# ==============================================================================
# IAM ROLE FOR EC2
# ==============================================================================

resource "aws_iam_role" "ec2_role" {
  name = var.ec2_role
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
  
  tags = var.tags
}

# ==============================================================================
# POLICY ATTACHMENT
# ==============================================================================

resource "aws_iam_role_policy_attachment" "ec2_policy_role" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.ec2_policy.arn
}

# ==============================================================================
# INSTANCE PROFILE
# ==============================================================================

resource "aws_iam_instance_profile" "ec2_profile" {
  name = var.profile_name
  role = aws_iam_role.ec2_role.name
  
  tags = var.tags
}
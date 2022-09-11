# Create a policy
resource "aws_iam_policy" "ec2_policy" {
  name        = var.policy_name
  path        = "/"
  description = "Policy to provide S3 access permission to EC2"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect": "Allow",
        "Action": [
            "s3:*"
        ],
        "Resource": [
            "arn:aws:s3:::*"
        ]
      }
    ]
  })
}


# Create a role
resource "aws_iam_role" "ec2_role" {
  name = var.ec2_role
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}


# Attach role to policy
resource "aws_iam_policy_attachment" "ec2_policy_role" {
  name       = var.policy_attachment
  roles      = [aws_iam_role.ec2_role.name]
  policy_arn = aws_iam_policy.ec2_policy.arn
}


# Attach role to an instance profile
resource "aws_iam_instance_profile" "ec2_profile" {
  name = var.profile_name
  role = aws_iam_role.ec2_role.name
}
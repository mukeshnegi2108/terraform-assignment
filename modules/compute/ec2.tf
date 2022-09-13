# Create EC2 instances
resource "aws_instance" "webserver" {
  ami                         = var.ami
  instance_type               = var.instance_type
  iam_instance_profile        = var.instance_profile
  vpc_security_group_ids      = [var.security_group]
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  tags = merge(
    {
      Name = var.application_name
  }, var.tags)
  user_data = "${file("../../modules/scripts/user-data.sh")}"
}
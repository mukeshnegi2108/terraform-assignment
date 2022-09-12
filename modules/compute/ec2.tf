# Create EC2 instances
resource "aws_instance" "webserver" {
  ami                         = var.ami
  ebs_optimized               = true
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

  provisioner "file" {
    source      = "scripts/cw_agent_config.json"
    destination = "/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json"
    on_failure  = continue //incase the provisioner fails, it'll continue with the infra creation.
  }

  connection {
    type        = "ssh"
    user        = var.webapp_user
    private_key = "${file("~/Downloads/tf-key.pem")}"
    host        = "${self.public_ip}"
  }
}
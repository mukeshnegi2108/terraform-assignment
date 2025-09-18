# ==============================================================================
# EC2 INSTANCE CONFIGURATION
# ==============================================================================

resource "aws_instance" "webserver" {
  ami                     = var.ami
  instance_type           = var.instance_type
  iam_instance_profile    = var.instance_profile
  vpc_security_group_ids  = [var.security_group]
  subnet_id               = var.subnet_id
  key_name                = var.key_name
  monitoring              = var.monitoring
  
  # Public IP assignment
  associate_public_ip_address = true
  
  # Root volume configuration
  root_block_device {
    volume_type           = var.root_volume_type
    volume_size           = var.root_volume_size
    delete_on_termination = true
    encrypted             = true
    
    tags = merge(
      {
        Name = "${var.application_name}-root-volume"
      },
      var.tags
    )
  }
  
  # User data script for nginx installation
  user_data = file("${path.module}/../scripts/user-data.sh")
  
  # Instance tags
  tags = merge(
    {
      Name = var.application_name
      Type = "WebServer"
    },
    var.tags
  )
  
  # Lifecycle management
  lifecycle {
    create_before_destroy = true
  }
}
# ==============================================================================
# SECURITY GROUP CONFIGURATION
# ==============================================================================

resource "aws_security_group" "myapp_sg" {
  name        = var.webapp_sg
  description = "Security group for web application"
  vpc_id      = var.vpc_id
  
  # HTTP access
  dynamic "ingress" {
    for_each = var.ingress_ports
    content {
      description = "HTTP/HTTPS access on port ${ingress.value}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = var.ingress_allowed_ips
    }
  }
  
  # SSH access (restrict to specific IPs in production)
  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ingress_allowed_ips
  }
  
  # Outbound internet access
  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.egress_allowed_ips
  }
  
  tags = merge(
    {
      Name = var.webapp_sg
    },
    var.tags
  )
}
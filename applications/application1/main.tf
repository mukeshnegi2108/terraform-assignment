# ==============================================================================
# NETWORKING MODULE
# ==============================================================================

module "application-networking" {
  source = "../../modules/networking"
  
  # Naming
  vpc_name         = var.vpc_name
  subnet_name      = var.subnet_name
  route_table_name = var.route_table_name
  igw_name         = var.igw_name
  
  # Tagging
  tags = local.common_tags
}

# ==============================================================================
# SECURITY MODULE
# ==============================================================================

module "application-security" {
  source = "../../modules/security"
  
  # IAM Configuration
  policy_name  = var.policy_name
  ec2_role     = var.ec2_role
  profile_name = var.profile_name
  
  # Security Group Configuration
  webapp_sg           = var.webapp_sg
  ingress_allowed_ips = var.ingress_allowed_ips
  vpc_id              = module.application-networking.vpc_id
  
  # Tagging
  tags = local.common_tags
}

# ==============================================================================
# STORAGE MODULE
# ==============================================================================

module "application-storage" {
  source = "../../modules/storage"
  
  # S3 Configuration
  bucket_name = "${local.name_prefix}-${var.application_name}-bucket"
  region      = var.region
  bucket_acl  = var.bucket_acl
  
  # Tagging
  tags = local.common_tags
}

# ==============================================================================
# COMPUTE MODULE
# ==============================================================================

module "application" {
  source = "../../modules/compute"
  
  # Instance Configuration
  application_name = var.application_name
  ami              = data.aws_ami.app_ami.id
  instance_type    = var.instance_type
  
  # Networking & Security
  subnet_id        = module.application-networking.subnet_id
  security_group   = module.application-security.securitygroup_id
  instance_profile = module.application-security.profile_name
  
  # Tagging
  tags = local.common_tags
}


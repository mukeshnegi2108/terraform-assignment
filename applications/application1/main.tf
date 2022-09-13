module "application-networking" {
  source           = "../../modules/networking"
  vpc_name         = var.vpc_name
  subnet_name      = var.subnet_name
  route_table_name = var.route_table_name
  igw_name         = var.igw_name
  tags             = local.common_tags
}

module "application-security" {
  source              = "../../modules/security"
  policy_name         = var.policy_name
  ec2_role            = var.ec2_role
  profile_name        = var.profile_name
  ingress_allowed_ips = var.ingress_allowed_ips
  webapp_sg           = var.webapp_sg
  vpc_id              = module.application-networking.vpc_id
  tags                = local.common_tags
}

module "application-storage" {
  source      = "../../modules/storage"
  bucket_name = "${var.application_name}-bucket"
  region      = var.region
  bucket_acl  = var.bucket_acl
  tags        = local.common_tags
}

module "application" {
  source           = "../../modules/compute"
  application_name = var.application_name
  ami              = data.aws_ami.app_ami.id
  instance_type    = var.instance_type
  instance_profile = module.application-security.profile_name
  subnet_id        = module.application-networking.subnet_id
  security_group   = module.application-security.securitygroup_id
  tags             = local.common_tags
}


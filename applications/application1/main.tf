
module "application-networking" {
  source = "../../modules/networking"
  vpc_name = ""
  subnet_name = ""
  route_table_name = ""
  igw_name = ""
  tags = local.common_tags
}

module "application-security" {
  source = "../../modules/security"
  policy_name = ""
  ec2_role = ""
  profile_name = ""
  webapp_sg = ""
  vpc_id = module.application-networking.vpc_id
  tags = local.common_tags
}

#module "application-monitoring" {
#  source = "../../modules/monitoring"
#  tags = local.common_tags
#}

module "application-storage" {
  source = "../../modules/storage"
  bucket_name = ""
  region = ""
  bucket_acl = ""
  tags = local.common_tags
}

module "application" {
  source = "../../modules/compute"
  application_name = ""
  ami = data.aws_ami.app_ami.id
  instance_type = var.instance_type
  instance_profile = module.application-security.profile_name
  security_group = module.application-security.securitygroup_id
  tags = local.common_tags
}


output "vpc_details" {
  value = module.application-networking.vpc_id
}

output "sg_details" {
  value = module.application-security.securitygroup_id
}

output "details" {
  value = module.application-storage.bucketname
}

output "Application_server" {
  value = module.application.describe_ec2
}
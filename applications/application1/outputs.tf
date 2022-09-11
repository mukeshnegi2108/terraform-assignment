output "vpc_details" {
  value = module.application-networking.vpc_id
}

output "sg_details" {
  value = module.application-security.securitygroup_id
}

output "bucket_name" {
  value = module.application-storage.bucketname
}

output "application_server" {
  value = module.application.describe_ec2
}
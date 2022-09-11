output "vpc_details" {
  value = module.app-infrastructure.vpc_details
}

output "sg_details" {
  value = module.app-infrastructure.sg_details
}

output "bucket_name" {
  value = module.app-infrastructure.bucket_name
}

output "application_server" {
  value = module.app-infrastructure.application_server
}

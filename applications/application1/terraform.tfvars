vpc_name            = "my-vpc"
subnet_name         = "my-vpc-public-subnet"
route_table_name    = "my-vpc-route-table"
igw_name            = "my-vpc-igw"
policy_name         = "s3-access-policy"
ec2_role            = "ec2-role"
profile_name        = "s3-access"
webapp_sg           = "application1-sg"
ingress_allowed_ips = ["0.0.0.0/0"]
bucket_name         = "app1-bucket"
bucket_acl          = "private"
application_name    = "app1-webserver"
instance_type       = "t2.micro"
webapp_user         = "ubuntu"
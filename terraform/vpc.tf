# module "vpc" {
#   source = "./modules/terraform-aws-vpc-module"

# #   vpc_id = data.aws.vpc.adex_poc_default_vpc.id
#   name   = local.vpc.vpc_name
#   cidr   = data.aws_vpc.adex_poc_default_vpc.cidr_block
#   region = var.region

#   azs              = slice(data.aws_availability_zones.available.names, 0, local.vpc.number_of_azs)
#   public_subnets   = local.vpc.public_subnets
#   private_subnets  = local.vpc.private_subnets
#   database_subnets = local.vpc.database_subnets
#   create_igw       = false

#   manage_default_network_acl    = false
#   manage_default_route_table    = false
#   manage_default_security_group = false
#   create_database_subnet_group  = true

#   enable_dns_hostnames = true
#   enable_dns_support   = true

#   enable_nat_gateway = false
#   single_nat_gateway = false

#   # VPC Flow Logs
#   enable_flow_log                      = true
#   create_flow_log_cloudwatch_log_group = true
#   create_flow_log_cloudwatch_iam_role  = true
#   flow_log_max_aggregation_interval    = 60


#   tags = {
#     name = "vpc"
#   }
# }

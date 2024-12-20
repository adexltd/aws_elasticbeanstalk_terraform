module "vpc" {
  source = "./modules/terraform-aws-vpc-module"

  #   vpc_id = data.aws.vpc.adex_poc_default_vpc.id
  name = local.vpc.vpc_name
  #   cidr   = data.aws_vpc.adex_poc_default_vpc.cidr_block
  cidr   = local.vpc.vpc_cidr
  region = var.region

  azs              = local.vpc.azs
  private_subnets  = [for k, v in local.vpc.azs : cidrsubnet(local.vpc.vpc_cidr, 4, k)]
  public_subnets   = [for k, v in local.vpc.azs : cidrsubnet(local.vpc.vpc_cidr, 4, k + 4)]
  database_subnets = [for k, v in local.vpc.azs : cidrsubnet(local.vpc.vpc_cidr, 4, k + 8)]
  create_igw       = true

  manage_default_network_acl    = false
  manage_default_route_table    = false
  manage_default_security_group = false
  create_database_subnet_group  = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway = true
  single_nat_gateway = true

  # VPC Flow Logs
  enable_flow_log                      = true
  create_flow_log_cloudwatch_log_group = true
  create_flow_log_cloudwatch_iam_role  = true
  flow_log_max_aggregation_interval    = 60


  tags = {
    name = "vpc"
  }
}

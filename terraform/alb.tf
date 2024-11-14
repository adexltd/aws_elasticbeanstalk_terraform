module "alb" {
  source  = "cloudposse/alb/aws"
  version = "1.10.0"

  vpc_id              = module.vpc.vpc_id
  subnet_ids          = module.vpc.public_subnets
  access_logs_enabled = false

  attributes = ["shared"]
}

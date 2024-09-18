locals {
  region      = "us-east-1"
  environment = var.naming_environment
  name        = var.project

  # # VPC
  # vpc = {
  #   vpc_name = module.naming.resources.vpc.name
  #   vpc_cidr = var.vpc_cidr
  #   azs      = slice(data.aws_availability_zones.available.names, 0, var.number_of_azs)
  # }

  # Application load balancer
  alb = {
    alb_name = module.naming.resources.alb.name
    vpc_id   = data.aws_vpc.adex_poc_default_vpc
    # public_subnets = [data.aws_subnets.private_subnets.id[0], data.aws_subnets.private_subnets.id[1]]
    # vpc_id                           = module.vpc.vpc_id
    # public_subnets                   = [module.vpc.private_subnets[0], module.vpc.private_subnets[1]]
    subnets                          = var.private_subnets
    internal                         = var.internal
    load_balancer_type               = var.load_balancer_type
    enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing
    enable_deletion_protection       = var.enable_deletion_protection
    backend_port                     = var.backend_port
    backend_protocol                 = var.backend_protocol
    target_group_name                = "${var.environment}-ebs-alb"
    target_group_index               = var.target_group_index
    target_type                      = var.target_type
    create_attachment                = var.create_attachment
  }

  # elastic_beanstalk_application
  elastic_beanstalk_application = {
    name        = "${module.naming.resources.prefix.name}-eb-app"
    description = "Test Elastic Beanstalk application"
  }

  elastic_beanstalk_environment = {
    name        = "${module.naming.resources.prefix.name}-eb-env"
    description = var.description
    tier        = var.tier
  }


  ### secrets_manager
  secrets_manager = {
    name_prefix           = "${var.naming_environment}-elasticbeanstalk-rds-secrets"
    description           = "Secrets Manager secret for RDS database"
    region                = var.region
    enable_rotation       = false
    ignore_secret_changes = true
  }


  #### RDS 
  rds = {
    identifier                   = module.naming.resources.rds.name
    engine                       = "mysql"
    engine_version               = var.engine_version
    family                       = var.family
    major_engine_version         = var.major_engine_version
    instance_class               = var.instance_class
    allocated_storage            = var.allocated_storage
    port                         = var.port
    create_db_parameter_group    = var.create_db_parameter_group
    create_db_option_group       = var.create_db_option_group
    multi_az                     = var.multi_az
    skip_final_snapshot          = var.skip_final_snapshot
    db_name                      = var.db_name
    username                     = var.username
    apply_immediately            = true
    create_random_password       = true
    performance_insights_enabled = var.performance_insights_enabled
  }


  ### S3
  s3_bucket = {
    name = module.naming.resources.s3.name
  }
}

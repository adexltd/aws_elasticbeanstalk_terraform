
module "rds" {
  source                       = "./modules/terraform-aws-rds-module"
  identifier                   = local.rds.identifier
  region                       = var.region
  engine                       = local.rds.engine
  engine_version               = local.rds.engine_version
  family                       = local.rds.family
  major_engine_version         = local.rds.major_engine_version
  instance_class               = local.rds.instance_class
  allocated_storage            = local.rds.allocated_storage
  db_name                      = local.rds.db_name
  username                     = local.rds.username
  port                         = local.rds.port
  create_db_parameter_group    = local.rds.create_db_parameter_group
  create_db_option_group       = local.rds.create_db_option_group
  monitoring_interval          = 0
  multi_az                     = local.rds.multi_az
  skip_final_snapshot          = local.rds.skip_final_snapshot
  deletion_protection          = false
  db_subnet_group_name         = module.vpc.database_subnet_group
  vpc_security_group_ids       = [aws_security_group.database.id]
  apply_immediately            = local.rds.apply_immediately
  create_random_password       = local.rds.create_random_password
  performance_insights_enabled = local.rds.performance_insights_enabled

  tags = module.naming.resources.rds.tags

}

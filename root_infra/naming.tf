module "naming" {
  source = "./modules/terraform-naming-convention-module"

  app_name       = "elasticbeanstalk"
  project_prefix = "ebs"
  app_name_short = "eb"
  environment    = local.environment
  aws_region     = local.region
  tags = {
    environment = var.naming_environment
    client      = "beanstalk_project"
    terraform   = true
  }
}

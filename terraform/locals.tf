locals {
  region      = "us-east-1"
  environment = var.naming_environment
  name        = var.project

  # VPC
  vpc = {
    vpc_name = module.naming.resources.vpc.name
    vpc_cidr = var.vpc_cidr
    azs      = slice(data.aws_availability_zones.available.names, 0, var.number_of_azs)
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

  ### S3
  s3_bucket = {
    name = module.naming.resources.s3.name
  }
}

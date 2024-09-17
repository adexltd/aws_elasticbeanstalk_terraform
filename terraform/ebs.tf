################################################################################
# Defines and manages the terraform resources
################################################################################
module "elastic_beanstalk_application" {
  source      = "./modules/terraform-aws-elastic-beanstalk-module/modules/app"
  name        = local.elastic_beanstalk_application.name
  description = local.elastic_beanstalk_application.description
}


module "elastic_beanstalk_environment" {
  source = "./modules/terraform-aws-elastic-beanstalk-module/modules/environment"

  name                       = local.elastic_beanstalk_environment.name
  description                = local.elastic_beanstalk_environment.description
  region                     = var.region
  availability_zone_selector = var.availability_zone_selector

  wait_for_ready_timeout             = var.wait_for_ready_timeout
  elastic_beanstalk_application_name = module.elastic_beanstalk_application.elastic_beanstalk_application_name
  environment_type                   = var.environment_type
  loadbalancer_type                  = var.loadbalancer_type
  loadbalancer_is_shared             = var.loadbalancer_is_shared
  shared_loadbalancer_arn            = module.alb.lb_arn
  healthcheck_url                    = "/"

  tier          = var.tier
  version_label = var.version_label

  instance_type    = var.instance_type
  root_volume_size = var.root_volume_size
  root_volume_type = var.root_volume_type

  autoscale_min             = var.autoscale_min
  autoscale_max             = var.autoscale_max
  autoscale_measure_name    = var.autoscale_measure_name
  autoscale_statistic       = var.autoscale_statistic
  autoscale_unit            = var.autoscale_unit
  autoscale_lower_bound     = var.autoscale_lower_bound
  autoscale_lower_increment = var.autoscale_lower_increment
  autoscale_upper_bound     = var.autoscale_upper_bound
  autoscale_upper_increment = var.autoscale_upper_increment

  vpc_id               = data.aws_vpc.adex_poc_default_vpc.id
  loadbalancer_subnets = var.public_subnets
  application_subnets  = var.private_subnets

  rolling_update_enabled  = var.rolling_update_enabled
  rolling_update_type     = var.rolling_update_type
  updating_min_in_service = var.updating_min_in_service
  updating_max_batch      = var.updating_max_batch

  solution_stack_name = var.solution_stack_name

  additional_settings = var.additional_settings
  #   additional_settings = [
  #     {
  #       namespace = "aws:elasticbeanstalk:environment:process:default"
  #       name      = "StickinessEnabled"
  #       value     = "false"
  #     },
  #     {
  #       namespace = "aws:elasticbeanstalk:managedactions"
  #       name      = "ManagedActionsEnabled"
  #       value     = "false"
  #     }
  #   ]

  env_vars = var.env_vars

  extended_ec2_policy_document = data.aws_iam_policy_document.minimal_s3_permissions.json
  prefer_legacy_ssm_policy     = false
  prefer_legacy_service_policy = false
  scheduled_actions            = var.scheduled_actions

  depends_on = [module.alb]

#   tags = module.naming.resources.prefix.tags

}

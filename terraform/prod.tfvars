region             = "us-east-1"
naming_environment = "development"
environment        = "dev"

## Variables for VPC
vpc_cidr      = "10.0.0.0/16"
number_of_azs = 2

## Variables for Elastic Beanstalk Environment
description                = "Test elastic-beanstalk-environment"
tier                       = "WebServer"
environment_type           = "LoadBalanced"
loadbalancer_type          = "application"
loadbalancer_is_shared     = true
availability_zone_selector = "Any 2"
wait_for_ready_timeout     = "20m"
version_label              = ""
solution_stack_name        = "64bit Amazon Linux 2 v5.9.7 running Node.js 18"
instance_type              = "t2.micro"
root_volume_size           = 8
root_volume_type           = "gp2"
autoscale_min              = 1
autoscale_max              = 2
autoscale_measure_name     = "CPUUtilization"
autoscale_statistic        = "Average"
autoscale_unit             = "Percent"
autoscale_lower_bound      = 20
autoscale_lower_increment  = -1
autoscale_upper_bound      = 80
autoscale_upper_increment  = 1
rolling_update_enabled     = true
rolling_update_type        = "Health"
updating_min_in_service    = 0
updating_max_batch         = 1
additional_settings = [
  {
    namespace = "aws:elasticbeanstalk:managedactions"
    name      = "ManagedActionsEnabled"
    value     = "false"
  },
  {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "StickinessEnabled"
    value     = "false"
  }
]

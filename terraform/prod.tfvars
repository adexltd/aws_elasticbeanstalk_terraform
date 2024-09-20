region             = "us-east-1"
naming_environment = "development"
environment        = "dev"

## Variables for VPC
vpc_id = "vpc-03d964f7cd3fa2c74"
# vpc_cidr      = "10.0.0.0/16"
# number_of_azs = 2

## Variables for ALB
internal                         = false
load_balancer_type               = "application"
enable_cross_zone_load_balancing = true
enable_deletion_protection       = false
private_subnets                  = ["subnet-094222bc07bb63e74", "subnet-0a6f15fc861987834"]
backend_port                     = 80
backend_protocol                 = "HTTP"
target_group_index               = 0
target_type                      = "instance"
create_attachment                = false


## Variables for Elastic Beanstalk Environment
description                = "Test elastic-beanstalk-environment"
tier                       = "WebServer"
environment_type           = "LoadBalanced"
loadbalancer_type          = "application"
loadbalancer_is_shared     = true
availability_zone_selector = "Any 2"
availability_zones         = ["us-east-1a", "us-east-1b"]
wait_for_ready_timeout     = "20m"
version_label              = ""
solution_stack_name        = "64bit Amazon Linux 2023 v6.2.0 running Node.js 20"
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
public_subnets             = ["subnet-0f97b0bb45cdeb3b7", "subnet-0cd1b0c6e27ef5b97"]
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

env_vars = {
  "DB_HOST"         = "localhost"
  "DB_USERNAME"     = "elasticbeanstalk"
  "DB_PASSWORD"     = ""
  }

scheduled_actions = [
  {
    name            = "Refreshinstances"
    minsize         = "1"
    maxsize         = "2"
    desiredcapacity = "2"
    starttime       = "2015-05-14T07:00:00Z"
    endtime         = "2025-01-12T07:00:00Z"
    recurrence      = "*/20 * * * *"
    suspend         = false
  }
]


# Variable for Secrets managers
enable_rotation         = false
recovery_window_in_days = 0


## Variable for RDS
engine_version               = "8.0.39"
family                       = "mysql8.0"
major_engine_version         = "8.0"
instance_class               = "db.t3.micro"
allocated_storage            = 20
port                         = "3306"
create_db_parameter_group    = false
create_db_option_group       = false
multi_az                     = false
skip_final_snapshot          = true
performance_insights_enabled = false
db_name                      = "elasticbeanstalk"
username                     = "elasticbeanstalk"

################################################################################
# variables defination
###############################################################################

variable "region" {
  description = "Region be used for all the resources"
}

variable "environment" {
  type        = string
  description = "Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT'"
}

variable "naming_environment" {
  description = "Name of the environment"
  type        = string
}

variable "project" {
  description = "Name of the Project"
  type        = string
  default     = ""
}


#################################################################################
# variables for VPC
#################################################################################

variable "vpc_cidr" {
  description = "cidr of vpc"
}

# variable "vpc_name" {
#   description = "name of vpc"
# }

variable "number_of_azs" {
  description = "number of availability zones"
  type        = number
}

# variable "vpc_id" {
#   description = "The default VPC"
#   # default     = "vpc-03d964f7cd3fa2c74"
# }

################################################################################
# variables for elastic beanstalk environment
###############################################################################

variable "description" {
  type        = string
  description = "Short description of the Environment"
}

variable "environment_type" {
  type        = string
  description = "Environment type, e.g. 'LoadBalanced' or 'SingleInstance'.  If setting to 'SingleInstance', `rolling_update_type` must be set to 'Time', `updating_min_in_service` must be set to 0, and `loadbalancer_subnets` will be unused (it applies to the ELB, which does not exist in SingleInstance environments)"
}

variable "tier" {
  type        = string
  description = "Elastic Beanstalk Environment tier, e.g. 'WebServer' or 'Worker'"
}

variable "loadbalancer_type" {
  type        = string
  description = "Load Balancer type, e.g. 'application' or 'classic'"
}

variable "loadbalancer_is_shared" {
  type        = bool
  default     = false
  description = "Flag to create a shared application loadbalancer. Only when loadbalancer_type = \"application\" https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/environments-cfg-alb-shared.html"
}

variable "availability_zone_selector" {
  type        = string
  description = "Availability Zone selector"
}

variable "wait_for_ready_timeout" {
  type        = string
  description = "The maximum duration to wait for the Elastic Beanstalk Environment to be in a ready state before timing out"
}

variable "version_label" {
  type        = string
  description = "Elastic Beanstalk Application version to deploy"
}

variable "solution_stack_name" {
  type        = string
  description = "Elastic Beanstalk stack, e.g. Docker, Go, Node, Java, IIS. For more info, see https://docs.aws.amazon.com/elasticbeanstalk/latest/platforms/platforms-supported.html"
}

variable "instance_type" {
  type        = string
  description = "Instances type"
}

variable "root_volume_size" {
  type        = number
  description = "The size of the EBS root volume"
}

variable "root_volume_type" {
  type        = string
  description = "The type of the EBS root volume"
}

variable "autoscale_min" {
  type        = number
  description = "Minumum instances to launch"
}

variable "autoscale_max" {
  type        = number
  description = "Maximum instances to launch"
}

variable "autoscale_measure_name" {
  type        = string
  description = "Metric used for your Auto Scaling trigger"
}

variable "autoscale_statistic" {
  type        = string
  description = "Statistic the trigger should use, such as Average"
}

variable "autoscale_unit" {
  type        = string
  description = "Unit for the trigger measurement, such as Bytes"
}

variable "autoscale_lower_bound" {
  type        = number
  description = "Minimum level of autoscale metric to remove an instance"
}

variable "autoscale_lower_increment" {
  type        = number
  description = "How many Amazon EC2 instances to remove when performing a scaling activity."
}

variable "autoscale_upper_bound" {
  type        = number
  description = "Maximum level of autoscale metric to add an instance"
}

variable "autoscale_upper_increment" {
  type        = number
  description = "How many Amazon EC2 instances to add when performing a scaling activity"
}

variable "rolling_update_enabled" {
  type        = bool
  description = "Whether to enable rolling update"
}

variable "rolling_update_type" {
  type        = string
  description = "`Health` or `Immutable`. Set it to `Immutable` to apply the configuration change to a fresh group of instances"
}

variable "updating_min_in_service" {
  type        = number
  description = "Minimum number of instances in service during update"
}

variable "updating_max_batch" {
  type        = number
  description = "Maximum number of instances to update at once"
}

# variable "public_subnets" {
#   description = "loadbalancer subnets"
# }

variable "additional_settings" {
  type = list(object({
    namespace = string
    name      = string
    value     = string
  }))

  description = "Additional Elastic Beanstalk setttings. For full list of options, see https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/command-options-general.html"
  default     = []
}

variable "env_vars" {
  type        = map(string)
  default     = {}
  description = "Map of custom ENV variables to be provided to the application running on Elastic Beanstalk, e.g. env_vars = { DB_USER = 'admin' DB_PASS = 'xxxxxx' }"
}

variable "scheduled_actions" {
  type = list(object({
    name            = string
    minsize         = string
    maxsize         = string
    desiredcapacity = string
    starttime       = string
    endtime         = string
    recurrence      = string
    suspend         = bool
  }))
  default     = []
  description = "Define a list of scheduled actions"
}

# variable "availability_zones" {
#   type        = list(string)
#   description = "List of availability zones"
# }

#################################################################################
# Variables for ALB
#################################################################################

variable "internal" {
  description = "Determines whether the ALB is internal or internet facing"
  type        = bool
}

variable "load_balancer_type" {
  description = "Type of load balancer"
  type        = string
}

variable "enable_cross_zone_load_balancing" {
  description = "Determines whether cross zone load balancing is enabled"
  type        = bool
}

variable "enable_deletion_protection" {
  description = "Determines whether deletion protection is enabled"
  type        = bool
}

# variable "private_subnets" {
#   description = "Subnets ids for alb"
#   # type        = string
# }

variable "backend_port" {
  description = "value of the backend port"
  type        = number
}

variable "backend_protocol" {
  description = "value of the backend protocol"
  type        = string
}

variable "target_group_index" {
  description = "value of the target group index"
  type        = number
}

variable "target_type" {
  description = "target type for load balancer"
  type        = string
}

variable "create_attachment" {
  description = "create_attachment for target"
  type        = bool
}

################################################################################
# variables for secrets manager
################################################################################
variable "enable_rotation" {
  description = "Determines whether secret rotation is enabled"
  type        = bool
  default     = true
}

variable "recovery_window_in_days" {
  description = "Number of days that AWS Secrets Manager waits before it can delete the secret. This value can be `0` to force deletion without recovery or range from `7` to `30` days. The default value is `30`"
  type        = number
  default     = null
}


################################################################################
# Variables for RDS
################################################################################

variable "engine_version" {
  description = "Database engine version"
  type        = string
}

variable "family" {
  description = "Database family"
  type        = string
}

variable "major_engine_version" {
  description = "Database major engine version"
  type        = string
}

variable "instance_class" {
  description = "Database instance class"
  type        = string
}

variable "allocated_storage" {
  description = "Database allocated storage"
  type        = number
}

variable "port" {
  description = "Database port"
  type        = string
}

variable "create_db_parameter_group" {
  description = "Database parameter group"
  type        = bool
}

variable "create_db_option_group" {
  description = "Database option group"
  type        = bool
}

variable "multi_az" {
  description = "Database multi az support"
  type        = bool
}

variable "skip_final_snapshot" {
  description = "Database skip final snapshot"
  type        = bool
}

variable "performance_insights_enabled" {
  description = "t3.micro doesnot support enabling"
  type        = bool
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "username" {
  description = "Username for the master DB user"
  type        = string
}

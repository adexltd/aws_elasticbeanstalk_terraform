variable "description" {
  type        = string
  default     = ""
  description = "Elastic Beanstalk Application description"
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Whether to elastic beanstalk"
}
variable "name" {
  type        = string
  default     = ""
  description = "Name of the elasticbeanstalk"
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)."
}

variable "appversion_lifecycle_service_role_arn" {
  type        = string
  description = "The service role ARN to use for application version cleanup. If left empty, the `appversion_lifecycle` block will not be created"
  default     = ""
}

variable "appversion_lifecycle_max_count" {
  type        = number
  default     = 200
  description = "The max number of application versions to keep. if left as default and `appversion_lifecycle_max_age_in_days` is set, `appversion_lifecycle_max_age_in_days` will be used. Otherwise `appversion_lifecycle_max_count` will take place"
}

variable "appversion_lifecycle_max_age_in_days" {
  type        = number
  default     = null
  description = "The number of days to retain an application version "
}

variable "appversion_lifecycle_delete_source_from_s3" {
  type        = bool
  default     = false
  description = "Whether to delete application versions from S3 source"
}

variable "create_lifecycle_service_role" {
  type        = bool
  default     = false
  description = "Whether to create service role for application version cleanup. If set, `appversion_lifecycle_service_role_arn` will be ignored"
}

variable "prefer_legacy_service_policy" {
  type        = bool
  default     = true
  description = "Whether to use AWSElasticBeanstalkService (deprecated) or AWSElasticBeanstalkManagedUpdatesCustomerRolePolicy policy"
}

#####################################################
##     Elasticbeanstalk Application Versions       ##
#####################################################
variable "eb_application_version_enabled" {
  type        = bool
  description = "Whether to create Elastic Beanstalk application version"
  default     = false
}
variable "eb_application_versions" {
  description = "A map of Elastic Beanstalk application versions"
  type = map(object({
    application  = string
    bucket       = string
    key          = string
    description  = optional(string)
    force_delete = optional(string)
    tags         = optional(map(string))

  }))
  default = {
    test-eb-app-version = {
      application  = null
      bucket       = null
      key          = null
      description  = null
      force_delete = null
      tags         = {}
    }
  }
}

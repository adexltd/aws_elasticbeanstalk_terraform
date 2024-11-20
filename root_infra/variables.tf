variable "region" {
  type        = string
  description = "Region be used for all the resources"
}

variable "environment" {
  type        = string
  description = "Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT'"
}

variable "namespace" {
  type        = string
  description = "Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp'"
}

variable "name" {
  type        = string
  description = "Solution name, e.g. 'app' or 'jenkins'"
}

variable "enable_server_side_encryption" {
  type        = bool
  description = "Enable DynamoDB server-side encryption"
}

variable "block_public_acls" {
  type        = bool
  description = "Whether Amazon S3 should block public ACLs for this bucket."
}

variable "block_public_policy" {
  type        = bool
  description = "Whether Amazon S3 should block public bucket policies for this bucket."
}

variable "restrict_public_buckets" {
  type        = bool
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket."
}

variable "bucket_replication_enabled" {
  type        = bool
  description = "Enable/Disable replica for S3 bucket (for cross region replication purpose)"
}

variable "enforce_ssl_requests" {
  type        = bool
  description = "Enable/Disable replica for S3 bucket (for cross region replication purpose)"
}

variable "naming_environment" {
  description = "Name of the environment"
  type        = string

}

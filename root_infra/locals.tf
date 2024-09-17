locals {
  region      = "us-east-1"
  environment = var.naming_environment
  terraform_state_backend_bucket = {
    bucket_name                   = module.naming.resources.s3.name
    bucket_replication_enabled    = var.bucket_replication_enabled
    namespace                     = var.namespace
    block_public_acls             = var.block_public_acls
    block_public_policy           = var.block_public_policy
    enable_server_side_encryption = var.enable_server_side_encryption
    restrict_public_buckets       = var.restrict_public_buckets
    enforce_ssl_requests          = var.enforce_ssl_requests
    region                        = var.region
  }
}

module "terraform_state_backend" {
  source                        = "./modules/terraform-aws-tfstate-backend-module"
  namespace                     = local.terraform_state_backend_bucket.namespace
  environment                   = local.environment
  name                          = local.terraform_state_backend_bucket.bucket_name
  bucket_replication_enabled    = local.terraform_state_backend_bucket.bucket_replication_enabled
  block_public_acls             = local.terraform_state_backend_bucket.block_public_acls
  block_public_policy           = local.terraform_state_backend_bucket.block_public_policy
  enable_server_side_encryption = local.terraform_state_backend_bucket.enable_server_side_encryption
  restrict_public_buckets       = local.terraform_state_backend_bucket.restrict_public_buckets
  enforce_ssl_requests          = local.terraform_state_backend_bucket.enforce_ssl_requests
  region                        = local.terraform_state_backend_bucket.region
}

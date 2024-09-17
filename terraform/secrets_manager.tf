module "secrets_manager" {
  source                = "./modules/terraform-aws-secretsmanager-module"
  region                = local.secrets_manager.region
  name                  = local.secrets_manager.name_prefix
  description           = local.secrets_manager.description
  enable_rotation       = local.secrets_manager.enable_rotation
  ignore_secret_changes = local.secrets_manager.ignore_secret_changes
  create                = true
  secret_string = jsonencode({
    password = module.rds.db_instance_password
  })

#   tags = module.naming.resources.secrets_manager.tags

}

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_naming"></a> [naming](#module\_naming) | ./modules/terraform-naming-convention-module | n/a |
| <a name="module_terraform_state_backend"></a> [terraform\_state\_backend](#module\_terraform\_state\_backend) | ./modules/terraform-aws-tfstate-backend-module | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_block_public_acls"></a> [block\_public\_acls](#input\_block\_public\_acls) | Whether Amazon S3 should block public ACLs for this bucket. | `bool` | n/a | yes |
| <a name="input_block_public_policy"></a> [block\_public\_policy](#input\_block\_public\_policy) | Whether Amazon S3 should block public bucket policies for this bucket. | `bool` | n/a | yes |
| <a name="input_bucket_replication_enabled"></a> [bucket\_replication\_enabled](#input\_bucket\_replication\_enabled) | Enable/Disable replica for S3 bucket (for cross region replication purpose) | `bool` | n/a | yes |
| <a name="input_enable_server_side_encryption"></a> [enable\_server\_side\_encryption](#input\_enable\_server\_side\_encryption) | Enable DynamoDB server-side encryption | `bool` | n/a | yes |
| <a name="input_enforce_ssl_requests"></a> [enforce\_ssl\_requests](#input\_enforce\_ssl\_requests) | Enable/Disable replica for S3 bucket (for cross region replication purpose) | `bool` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT' | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Solution name, e.g. 'app' or 'jenkins' | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp' | `string` | n/a | yes |
| <a name="input_naming_environment"></a> [naming\_environment](#input\_naming\_environment) | Name of the environment | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region be used for all the resources | `string` | n/a | yes |
| <a name="input_restrict_public_buckets"></a> [restrict\_public\_buckets](#input\_restrict\_public\_buckets) | Whether Amazon S3 should restrict public bucket policies for this bucket. | `bool` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

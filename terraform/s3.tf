module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.1.2"

  bucket = local.s3_bucket.name
  acl    = "private"

  control_object_ownership = true
  force_destroy            = true
  object_ownership         = "BucketOwnerPreferred"
  attach_policy            = true
  policy                   = data.aws_iam_policy_document.s3_bucket_policy.json


  versioning = {
    enabled = true
  }

  tags = module.naming.resources.s3.tags

}

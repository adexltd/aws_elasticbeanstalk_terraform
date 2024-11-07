terraform {
  backend "s3" {
    region         = "us-east-1"
    key            = "675738512763/beanstalk_project.tfstate"
    bucket         = "adex-terraform-state"
    dynamodb_table = "adex-terraform-state"
    acl            = "bucket-owner-full-control"
    encrypt        = true
  }
}

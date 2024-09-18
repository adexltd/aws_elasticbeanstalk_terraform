data "aws_availability_zones" "available" {}


data "aws_ami" "ami_id" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "state"
    values = ["available"]
  }
}


data "aws_vpc" "adex_poc_default_vpc" {
  id = var.vpc_id
}

# data "aws_subnets" "default" {
#   vpc_id = data.aws_vpc.adex_poc_default_vpc.id
# }
data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

data "aws_subnet" "subnet" {
  for_each = toset(data.aws_subnets.subnets.ids)
  id       = each.value
}

data "aws_iam_policy_document" "minimal_s3_permissions" {

  statement {
    sid = "AllowS3OperationsOnElasticBeanstalkBuckets"
    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation"
    ]
    resources = ["*"]
  }
}

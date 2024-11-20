locals {
  partition                             = join("", data.aws_partition.current[*].partition)
  appversion_lifecycle_service_role_arn = var.create_lifecycle_service_role ? aws_iam_role.default[0].arn : var.appversion_lifecycle_service_role_arn
  appversion_lifecycle_max_age_in_days  = var.appversion_lifecycle_max_count == 200 ? var.appversion_lifecycle_max_age_in_days : null
  appversion_lifecycle_max_count        = local.appversion_lifecycle_max_age_in_days != null ? null : var.appversion_lifecycle_max_count
}

data "aws_partition" "current" {
  count = var.enabled ? 1 : 0
}

resource "aws_elastic_beanstalk_application" "default" {
  count       = var.enabled ? 1 : 0
  name        = var.name
  description = var.description
  tags        = var.tags

  dynamic "appversion_lifecycle" {
    for_each = local.appversion_lifecycle_service_role_arn != "" ? ["true"] : []
    content {
      service_role          = local.appversion_lifecycle_service_role_arn
      max_count             = local.appversion_lifecycle_max_count
      max_age_in_days       = local.appversion_lifecycle_max_age_in_days
      delete_source_from_s3 = var.appversion_lifecycle_delete_source_from_s3
    }
  }
}

data "aws_iam_policy_document" "service" {
  count = var.enabled && var.create_lifecycle_service_role ? 1 : 0

  statement {
    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type        = "Service"
      identifiers = ["elasticbeanstalk.amazonaws.com"]
    }

    effect = "Allow"
  }
}

resource "aws_iam_role" "default" {
  count = var.enabled && var.create_lifecycle_service_role ? 1 : 0

  name               = "${var.name}-eb-service"
  assume_role_policy = join("", data.aws_iam_policy_document.service[*].json)
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "enhanced_health" {
  count = var.enabled && var.create_lifecycle_service_role ? 1 : 0

  role       = join("", aws_iam_role.default[*].name)
  policy_arn = "arn:${local.partition}:iam::aws:policy/service-role/AWSElasticBeanstalkEnhancedHealth"
}

resource "aws_iam_role_policy_attachment" "service" {
  count = var.enabled && var.create_lifecycle_service_role ? 1 : 0

  role       = join("", aws_iam_role.default[*].name)
  policy_arn = var.prefer_legacy_service_policy ? "arn:${local.partition}:iam::aws:policy/service-role/AWSElasticBeanstalkService" : "arn:${local.partition}:iam::aws:policy/AWSElasticBeanstalkManagedUpdatesCustomerRolePolicy"
}

resource "aws_elastic_beanstalk_application_version" "this" {
  for_each     = { for k, v in var.eb_application_versions : k => v if var.eb_application_version_enabled }
  name         = each.key
  application  = aws_elastic_beanstalk_application.default[0].name == "" ? each.value.name : aws_elastic_beanstalk_application.default[0].name
  description  = each.value.description
  bucket       = each.value.bucket
  key          = each.value.key
  force_delete = each.value.force_delete
  tags         = each.value.tags
}

locals {
  partition                 = join("", data.aws_partition.current[*].partition)
  s3_bucket_access_log_name = var.s3_bucket_access_log_bucket_name != "" ? var.s3_bucket_access_log_bucket_name : "${var.name}-alb-logs-${random_string.elb_logs_suffix.result}"
}

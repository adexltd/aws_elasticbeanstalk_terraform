output "latest_ubuntu_ami_id" {
  value = data.aws_ami.ami_id.id
}

output "alb_arn" {
  value = module.alb.alb_arn
}

output "artifact_bucket" {
  value = module.s3_bucket.s3_bucket_id
}

output "elastic_beanstalk_application_name" {
  value = module.elastic_beanstalk_application.elastic_beanstalk_application_name
}

output "elastic_beanstalk_environment_name" {
  value = module.elastic_beanstalk_environment.elastic_beanstalk_environment_name
}

output "latest_ubuntu_ami_id" {
  value = data.aws_ami.ami_id.id
}

output "alb_arn" {
  value = module.alb.alb_arn
}

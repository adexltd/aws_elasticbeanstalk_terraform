output "latest_ubuntu_ami_id" {
  value = data.aws_ami.ami_id.id
}

# output "subnet_cidr_blocks" {
#   value = [for s in data.aws_subnet.subnet : s.cidr_block]
# }

output "alb_arn" {
  value = module.alb.alb_arn
}

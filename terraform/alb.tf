module "alb" {

  source = "./modules/terraform-aws-elb-module"

  name = local.alb.alb_name
  # vpc_id = data.aws_vpc.adex_poc_default_vpc.id
  vpc_id = module.vpc.vpc_id

  subnets                          = local.alb.public_subnets
  internal                         = local.alb.internal
  load_balancer_type               = local.alb.load_balancer_type
  enable_cross_zone_load_balancing = local.alb.enable_cross_zone_load_balancing
  enable_deletion_protection       = local.alb.enable_deletion_protection
  security_groups                  = [aws_security_group.alb.id]

  http_tcp_listeners = [
    {
      port               = local.alb.target_port
      protocol           = local.alb.target_protocol
      target_group_index = local.alb.target_group_index
    }
  ]

  target_groups = [
    {
      name             = local.alb.target_group_name
      backend_protocol = local.alb.backend_protocol
      backend_port     = local.alb.backend_port
      target_type      = local.alb.target_type

      health_check = {
        enabled             = true
        path                = "/health"
        protocol            = "HTTP"         # Customize this based on your needs
        matcher             = "200-402"      # HTTP status codes that indicate a healthy response
        interval            = 50             # Time in seconds between health checks
        timeout             = 46             # Time in seconds to wait for a response before marking as failed
        healthy_threshold   = 3              # Number of successes required to mark the target healthy
        unhealthy_threshold = 2              # Number of failures required to mark the target unhealthy
        port                = "traffic-port" # Port used for health checks, "traffic-port" uses the target group port
      }

    }
  ]

  tags = module.naming.resources.alb.tags

}

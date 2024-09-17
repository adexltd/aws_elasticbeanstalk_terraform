#################################################
# ALB
#################################################

resource "aws_security_group" "alb" {
  name        = "${module.naming.resources.sg.name}-alb-sg"
  description = "Allow traffic to and from loadbalancer"
  vpc_id      = data.aws_vpc.adex_poc_default_vpc.id

  # HTTP rule
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS rule
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rule to allow all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = module.naming.resources.alb.tags
}


#################################################
# RDS
#################################################

resource "aws_security_group" "database" {
  name        = "${module.naming.resources.rds.name}-sg"
  description = "Security group for database"
  vpc_id      = data.aws_vpc.adex_poc_default_vpc.id

  ingress {
    description     = "TLS from VPC"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    # security_groups = [aws_security_group.backend_asg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = module.naming.resources.rds.tags
}

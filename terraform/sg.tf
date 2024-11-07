#################################################
# ALB
#################################################

resource "aws_security_group" "alb" {
  name        = "${module.naming.resources.sg.name}-alb-sg"
  description = "Allow traffic to and from loadbalancer"
  # vpc_id      = data.aws_vpc.adex_poc_default_vpc.id
  vpc_id = module.vpc.vpc_id

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

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # security_groups = [aws_security_group.alb.id] # Allow traffic from ALB only
  }

  egress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # security_groups = [aws_security_group.eb_instances.id] # Allow traffic to EB instances on port 8080
  }

  # Outbound rule to allow all traffic
  # egress {
  #   from_port   = 0
  #   to_port     = 0
  #   protocol    = "-1"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }
  tags = module.naming.resources.alb.tags
}


#################################################
# RDS
#################################################

resource "aws_security_group" "database" {
  name        = "${module.naming.resources.rds.name}-sg"
  description = "Security group for database"
  # vpc_id      = data.aws_vpc.adex_poc_default_vpc.id
  vpc_id = module.vpc.vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # cidr_blocks = local.vpc.vpc_cidr
    # security_groups = [aws_security_group.backend_asg.id]
    security_groups = [aws_security_group.eb_instances.id] # Restrict access to EB instances only
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = module.naming.resources.rds.tags
}



#################################################
# EC2
#################################################
# Security Group for Elastic Beanstalk Instances
resource "aws_security_group" "eb_instances" {
  name        = "${local.elastic_beanstalk_application.name}-sg"
  description = "Security group for Elastic Beanstalk instances"
  # vpc_id      = data.aws_vpc.adex_poc_default_vpc.id
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    # cidr_blocks     = ["0.0.0.0/0"] # Allow HTTP traffic
    security_groups = [aws_security_group.alb.id]
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    # cidr_blocks     = ["0.0.0.0/0"] # Allow HTTPS traffic
    security_groups = [aws_security_group.alb.id]
  }

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id] # Allow traffic from ALB only
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }
}

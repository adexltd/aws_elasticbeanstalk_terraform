# resource "aws_iam_policy" "secrets_manager_policy" {
#   name        = "SecretsManagerGetSecretValuePolicy"
#   description = "IAM policy that allows GetSecretValue for Secrets Manager"

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect    = "Allow"
#         Action    = "secretsmanager:GetSecretValue"
#         Resource  = "*"
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "attach_secrets_manager_policy" {
#   role       = aws_iam_role.SecretsManagerGetSecretValuePolicy.name 
#   policy_arn = aws_iam_policy.secrets_manager_policy.arn
# }

# Create the IAM role
resource "aws_iam_role" "my_iam_role" {
  name = "my-iam-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com" # Or ECS, Lambda, etc.
        }
      }
    ]
  })
}

# Attach the policy to the dynamically created IAM role
resource "aws_iam_role_policy_attachment" "attach_secrets_manager_policy" {
  role       = aws_iam_role.my_iam_role.name
  policy_arn = aws_iam_policy.secrets_manager_policy.arn
}

# resource "aws_iam_role" "elastic_beanstalk_service_role" {
#   name = "aws-elasticbeanstalk-service-role"

#   assume_role_policy = jsonencode({
#     "Version" : "2012-10-17",
#     "Statement" : [
#       {
#         "Sid" : "",
#         "Effect" : "Allow",
#         "Principal" : {
#           "Service" : "elasticbeanstalk.amazonaws.com"
#         },
#         "Action" : "sts:AssumeRole",
#         "Condition" : {
#           "StringEquals" : {
#             "sts:ExternalId" : "elasticbeanstalk"
#           }
#         }
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "service_role_policy" {
#   role       = aws_iam_role.elastic_beanstalk_service_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkFullAccess"
# }

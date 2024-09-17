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

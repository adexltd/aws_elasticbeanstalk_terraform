terraform {
  backend "s3" {
    region         = "us-east-1"
    key            = "beanstalk/beanstalk_project.tfstate"
    bucket         = "beanstalk-development-ebs-ue1-eb-d-s3"
    dynamodb_table = "beanstalk-development-ebs-ue1-eb-d-s3"
    encrypt        = true
  }
}


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-west-2"

  assume_role {
    role_arn = "arn:aws:iam::${var.deployment_target_account_number}:role/cross-account-poc-1"
  }
}

resource "aws_s3_bucket" "b" {
  bucket = "my-tf-test-hdje84jk-bucketorama"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
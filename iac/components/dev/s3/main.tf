
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }

  backend "s3" {
    region = "us-west-2"
    bucket = "tf-state-cross-account"
    key    = "dev-s3"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-west-2"

  assume_role {
    role_arn = "arn:aws:iam::${var.target_account_number}:role/cross-account-poc"
    session_name = "REMOTE_SESSION"
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
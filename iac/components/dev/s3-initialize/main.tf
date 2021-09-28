
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

}

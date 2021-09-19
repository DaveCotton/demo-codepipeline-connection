
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

}

data "aws_iam_policy_document" "policy_document" {
  statement {
    actions = [
      "s3:*"
    ]
    resources = [
      "arn:aws:s3:::*",
    ]
  }
}

resource "aws_iam_policy" "cross-account-poc" {
    name   = "cross-account-poc-1"
    path   = "/"
    policy = data.aws_iam_policy_document.policy_document.json
}

resource "aws_iam_role" "cross-account-poc" {
  name = "cross-account-poc-1"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        "Principal": {
          "AWS": "arn:aws:iam::${var.pipeline_account_number}:root"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "role-policy-attachment" {
  role       = aws_iam_role.cross-account-poc.name
  policy_arn = aws_iam_policy.cross-account-poc.arn
}
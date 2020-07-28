provider "aws" {}

provider "aws" {
  alias = "destination_account"
}

data "aws_caller_identity" "landing" {
  provider = aws
}

data "aws_caller_identity" "destination_account" {
  provider = aws.destination_account
}

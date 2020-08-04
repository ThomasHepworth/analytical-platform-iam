provider "aws" {
  alias = "source"
}

provider "aws" {
  alias = "destination"
}

data "aws_caller_identity" "landing" {
  provider = aws.source
}

data "aws_caller_identity" "destination_account" {
  provider = aws.destination
}

terraform {
  required_version = "~> 0.11.0"

  backend "s3" {
    acl            = "private"
    bucket         = "tf-state-analytical-platform-landing"
    encrypt        = true
    key            = "kitchen"
    region         = "eu-west-1"
    dynamodb_table = "tf-state-lock"
    kms_key_id     = "arn:aws:kms:eu-west-1:335823981503:key/925a5b6c-7df1-49a0-a3cc-471e8524637d"
  }
}

provider "aws" {
  region  = "eu-west-1"
  version = "~> 2.6"
}

provider "aws" {
  region  = "eu-west-1"
  version = "~> 2.6"
  alias   = "landing"

  assume_role {
    role_arn = "arn:aws:iam::${var.landing_account_id}:role/${var.landing_iam_role}"
  }
}

variable "landing_account_id" {
  description = "ID of account containing IAM users"
  default     = "335823981503"
}

variable "landing_iam_role" {
  default = "landing-iam-role"
}

variable "ap_accounts" {
  type        = "map"
  description = "IDs of accounts to assume role into"

  default = {
    dev = "525294151996"
  }
}

## Kitchen

variable "kitchen_name" {
  default = "kitchen"
}

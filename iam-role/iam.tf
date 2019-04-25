terraform {
  required_version = "~> 0.11.0"
  backend          "local"          {}
}

provider "aws" {
  region  = "eu-west-1"
  version = "~> 2.5"
}

variable "iam_role" {
  default = "landing-iam-role"
}

data "aws_iam_policy_document" "iam_role_assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["arn:aws:iam::335823981503:root"]
      type        = "AWS"
    }
  }
}

data "aws_iam_policy_document" "iam_role" {
  statement {
    sid    = "CreateRoles"
    effect = "Allow"

    actions = [
      "iam:AttachRolePolicy",
      "iam:CreateRole",
      "iam:DeleteRole",
      "iam:DeleteRolePolicy",
      "iam:DetachRolePolicy",
      "iam:GetRole",
      "iam:GetRolePolicy",
      "iam:ListInstanceProfilesForRole",
      "iam:PutRolePolicy",
      "iam:TagRole",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role" "iam_role" {
  assume_role_policy = "${data.aws_iam_policy_document.iam_role_assume.json}"
  name               = "${var.iam_role}"
}

resource "aws_iam_role_policy" "iam_role" {
  policy = "${data.aws_iam_policy_document.iam_role.json}"
  role   = "${aws_iam_role.iam_role.id}"
}

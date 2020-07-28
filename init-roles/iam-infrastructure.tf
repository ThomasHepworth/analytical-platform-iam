# Creates a role "terraform-infrastructure" that can be assumed by:
# * Landing AWS account user/roles (which also need permission via ../modules/assume),
#   which is used by the IAM Terraform Pipeline
# * CodeBuild, during the course of the running of the IAM Terraform Pipeline

data "aws_iam_policy_document" "terraform_assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["arn:aws:iam::${var.accounts["landing"]}:root"]
      type        = "AWS"
    }
  }

  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["codebuild.amazonaws.com"]
      type        = "Service"
    }
  }
}

data "aws_iam_policy_document" "terraform" {
  statement {
    sid       = "apRemoteTerraform"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "vpc:*",
      "s3:*",
      "route53:*",
      "kms:Decrypt",
      "iam:*",
      "logs:*",
      "elasticloadbalancing:*",
      "ec2:*",
      "cloudwatch:*",
      "cloudtrail:*",
      "autoscaling:*",
      "lambda:*",
    ]
  }
}

resource "aws_iam_role" "terraform" {
  assume_role_policy = data.aws_iam_policy_document.terraform_assume.json
  name               = "terraform-infrastructure"
}

resource "aws_iam_policy" "terraform" {
  name   = "terraform-infrastructure"
  policy = data.aws_iam_policy_document.terraform.json
}

resource "aws_iam_policy_attachment" "terraform" {
  name       = "terraform-infrastructure"
  policy_arn = aws_iam_policy.terraform.arn
  roles      = [aws_iam_role.terraform.name]
}

# Role for codebuild

variable "terraform_inf_role" {
  default = "terraform-infrastructure"
}

data "aws_iam_policy_document" "terraform_inf_role_assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    # Allow users from the landing account to assume
    principals {
      identifiers = ["arn:aws:iam::335823981503:root"]
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

data "aws_iam_policy_document" "terraform_inf_role" {
  statement {
    sid    = "apRemoteTerraform"
    effect = "Allow"

    actions = [
      "vpc:*",
      "s3:*",
      "route53:*",
      "kms:Decrypt",
      "iam:*",
      "elasticloadbalancing:*",
      "ec2:*",
      "cloudwatch:*",
      "cloudtrail:*",
      "autoscaling:*",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role" "terraform_inf_role" {
  assume_role_policy = "${data.aws_iam_policy_document.terraform_inf_role_assume.json}"
  name               = "${var.terraform_inf_role}"
}

resource "aws_iam_policy" "terraform_inf_role" {
  name   = "${var.terraform_inf_role}"
  policy = "${data.aws_iam_policy_document.terraform_inf_role.json}"
}

resource "aws_iam_policy_attachment" "terraform_inf_role_att" {
  name       = "${var.terraform_inf_role}"
  policy_arn = "${aws_iam_policy.terraform_inf_role.arn}"
  roles      = ["${aws_iam_role.terraform_inf_role.name}"]
}

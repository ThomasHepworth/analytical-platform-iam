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
      "iam:CreatePolicyVersion",
      "iam:CreateRole",
      "iam:DeactivateMFADevice",
      "iam:DeleteAccessKey",
      "iam:DeleteLoginProfile",
      "iam:DeleteRole",
      "iam:DeleteRolePolicy",
      "iam:DetachRolePolicy",
      "iam:Get*",
      "iam:List*",
      "iam:PutRolePolicy",
      "iam:TagRole",
      "iam:UpdateAssumeRolePolicy",
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

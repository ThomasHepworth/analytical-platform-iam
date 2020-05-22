# Role "landing-iam-role" used by the "iam" CodePipeline

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
      "iam:AddUserToGroup",
      "iam:AttachGroupPolicy",
      "iam:AttachRolePolicy",
      "iam:AttachUserPolicy",
      "iam:CreatePolicyVersion",
      "iam:CreateGroup",
      "iam:CreatePolicy",
      "iam:CreatePolicyVersion",
      "iam:CreateRole",
      "iam:CreateUser",
      "iam:DeactivateMFADevice",
      "iam:DeleteAccessKey",
      "iam:DeleteGroup",
      "iam:DeleteLoginProfile",
      "iam:DeletePolicy",
      "iam:DeletePolicyVersion",
      "iam:DeleteRole",
      "iam:DeleteRolePolicy",
      "iam:DeleteUser",
      "iam:DeleteUserPolicy",
      "iam:DetachRolePolicy",
      "iam:DeleteVirtualMFADevice",
      "iam:Get*",
      "iam:List*",
      "iam:PutRolePolicy",
      "iam:RemoveUserFromGroup",
      "iam:TagRole",
      "iam:UpdateAssumeRolePolicy",
      "iam:UpdateGroup",
      "iam:UpdateUser",
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

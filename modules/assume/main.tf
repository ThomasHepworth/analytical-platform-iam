data "aws_iam_policy_document" "allow_policy" {
  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = ["arn:aws:iam::${var.assume_role_in_account_id}:role/${var.assumed_role_name}"]
  }
}

data "aws_iam_policy_document" "deny_policy" {
  statement {
    effect    = "Deny"
    actions   = ["*"]
    resources = ["*"]
  }
}

resource "aws_iam_group" "group" {
  name = var.group_name
}

resource "aws_iam_group_membership" "group_membership" {
  group = aws_iam_group.group.name
  name  = "group-membership"
  users = var.users
}

resource "aws_iam_policy" "assume" {
  policy = var.group_effect == "Allow" ? data.aws_iam_policy_document.allow_policy.json : data.aws_iam_policy_document.deny_policy.json
  name   = "assume-role-${var.group_name}"
}

resource "aws_iam_policy_attachment" "assume" {
  name       = aws_iam_group.group.name
  policy_arn = aws_iam_policy.assume.arn
  groups     = [aws_iam_group.group.name]
}

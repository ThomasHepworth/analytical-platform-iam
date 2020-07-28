data "aws_iam_policy_document" "destination_assume" {
  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = ["arn:aws:iam::${data.aws_caller_identity.destination_account.account_id}:role/${var.destination_role_name}"]
  }
}

resource "aws_iam_policy" "policy" {
  name_prefix = "allow-${var.destination_role_name}-assume"
  policy      = data.aws_iam_policy_document.destination_assume.json
}

resource "aws_iam_user_policy_attachment" "assume" {
  for_each = toset(var.users)

  user       = each.key
  policy_arn = aws_iam_policy.policy.arn
}

resource "aws_iam_user_policy" "this" {
  for_each = toset(var.users)

  user   = each.key
  name   = "opg-access-${each.key}"
  policy = var.aws_iam_policy_document.json
}

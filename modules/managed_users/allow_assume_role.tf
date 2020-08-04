data "aws_iam_policy_document" "allow_assuming_destination_role" {
  statement {
    sid       = "AllowAssumingRoleFromLanding"
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = [aws_iam_role.destination.arn]
  }
}

data "aws_iam_policy_document" "allow_landing_assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    condition {
      test     = "BoolIfExists"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.landing.account_id}:root"]
    }
  }
}

resource "aws_iam_policy" "assume" {
  provider = aws.source
  name     = substr("assume-role-${var.destination_role_name}", 0, 31)
  policy   = data.aws_iam_policy_document.allow_assuming_destination_role.json
}

resource "aws_iam_role" "allow_assume" {
  provider           = aws.source
  name               = substr("assume-role-${var.destination_role_name}", 0, 31)
  assume_role_policy = data.aws_iam_policy_document.allow_landing_assume.json
  tags               = var.tags
}

output "allow_assume_role" {
  value = aws_iam_role.allow_assume
}

resource "aws_iam_policy_attachment" "landing" {
  provider   = aws.source
  name       = "attachment-${var.destination_role_name}"
  users      = var.users
  roles      = ["arn:aws:iam::${data.aws_caller_identity.landing.account_id}:role/allow-assume-${var.destination_role_name}"]
  policy_arn = aws_iam_policy.assume.arn
}

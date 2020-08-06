data "aws_iam_policy_document" "allow_assuming_destination_role" {
  statement {
    sid       = "AllowAssumingDestinationRole"
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = [aws_iam_role.destination.arn]

    condition {
      test     = "BoolIfExists"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }
  }
}

resource "aws_iam_policy" "landing" {
  provider = aws.source
  name     = substr("ar-${var.destination_role_name}${local.suffix}", 0, 31)
  policy   = data.aws_iam_policy_document.allow_assuming_destination_role.json
}

resource "aws_iam_policy_attachment" "landing" {
  provider   = aws.source
  name       = "attachment-${var.destination_role_name}"
  users      = var.user_names
  policy_arn = aws_iam_policy.landing.arn
}

locals {
  suffix = var.destination_account_name == "" ? "" : "-${var.destination_account_name}"
}

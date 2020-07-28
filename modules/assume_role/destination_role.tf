data "aws_iam_policy_document" "assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    condition {
      test     = "BoolIfExists"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }

    principals {
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.landing.account_id}:root"]
      type        = "AWS"
    }
  }
}

resource "aws_iam_role" "role" {
  provider           = aws.destination_account
  name_prefix        = var.destination_role_name
  assume_role_policy = data.aws_iam_policy_document.assume.json
  tags               = var.tags
}

resource "aws_iam_role_policy" "role_policy" {
  provider = aws.destination_account
  policy   = var.aws_iam_policy_document.json
  role     = aws_iam_role.role.id
  name     = var.destination_role_name
}

# Specify an existing role for example arn:aws:iam::aws:policy/AdministratorAccess
resource "aws_iam_role_policy_attachment" "role_policy_attachment" {
  provider = aws.destination_account
  count    = signum(length(var.existing_policy_arn))

  policy_arn = var.existing_policy_arn
  role       = aws_iam_role.role.name
}

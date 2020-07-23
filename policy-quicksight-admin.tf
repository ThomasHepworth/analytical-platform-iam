data "aws_iam_policy_document" "quicksight_admin" {
  statement {
    sid       = "QuicksightAll"
    effect    = "Allow"
    resources = ["*"]
    actions   = ["quicksight:*"]
  }
}

data "aws_iam_policy_document" "calum_test" {
  statement {
    sid    = "Read"
    effect = "Allow"

    actions = [
      "s3:Get*",
      "s3:List*",
      "s3:DeleteObject",
    ]

    resources = [
      "arn:aws:s3:::alpha-everyone",
      "arn:aws:s3:::alpha-everyone/*",
    ]
  }
}

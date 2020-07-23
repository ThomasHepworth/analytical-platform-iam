data "aws_iam_policy_document" "read_data_only" {
  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "s3:Get*",
      "s3:List*",
    ]
  }
}

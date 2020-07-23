data "aws_iam_policy_document" "data_admin" {
  statement {
    sid       = "Read"
    effect    = "Allow"
    resources = ["arn:aws:s3:::alpha_*"]

    actions = [
      "s3:Get*",
      "s3:List*",
    ]
  }

  statement {
    sid       = "ObjectAdmin"
    effect    = "Allow"
    resources = ["arn:aws:s3:::alpha_*"]

    actions = [
      "s3:AbortMultipartUpload",
      "s3:DeleteObject*",
      "s3:PutObject*",
      "s3:ReplicateObject",
      "s3:RestoreObject",
    ]
  }

  statement {
    sid       = "Bucket"
    effect    = "Allow"
    resources = ["arn:aws:s3:::alpha_*"]

    actions = [
      "s3:DeleteBucket*",
      "s3:PutBucket*",
      "s3:PutEncryptionConfiguration",
      "s3:PutMetricsConfiguration",
    ]
  }
}

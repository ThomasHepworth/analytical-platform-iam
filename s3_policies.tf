data "aws_iam_policy_document" "crest" {
  statement {
    sid       = "CRESTManagersListAllBucketsInConsole"
    effect    = "Allow"
    resources = ["arn:aws:s3:::*"]
    actions = [
      "s3:GetBucketLocation",
      "s3:ListAllMyBuckets",
    ]
  }
  statement {
    sid       = "CRESTManagersListBucketObjects"
    effect    = "Allow"
    actions   = ["s3:ListBucket"]
    resources = ["arn:aws:s3:::alpha-moj-analytics-crest"]
  }

  statement {
    sid       = "CRESTManagersReadWriteDeleteObjects"
    effect    = "Allow"
    resources = ["arn:aws:s3:::alpha-moj-analytics-crest/*"]
    actions = [
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:RestoreObject",
    ]
  }
}

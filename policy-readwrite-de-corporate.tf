data "aws_iam_policy_document" "readwrite_de_corporate" {
  statement {

    sid = "ReadWrite"
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:GetObjectVersion",
      "s3:DeleteObject",
      "s3:DeleteObjectVersion",
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:RestoreObject"
    ]
    
    resources = [
      "arn:aws:s3:::mojap-land/github-logs/*",
      "arn:aws:s3:::mojap-raw-hist/github-logs/*",
      "arn:aws:s3:::mojap-raw/github-logs/*",
      "arn:aws:s3:::mojap-land/sop/*",
      "arn:aws:s3:::mojap-raw-hist/sop/*",
      "arn:aws:s3:::mojap-raw/sop/*"
    ]
  }
}
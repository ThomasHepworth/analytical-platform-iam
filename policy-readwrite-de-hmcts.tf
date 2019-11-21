data "aws_iam_policy_document" "readwrite_de_hmcts" {
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
      "arn:aws:s3:::mojap-land/hmcts/*",
      "arn:aws:s3:::mojap-raw-hist/hmcts/*",
      "arn:aws:s3:::mojap-raw/hmcts/*"
    ]
  }
}
module "opg" {
  source = "./modules/assume_role"
  users  = local.opg_data_science_team

  destination_role_name   = "opg-data-access"
  aws_iam_policy_document = data.aws_iam_policy_document.opg_access
  tags                    = local.tags

  providers = {
    aws                     = aws.landing
    aws.destination_account = aws.data
  }
}

data "aws_iam_policy_document" "opg_access" {
  statement {
    effect = "Allow"
    sid    = "ReadWrite"
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
      "arn:aws:s3:::alpha-opg-*/*",
      "arn:aws:s3:::mojap-land/opg/sirius/*",
    ]
  }

  statement {
    effect  = "Allow"
    sid     = "ListBuckets"
    actions = ["s3:ListBucket"]
    resources = [
      "arn:aws:s3:::mojap-land",
      "arn:aws:s3:::alpha-opg*",
    ]
  }
}

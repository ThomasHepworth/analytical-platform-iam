module "opg_data_science" {
  source = "./modules/assume_role"
  tags   = local.tags

  destination_role_name = "opg-data-science"
  user_names            = module.opg_data_science_group.user_names
  user_arns             = module.opg_data_science_group.user_arns

  managed_policies = [
    "arn:aws:iam::aws:policy/AmazonAthenaFullAccess",
    "arn:aws:iam::aws:policy/AWSGlueConsoleFullAccess",
    "arn:aws:iam::aws:policy/CloudWatchLogsReadOnlyAccess",
  ]

  aws_iam_policy_documents = {
    "opg_data_science" = data.aws_iam_policy_document.opg_access,
  }

  providers = {
    aws             = aws.landing
    aws.destination = aws.data
  }
}

output "opg_ds_role_name" {
  value = module.opg_data_science.destination_role.name
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

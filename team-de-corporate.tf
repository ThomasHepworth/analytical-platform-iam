module "corporate_data_engineer" {
  source = "./modules/assume_role"
  tags   = local.tags

  destination_role_name = "corporate-data-engineer"
  user_names            = module.corporate_data_engineering_team.user_names
  user_arns             = module.corporate_data_engineering_team.user_arns

  managed_policies = [
    "arn:aws:iam::aws:policy/AmazonAthenaFullAccess",
    "arn:aws:iam::aws:policy/AWSGlueConsoleFullAccess",
    "arn:aws:iam::aws:policy/AWSLakeFormationDataAdmin",
    "arn:aws:iam::aws:policy/AWSSupportAccess",
    "arn:aws:iam::aws:policy/AWSCloudTrailReadOnlyAccess",
    "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess",
    "arn:aws:iam::aws:policy/CloudWatchLogsReadOnlyAccess",
    "arn:aws:iam::aws:policy/CloudWatchEventsReadOnlyAccess",
    "arn:aws:iam::aws:policy/CloudWatchSyntheticsReadOnlyAccess",
    "arn:aws:iam::aws:policy/AWSCloudTrailReadOnlyAccess",
    "arn:aws:iam::aws:policy/AWSCodePipelineReadOnlyAccess",
  ]

  aws_iam_policy_documents = {
    "corporate_data_engineer" = data.aws_iam_policy_document.corporate_data_engineer,
  }

  providers = {
    aws             = aws.landing
    aws.destination = aws.data
  }
}

data "aws_iam_policy_document" "corporate_data_engineer" {
  statement {
    sid    = "ReadWrite"
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:GetObjectVersion",
      "s3:DeleteObject",
      "s3:DeleteObjectVersion",
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:RestoreObject",
    ]

    resources = [
      "arn:aws:s3:::mojap-land/github-logs/*",
      "arn:aws:s3:::mojap-raw-hist/github-logs/*",
      "arn:aws:s3:::mojap-raw/github-logs/*",
      "arn:aws:s3:::mojap-land/sop/*",
      "arn:aws:s3:::mojap-raw-hist/sop/*",
      "arn:aws:s3:::mojap-raw/sop/*",
      "arn:aws:s3:::alpha-dag-sop-data-engineering/*",
      "arn:aws:s3:::alpha-dag-sop-engineering-draft/*",
      "arn:aws:s3:::alpha-dag-sop-engineering-backup/*",
      "arn:aws:s3:::alpha-dag-sop-bulk-uploads/*",
    ]
  }
}

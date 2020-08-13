module "data_first_data_engineer" {
  source = "./modules/assume_role"
  tags   = local.tags

  destination_role_name = "data-first-data-engineer"
  user_names            = module.data_first_data_engineering_team.user_names
  user_arns             = module.data_first_data_engineering_team.user_arns

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
    "data_first_data_engineer" = data.aws_iam_policy_document.data_first_data_engineer,
  }

  providers = {
    aws             = aws.landing
    aws.destination = aws.data
  }
}

output "data_first_engineer_role_name" {
  value = module.data_first_data_engineer.destination_role.name
}

data "aws_iam_policy_document" "data_first_data_engineer" {
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
      "arn:aws:s3:::mojap-land/hmcts/family/*",
      "arn:aws:s3:::mojap-raw-hist/hmcts/family/*",
      "arn:aws:s3:::mojap-raw/hmcts/family/*",
      "arn:aws:s3:::alpha-data-discovery/*",
    ]
  }
}

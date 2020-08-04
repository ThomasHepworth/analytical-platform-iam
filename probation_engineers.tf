module "probation_data_engineer_dev" {
  source                = "./modules/managed_users"
  tags                  = local.tags
  destination_role_name = "probation-data-engineer-dev"
  users                 = [aws_iam_user.danw.name]

  managed_policies = [
    "arn:aws:iam::aws:policy/AmazonAthenaFullAccess",
    "arn:aws:iam::aws:policy/AWSGlueConsoleFullAccess",
    "arn:aws:iam::aws:policy/AWSLakeFormationDataAdmin",
    "arn:aws:iam::aws:policy/AWSSupportAccess",
    "arn:aws:iam::aws:policy/AWSCloudTrailReadOnlyAccess",
    "arn:aws:iam::aws:policy/CloudWatchLogsReadOnlyAccess",
    "arn:aws:iam::aws:policy/AWSCodePipelineApproverAccess",
    "arn:aws:iam::aws:policy/AWSCodePipelineReadOnlyAccess",
  ]

  aws_iam_policy_documents = {
    "probation_data_engineer" = data.aws_iam_policy_document.probation_data_engineer,
  }

  providers = {
    aws             = aws.landing
    aws.destination = aws.dev
  }
}

# TODO: Extend this to more applicable log groups
# and deny access to sensitive logs
# Users require access to: cloudtrail, cloudwatch & cloudwatch logs
data "aws_iam_policy_document" "logs" {
  statement {
    effect = "Deny"
    sid    = "Deny Access to sensitive logs"
  }

  statement {
    effect = "Allow"
    sid    = "Allow Access to logs"
  }
}

# TODO: Get list of allow IAM read-only permissions
data "aws_iam_policy_document" "iam" {
  statement {
    effect = "Allow"
    sid    = "Allow users to read IAM"
  }
}

output "probation_engineer_role_name" {
  value = "Probation Engineer assume role: ${module.probation_data_engineer_dev.destination_role.name}"
}

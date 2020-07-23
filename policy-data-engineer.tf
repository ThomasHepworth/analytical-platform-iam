data "aws_iam_policy_document" "data_engineer" {
  statement {
    sid       = "AthenaFullAccess"
    effect    = "Allow"
    actions   = ["athena:*"]
    resources = ["*"]
  }

  statement {
    sid       = "AthenaAccessQueryResults"
    effect    = "Allow"
    resources = ["arn:aws:s3:::aws-athena-query-results-*"]

    actions = [
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:ListMultipartUploadParts",
      "s3:AbortMultipartUpload",
      "s3:CreateBucket",
      "s3:PutObject",
    ]
  }

  statement {
    sid       = "AthenaAccessExamples"
    effect    = "Allow"
    resources = ["arn:aws:s3:::athena-examples*"]

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]
  }

  statement {
    sid       = "ListBuckets"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "s3:ListBucket",
      "s3:GetBucketAcl",
      "s3:GetBucketLocation",
      "s3:ListAllMyBuckets",
    ]
  }

  statement {
    sid       = "AthenaCloudwatchAlarms"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "cloudwatch:DescribeAlarms",
      "cloudwatch:PutMetricAlarm",
      "cloudwatch:PutMetricData",
      "cloudwatch:GetMetricData",
      "cloudwatch:ListDashboards",
    ]
  }

  statement {
    sid       = "AthenaLakeFormation"
    effect    = "Allow"
    resources = ["*"]
    actions   = ["lakeformation:GetDataAccess"]
  }

  statement {
    sid       = "GlueFullAccess"
    effect    = "Allow"
    resources = ["*"]
    actions   = ["glue:*"]
  }

  statement {
    sid       = "GlueIamGetReadRolesPolices"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "iam:GetRole",
      "iam:GetRolePolicy",
      "iam:ListAttachedRolePolicies",
      "iam:ListGroups",
      "iam:ListRolePolicies",
      "iam:ListUsers",
      "kms:ListAliases",
      "kms:DescribeKey",
    ]
  }

  statement {
    sid       = "GlueCreateBucket"
    effect    = "Allow"
    resources = ["arn:aws:s3:::aws-glue-*"]
    actions   = ["s3:CreateBucket"]
  }

  statement {
    sid    = "GlueManageS3Object"
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
    ]

    resources = [
      "arn:aws:s3:::aws-glue-*/*",
      "arn:aws:s3:::*/*aws-glue-*/*",
      "arn:aws:s3:::aws-glue-*",
    ]
  }

  statement {
    sid     = "GlueS3Crawler"
    effect  = "Allow"
    actions = ["s3:GetObject"]

    resources = [
      "arn:aws:s3:::crawler-public*",
      "arn:aws:s3:::aws-glue-*",
    ]
  }

  statement {
    sid       = "GlueCloudwatchLog"
    effect    = "Allow"
    resources = ["arn:aws:logs:*:*:/aws-glue/*"]

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:GetLogEvents",
      "logs:PutLogEvents",
    ]
  }

  statement {
    sid       = "GlueCloudFormationRead"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "cloudformation:DescribeStacks",
      "cloudformation:GetTemplateSummary",
    ]
  }

  statement {
    sid       = "GlueTagService"
    effect    = "Allow"
    actions   = ["tag:GetResources"]
    resources = ["*"]
  }

  statement {
    sid       = "GluePathCreateBucket"
    effect    = "Allow"
    actions   = ["s3:CreateBucket"]
    resources = ["arn:aws:s3:::aws-glue-*"]
  }

  statement {
    sid       = "GlueManageCloudformationStack"
    effect    = "Allow"
    resources = ["arn:aws:cloudformation:*:*:stack/aws-glue*/*"]

    actions = [
      "cloudformation:CreateStack",
      "cloudformation:DeleteStack",
    ]

  }

  statement {
    sid       = "GlueIamPassRoleToServiceGlue"
    effect    = "Allow"
    actions   = ["iam:PassRole"]
    resources = ["arn:aws:iam::*:role/AWSGlueServiceRole*"]

    condition {
      test     = "StringLike"
      variable = "iam:PassedToService"
      values   = ["glue.amazonaws.com"]
    }

  }

  statement {
    sid       = "GlueIamPassRoleToServiceGlueService"
    effect    = "Allow"
    resources = ["arn:aws:iam::*:role/service-role/AWSGlueServiceRole*"]
    actions   = ["iam:PassRole"]

    condition {
      test     = "StringLike"
      variable = "iam:PassedToService"
      values   = ["glue.amazonaws.com"]
    }
  }

  statement {
    sid       = "AttachRolesToSelfManagedGroups"
    effect    = "Allow"
    resources = ["arn:aws:iam::*:role/alpha_user_*"]

    actions = [
      "iam:AttachRolePolicy",
      "iam:DetachRolePolicy",
      "iam:GetRole",
      "iam:GetRolePolicy",
      "iam:ListAttachedRolePolicies",
      "iam:ListRoles",
    ]
  }

  statement {
    sid    = "ManageDataEngineerPolicies"
    effect = "Allow"

    actions = [
      "iam:CreatePolicy",
      "iam:CreatePolicyVersion",
      "iam:DeletePolicy",
      "iam:GetPolicy",
      "iam:GetPolicyVersion",
      "iam:ListPolicies",
      "iam:ListPolicyVersions",
    ]

    resources = [
      "arn:aws:iam::*:policy/StandardDatabaseAccess",
      "arn:aws:iam::*:policy/StandardGlueAccess",
    ]
  }

  statement {
    sid       = "ListDockerRepository"
    effect    = "Allow"
    actions   = ["ecr:ListImages"]
    resources = ["*"]
  }
}

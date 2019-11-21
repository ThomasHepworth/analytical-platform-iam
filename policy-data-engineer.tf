data "aws_iam_policy_document" "data_engineer" {
  statement {
    sid    = "AthenaFullAccess"
    effect = "Allow"

    actions = ["athena:*"]

    resources = ["*"]
  }

  statement {
    sid    = "AthenaAccessQueryResults"
    effect = "Allow"

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

    resources = ["arn:aws:s3:::aws-athena-query-results-*"]
  }

  statement {
    sid    = "AthenaAccessExamples"
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = ["arn:aws:s3:::athena-examples*"]
  }

  statement {
    sid    = "ListBuckets"
    effect = "Allow"

    actions = [
      "s3:ListBucket",
      "s3:GetBucketAcl",
      "s3:GetBucketLocation",
      "s3:ListAllMyBuckets",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "AthenaCloudwatchAlarms"
    effect = "Allow"

    actions = [
      "cloudwatch:DescribeAlarms",
      "cloudwatch:PutMetricAlarm",
      "cloudwatch:PutMetricData",
      "cloudwatch:GetMetricData",
      "cloudwatch:ListDashboards",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "AthenaLakeFormation"
    effect = "Allow"

    actions = ["lakeformation:GetDataAccess"]

    resources = ["*"]
  }

  statement {
    sid    = "GlueFullAccess"
    effect = "Allow"

    actions = [
      "glue:*",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "GlueIamGetReadRolesPolices"
    effect = "Allow"

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

    resources = ["*"]
  }

  statement {
    sid    = "GlueCreateBucket"
    effect = "Allow"

    actions = ["s3:CreateBucket"]

    resources = ["arn:aws:s3:::aws-glue-*"]
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
    sid    = "GlueS3Crawler"
    effect = "Allow"

    actions = ["s3:GetObject"]

    resources = [
      "arn:aws:s3:::crawler-public*",
      "arn:aws:s3:::aws-glue-*",
    ]
  }

  statement {
    sid    = "GlueCloudwatchLog"
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:GetLogEvents",
      "logs:PutLogEvents",
    ]

    resources = ["arn:aws:logs:*:*:/aws-glue/*"]
  }

  statement {
    sid    = "GlueCloudFormationRead"
    effect = "Allow"

    actions = [
      "cloudformation:DescribeStacks",
      "cloudformation:GetTemplateSummary",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "GlueTagService"
    effect = "Allow"

    actions = ["tag:GetResources"]

    resources = ["*"]
  }

  statement {
    sid    = "GluePathCreateBucket"
    effect = "Allow"

    actions = ["s3:CreateBucket"]

    resources = ["arn:aws:s3:::aws-glue-*"]
  }

  statement {
    sid    = "GlueManageCloudformationStack"
    effect = "Allow"

    actions = [
      "cloudformation:CreateStack",
      "cloudformation:DeleteStack",
    ]

    resources = ["arn:aws:cloudformation:*:*:stack/aws-glue*/*"]
  }

  statement {
    sid    = "GlueIamPassRoleToServiceGlue"
    effect = "Allow"

    actions = ["iam:PassRole"]

    condition {
      test     = "StringLike"
      variable = "iam:PassedToService"
      values   = ["glue.amazonaws.com"]
    }

    resources = ["arn:aws:iam::*:role/AWSGlueServiceRole*"]
  }

  statement {
    sid    = "GlueIamPassRoleToServiceGlueService"
    effect = "Allow"

    actions = ["iam:PassRole"]

    condition {
      test     = "StringLike"
      variable = "iam:PassedToService"
      values   = ["glue.amazonaws.com"]
    }

    resources = ["arn:aws:iam::*:role/service-role/AWSGlueServiceRole*"]
  }

  statement {
    sid = "AttachRolesToSelfManagedGroups"
    effect = "Allow"

    actions = [
      "iam:AttachRolePolicy",
      "iam:DetachRolePolicy",
      "iam:GetRole",
      "iam:GetRolePolicy",
      "iam:ListAttachedRolePolicies",
      "iam:ListRoles"
      ]

    resources = ["arn:aws:iam::*:role/alpha_user_*"]
  }

  statement {
    sid = "ManageDataEngineerPolicies"
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
    sid = "ListDockerRepository"
    effect = "Allow"

    actions = ["ecr:ListImages"]

    resources = ["*"]
  }
}
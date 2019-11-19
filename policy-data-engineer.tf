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
    sid    = "ListSnsTopics"
    effect = "Allow"

    actions = [
      "sns:ListTopics",
      "sns:GetTopicAttributes",
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
    sid    = "GlueEc2Describe"
    effect = "Allow"

    actions = [
      "ec2:DescribeVpcEndpoints",
      "ec2:DescribeRouteTables",
      "ec2:CreateNetworkInterface",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSubnets",
      "ec2:DescribeVpcAttribute",
      "ec2:DescribeVpcs",
      "ec2:DescribeKeyPairs",
      "ec2:DescribeInstances",
      "ec2:DescribeImages",
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
    sid    = "GlueManageEc2Tags"
    effect = "Allow"

    actions = [
      "ec2:CreateTags",
      "ec2:DeleteTags",
      "ec2:RunInstances",
    ]

    condition {
      test     = "ForAllValues:StringEquals"
      variable = "aws:TagKeys"
      values   = ["aws-glue-service-resource"]
    }

    resources = [
      "arn:aws:ec2:*:*:network-interface/*",
      "arn:aws:ec2:*:*:security-group/*",
      "arn:aws:ec2:*:*:instance/*",
      "arn:aws:ec2:*:*:key-pair/*",
      "arn:aws:ec2:*:*:image/*",
      "arn:aws:ec2:*:*:subnet/*",
      "arn:aws:ec2:*:*:volume/*",
    ]
  }

  statement {
    sid    = "GlueRedshiftAccess"
    effect = "Allow"

    actions = [
      "redshift:DescribeClusters",
      "redshift:DescribeClusterSubnetGroups",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "GlueRdsAccess"
    effect = "Allow"

    actions = [
      "rds:DescribeDBInstances",
      "rds:DescribeDBClusters",
      "rds:DescribeDBSubnetGroups",
    ]

    resources = ["*"]
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
    sid    = "GlueDynamoAccess"
    effect = "Allow"

    actions = ["dynamodb:ListTables"]

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
    sid    = "GlueTearDownGlueInstances"
    effect = "Allow"

    actions = [
      "ec2:TerminateInstances",
      "ec2:CreateTags",
      "ec2:DeleteTags",
    ]

    condition {
      test     = "StringLike"
      variable = "ec2:ResourceTag/aws:cloudformation:stack-id"
      values   = ["arn:aws:cloudformation:*:*:stack/aws-glue-*/*"]
    }

    condition {
      test     = "StringEquals"
      variable = "ec2:ResourceTag/aws:cloudformation:logical-id"
      values   = ["ZeppelinInstance"]
    }

    resources = ["arn:aws:ec2:*:*:instance/*"]
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
    sid    = "GlueIamPassRoleToServiceEc2"
    effect = "Allow"

    actions = ["iam:PassRole"]

    condition {
      test     = "StringLike"
      variable = "iam:PassedToService"
      values   = ["ec2.amazonaws.com"]
    }

    resources = ["arn:aws:iam::*:role/AWSGlueServiceNotebookRole*"]
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
}

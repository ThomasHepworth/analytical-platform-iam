# Permissions required by Terraform for enabling GuardDuty
data "aws_iam_policy_document" "ap_terraform_aws_security" {
  statement {
    sid    = "CloudWatchAlarms"
    effect = "Allow"

    actions = [
      "cloudwatch:Get*",
      "cloudwatch:List*",
      "cloudwatch:Describe*",
      "cloudwatch:PutMetricAlarm",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "CloudformationCreationUpdate"
    effect = "Allow"

    actions = [
      "cloudformation:CreateStack",
      "cloudformation:UpdateStack",
      "cloudformation:DescribeStacks",
      "cloudformation:DescribeStackEvents",
      "cloudformation:DescribeStackResources",
      "cloudformation:GetTemplate",
      "cloudformation:ValidateTemplate",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "BucketCreation"
    effect = "Allow"

    actions = [
      "s3:Get*",
      "s3:List*",
      "s3:Put*",
      "s3:Delete*",
      "s3:Create*",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "AWSConfigCreation"
    effect = "Allow"

    actions = [
      "config:Get*",
      "config:List*",
      "config:Delete*",
      "config:Describe*",
      "config:Put*",
      "config:Start*",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "GuardDutyLandingTerraform"
    effect = "Allow"

    actions = [
      "guardduty:*",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "GuarddutyPipelineLogGroup"
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DeleteLogGroup",
      "logs:Describe*",
      "logs:List*",
      "logs:PutLogEvents",
      "logs:PutRetentionPolicy",
    ]

    resources = ["arn:aws:logs:*:*:*"]
  }

  statement {
    sid    = "SecurityHubTerraform"
    effect = "Allow"

    actions = [
      "securityhub:*",
    ]

    resources = ["*"]
  }

  statement {
    sid       = "SecurityHubLinkedRole"
    effect    = "Allow"
    actions   = ["iam:CreateServiceLinkedRole"]
    resources = ["*"]

    condition {
      test     = "StringLike"
      variable = "iam:AWSServiceName"

      values = [
        "securityhub.amazonaws.com",
      ]
    }
  }

  statement {
    sid       = "GuardDutyLinkedRolesTerraform"
    effect    = "Allow"
    actions   = ["iam:CreateServiceLinkedRole"]
    resources = ["*"]

    condition {
      test     = "StringLike"
      variable = "iam:AWSServiceName"

      values = [
        "guardduty.amazonaws.com",
      ]
    }
  }

  statement {
    sid    = "GuardDutyRWRolesTerraform"
    effect = "Allow"

    actions = [
      "iam:AttachRolePolicy",
      "iam:CreatePolicy",
      "iam:CreatePolicyVersion",
      "iam:CreateRole",
      "iam:DeletePolicy",
      "iam:DeleteRole",
      "iam:DeleteRolePolicy",
      "iam:DetachRolePolicy",
      "iam:Get*",
      "iam:List*",
      "iam:PassRole",
      "iam:PutRolePolicy",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "GuardDutyCloudWatchEvent"
    effect = "Allow"

    actions = [
      "events:*",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "SSMParameterAccess"
    effect = "Allow"

    actions = [
      "ssm:GetParameter*",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "KMSDecryptAccess"
    effect = "Allow"

    actions = [
      "kms:Decrypt",
    ]

    resources = ["arn:aws:kms:eu-west-1:${var.landing_account_id}:key/925a5b6c-7df1-49a0-a3cc-471e8524637d"]
  }

  statement {
    sid    = "SNSTopicCreation"
    effect = "Allow"

    actions = [
      "sns:*",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "LambdaCreation"
    effect = "Allow"

    not_actions = [
      "lambda:PutFunctionConcurrency",
    ]

    resources = ["arn:aws:lambda:*:*:function:*"]
  }
}

# Create terraform role in landing account
module "add_terraform_guardduty_role_in_landing" {
  source = "modules/role"

  assume_role_in_account_id  = "${var.landing_account_id}"
  role_name                  = "${var.terraform_aws_security_name}"
  landing_account_id         = "${var.landing_account_id}"
  role_policy                = "${data.aws_iam_policy_document.ap_terraform_aws_security.json}"
  role_principal_identifiers = ["arn:aws:iam::${var.landing_account_id}:root"]
  role_principal_type        = "AWS"
}

# Create terraform role in dev account
module "add_terraform_guardduty_role_in_dev" {
  source = "modules/role"

  assume_role_in_account_id  = "${var.ap_accounts["dev"]}"
  role_name                  = "${var.terraform_aws_security_name}"
  landing_account_id         = "${var.landing_account_id}"
  role_policy                = "${data.aws_iam_policy_document.ap_terraform_aws_security.json}"
  role_principal_identifiers = ["arn:aws:iam::${var.landing_account_id}:root"]
  role_principal_type        = "AWS"
}

# Create terraform role in prod account
module "add_terraform_guardduty_role_in_prod" {
  source = "modules/role"

  assume_role_in_account_id  = "${var.ap_accounts["prod"]}"
  role_name                  = "${var.terraform_aws_security_name}"
  landing_account_id         = "${var.landing_account_id}"
  role_policy                = "${data.aws_iam_policy_document.ap_terraform_aws_security.json}"
  role_principal_identifiers = ["arn:aws:iam::${var.landing_account_id}:root"]
  role_principal_type        = "AWS"
}

# Create terraform role in data account
module "add_terraform_guardduty_role_in_data" {
  source = "modules/role"

  assume_role_in_account_id  = "${var.ap_accounts["data"]}"
  role_name                  = "${var.terraform_aws_security_name}"
  landing_account_id         = "${var.landing_account_id}"
  role_policy                = "${data.aws_iam_policy_document.ap_terraform_aws_security.json}"
  role_principal_identifiers = ["arn:aws:iam::${var.landing_account_id}:root"]
  role_principal_type        = "AWS"
}

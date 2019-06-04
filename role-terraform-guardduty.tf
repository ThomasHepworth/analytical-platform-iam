# Permissions required by Terraform for enabling GuardDuty
data "aws_iam_policy_document" "ap_terraform_guardduty" {
  statement {
    sid       = "GuardDutyLandingTerraform"
    effect    = "Allow"
    actions   = [
      "guardduty:*"
    ]
    resources = ["*"]
  }
  statement {
    sid       = "GuarddutyPipelineLogGroup"
    effect    = "Allow"
    actions   = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:Describe*",
      "logs:List*",
      "logs:PutLogEvents",
      "logs:PutRetentionPolicy"
    ]
    resources = ["arn:aws:logs:*:*:*"]
  }
  statement {
    sid       = "GuardDutyLinkedRolesTerraform"
    effect    = "Allow"
    actions   = ["iam:CreateServiceLinkedRole"]
    resources = ["*"]
    condition {
      test = "StringLike"
      variable = "iam:AWSServiceName"
      values = [
        "guardduty.amazonaws.com"
      ]
    }
  }
  statement {
    sid       = "GuardDutyRWRolesTerraform"
    effect    = "Allow"
    actions   = [
      "iam:AttachRolePolicy",
      "iam:CreatePolicy",
      "iam:CreateRole",
      "iam:DeleteRolePolicy",
      "iam:Get*",
      "iam:List*",
      "iam:PutRolePolicy"
    ]
    resources = ["*"]
  }
  statement {
    sid       = "GuardDutyCloudWatchEvent"
    effect    = "Allow"
    actions   = [
      "events:*"
    ]
    resources = ["*"]
  }
  statement {
    sid       = "SSMParameterAccess"
    effect    = "Allow"
    actions   = [
      "ssm:GetParameter*"
    ]
    resources = ["*"]
  }
  statement {
    sid       = "KMSDecryptAccess"
    effect    = "Allow"
    actions   = [
      "kms:Decrypt"
    ]
    resources = ["arn:aws:kms:eu-west-1:${var.landing_account_id}:key/925a5b6c-7df1-49a0-a3cc-471e8524637d"]
  }
  statement {
    sid       = "SNSTopicCreation"
    effect    = "Allow"
    actions   = [
      "sns:*"
    ]
    resources = ["*"]
  }
  statement {
    sid       = "LambdaCreation"
    effect    = "Allow"
    not_actions   = [
      "lambda:AddPermission",
      "lambda:PutFunctionConcurrency"
    ]
    resources = ["arn:aws:lambda:*:*:function:*"]
  }
}

# Create terraform role in landing account
module "add_terraform_guardduty_role_in_landing" {
  source = "modules/role"

  assume_role_in_account_id = "${var.landing_account_id}"
  role_name                 = "${var.terraform_guardduty_name}"
  landing_account_id        = "${var.landing_account_id}"
  role_policy               = "${data.aws_iam_policy_document.ap_terraform_guardduty.json}"
}

# Create terraform role in dev account
module "add_terraform_guardduty_role_in_dev" {
  source = "modules/role"

  assume_role_in_account_id = "${var.ap_accounts["dev"]}"
  role_name                 = "${var.terraform_guardduty_name}"
  landing_account_id        = "${var.landing_account_id}"
  role_policy               = "${data.aws_iam_policy_document.ap_terraform_guardduty.json}"
}

# Create terraform role in prod account
module "add_terraform_guardduty_role_in_prod" {
  source = "modules/role"

  assume_role_in_account_id = "${var.ap_accounts["prod"]}"
  role_name                 = "${var.terraform_guardduty_name}"
  landing_account_id        = "${var.landing_account_id}"
  role_policy               = "${data.aws_iam_policy_document.ap_terraform_guardduty.json}"
}

# Create terraform role in data account
module "add_terraform_guardduty_role_in_data" {
  source = "modules/role"

  assume_role_in_account_id = "${var.ap_accounts["data"]}"
  role_name                 = "${var.terraform_guardduty_name}"
  landing_account_id        = "${var.landing_account_id}"
  role_policy               = "${data.aws_iam_policy_document.ap_terraform_guardduty.json}"
}

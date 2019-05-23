# Change to whatever terraform requires in the landing account (doesn't need R53 yet)
data "aws_iam_policy_document" "landing_terraform_infrastructure" {
  statement {
    sid       = "GuardDutyLandingTerraform"
    effect    = "Allow"
    actions   = [
      "guardduty:*"
    ]
    resources = ["*"]
  }
  statement {
    sid       = "GuardDutyLandingLinkedRolesTerraform"
    effect    = "Allow"
    actions   = ["iam:CreateServiceLinkedRole"]
    resources = ["arn:aws:iam:::role/aws-service-role/guardduty.amazonaws.com/AWSServiceRoleForAmazonGuardDuty"]
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
      "iam:PutRolePolicy",
      "iam:DeleteRolePolicy"
    ]
    resources = ["arn:aws:iam:::role/aws-service-role/guardduty.amazonaws.com/AWSServiceRoleForAmazonGuardDuty"]
  }
}

# Permissions required by Terraform in the Analytical Platform accounts (excluding landing account)
data "aws_iam_policy_document" "ap_terraform_infrastructure" {
  statement {
    sid       = "GuardDutyLandingTerraform"
    effect    = "Allow"
    actions   = [
      "guardduty:*"
    ]
    resources = ["*"]
  }
  statement {
    sid       = "GuardDutyLandingLinkedRolesTerraform"
    effect    = "Allow"
    actions   = ["iam:CreateServiceLinkedRole"]
    resources = ["arn:aws:iam:::role/aws-service-role/guardduty.amazonaws.com/AWSServiceRoleForAmazonGuardDuty"]
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
      "iam:PutRolePolicy",
      "iam:DeleteRolePolicy"
    ]
    resources = ["arn:aws:iam:::role/aws-service-role/guardduty.amazonaws.com/AWSServiceRoleForAmazonGuardDuty"]
  }
}

# Create terraform role in landing account
module "add_terraform_infrastructure_role_in_landing" {
  source = "modules/role"

  assume_role_in_account_id = "${var.landing_account_id}"
  role_name                 = "${var.terraform_infrastructure_name}-${local.landing}"
  landing_account_id        = "${var.landing_account_id}"
  role_policy               = "${data.aws_iam_policy_document.landing_terraform_infrastructure.json}"
}

# Create terraform role in dev account
module "add_terraform_infrastructure_role_in_dev" {
  source = "modules/role"

  assume_role_in_account_id = "${var.ap_accounts["dev"]}"
  role_name                 = "${var.terraform_infrastructure_name}-${local.dev}"
  landing_account_id        = "${var.landing_account_id}"
  role_policy               = "${data.aws_iam_policy_document.ap_terraform_infrastructure.json}"
}

module "add_terraform_infrastructure_role_in_prod" {
  source = "modules/role"

  assume_role_in_account_id = "${var.ap_accounts["prod"]}"
  role_name                 = "${var.terraform_infrastructure_name}-${local.prod}"
  landing_account_id        = "${var.landing_account_id}"
  role_policy               = "${data.aws_iam_policy_document.ap_terraform_infrastructure.json}"
}

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
      "iam:PutRolePolicy",
      "iam:DeleteRolePolicy"
    ]
    resources = ["*"]
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

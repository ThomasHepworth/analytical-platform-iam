# Change to whatever terraform requires in the landing account (doesn't need R53 yet)
data "aws_iam_policy_document" "landing_terraform_infrastructure" {
  statement {
    sid       = "Route53"
    effect    = "Allow"
    actions   = [
      "route53:*",
      "s3:*",
      "ssm:*",
      "kms:Decrypt",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }
}

# Permissions required by Terraform in the Analytical Platform accounts (excluding landing account)
data "aws_iam_policy_document" "ap_terraform_infrastructure" {
  statement {
    sid       = "apRemoteTerraform"
    effect    = "Allow"
    actions   = [
      "route53:*",
      "cloudtrail:*",
      "iam:*",
      "vpc:*",
      "ec2:*",
      "s3:*",
      "elasticloadbalancing:*",
      "cloudwatch:*",
      "autoscaling:*",
      "kms:Decrypt"
      ]
    resources = ["*"]
  }
}

# Create terraform role in landing account
module "add_terraform_infrastructure_role_in_landing" {
  source = "modules/role"

  assume_role_in_account_id  = "${var.landing_account_id}"
  role_name                  = "${var.terraform_infrastructure_name}"
  landing_account_id         = "${var.landing_account_id}"
  role_policy                = "${data.aws_iam_policy_document.landing_terraform_infrastructure.json}"
  role_principal_identifiers = ["codebuild.amazonaws.com"]
  role_principal_type        = "Service"
}

# Create terraform role in dev account
module "add_terraform_infrastructure_role_in_dev" {
  source = "modules/role"

  assume_role_in_account_id  = "${var.ap_accounts["dev"]}"
  role_name                  = "${var.terraform_infrastructure_name}"
  landing_account_id         = "${var.landing_account_id}"
  role_policy                = "${data.aws_iam_policy_document.ap_terraform_infrastructure.json}"
  role_principal_identifiers = ["codebuild.amazonaws.com"]
  role_principal_type        = "Service"
}

module "add_terraform_infrastructure_role_in_prod" {
  source = "modules/role"

  assume_role_in_account_id  = "${var.ap_accounts["prod"]}"
  role_name                  = "${var.terraform_infrastructure_name}"
  landing_account_id         = "${var.landing_account_id}"
  role_policy                = "${data.aws_iam_policy_document.ap_terraform_infrastructure.json}"
  role_principal_identifiers = ["codebuild.amazonaws.com"]
  role_principal_type        = "Service"
}

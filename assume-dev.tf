locals {
  dev = "dev"
}

##### Restricted Admin #####
## Restricted Admin Group

module "assume_restricted_admin_in_dev" {
  source = "modules/assume"

  assumed_role_name = "${var.restricted_admin_name}-${local.dev}"

  assume_role_in_account_id = [
    "${var.ap_accounts["dev"]}",
  ]

  landing_account_id = "${var.landing_account_id}"
  group_name         = "${var.restricted_admin_name}-${local.dev}"

  users = [
    "${aws_iam_user.mikael.name}",
    "${aws_iam_user.shojul.name}",
    "${aws_iam_user.aldo.name}",
    "${aws_iam_user.ravi.name}",
    "${aws_iam_user.david.name}",
    "${aws_iam_user.andy.name}",
    "${aws_iam_user.josh.name}",
  ]
}

## Create restricted admin role in dev account
module "add_restricted_admin_role_in_dev" {
  source = "modules/role"

  providers = {
    aws = "aws.dev"
  }

  role_name          = "${var.restricted_admin_name}-${local.dev}"
  landing_account_id = "${var.landing_account_id}"
  role_policy        = "${data.aws_iam_policy_document.restricted_admin.json}"
}

##### READ ONLY #####
## Read Only Group

module "assume_read_only_in_dev" {
  source = "modules/assume"

  assumed_role_name = "${var.read_only_name}-${local.dev}"

  assume_role_in_account_id = [
    "${var.ap_accounts["dev"]}",
  ]

  landing_account_id = "${var.landing_account_id}"
  group_name         = "${var.read_only_name}-${local.dev}"

  users = [
    "${aws_iam_user.mikael.name}",
    "${aws_iam_user.shojul.name}",
    "${aws_iam_user.aldo.name}",
    "${aws_iam_user.ravi.name}",
    "${aws_iam_user.david.name}",
    "${aws_iam_user.andy.name}",
    "${aws_iam_user.josh.name}",
  ]
}

## Create read only role in data account
module "add_read_only_role_in_dev" {
  source = "modules/role"

  providers = {
    aws = "aws.dev"
  }

  role_name          = "${var.read_only_name}-${local.dev}"
  landing_account_id = "${var.landing_account_id}"
  role_policy        = "${data.aws_iam_policy_document.read_only.json}"
}

## Create audit security role in dev account
module "add_audit_security_role_in_dev" {
  source = "modules/role"

  providers = {
    aws = "aws.dev"
  }

  role_name          = "${var.audit_security_name}"
  landing_account_id = "${var.security_account_id}"
  role_policy_arn    = "arn:aws:iam::aws:policy/SecurityAudit"
}

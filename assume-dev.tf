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
    "${aws_iam_user.olivier.name}",
  ]
}

## Create restricted admin role in dev account
module "add_restricted_admin_role_in_dev" {
  source = "modules/role"

  assume_role_in_account_id  = "${var.ap_accounts["dev"]}"
  role_name                  = "${var.restricted_admin_name}-${local.dev}"
  landing_account_id         = "${var.landing_account_id}"
  role_policy                = "${data.aws_iam_policy_document.restricted_admin.json}"
  role_principal_identifiers = ["arn:aws:iam::${var.landing_account_id}:root"]
  role_principal_type        = "AWS"
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
  ]
}

## Create read only role in data account
module "add_read_only_role_in_dev" {
  source = "modules/role"

  assume_role_in_account_id  = "${var.ap_accounts["dev"]}"
  role_name                  = "${var.read_only_name}-${local.dev}"
  landing_account_id         = "${var.landing_account_id}"
  role_policy                = "${data.aws_iam_policy_document.read_only.json}"
  role_principal_identifiers = ["arn:aws:iam::${var.landing_account_id}:root"]
  role_principal_type        = "AWS"
}

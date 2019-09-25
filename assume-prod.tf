locals {
  prod = "prod"
}

##### Restricted Admin #####
## Restricted Admin Group

module "assume_restricted_admin_in_prod" {
  source = "modules/assume"

  assumed_role_name = "${var.restricted_admin_name}-${local.prod}"

  assume_role_in_account_id = [
    "${var.ap_accounts["prod"]}",
  ]

  landing_account_id = "${var.landing_account_id}"
  group_name         = "${var.restricted_admin_name}-${local.prod}"

  users = [
    "${aws_iam_user.mikael.name}",
    "${aws_iam_user.shojul.name}",
    "${aws_iam_user.aldo.name}",
    "${aws_iam_user.ravi.name}",
    "${aws_iam_user.olivier.name}",
  ]
}

## Create restricted admin role in prod account
module "add_restricted_admin_role_in_prod" {
  source = "modules/role"

  assume_role_in_account_id = "${var.ap_accounts["prod"]}"
  role_name                 = "${var.restricted_admin_name}-${local.prod}"
  landing_account_id        = "${var.landing_account_id}"
  role_policy               = "${data.aws_iam_policy_document.restricted_admin.json}"
}

##### READ ONLY #####
## Read Only Group

module "assume_read_only_in_prod" {
  source = "modules/assume"

  assumed_role_name = "${var.read_only_name}-${local.prod}"

  assume_role_in_account_id = [
    "${var.ap_accounts["prod"]}",
  ]

  landing_account_id = "${var.landing_account_id}"
  group_name         = "${var.read_only_name}-${local.prod}"

  users = [
    "${aws_iam_user.mikael.name}",
    "${aws_iam_user.shojul.name}",
    "${aws_iam_user.aldo.name}",
    "${aws_iam_user.ravi.name}",
  ]
}

## Create read only role in data account
module "add_read_only_role_in_prod" {
  source = "modules/role"

  assume_role_in_account_id = "${var.ap_accounts["prod"]}"
  role_name                 = "${var.read_only_name}-${local.prod}"
  landing_account_id        = "${var.landing_account_id}"
  role_policy               = "${data.aws_iam_policy_document.read_only.json}"
}

## Create mvision trial read only role in prod
module "add_mvision_trial_role_in_prod" {
  source = "modules/role"

  assume_role_in_account_id = "${var.ap_accounts["prod"]}"
  role_name                 = "${var.mcafee_mvision_trial_role}"
  landing_account_id        = "${var.mvision_account_id}"
  role_policy_arn           = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  external_id               = "${var.mvision_external_id}"
}

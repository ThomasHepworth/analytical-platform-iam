locals {
  landing = "landing"
}

##### RESTRICTED ADMIN #####
## Restricted Admin Group

module "assume_restricted_admin_in_landing" {
  source = "modules/assume"

  assumed_role_name = "${var.restricted_admin_name}-${local.landing}"

  assume_role_in_account_id = [
    "${var.landing_account_id}",
  ]

  landing_account_id = "${var.landing_account_id}"
  group_name         = "${var.restricted_admin_name}-${local.landing}"

  users = [
    "${aws_iam_user.mikael.name}",
    "${aws_iam_user.shojul.name}",
    "${aws_iam_user.aldo.name}",
    "${aws_iam_user.ravi.name}",
    "${aws_iam_user.olivier.name}",
  ]
}

## Restricted Admin Role
## Create restricted admin role in dev account
module "add_restricted_admin_role_in_landing" {
  source = "modules/role"

  assume_role_in_account_id = "${var.landing_account_id}"
  role_name                 = "${var.restricted_admin_name}-${local.landing}"
  landing_account_id        = "${var.landing_account_id}"
  role_policy               = "${data.aws_iam_policy_document.restricted_admin.json}"
}

##### READ ONLY #####
## Read Only Group

module "assume_read_only_in_landing" {
  source = "modules/assume"

  assumed_role_name = "${var.read_only_name}-${local.landing}"

  assume_role_in_account_id = [
    "${var.landing_account_id}",
  ]

  landing_account_id = "${var.landing_account_id}"
  group_name         = "${var.read_only_name}-${local.landing}"

  users = [
    "${aws_iam_user.mikael.name}",
    "${aws_iam_user.shojul.name}",
    "${aws_iam_user.aldo.name}",
    "${aws_iam_user.ravi.name}",
  ]
}

## Create read only role in data account
module "add_read_only_role_in_landing" {
  source = "modules/role"

  assume_role_in_account_id = "${var.landing_account_id}"
  role_name                 = "${var.read_only_name}-${local.landing}"
  landing_account_id        = "${var.landing_account_id}"
  role_policy               = "${data.aws_iam_policy_document.read_only.json}"
}

##### SUSPENDED USERS #####
## Create suspended users group for inactive users

module "add_suspended_users_group_in_landing" {
  source = "modules/assume"

  assumed_role_name = "nil"

  assume_role_in_account_id = ["nil"]
  landing_account_id        = "${var.landing_account_id}"
  group_name                = "${var.suspended_users_name}"
  group_effect              = "Deny"

  users = [
    "${aws_iam_user.suspended.name}",
  ]
}

## Create mvision trial read only role in landing
module "add_mvision_trial_role_in_landing" {
  source = "modules/role"

  assume_role_in_account_id = "${var.landing_account_id}"
  role_name                 = "${var.mcafee_mvision_trial_role}"
  landing_account_id        = "${var.mvision_account_id}"
  role_policy_arn           = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  external_id               = "${var.mvision_external_id}"
}

## Create audit security role in landing account
module "add_audit_security_role_in_landing" {
  source = "modules/role"

  assume_role_in_account_id = "${var.landing_account_id}"
  role_name                 = "${var.audit_security_name}"
  landing_account_id        = "${var.security_account_id}"
  role_policy_arn           = "arn:aws:iam::aws:policy/SecurityAudit"
}

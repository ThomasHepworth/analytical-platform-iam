locals {
  data = "data"
}

##### Restricted Admin #####
## Restricted Admin Group

module "assume_restricted_admin_in_data" {
  source = "modules/assume"

  assumed_role_name = "${var.restricted_admin_name}-${local.data}"

  assume_role_in_account_id = [
    "${var.ap_accounts["data"]}",
  ]

  landing_account_id = "${var.landing_account_id}"
  group_name         = "${var.restricted_admin_name}-${local.data}"

  users = [
    "${aws_iam_user.mikael.name}",
    "${aws_iam_user.shojul.name}",
    "${aws_iam_user.aldo.name}",
    "${aws_iam_user.ravi.name}",
    "${aws_iam_user.olivier.name}",
  ]
}

## Create restricted admin role in data account
module "add_restricted_admin_role_in_data" {
  source = "modules/role"

  assume_role_in_account_id = "${var.ap_accounts["data"]}"
  role_name                 = "${var.restricted_admin_name}-${local.data}"
  landing_account_id        = "${var.landing_account_id}"
  role_policy               = "${data.aws_iam_policy_document.restricted_admin.json}"
}

##### READ ONLY #####
## Read Only Group

module "assume_read_only_in_data" {
  source = "modules/assume"

  assumed_role_name = "${var.read_only_name}-${local.data}"

  assume_role_in_account_id = [
    "${var.ap_accounts["data"]}",
  ]

  landing_account_id = "${var.landing_account_id}"
  group_name         = "${var.read_only_name}-${local.data}"

  users = [
    "${aws_iam_user.mikael.name}",
    "${aws_iam_user.shojul.name}",
    "${aws_iam_user.aldo.name}",
    "${aws_iam_user.ravi.name}",
  ]
}

## Create read only role in data account
module "add_read_only_role_in_data" {
  source = "modules/role"

  assume_role_in_account_id = "${var.ap_accounts["data"]}"
  role_name                 = "${var.read_only_name}-${local.data}"
  landing_account_id        = "${var.landing_account_id}"
  role_policy               = "${data.aws_iam_policy_document.read_only.json}"
}

##### READ S3 ONLY #####
## Read S3 Only Group

module "assume_read_s3_only_in_data" {
  source = "modules/assume"

  assumed_role_name = "${var.read_data_only_name}-${local.data}-acc"

  assume_role_in_account_id = [
    "${var.ap_accounts["data"]}",
  ]

  landing_account_id = "${var.landing_account_id}"
  group_name         = "${var.read_data_only_name}-${local.data}-acc"

  users = [
    "${aws_iam_user.mikael.name}",
    "${aws_iam_user.shojul.name}",
    "${aws_iam_user.aldo.name}",
    "${aws_iam_user.ravi.name}",
    "${aws_iam_user.calum.name}",
  ]
}

## Create read s3 only role in data account
module "add_read_data_only_role_in_data" {
  source = "modules/role"

  assume_role_in_account_id = "${var.ap_accounts["data"]}"
  role_name                 = "${var.read_data_only_name}-${local.data}-acc"
  landing_account_id        = "${var.landing_account_id}"
  role_policy               = "${data.aws_iam_policy_document.read_data_only.json}"
}

##### DATA ADMIN #####
## Data ADMIN Group

module "assume_data_admin_in_data" {
  source = "modules/assume"

  assumed_role_name = "${var.data_admin_name}-${local.data}-acc"

  assume_role_in_account_id = [
    "${var.ap_accounts["data"]}",
  ]

  landing_account_id = "${var.landing_account_id}"
  group_name         = "${var.data_admin_name}-${local.data}-acc"

  users = [
    "${aws_iam_user.mikael.name}",
    "${aws_iam_user.shojul.name}",
    "${aws_iam_user.aldo.name}",
    "${aws_iam_user.ravi.name}",
    "${aws_iam_user.olivier.name}",
  ]
}

## Create read data only role in data account
module "add_data_admin_role_in_data" {
  source = "modules/role"

  assume_role_in_account_id = "${var.ap_accounts["data"]}"
  role_name                 = "${var.data_admin_name}-${local.data}-acc"
  landing_account_id        = "${var.landing_account_id}"
  role_policy               = "${data.aws_iam_policy_document.data_admin.json}"
}

## Create audit security role in data account
module "add_audit_security_role_in_data" {
  source = "modules/role"

  assume_role_in_account_id = "${var.ap_accounts["data"]}"
  role_name                 = "${var.audit_security_name}"
  landing_account_id        = "${var.security_account_id}"
  role_policy_arn           = "arn:aws:iam::aws:policy/SecurityAudit"
}

##### CALUM TEST #####
## Calum Test Group

module "assume_calum_test_in_data" {
  source = "modules/assume"

  assumed_role_name = "${var.calum_test_name}-${local.data}-acc"

  assume_role_in_account_id = [
    "${var.ap_accounts["data"]}",
  ]

  landing_account_id = "${var.landing_account_id}"
  group_name         = "${var.calum_test_name}-${local.data}-acc"

  users = [
    "${aws_iam_user.calum.name}",
  ]
}

## Create Calum test role in data account
module "add_calum_test_role_in_data" {
  source = "modules/role"

  assume_role_in_account_id = "${var.ap_accounts["data"]}"
  role_name                 = "${var.calum_test_name}-${local.data}-acc"
  landing_account_id        = "${var.landing_account_id}"
  role_policy               = "${data.aws_iam_policy_document.calum_test.json}"
}

module "assume_restricted_admin_in_data" {
  source = "./modules/assume"

  assumed_role_name         = "${var.restricted_admin_name}-data"
  assume_role_in_account_id = var.ap_accounts["data"]
  landing_account_id        = var.landing_account_id
  group_name                = "${var.restricted_admin_name}-data"
  users                     = local.analytical_platform_team
}

module "add_restricted_admin_role_in_data" {
  source    = "./modules/role"
  providers = { aws = aws.data }

  role_name          = "${var.restricted_admin_name}-data"
  landing_account_id = var.landing_account_id
  role_policy        = data.aws_iam_policy_document.restricted_admin.json
}

module "assume_read_only_in_data" {
  source = "./modules/assume"

  assumed_role_name         = "${var.read_only_name}-data"
  assume_role_in_account_id = var.ap_accounts["data"]
  landing_account_id        = var.landing_account_id
  group_name                = "${var.read_only_name}-data"
  users                     = local.analytical_platform_team
}

module "add_read_only_role_in_data" {
  source    = "./modules/role"
  providers = { aws = aws.data }

  role_name          = "${var.read_only_name}-data"
  landing_account_id = var.landing_account_id
  role_policy        = data.aws_iam_policy_document.read_only.json
}

module "assume_read_s3_only_in_data" {
  source = "./modules/assume"

  assumed_role_name         = "${var.read_data_only_name}-data-acc"
  assume_role_in_account_id = var.ap_accounts["data"]
  landing_account_id        = var.landing_account_id
  group_name                = "${var.read_data_only_name}-data-acc"

  users = [
    aws_iam_user.calum.name,
    aws_iam_user.sam.name,
    aws_iam_user.andrew.name,
    aws_iam_user.toms.name,
    aws_iam_user.danw.name,
  ]
}

module "add_read_data_only_role_in_data" {
  source    = "./modules/role"
  providers = { aws = aws.data }

  role_name          = "${var.read_data_only_name}-data-acc"
  landing_account_id = var.landing_account_id
  role_policy        = data.aws_iam_policy_document.read_data_only.json
}

module "assume_data_admin_in_data" {
  source = "./modules/assume"

  assumed_role_name         = "${var.data_admin_name}-data-acc"
  assume_role_in_account_id = var.ap_accounts["data"]
  landing_account_id        = var.landing_account_id
  group_name                = "${var.data_admin_name}-data-acc"
  users                     = local.analytical_platform_team
}

module "add_data_admin_role_in_data" {
  source    = "./modules/role"
  providers = { aws = aws.data }

  role_name          = "${var.data_admin_name}-data-acc"
  landing_account_id = var.landing_account_id
  role_policy        = data.aws_iam_policy_document.data_admin.json
}

module "add_audit_security_role_in_data" {
  source    = "./modules/role"
  providers = { aws = aws.data }

  role_name          = var.audit_security_name
  landing_account_id = var.security_account_id
  role_policy_arn    = "arn:aws:iam::aws:policy/SecurityAudit"
}

module "add_data_engineers_group" {
  source = "./modules/assume"

  assumed_role_name         = var.data_engineers_name
  assume_role_in_account_id = var.ap_accounts["data"]
  landing_account_id        = var.landing_account_id
  group_name                = var.data_engineers_name
  users                     = local.data_engineering_team
}

module "add_data_engineers_role_in_data_account" {
  source    = "./modules/role"
  providers = { aws = aws.data }

  role_name          = var.data_engineers_name
  landing_account_id = var.landing_account_id
  role_policy        = data.aws_iam_policy_document.data_engineer.json
}

module "add_hmcts_data_engineers_group" {
  source = "./modules/assume"

  assumed_role_name         = var.hmcts_data_engineers_name
  assume_role_in_account_id = var.ap_accounts["data"]
  landing_account_id        = var.landing_account_id
  group_name                = var.hmcts_data_engineers_name
  users                     = local.courts_data_engineering_team
}

module "add_hmcts_data_engineers_role_in_data_account" {
  source    = "./modules/role"
  providers = { aws = aws.data }

  role_name          = var.hmcts_data_engineers_name
  landing_account_id = var.landing_account_id
  role_policy        = data.aws_iam_policy_document.hmcts_data_engineer.json
}

module "add_probation_data_engineers_group" {
  source = "./modules/assume"

  assumed_role_name         = var.probation_data_engineers_name
  assume_role_in_account_id = var.ap_accounts["data"]
  landing_account_id        = var.landing_account_id
  group_name                = var.probation_data_engineers_name
  users                     = local.probation_data_engineering_team
}

module "add_probation_data_engineers_role_in_data_account" {
  source    = "./modules/role"
  providers = { aws = aws.data }

  role_name          = var.probation_data_engineers_name
  landing_account_id = var.landing_account_id
  role_policy        = data.aws_iam_policy_document.probation_data_engineer.json
}

module "add_prison_data_engineers_group" {
  source = "./modules/assume"

  assumed_role_name         = var.prison_data_engineers_name
  assume_role_in_account_id = var.ap_accounts["data"]
  landing_account_id        = var.landing_account_id
  group_name                = var.prison_data_engineers_name
  users                     = local.prisons_data_engineering_team
}

module "add_prison_data_engineers_role_in_data_account" {
  source    = "./modules/role"
  providers = { aws = aws.data }

  role_name          = var.prison_data_engineers_name
  landing_account_id = var.landing_account_id
  role_policy        = data.aws_iam_policy_document.prison_data_engineer.json
}

module "add_corporate_data_engineers_group" {
  source = "./modules/assume"

  assumed_role_name         = var.corporate_data_engineers_name
  assume_role_in_account_id = var.ap_accounts["data"]
  landing_account_id        = var.landing_account_id
  group_name                = var.corporate_data_engineers_name
  users                     = local.corporate_data_engineering_team
}

module "add_corporate_data_engineers_role_in_data_account" {
  source    = "./modules/role"
  providers = { aws = aws.data }

  role_name          = var.corporate_data_engineers_name
  landing_account_id = var.landing_account_id
  role_policy        = data.aws_iam_policy_document.corporate_data_engineer.json
}

module "add_billing_viewer_role_in_data_account" {
  source    = "./modules/role"
  providers = { aws = aws.data }

  role_name          = var.billing_viewer_name
  landing_account_id = var.landing_account_id
  role_policy        = data.aws_iam_policy_document.billing_viewer.json
}

module "add_billing_viewer_group" {
  source = "./modules/assume"

  assumed_role_name         = var.billing_viewer_name
  assume_role_in_account_id = var.ap_accounts["data"]
  landing_account_id        = var.landing_account_id
  group_name                = var.billing_viewer_name

  users = distinct(concat(
    local.analytical_platform_team,
    local.analytical_users,
  ))
}

module "assume_quicksight_admin_in_data" {
  source = "./modules/assume"

  assumed_role_name         = "${var.quicksight_admin_name}-data"
  assume_role_in_account_id = var.ap_accounts["data"]
  landing_account_id        = var.landing_account_id
  group_name                = "${var.quicksight_admin_name}-data"

  users = [
    aws_iam_user.gareth.name,
  ]
}

module "add_quicksight_admin_role_in_data" {
  source    = "./modules/role"
  providers = { aws = aws.data }

  role_name          = "${var.quicksight_admin_name}-data"
  landing_account_id = var.landing_account_id
  role_policy        = data.aws_iam_policy_document.quicksight_admin.json
}

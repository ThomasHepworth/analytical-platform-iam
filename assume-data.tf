module "assume_restricted_admin_in_data" {
  source = "./modules/assume"

  assumed_role_name         = "${var.restricted_admin_name}-data"
  assume_role_in_account_id = var.ap_accounts["data"]
  source_account_id         = var.ap_accounts["landing"]
  group_name                = "${var.restricted_admin_name}-data"
  users                     = module.analytical_platform_team.user_names
}

module "add_restricted_admin_role_in_data" {
  source    = "./modules/role"
  providers = { aws = aws.data }

  role_name         = "${var.restricted_admin_name}-data"
  source_account_id = var.ap_accounts["landing"]
  role_policy       = data.aws_iam_policy_document.restricted_admin.json
  tags              = local.tags
}

module "assume_data_admin_in_data" {
  source = "./modules/assume"

  assumed_role_name         = "${var.data_admin_name}-data-acc"
  assume_role_in_account_id = var.ap_accounts["data"]
  source_account_id         = var.ap_accounts["landing"]
  group_name                = "${var.data_admin_name}-data-acc"
  users                     = module.analytical_platform_team.user_names
}

module "add_data_admin_role_in_data" {
  source    = "./modules/role"
  providers = { aws = aws.data }

  role_name         = "${var.data_admin_name}-data-acc"
  source_account_id = var.ap_accounts["landing"]
  role_policy       = data.aws_iam_policy_document.data_admin.json
  tags              = local.tags
}

module "add_audit_security_role_in_data" {
  source    = "./modules/role"
  providers = { aws = aws.data }

  role_name         = var.audit_security_name
  source_account_id = var.ap_accounts["security"]
  role_policy_arn   = "arn:aws:iam::aws:policy/SecurityAudit"
  tags              = local.tags
}

module "add_data_engineers_group" {
  source = "./modules/assume"

  assumed_role_name         = var.data_engineers_name
  assume_role_in_account_id = var.ap_accounts["data"]
  source_account_id         = var.ap_accounts["landing"]
  group_name                = var.data_engineers_name
  users                     = module.data_engineering_team.user_names
}

module "add_data_engineers_role_in_data_account" {
  source    = "./modules/role"
  providers = { aws = aws.data }

  role_name         = var.data_engineers_name
  source_account_id = var.ap_accounts["landing"]
  role_policy       = data.aws_iam_policy_document.data_engineer.json
  tags              = local.tags
}

module "add_hmcts_data_engineers_group" {
  source = "./modules/assume"

  assumed_role_name         = var.hmcts_data_engineers_name
  assume_role_in_account_id = var.ap_accounts["data"]
  source_account_id         = var.ap_accounts["landing"]
  group_name                = var.hmcts_data_engineers_name
  users                     = module.courts_data_engineering_team.user_names
}

module "add_hmcts_data_engineers_role_in_data_account" {
  source    = "./modules/role"
  providers = { aws = aws.data }

  role_name         = var.hmcts_data_engineers_name
  source_account_id = var.ap_accounts["landing"]
  role_policy       = data.aws_iam_policy_document.courts_data_engineer.json
  tags              = local.tags
}

module "add_probation_data_engineers_group" {
  source = "./modules/assume"

  assumed_role_name         = var.probation_data_engineers_name
  assume_role_in_account_id = var.ap_accounts["data"]
  source_account_id         = var.ap_accounts["landing"]
  group_name                = var.probation_data_engineers_name
  users                     = module.probation_data_engineering_team.user_names
}

module "add_probation_data_engineers_role_in_data_account" {
  source    = "./modules/role"
  providers = { aws = aws.data }

  role_name         = var.probation_data_engineers_name
  source_account_id = var.ap_accounts["landing"]
  role_policy       = data.aws_iam_policy_document.probation_data_engineer.json
  tags              = local.tags
}

module "add_prison_data_engineers_group" {
  source = "./modules/assume"

  assumed_role_name         = var.prison_data_engineers_name
  assume_role_in_account_id = var.ap_accounts["data"]
  source_account_id         = var.ap_accounts["landing"]
  group_name                = var.prison_data_engineers_name
  users                     = module.prison_data_engineering_team.user_names
}

module "add_prison_data_engineers_role_in_data_account" {
  source    = "./modules/role"
  providers = { aws = aws.data }

  role_name         = var.prison_data_engineers_name
  source_account_id = var.ap_accounts["landing"]
  role_policy       = data.aws_iam_policy_document.prison_data_engineer.json
  tags              = local.tags
}

module "add_corporate_data_engineers_group" {
  source = "./modules/assume"

  assumed_role_name         = var.corporate_data_engineers_name
  assume_role_in_account_id = var.ap_accounts["data"]
  source_account_id         = var.ap_accounts["landing"]
  group_name                = var.corporate_data_engineers_name
  users                     = module.corporate_data_engineering_team.user_names
}

module "add_corporate_data_engineers_role_in_data_account" {
  source    = "./modules/role"
  providers = { aws = aws.data }

  role_name         = var.corporate_data_engineers_name
  source_account_id = var.ap_accounts["landing"]
  role_policy       = data.aws_iam_policy_document.corporate_data_engineer.json
  tags              = local.tags
}

module "assume_quicksight_admin_in_data" {
  source = "./modules/assume"

  assumed_role_name         = "${var.quicksight_admin_name}-data"
  assume_role_in_account_id = var.ap_accounts["data"]
  source_account_id         = var.ap_accounts["landing"]
  group_name                = "${var.quicksight_admin_name}-data"

  users = [
    aws_iam_user.gareth.name,
  ]
}

module "add_quicksight_admin_role_in_data" {
  source    = "./modules/role"
  providers = { aws = aws.data }

  role_name         = "${var.quicksight_admin_name}-data"
  source_account_id = var.ap_accounts["landing"]
  role_policy       = data.aws_iam_policy_document.quicksight_admin.json
  tags              = local.tags
}

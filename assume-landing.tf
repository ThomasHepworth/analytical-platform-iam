module "assume_restricted_admin_in_landing" {
  source = "./modules/assume"

  assumed_role_name         = "${var.restricted_admin_name}-landing"
  assume_role_in_account_id = var.ap_accounts["landing"]
  source_account_id         = var.ap_accounts["landing"]
  group_name                = "${var.restricted_admin_name}-landing"
  users                     = module.analytical_platform_team.user_names
}

module "add_restricted_admin_role_in_landing" {
  source    = "./modules/role"
  providers = { aws = aws.landing }

  role_name         = "${var.restricted_admin_name}-landing"
  source_account_id = var.ap_accounts["landing"]
  role_policy       = data.aws_iam_policy_document.restricted_admin.json
  tags              = local.tags
}

module "assume_code_pipeline_approver_in_landing" {
  source = "./modules/assume"

  assumed_role_name         = "${var.code_pipeline_approver_name}-landing"
  assume_role_in_account_id = var.ap_accounts["landing"]
  source_account_id         = var.ap_accounts["landing"]
  group_name                = "${var.code_pipeline_approver_name}-landing"
  users                     = module.data_engineering_leads_team.user_names
}

module "add_code_pipeline_approver_role_in_landing" {
  source    = "./modules/role"
  providers = { aws = aws.landing }

  role_name         = "${var.code_pipeline_approver_name}-landing"
  source_account_id = var.ap_accounts["landing"]
  role_policy       = data.aws_iam_policy_document.code_pipeline_approver.json
  tags              = local.tags
}

module "add_suspended_users_group_in_landing" {
  source = "./modules/assume"

  assumed_role_name         = "nil"
  assume_role_in_account_id = "nil"
  source_account_id         = var.ap_accounts["landing"]
  group_name                = var.suspended_users_name
  group_effect              = "Deny"
  users                     = [aws_iam_user.suspended.name]
}

module "add_audit_security_role_in_landing" {
  source    = "./modules/role"
  providers = { aws = aws.landing }

  role_name         = var.audit_security_name
  source_account_id = var.ap_accounts["security"]
  role_policy_arn   = "arn:aws:iam::aws:policy/SecurityAudit"
  tags              = local.tags
}

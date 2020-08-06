module "assume_restricted_admin_in_landing" {
  source = "./modules/assume"

  assumed_role_name         = "${var.restricted_admin_name}-landing"
  assume_role_in_account_id = var.landing_account_id
  landing_account_id        = var.landing_account_id
  group_name                = "${var.restricted_admin_name}-landing"
  users                     = module.analytical_platform_team.user_names
}

module "add_restricted_admin_role_in_landing" {
  source    = "./modules/role"
  providers = { aws = aws.landing }

  role_name          = "${var.restricted_admin_name}-landing"
  landing_account_id = var.landing_account_id
  role_policy        = data.aws_iam_policy_document.restricted_admin.json
}

module "assume_code_pipeline_approver_in_landing" {
  source = "./modules/assume"

  assumed_role_name         = "${var.code_pipeline_approver_name}-landing"
  assume_role_in_account_id = var.landing_account_id
  landing_account_id        = var.landing_account_id
  group_name                = "${var.code_pipeline_approver_name}-landing"
  users                     = module.data_engineering_leads_team.user_names
}

module "add_code_pipeline_approver_role_in_landing" {
  source    = "./modules/role"
  providers = { aws = aws.landing }

  role_name          = "${var.code_pipeline_approver_name}-landing"
  landing_account_id = var.landing_account_id
  role_policy        = data.aws_iam_policy_document.code_pipeline_approver.json
}

module "add_suspended_users_group_in_landing" {
  source = "./modules/assume"

  assumed_role_name         = "nil"
  assume_role_in_account_id = "nil"
  landing_account_id        = var.landing_account_id
  group_name                = var.suspended_users_name
  group_effect              = "Deny"
  users                     = [aws_iam_user.suspended.name]
}

module "add_audit_security_role_in_landing" {
  source    = "./modules/role"
  providers = { aws = aws.landing }

  role_name          = var.audit_security_name
  landing_account_id = var.security_account_id
  role_policy_arn    = "arn:aws:iam::aws:policy/SecurityAudit"
}

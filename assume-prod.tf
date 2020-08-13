module "assume_restricted_admin_in_prod" {
  source = "./modules/assume"

  assumed_role_name         = "${var.restricted_admin_name}-prod"
  assume_role_in_account_id = var.ap_accounts["prod"]
  source_account_id         = var.ap_accounts["landing"]
  group_name                = "${var.restricted_admin_name}-prod"
  users                     = module.analytical_platform_team.user_names
}

module "add_restricted_admin_role_in_prod" {
  source    = "./modules/role"
  providers = { aws = aws.prod }

  role_name         = "${var.restricted_admin_name}-prod"
  source_account_id = var.ap_accounts["landing"]
  role_policy       = data.aws_iam_policy_document.restricted_admin.json
  tags              = local.tags
}

module "add_audit_security_role_in_prod" {
  source    = "./modules/role"
  providers = { aws = aws.prod }

  role_name         = var.audit_security_name
  source_account_id = var.security_account_id
  role_policy_arn   = "arn:aws:iam::aws:policy/SecurityAudit"
  tags              = local.tags
}

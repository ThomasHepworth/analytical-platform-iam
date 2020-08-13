module "assume_restricted_admin_in_dev" {
  source = "./modules/assume"

  assumed_role_name         = "${var.restricted_admin_name}-dev"
  assume_role_in_account_id = var.ap_accounts["dev"]
  source_account_id         = var.ap_accounts["landing"]
  group_name                = "${var.restricted_admin_name}-dev"
  users                     = module.analytical_platform_team.user_names
}

module "add_restricted_admin_role_in_dev" {
  source    = "./modules/role"
  providers = { aws = aws.dev }

  role_name         = "${var.restricted_admin_name}-dev"
  source_account_id = var.ap_accounts["landing"]
  role_policy       = data.aws_iam_policy_document.restricted_admin.json
  tags              = local.tags
}

module "add_audit_security_role_in_dev" {
  source    = "./modules/role"
  providers = { aws = aws.dev }

  role_name         = var.audit_security_name
  source_account_id = var.ap_accounts["security"]
  role_policy_arn   = "arn:aws:iam::aws:policy/SecurityAudit"
  tags              = local.tags
}

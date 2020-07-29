module "assume_restricted_admin_in_prod" {
  source = "./modules/assume"

  assumed_role_name         = "${var.restricted_admin_name}-prod"
  assume_role_in_account_id = var.ap_accounts["prod"]
  landing_account_id        = var.landing_account_id
  group_name                = "${var.restricted_admin_name}-prod"
  users                     = local.analytical_platform_team
}

module "add_restricted_admin_role_in_prod" {
  source    = "./modules/role"
  providers = { aws = aws.prod }

  role_name          = "${var.restricted_admin_name}-prod"
  landing_account_id = var.landing_account_id
  role_policy        = data.aws_iam_policy_document.restricted_admin.json
}

module "add_audit_security_role_in_prod" {
  source    = "./modules/role"
  providers = { aws = aws.prod }

  role_name          = var.audit_security_name
  landing_account_id = var.security_account_id
  role_policy_arn    = "arn:aws:iam::aws:policy/SecurityAudit"
}

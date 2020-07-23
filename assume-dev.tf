module "assume_restricted_admin_in_dev" {
  source = "./modules/assume"

  assumed_role_name         = "${var.restricted_admin_name}-dev"
  assume_role_in_account_id = var.ap_accounts["dev"]
  landing_account_id        = var.landing_account_id
  group_name                = "${var.restricted_admin_name}-dev"
  users                     = local.analytical_platform_team
}

module "add_restricted_admin_role_in_dev" {
  source    = "./modules/role"
  providers = { aws = aws.dev }

  role_name          = "${var.restricted_admin_name}-dev"
  landing_account_id = var.landing_account_id
  role_policy        = data.aws_iam_policy_document.restricted_admin.json
}

module "assume_read_only_in_dev" {
  source = "./modules/assume"

  assumed_role_name         = "${var.read_only_name}-dev"
  assume_role_in_account_id = var.ap_accounts["dev"]
  landing_account_id        = var.landing_account_id
  group_name                = "${var.read_only_name}-dev"
  users                     = local.analytical_platform_team
}

module "add_read_only_role_in_dev" {
  source    = "./modules/role"
  providers = { aws = aws.dev }

  role_name          = "${var.read_only_name}-dev"
  landing_account_id = var.landing_account_id
  role_policy        = data.aws_iam_policy_document.read_only.json
}

module "add_audit_security_role_in_dev" {
  source    = "./modules/role"
  providers = { aws = aws.dev }

  role_name          = var.audit_security_name
  landing_account_id = var.security_account_id
  role_policy_arn    = "arn:aws:iam::aws:policy/SecurityAudit"
}

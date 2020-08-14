module "add_audit_security_role_in_landing" {
  source    = "./modules/role"
  providers = { aws = aws.landing }

  role_name         = var.audit_security_name
  source_account_id = var.ap_accounts["security"]
  role_policy_arn   = "arn:aws:iam::aws:policy/SecurityAudit"
  tags              = local.tags
}

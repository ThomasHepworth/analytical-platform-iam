module "assume_restricted_admin_in_landing" {
  source = "./modules/assume"

  assumed_role_name         = "${var.restricted_admin_name}-landing"
  assume_role_in_account_id = var.landing_account_id
  landing_account_id        = var.landing_account_id
  group_name                = "${var.restricted_admin_name}-landing"
  users                     = local.analytical_platform_team
}

module "add_restricted_admin_role_in_landing" {
  source    = "./modules/role"
  providers = { aws = aws.landing }

  role_name          = "${var.restricted_admin_name}-landing"
  landing_account_id = var.landing_account_id
  role_policy        = data.aws_iam_policy_document.restricted_admin.json
}

module "assume_read_only_in_landing" {
  source = "./modules/assume"

  assumed_role_name         = "${var.read_only_name}-landing"
  assume_role_in_account_id = var.landing_account_id
  landing_account_id        = var.landing_account_id
  group_name                = "${var.read_only_name}-landing"
  users                     = local.analytical_platform_team
}

module "add_read_only_role_in_landing" {
  source    = "./modules/role"
  providers = { aws = aws.landing }

  role_name          = "${var.read_only_name}-landing"
  landing_account_id = var.landing_account_id
  role_policy        = data.aws_iam_policy_document.read_only.json
}

module "assume_code_pipeline_approver_in_landing" {
  source = "./modules/assume"

  assumed_role_name         = "${var.code_pipeline_approver_name}-landing"
  assume_role_in_account_id = var.landing_account_id
  landing_account_id        = var.landing_account_id
  group_name                = "${var.code_pipeline_approver_name}-landing"

  # TODO this list of users seems arbitrary
  users = [
    aws_iam_user.adam.name,
    aws_iam_user.calum.name,
    aws_iam_user.george.name,
    aws_iam_user.jacob.name,
    aws_iam_user.karik.name,
    aws_iam_user.sam.name,
  ]
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

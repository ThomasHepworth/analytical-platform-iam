module "assume_restricted_admin_in_data_engineering" {
  source = "./modules/assume"

  assumed_role_name         = "${var.restricted_admin_name}-data-engineering"
  assume_role_in_account_id = var.data_engineering_account_id
  landing_account_id        = var.landing_account_id
  group_name                = "${var.restricted_admin_name}-data-engineering"
  users                     = local.data_engineering_team
}

module "add_restricted_admin_role_in_data_engineering" {
  source    = "./modules/role"
  providers = { aws = aws.data_engineering }

  role_name          = "${var.restricted_admin_name}-data-engineering"
  landing_account_id = var.landing_account_id
  role_policy        = data.aws_iam_policy_document.restricted_admin.json
}

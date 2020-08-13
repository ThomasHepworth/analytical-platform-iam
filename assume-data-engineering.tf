module "assume_restricted_admin_in_data_engineering" {
  source = "./modules/assume"

  assumed_role_name         = "${var.restricted_admin_name}-data-engineering"
  assume_role_in_account_id = var.ap_accounts["data_engineering"]
  source_account_id         = var.ap_accounts["landing"]
  group_name                = "${var.restricted_admin_name}-data-engineering"
  users                     = module.data_engineering_team.user_names
}

module "add_restricted_admin_role_in_data_engineering" {
  source    = "./modules/role"
  providers = { aws = aws.data_engineering }

  role_name         = "${var.restricted_admin_name}-data-engineering"
  source_account_id = var.ap_accounts["landing"]
  role_policy       = data.aws_iam_policy_document.restricted_admin.json
  tags              = local.tags
}

module "assume_pulumi_codebuild_service_role_in_data_engineering" {
  source = "./modules/assume"

  assumed_role_name         = "system/pulumi-codebuild-service-role"
  assume_role_in_account_id = var.ap_accounts["data_engineering"]
  source_account_id         = var.ap_accounts["landing"]
  group_name                = "pulumi-data-engineering"
  users                     = module.data_engineering_team.user_names
}

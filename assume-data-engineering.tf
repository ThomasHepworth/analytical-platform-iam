module "assume_pulumi_codebuild_service_role_in_data_engineering" {
  source = "./modules/assume"

  assumed_role_name         = "system/pulumi-codebuild-service-role"
  assume_role_in_account_id = var.ap_accounts["data_engineering"]
  source_account_id         = var.ap_accounts["landing"]
  group_name                = "pulumi-data-engineering"
  users                     = module.data_engineering_team.user_names
}

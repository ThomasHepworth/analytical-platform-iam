output "restricted-admin-roles" {
  value = {
    "dev"              = module.ap_team_dev_restricted_admin.destination_role.arn,
    "prod"             = module.ap_team_prod_restricted_admin.destination_role.arn,
    "data"             = module.ap_team_data_restricted_admin.destination_role.arn,
    "landing"          = module.ap_team_landing_restricted_admin.destination_role.arn,
    "data_engineering" = module.ap_team_data_engineering_restricted_admin.destination_role.arn
  }
}

output "read-only-roles" {
  value = {
    "dev"     = module.ap_team_dev_read_only.destination_role.arn,
    "prod"    = module.ap_team_prod_read_only.destination_role.arn,
    "data"    = module.ap_team_data_read_only.destination_role.arn,
    "landing" = module.ap_team_landing_read_only.destination_role.arn,
    # "data_engineering" = module.ap_team_data_engineering_read_only.destination_role.arn,
  }
}

output "engineer_team_roles" {
  value = {
    "Corporate Data Engineer"   = module.corporate_data_engineer.destination_role.arn,
    "Courts Data Engineer"      = module.courts_data_engineer.destination_role.arn,
    "Data First Engineer"       = module.data_first_data_engineer.destination_role.arn,
    "Data First Data Science"   = module.data_first_data_science.destination_role.arn,
    "Prison Data Enginer"       = module.prison_data_engineer.destination_role.arn,
    "Probation Data Enginer"    = module.probation_data_engineer.destination_role.arn,
    "Engineering Leads"         = module.data_engineering_leads.destination_role.arn,
    "OPG Data Science Engineer" = module.opg_data_science.destination_role.arn
  }
}

locals {
  data_science_team = distinct(concat(
    module.opg_data_science_group.user_names,
    module.data_first_data_science_team.user_names,
  ))

  analytical_users = distinct(concat(
    module.data_engineering_team.user_names,
    local.data_science_team,
  ))

  all_users = distinct(concat(
    local.analytical_users,
    module.analytical_platform_team.user_names
  ))
}

module "data_engineering_team" {
  source = "./modules/group"
  users = distinct(concat(
    module.courts_data_engineering_team.user_names,
    module.corporate_data_engineering_team.user_names,
    module.data_first_data_engineering_team.user_names,
    module.prison_data_engineering_team.user_names,
    module.probation_data_engineering_team.user_names,
  ))
}

module "corporate_data_engineering_team" {
  source = "./modules/group"
  users = [
    aws_iam_user.karik.name,
    aws_iam_user.anthony.name,
    aws_iam_user.sam.name,
  ]
}

module "courts_data_engineering_team" {
  source = "./modules/group"
  users = [
    aws_iam_user.karik.name,
    aws_iam_user.sam.name,
  ]
}

module "data_first_data_engineering_team" {
  source = "./modules/group"
  users = [
    aws_iam_user.george.name,
    aws_iam_user.sam.name,
    module.tapan_perkins.name,
    module.sam_lindsay.name,
  ]
}

module "prison_data_engineering_team" {
  source = "./modules/group"
  users = [
    aws_iam_user.adam.name,
    aws_iam_user.sam.name,
  ]
}

module "probation_data_engineering_team" {
  source = "./modules/group"
  users = [
    aws_iam_user.calum.name,
    aws_iam_user.jacob.name,
    aws_iam_user.alec.name,
    aws_iam_user.darius.name,
    aws_iam_user.davidf.name,
    aws_iam_user.sam.name,
  ]
}

module "opg_data_science_group" {
  source = "./modules/group"
  users = [
    aws_iam_user.sam.name,
    module.rich_ingley.name,
  ]
}

module "data_first_data_science_team" {
  source = "./modules/group"
  users = [
    aws_iam_user.robin.name,
  ]
}

module "data_engineering_leads_team" {
  source = "./modules/group"
  users = [
    aws_iam_user.adam.name,
    aws_iam_user.calum.name,
    aws_iam_user.george.name,
    aws_iam_user.jacob.name,
    aws_iam_user.karik.name,
    aws_iam_user.sam.name,
  ]
}

module "analytical_platform_team" {
  source = "./modules/group"
  users = [
    aws_iam_user.david.name,
    aws_iam_user.aldo.name,
    aws_iam_user.andrew.name,
    aws_iam_user.nicholas.name,
    aws_iam_user.toms.name,
    aws_iam_user.danw.name,
  ]
}

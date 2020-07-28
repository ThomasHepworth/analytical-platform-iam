locals {
  analytical_platform_team = [
    aws_iam_user.david.name,
    aws_iam_user.aldo.name,
    aws_iam_user.andrew.name,
    aws_iam_user.nicholas.name,
    aws_iam_user.toms.name,
    aws_iam_user.danw.name,
  ]

  courts_data_engineering_team = [
    aws_iam_user.karik.name,
    aws_iam_user.sam.name,
  ]

  corporate_data_engineering_team = [
    aws_iam_user.karik.name,
    aws_iam_user.anthony.name,
    aws_iam_user.sam.name,
  ]

  data_first_data_engineering_team = [
    aws_iam_user.george.name,
    aws_iam_user.sam.name,
  ]

  prisons_data_engineering_team = [
    aws_iam_user.adam.name,
    aws_iam_user.sam.name,
  ]

  probation_data_engineering_team = [
    aws_iam_user.calum.name,
    aws_iam_user.jacob.name,
    aws_iam_user.alec.name,
    aws_iam_user.darius.name,
    aws_iam_user.davidf.name,
    aws_iam_user.sam.name,
  ]

  opg_data_science_team = [
    aws_iam_user.sam.name,
    aws_iam_user.rich_ingley.name,
  ]

  data_first_data_science_team = [
    aws_iam_user.robin.name,
  ]

  data_engineering_team = distinct(concat(
    local.courts_data_engineering_team,
    local.corporate_data_engineering_team,
    local.data_first_data_engineering_team,
    local.prisons_data_engineering_team,
    local.probation_data_engineering_team,
  ))

  data_science_team = distinct(concat(
    local.opg_data_science_team,
    local.data_first_data_science_team,
  ))

  analytical_users = distinct(concat(
    local.data_engineering_team,
    local.data_science_team,
  ))

  all_users = distinct(concat(
    local.analytical_users,
    local.analytical_platform_team
  ))
}

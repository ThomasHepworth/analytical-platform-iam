module "ap_team_dev_restricted_admin" {
  source = "./modules/assume_role"
  tags   = local.tags

  destination_role_name    = "restricted-admin"
  destination_account_name = "dev"
  user_names               = module.analytical_platform_team.user_names
  user_arns                = module.analytical_platform_team.user_arns

  aws_iam_policy_documents = {
    "restricted-admin" = data.aws_iam_policy_document.restricted_admin,
  }

  providers = {
    aws             = aws.landing
    aws.destination = aws.dev
  }
}


module "ap_team_prod_restricted_admin" {
  source = "./modules/assume_role"
  tags   = local.tags

  destination_role_name    = "restricted-admin"
  destination_account_name = "prod"
  user_names               = module.analytical_platform_team.user_names
  user_arns                = module.analytical_platform_team.user_arns

  aws_iam_policy_documents = {
    "restricted-admin" = data.aws_iam_policy_document.restricted_admin,
  }

  providers = {
    aws             = aws.landing
    aws.destination = aws.prod
  }
}

module "ap_team_data_restricted_admin" {
  source = "./modules/assume_role"
  tags   = local.tags

  destination_role_name    = "restricted-admin"
  destination_account_name = "data"

  user_names = distinct(concat(
    module.analytical_platform_team.user_names,
    module.data_engineering_team.user_names,
  ))

  user_arns = distinct(concat(
    module.analytical_platform_team.user_arns,
    module.data_engineering_team.user_arns,
  ))

  aws_iam_policy_documents = {
    "restricted-admin" = data.aws_iam_policy_document.restricted_admin,
  }

  providers = {
    aws             = aws.landing
    aws.destination = aws.data
  }
}

module "ap_team_landing_restricted_admin" {
  source = "./modules/assume_role"
  tags   = local.tags

  destination_role_name    = "restricted-admin"
  destination_account_name = "landing"
  user_names               = module.analytical_platform_team.user_names
  user_arns                = module.analytical_platform_team.user_arns

  aws_iam_policy_documents = {
    "restricted-admin" = data.aws_iam_policy_document.restricted_admin,
  }

  providers = {
    aws             = aws.landing
    aws.destination = aws.landing
  }
}

module "ap_team_data_engineering_restricted_admin" {
  source = "./modules/assume_role"
  tags   = local.tags

  destination_role_name    = "restricted-admin"
  destination_account_name = "data_engineering"

  user_names = distinct(concat(
    module.analytical_platform_team.user_names,
    module.data_engineering_team.user_names,
  ))

  user_arns = distinct(concat(
    module.analytical_platform_team.user_arns,
    module.data_engineering_team.user_arns,
  ))

  aws_iam_policy_documents = {
    "restricted-admin" = data.aws_iam_policy_document.restricted_admin,
  }

  providers = {
    aws             = aws.landing
    aws.destination = aws.data_engineering
  }
}

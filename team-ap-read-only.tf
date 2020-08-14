module "ap_team_dev_read_only" {
  source = "./modules/assume_role"
  tags   = local.tags

  destination_role_name    = "read-only"
  destination_account_name = "dev"
  user_names               = module.analytical_platform_team.user_names
  user_arns                = module.analytical_platform_team.user_arns

  aws_iam_policy_documents = {
    "read-only" = data.aws_iam_policy_document.read_only,
  }

  providers = {
    aws             = aws.landing
    aws.destination = aws.dev
  }
}

module "ap_team_prod_read_only" {
  source = "./modules/assume_role"
  tags   = local.tags

  destination_role_name    = "read-only"
  destination_account_name = "prod"
  user_names               = module.analytical_platform_team.user_names
  user_arns                = module.analytical_platform_team.user_arns

  aws_iam_policy_documents = {
    "read-only" = data.aws_iam_policy_document.read_only,
  }

  providers = {
    aws             = aws.landing
    aws.destination = aws.prod
  }
}

module "ap_team_data_read_only" {
  source = "./modules/assume_role"
  tags   = local.tags

  destination_role_name    = "read-only"
  destination_account_name = "data"
  user_names               = module.analytical_platform_team.user_names
  user_arns                = module.analytical_platform_team.user_arns

  aws_iam_policy_documents = {
    "read-only" = data.aws_iam_policy_document.read_only,
  }

  providers = {
    aws             = aws.landing
    aws.destination = aws.data
  }
}

module "ap_team_landing_read_only" {
  source = "./modules/assume_role"
  tags   = local.tags

  destination_role_name    = "read-only"
  destination_account_name = "landing"
  user_names               = module.analytical_platform_team.user_names
  user_arns                = module.analytical_platform_team.user_arns

  aws_iam_policy_documents = {
    "read-only" = data.aws_iam_policy_document.read_only,
  }

  providers = {
    aws             = aws.landing
    aws.destination = aws.landing
  }
}

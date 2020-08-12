locals {
  teams = {
    "courts-data-engineer" = {
      user_names = module.courts_data_engineering_team.user_names
      user_arns  = module.courts_data_engineering_team.user_arns
      policy_documents = {
        "courts_data_engineer" = data.aws_iam_policy_document.courts_data_engineer,
      }
    }

    "corporate-data-engineer" = {
      user_names = module.corporate_data_engineering_team.user_names
      user_arns  = module.corporate_data_engineering_team.user_arns
      policy_documents = {
        "corporate_data_engineer" = data.aws_iam_policy_document.corporate_data_engineer,
      }
    }

    "data-first-data-engineer" = {
      user_names = module.corporate_data_engineering_team.user_names
      user_arns  = module.corporate_data_engineering_team.user_arns
    }

    "prison-data-engineer" = {
      user_names = module.prison_data_engineering_team.user_names
      user_arns  = module.prison_data_engineering_team.user_arns
      policy_documents = {
        "prison_data_engineer" = data.aws_iam_policy_document.prison_data_engineer,
      }
    }

    "probation-data-engineer" = {
      user_names = module.probation_data_engineering_team.user_names
      user_arns  = module.probation_data_engineering_team.user_arns
      policy_documents = {
        "probation_data_engineer" = data.aws_iam_policy_document.probation_data_engineer,
      }
    }
  }
}

module "data_engineer" {
  for_each = local.teams
  source   = "./modules/assume_role"
  tags     = local.tags

  destination_role_name    = each.key
  user_names               = each.value["user_names"]
  user_arns                = each.value["user_arns"]
  aws_iam_policy_documents = contains(keys(each.value), "policy_documents") ? each.value["policy_documents"] : {}
  managed_policies         = contains(keys(each.value), "managed_policies") ? each.value["managed_policies"] : local.default_managed_policies

  providers = {
    aws.source      = aws.landing
    aws.destination = aws.data
  }
}

locals {
  default_managed_policies = [
    "arn:aws:iam::aws:policy/AmazonAthenaFullAccess",
    "arn:aws:iam::aws:policy/AWSGlueConsoleFullAccess",
    "arn:aws:iam::aws:policy/AWSLakeFormationDataAdmin",
    "arn:aws:iam::aws:policy/AWSSupportAccess",
    "arn:aws:iam::aws:policy/AWSCloudTrailReadOnlyAccess",
    "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess",
    "arn:aws:iam::aws:policy/CloudWatchLogsReadOnlyAccess",
    "arn:aws:iam::aws:policy/CloudWatchEventsReadOnlyAccess",
    "arn:aws:iam::aws:policy/CloudWatchSyntheticsReadOnlyAccess",
    "arn:aws:iam::aws:policy/AWSCloudTrailReadOnlyAccess",
  ]
}

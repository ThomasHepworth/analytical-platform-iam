locals {
  data-engineering = "data-engineering"
}

##### Restricted Admin #####

## Create restricted admin group in data engineering account
module "assume_restricted_admin_in_data_engineering" {
  source = "./modules/assume"

  assumed_role_name         = "${var.restricted_admin_name}-${local.data-engineering}"
  assume_role_in_account_id = var.data_engineering_account_id

  landing_account_id = var.landing_account_id
  group_name         = "${var.restricted_admin_name}-${local.data-engineering}"

  users = [
    aws_iam_user.alec.name,
    aws_iam_user.darius.name,
    aws_iam_user.calum.name,
    aws_iam_user.davidf.name,
    aws_iam_user.jacob.name,
  ]
}

## Create restricted admin role in data engineering account
module "add_restricted_admin_role_in_data_engineering" {
  source = "./modules/role"

  providers = {
    aws = aws.data-engineering
  }

  role_name          = "${var.restricted_admin_name}-${local.data-engineering}"
  landing_account_id = var.landing_account_id
  role_policy        = data.aws_iam_policy_document.restricted_admin.json
}

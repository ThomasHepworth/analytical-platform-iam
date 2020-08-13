module "assume_kitchen_in_dev" {
  source = "../../../modules/assume"

  assumed_role_name         = var.kitchen_name
  assume_role_in_account_id = var.ap_accounts["landing"]
  source_account_id         = var.ap_accounts["landing"]
  group_name                = var.kitchen_name
  users                     = [aws_iam_user.kitchen.name]
}

module "add_kitchen_role_in_dev" {
  source = "../../../modules/role"

  providers = {
    aws = aws.landing
  }

  role_name         = var.kitchen_name
  source_account_id = var.ap_accounts["landing"]
  role_policy       = data.aws_iam_policy_document.read_market_place_subscriptions.json
}

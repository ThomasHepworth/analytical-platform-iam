module "assume_kitchen_in_dev" {
  source = "../../../modules/assume"

  assumed_role_name = "${var.kitchen_name}"

  assume_role_in_account_id = ["${var.landing_account_id}"]
  landing_account_id        = "${var.landing_account_id}"
  group_name                = "${var.kitchen_name}"

  users = [
    "${aws_iam_user.kitchen.name}",
  ]
}

module "add_kitchen_role_in_dev" {
  source = "../../../modules/role"

  assume_role_in_account_id = "${var.landing_account_id}"
  role_name                 = "${var.kitchen_name}"
  landing_account_id        = "${var.landing_account_id}"

  role_policy = "${data.aws_iam_policy_document.read_market_place_subscriptions.json}"
}

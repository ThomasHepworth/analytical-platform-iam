resource "aws_iam_group" "users" {
  name     = "users"
  provider = aws.landing
}

resource "aws_iam_user" "nicholas" {
  name          = "nicholas.tollervey@digital.justice.gov.uk"
  force_destroy = true
}

resource "aws_iam_user" "aldo" {
  name          = "aldo.giambelluca@digital.justice.gov.uk"
  force_destroy = true
}

resource "aws_iam_user" "suspended" {
  name          = "suspended.test@digital.justice.gov.uk"
  force_destroy = true
}

resource "aws_iam_user" "calum" {
  name          = "calum.barnett@digital.justice.gov.uk"
  force_destroy = true
}

resource "aws_iam_user" "karik" {
  name          = "karik.isichei@digital.justice.gov.uk"
  force_destroy = true
}

resource "aws_iam_user" "robin" {
  name          = "robin.linacre@digital.justice.gov.uk"
  force_destroy = true
}

resource "aws_iam_user" "anthony" {
  name          = "anthony.cody@digital.justice.gov.uk"
  force_destroy = true
}

resource "aws_iam_user" "george" {
  name          = "george.kelly@digital.justice.gov.uk"
  force_destroy = true
}

resource "aws_iam_user" "adam" {
  name          = "adam.booker@digital.justice.gov.uk"
  force_destroy = true
}

resource "aws_iam_user" "sam" {
  name          = "samuel.tazzyman@digital.justice.gov.uk"
  force_destroy = true
}

resource "aws_iam_user" "david" {
  name          = "david.read@digital.justice.gov.uk"
  force_destroy = true
}

resource "aws_iam_user" "andrew" {
  name          = "andrew.lightfoot@digital.justice.gov.uk"
  force_destroy = true
}

resource "aws_iam_user" "gareth" {
  name          = "gareth.davies@digital.justice.gov.uk"
  force_destroy = true
}

resource "aws_iam_user" "alec" {
  name          = "alec.johnson@digital.justice.gov.uk"
  force_destroy = true
}

resource "aws_iam_user" "darius" {
  name          = "darius.nicholson@digital.justice.gov.uk"
  force_destroy = true
}

resource "aws_iam_user" "davidf" {
  name          = "david.fuller@digital.justice.gov.uk"
  force_destroy = true
}

resource "aws_iam_user" "jacob" {
  name          = "jacob.browning@digital.justice.gov.uk"
  force_destroy = true
}

resource "aws_iam_user" "toms" {
  name          = "tom.skelley@digital.justice.gov.uk"
  force_destroy = true
}

resource "aws_iam_user" "danw" {
  name          = "daniel.webb@digital.justice.gov.uk"
  force_destroy = true
}

module "rich_ingley" {
  source      = "./modules/user"
  email       = "richard.ingley@digital.justice.gov.uk"
  tags        = local.tags
  group_names = [aws_iam_group.users.name]
  providers   = { aws = aws.landing }
}

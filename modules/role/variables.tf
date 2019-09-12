variable "region" {
  default = "eu-west-1"
}

variable "assume_role_in_account_id" {
  description = "The ID of the account with the role you want to assume"
}

variable "landing_account_id" {
  default     = "335823981503"
  description = "The Landing account ID"
}

variable "landing_iam_role" {
  default     = "landing-iam-role"
  description = "The role to assume to manage roles in remote accounts"
}

variable "role_name" {}

variable "role_policy" {
  description = "The main policy to attach to the role"
  default     = ""
}

variable "role_policy_arn" {
  description = "The ARN of the main policy"
  default     = ""
}

variable "role_principal_identifiers" {
  type = "list"
}

variable "role_principal_type" {}

variable "tags" {
  type = "map"

  default = {
    business-unit = "Platforms"
    application   = "analytical-platform"
    is-production = true
    owner         = "analytical-platform:analytics-platform-tech@digital.justice.gov.uk"
  }
}

variable "external_id" {
  description = "OPTIONAL: External ID for referencing external third party AWS account"
  default     = ""
}

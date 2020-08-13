variable "ap_accounts" {
  type        = map(string)
  description = "IDs of accounts to assume role into"
}

variable "restricted_admin_name" {
  default = "restricted-admin"
}

variable "data_admin_name" {
  default = "data-admin-in"
}

variable "landing_iam_role" {
  default = "landing-iam-role"
}

variable "suspended_users_name" {
  default = "suspended_users"
}

variable "audit_security_name" {
  default = "AuditAdminRole"
}

variable "security_account_id" {
  description = "AWS Security account ID"
}

variable "data_engineers_name" {
  default = "data-engineers"
}

variable "hmcts_data_engineers_name" {
  default = "data-engineers-hmcts"
}

variable "prison_data_engineers_name" {
  default = "data-engineers-prisons"
}

variable "probation_data_engineers_name" {
  default = "data-engineers-probation"
}

variable "corporate_data_engineers_name" {
  default = "data-engineers-corporate"
}

variable "quicksight_admin_name" {
  default = "quicksight-admin"
}

variable "data_engineering_account_id" {
  description = "AWS Data Engineering account ID"
}

variable "code_pipeline_approver_name" {
  default = "code-pipeline-approver"
}

locals {
  tags = {
    business-unit = "Platforms"
    application   = "analytical-platform"
    is-production = "true"
    owner         = "analytical-platform:analytics-platform-tech@digital.justice.gov.uk"
  }
}

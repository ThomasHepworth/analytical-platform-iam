variable "landing_account_id" {
  description = "ID of account containing IAM users"
}

variable "ap_accounts" {
  type        = "map"
  description = "IDs of accounts to assume role into"
}

## Restricted Admin

variable "restricted_admin_name" {
  default = "restricted-admin"
}

## Read Only

variable "read_only_name" {
  default = "read-only"
}

## Read Data Only

variable "read_data_only_name" {
  default = "read-s3-only"
}

## Data Admin

variable "data_admin_name" {
  default = "data-admin-in"
}

variable "landing_iam_role" {
  default = "landing-iam-role"
}

## Suspended Users

variable "suspended_users_name" {
  default = "suspended_users"
}

## Audit Security role name

variable "audit_security_name" {
  default = "AuditAdminRole"
}

variable "security_account_id" {
  description = "AWS Security account ID"
}

## Data Engineers

variable "data_engineers_name" {
  default = "data-engineers"
}

variable "billing_viewer_name" {
  default = "billing-viewer"
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

## Quicksight Admin

variable "quicksight_admin_name" {
  default = "quicksight-admin"
}

variable "data_engineering_id" {
  description = "AWS Data Engineering account ID"
}
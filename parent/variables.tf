variable "management_groups" {
  description = "Management Group hierarchy"
  type = map(object({
    display_name = string
    parent_id    = string
  }))
}

variable "policy_assignments" {
  description = "Policies to assign at MG level"
  type = list(object({
    name             = string
    policy_file      = string
    management_group = string
  }))
}

variable "rbac_assignments" {
  description = "RBAC assignments at MG level"
  type = list(object({
    management_group = string
    role_name        = string
    principal_id     = string
  }))
}

variable "subscription_associations" {
  description = "Subscription to Management Group mapping"
  type = list(object({
    subscription_id  = string
    management_group = string
  }))
}
variable "policies" {
  description = "Policy assignments keyed by name"
  type = map(object({
    policy_definition_id = string
    management_group_id  = string
    parameters           = optional(map(any))
  }))
}

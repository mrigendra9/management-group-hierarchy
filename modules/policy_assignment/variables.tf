variable "policy_name" {
  description = "Policy definition name"
  type        = string
}

variable "policy_json_path" {
  description = "Path to policy JSON file"
  type        = string
}

variable "scope" {
  description = "Management Group scope ID"
  type        = string
}


variable "policies" {
  description = "Map of policy assignments"
  type = map(object({
    policy_definition_id = string
    management_group_id  = string
    parameters           = optional(map(any))
  }))
}

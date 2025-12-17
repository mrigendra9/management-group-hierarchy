terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
subscription_id = "68246c89-0e8b-4cba-995d-dbfe5de3abae"
}

############################
# MANAGEMENT GROUPS
############################
module "management_groups" {
  for_each = var.management_groups
  source   = "../modules/management_group"

  name         = each.key
  display_name = each.value.display_name
  parent_id    = each.value.parent_id
}

############################
# POLICY ASSIGNMENTS
############################

# module "policy_assignments" {
#   source = "../modules/policy_assignment"

#   for_each = var.policies

#   policy_name      = each.value.name
#   policy_json_path = each.value.policy_file
#   scope             = module.management_groups[each.value.management_group].id
# }

module "policy_assignments" {
  source   = "../modules/policy_assignment"
  policies = {
    audit_vms = {
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/xxxx"
      management_group_id  = "mg-root"
      parameters = {
        effect = "Audit"
      }
    }
    deny_storage = {
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/yyyy"
      management_group_id  = "mg-root"
      parameters = {}
    }
  }
}

############################
# RBAC ASSIGNMENTS
############################
module "rbac_assignments" {
  for_each = {
    for r in var.rbac_assignments :
    "${r.management_group}-${r.role_name}" => r
  }

  source        = "../modules/rbac_assignment"
  scope         = module.management_groups[each.value.management_group].id
  role_name     = each.value.role_name
  principal_id  = each.value.principal_id
}

############################
# SUBSCRIPTION ASSOCIATION
############################
module "subscription_associations" {
  for_each = {
    for s in var.subscription_associations :
    s.subscription_id => s
  }

  source              = "../modules/subscription_association"
  subscription_id     = each.value.subscription_id
  management_group_id = module.management_groups[each.value.management_group].id
}

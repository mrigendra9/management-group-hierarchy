output "management_group_ids" {
  description = "All management group IDs"
  value = {
    for mg_name, mg in module.management_groups :
    mg_name => mg.id
  }
}

output "policy_assignments" {
  description = "Policy assignment IDs"
  value = {
    for k, p in module.policy_assignments :
    k => p.policy_assignment_id
  }
}

output "rbac_assignments" {
  description = "RBAC assignment IDs"
  value = {
    for k, r in module.rbac_assignments :
    k => r.role_assignment_id
  }
}

output "subscription_associations" {
  description = "Subscription to MG associations"
  value = {
    for k, s in module.subscription_associations :
    k => s.subscription_association_id
  }
}

# resource "azurerm_policy_definition" "this" {
#   name         = var.policy_name
#   policy_type  = "Custom"
#   mode         = "All"
#   display_name = var.policy_name

#   policy_rule = file(var.policy_json_path)
# }

# resource "azurerm_policy_assignment" "this" {
#   name                 = var.policy_name
#   policy_definition_id = azurerm_policy_definition.this.id
#   scope                = var.scope
# }

resource "azurerm_management_group_policy_assignment" "this" {
  for_each = var.policies
  name                 = each.key
  management_group_id  = each.value.management_group_id
  policy_definition_id = each.value.policy_definition_id
  parameters           = each.value.parameters
}

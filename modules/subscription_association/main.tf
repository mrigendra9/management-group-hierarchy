# 
resource "azurerm_management_group_subscription_association" "this" {
  for_each            = var.subscriptions
  management_group_id  = each.value.management_group_id
  subscription_id      = each.value.subscription_id
}

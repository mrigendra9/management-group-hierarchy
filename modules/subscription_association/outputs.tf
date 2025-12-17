# output "id" {
#   value = azurerm_management_group_subscription_association.this.id
# }

output "id" {
  value = [for s in azurerm_management_group_subscription_association.this : s.id]
}


# 
variable "subscriptions" {
  description = "Map of subscription assignments"
  type = map(object({
    management_group_id = string
    subscription_id     = string
  }))
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the PostgreSQL Server. Changing this forces a new resource to be created."
  type        = string
}

variable "location" {
    default = "southeastasia"
}
variable "email_receiver_name" {
  type        = string
}
variable "email_receiver_address" {
  type        = string
}
variable "azurerm_monitor_action_group_name" {
  type        = string
}
variable "azurerm_monitor_action_group_short_name" {
  type        = string
}
variable "azurerm_monitor_action_rule_action_group_name" {
  type        = string
}

variable "use_common_alert_schema" {
  type = bool
}
variable "azurerm_monitor_metric_alert_name" {
  type = string
}

variable "monitor_metric_alert_name" {
  description = "For each monitor_metric_alert_name, create an object that contain fields"
  default     = {}
}
variable "azurerm_postgresql_server_id" {
  type = string
}

variable "resource_group_id"{
  type     = string
}
variable "monitor_metric_alert_criteria" {
  
    type = map(object({
      # criteria.*.aggregation to be one of [Average Count Minimum Maximum Total]
      aggregation = string
      metric_name = string
      # criteria.0.operator to be one of [Equals NotEquals GreaterThan GreaterThanOrEqual LessThan LessThanOrEqual]
      operator  = string
      threshold = number
      }))
}




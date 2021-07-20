###########
## Monitoring
#############

resource "azurerm_monitor_action_group" "psqlactiongrp" {
  name = var.azurerm_monitor_action_group_name
  short_name = var.azurerm_monitor_action_group_short_name
  resource_group_name = var.resource_group_name

  email_receiver {
    name = var.email_receiver_name
    email_address = var.email_receiver_address
    use_common_alert_schema = var.use_common_alert_schema
  }
}

resource "azurerm_monitor_action_rule_action_group" "psqlruleactiongrp" {
  name = var.azurerm_monitor_action_rule_action_group_name
  resource_group_name = var.resource_group_name
  action_group_id     = azurerm_monitor_action_group.psqlactiongrp.id

  scope {
    type         = "ResourceGroup"
    resource_ids = [var.resource_group_id]
  }
}

resource "azurerm_monitor_metric_alert" "psqlalert" {
  for_each            = var.monitor_metric_alert_criteria
  name                = upper(each.key)
  resource_group_name = var.resource_group_name
  #scopes              = [azurerm_postgresql_server.server.id]
  scopes              = [var.azurerm_postgresql_server_id]
  
  criteria {
    metric_namespace = "Microsoft.DBforPostgreSQL/servers"
    metric_name      = each.value.metric_name
    aggregation      = each.value.aggregation
    operator         = each.value.operator
    threshold        = each.value.threshold
  }

  action {
    action_group_id =  azurerm_monitor_action_group.psqlactiongrp.id
  }
}



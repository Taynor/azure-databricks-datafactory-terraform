data "azurerm_resource_group" "adb-rg-name" {
  name = var.resource_group_name
}

/*data "azurerm_virtual_network" "adb-vnet" {
  name                = var.adb-vnet_name
  resource_group_name = data.azurerm_resource_group.adb-rg-name.name
}

data "azurerm_subnet" "adb-public-subnet" {
  name                 = var.adb-public-subnet_name
  virtual_network_name = data.azurerm_virtual_network.adb-vnet.name
  resource_group_name  = data.azurerm_resource_group.adb-rg-name.name
}

data "azurerm_subnet" "adb-private-subnet" {
  name                 = var.adb-private-subnet-name
  virtual_network_name = data.azurerm_virtual_network.adb-vnet.name
  resource_group_name  = data.azurerm_resource_group.adb-rg-name.name
}

data "azurerm_subnet" "adb-endpoint-subnet" {
  name                 = var.adb-private-subnet-name
  virtual_network_name = data.azurerm_virtual_network.adb-vnet.name
  resource_group_name  = data.azurerm_resource_group.adb-rg-name.name
}

data "azurerm_network_security_group" "adb-nsg" {
  name                = var.adb-nsg_name
  resource_group_name = data.azurerm_resource_group.adb-rg-name.name
}

data "azurerm_databricks_workspace_private_endpoint_connection" "adb-private-endpoint-connection" {
  workspace_id        = azurerm_databricks_workspace.adb-workspace.id
  private_endpoint_id = azurerm_private_endpoint.adb-private-endpoint.id
}

resource "azurerm_subnet_network_security_group_association" "adb-private-subnet_ga" {
  subnet_id                 = data.azurerm_subnet.adb-private-subnet.id
  network_security_group_id = data.azurerm_network_security_group.adb-nsg.id
}

resource "azurerm_subnet_network_security_group_association" "adb-public-subnet_ga" {
  subnet_id                 = data.azurerm_subnet.adb-public-subnet.id
  network_security_group_id = data.azurerm_network_security_group.adb-nsg.id
}*/

resource "azurerm_databricks_workspace" "this" {
  name                        = var.abd-ws-name
  resource_group_name         = data.azurerm_resource_group.adb-rg-name.name
  location                    = var.adb-ws-location
  sku                         = "premium"
  managed_resource_group_name = var.adb-managed-ws-name
}

/*resource "databricks_service_principal" "sp" {
  application_id = "service principal id"
  depends_on     = [azurerm_databricks_workspace.this]
}*/

/*resource "databricks_group_member" "i-am-admin" {
  group_id   = data.databricks_group.admins.id
  member_id  = "service principal id"
  depends_on = [azurerm_databricks_workspace.this]
}*/

  /*public_network_access_enabled         = false
  network_security_group_rules_required = "NoAzureDatabricksRules"

  custom_parameters {
    no_public_ip        = true
    public_subnet_name  = data.azurerm_subnet.adb-public-subnet.name
    private_subnet_name = data.azurerm_subnet.adb-private-subnet.name
    virtual_network_id  = data.azurerm_virtual_network.adb-vnet.id

    public_subnet_network_security_group_association_id  = azurerm_subnet_network_security_group_association.adb-public-subnet_ga.id
    private_subnet_network_security_group_association_id = azurerm_subnet_network_security_group_association.adb-private-subnet_ga.id
  }*/


/*resource "azurerm_private_endpoint" "adb-private-endpoint" {
  name                = "adb-private-endpoint"
  location            = data.azurerm_resource_group.adb-rg-name.location
  resource_group_name = data.azurerm_resource_group.adb-rg-name.name
  subnet_id           = data.azurerm_subnet.adb-endpoint-subnet.id

  private_service_connection {
    name                           = "adb-private-service-connection"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_databricks_workspace.adb-workspace.id
    subresource_names              = ["databricks_ui_api"]
  }
}

resource "azurerm_private_dns_zone" "adb-private-dns-zone" {
  depends_on = [azurerm_private_endpoint.adb-private-endpoint]

  name                = "privatelink.azuredatabricks.net"
  resource_group_name = data.azurerm_resource_group.adb-rg-name.name
}

resource "azurerm_private_dns_cname_record" "adb-private-dns-cname" {
  name                = azurerm_databricks_workspace.adb-workspace.workspace_url
  zone_name           = azurerm_private_dns_zone.adb-private-dns-zone.name
  resource_group_name = data.azurerm_resource_group.adb-rg-name.name
  ttl                 = 300
  record              = "uksouth.azuredatabricks.net"
}*/
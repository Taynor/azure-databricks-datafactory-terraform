data "azurerm_resource_group" "adf-rg-name" {
  name = var.resource_group_name
}

resource "azurerm_data_factory" "adf" {
  name                   = var.adf_name
  location               = var.adf_location
  resource_group_name    = data.azurerm_resource_group.adf-rg-name.name
  public_network_enabled = false
}
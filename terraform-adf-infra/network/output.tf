output "azurerm_virtual_network_name" {
  value = azurerm_virtual_network.adf-vnet.name
}

output "azurerm_virtual_network_id" {
  value = azurerm_virtual_network.adf-vnet.id
}

output "azurerm_subnet_name_public" {
  value = azurerm_subnet.adf-public-subnet.name
}

output "azurerm_subnet_id_public" {
  value = azurerm_subnet.adf-public-subnet.id
}

output "azurerm_subnet_name_private" {
  value = azurerm_subnet.adf-private-subnet.name
}

output "azurerm_subnet_id_private" {
  value = azurerm_subnet.adf-private-subnet.id
}
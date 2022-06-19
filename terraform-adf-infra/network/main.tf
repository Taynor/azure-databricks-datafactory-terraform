data "azurerm_resource_group" "adf-rg-name" {
  name = var.resource_group_name
}

data "azurerm_storage_account" "adf-storage-account" {
  name                = var.storage_account_name
  resource_group_name = data.azurerm_resource_group.adf-rg-name.name
}

resource "azurerm_virtual_network" "adf-vnet" {
  name                = var.adf-vnet_name
  location            = data.azurerm_resource_group.adf-rg-name.location
  resource_group_name = data.azurerm_resource_group.adf-rg-name.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
}

resource "azurerm_network_security_group" "adf-nsg" {
  name                = var.adf-nsg_name
  location            = data.azurerm_resource_group.adf-rg-name.location
  resource_group_name = data.azurerm_resource_group.adf-rg-name.name
}

resource "azurerm_subnet" "adf-public-subnet" {
  name                 = var.adf-public-subnet_name
  resource_group_name  = data.azurerm_resource_group.adf-rg-name.name
  virtual_network_name = azurerm_virtual_network.adf-vnet.name
  address_prefixes     = ["10.0.1.0/24"]
  delegation {
    name = "adf-public-uksouth"

    service_delegation {
      actions = [
          "Microsoft.Network/virtualNetworks/subnets/join/action",
          "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
          "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
        ]
      name = "Microsoft.Databricks/workspaces"
    }
  }
}

resource "azurerm_subnet" "adf-private-subnet" {
  name                 = var.adf-private-subnet-name
  resource_group_name  = data.azurerm_resource_group.adf-rg-name.name
  virtual_network_name = azurerm_virtual_network.adf-vnet.name
  address_prefixes     = ["10.0.2.0/24"]
  delegation {
    name = "adf-private-uksouth"

    service_delegation {
      actions = [
          "Microsoft.Network/virtualNetworks/subnets/join/action",
          "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
          "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
        ]
      name = "Microsoft.Databricks/workspaces"
    }
  }
}

resource "azurerm_subnet" "adf-endpoint-subnet" {
  name                 = var.adf-endpoint-subnet-name
  resource_group_name  = data.azurerm_resource_group.adf-rg-name.name
  virtual_network_name = azurerm_virtual_network.adf-vnet.name
  address_prefixes     = ["10.0.3.0/24"]

  enforce_private_link_endpoint_network_policies = true
}

resource "azurerm_subnet_service_endpoint_storage_policy" "adf-ssesp" {
  name                = var.adf-ssesp-name
  resource_group_name = data.azurerm_resource_group.adf-rg-name.name
  location            = data.azurerm_resource_group.adf-rg-name.location
  definition {
    name        = "adf-storage"
    description = "adf storage definition"
    service_resources = [
      data.azurerm_resource_group.adf-rg-name.id,
      data.azurerm_storage_account.adf-storage-account.id
    ]
  }
}

resource "azurerm_public_ip" "adf-public-ip" {
  name                = var.adf-public-ip-name
  location            = data.azurerm_resource_group.adf-rg-name.location
  resource_group_name = data.azurerm_resource_group.adf-rg-name.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1"]
}

resource "azurerm_public_ip_prefix" "adf-public-ip-prefix" {
  name                = var.adf-public-ip-prefix-name
  location            = data.azurerm_resource_group.adf-rg-name.location
  resource_group_name = data.azurerm_resource_group.adf-rg-name.name
  prefix_length       = 30
  zones               = ["1"]
}

resource "azurerm_nat_gateway" "adf-nat-gateway" {
  name                                             = var.adf-nat-gateway-name
  location                                         = data.azurerm_resource_group.adf-rg-name.location
  resource_group_name                              = data.azurerm_resource_group.adf-rg-name.name
  sku_name                                         = "Standard"
  idle_timeout_in_minutes                          = 10
  zones                                            = ["1"]
}

resource "azurerm_nat_gateway_public_ip_association" "adf-nat-gateway-pia" {
  nat_gateway_id       = azurerm_nat_gateway.adf-nat-gateway.id
  public_ip_address_id = azurerm_public_ip.adf-public-ip.id
}

resource "azurerm_nat_gateway_public_ip_prefix_association" "adf_nat_gateway_pipa" {
  nat_gateway_id      = azurerm_nat_gateway.adf-nat-gateway.id
  public_ip_prefix_id = azurerm_public_ip_prefix.adf-public-ip-prefix.id
}
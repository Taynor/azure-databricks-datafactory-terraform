data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "adf-rg-name" {
  name = var.resource_group_name
}

resource "azurerm_key_vault" "adf-keyvault" {
  name                        = var.keyvault_name
  location                    = var.keyvault_location
  resource_group_name         = data.azurerm_resource_group.adf-rg-name.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get", "Create", "Delete", "List", "Purge", "Update"
    ]

    secret_permissions = [
      "Get", "Delete", "List", "Purge", "Set"
    ]

    storage_permissions = [
      "Get", "GetSAS", "List", "ListSAS", "Purge", "Set", "SetSAS", "Update"
    ]
  }
}

resource "azurerm_key_vault_secret" "tenant-id" {
  name            = "TenantId"
  value           = var.TENANT_ID
  key_vault_id    = azurerm_key_vault.adf-keyvault.id
  expiration_date = "2023-12-30T20:00:00Z"
  content_type    = "text/plain"
}

resource "azurerm_key_vault_secret" "client-id" {
  name            = "ClientId"
  value           = var.CLIENT_ID
  key_vault_id    = azurerm_key_vault.adf-keyvault.id
  expiration_date = "2023-12-30T20:00:00Z"
  content_type    = "text/plain"
}

resource "azurerm_key_vault_secret" "secret-id" {
  name            = "ClientSecret"
  value           = var.SECRET
  key_vault_id    = azurerm_key_vault.adf-keyvault.id
  expiration_date = "2023-12-30T20:00:00Z"
  content_type    = "text/plain"
}
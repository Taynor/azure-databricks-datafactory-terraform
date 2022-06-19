data "azurerm_resource_group" "adf-rg-name" {
  name = var.resource_group_name
}

data "azurerm_client_config" "storage_account_client_config" {
}

resource "azurerm_storage_account" "adf-storage-account" {
  name                     = var.storage_account_name
  resource_group_name      = data.azurerm_resource_group.adf-rg-name.name
  location                 = var.storage_account_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled           = true
  account_kind             = "StorageV2"
  min_tls_version          = "TLS1_2"
}

resource "azurerm_storage_data_lake_gen2_filesystem" "adf-dl-gen2-fs" {
  name               = var.adf-dl-gen2-fs_name
  storage_account_id = azurerm_storage_account.adf-storage-account.id
  depends_on         = [azurerm_storage_account.adf-storage-account
  ]
}

resource "azurerm_storage_data_lake_gen2_path" "adf-dl-gen2-path" {
  for_each           = toset(var.dl_paths)
  filesystem_name    = azurerm_storage_data_lake_gen2_filesystem.adf-dl-gen2-fs.name
  resource           = "directory"
  path               = each.value
  storage_account_id = azurerm_storage_account.adf-storage-account.id
  depends_on         = [azurerm_storage_account.adf-storage-account,
    azurerm_storage_data_lake_gen2_filesystem.adf-dl-gen2-fs]
  lifecycle {
    prevent_destroy = true
  }
}
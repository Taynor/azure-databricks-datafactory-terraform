output "adb-storage-account_name" {
  value = azurerm_storage_account.adf-storage-account.name
}

output "adb-storage-account_id" {
  value = azurerm_storage_account.adf-storage-account.id
}

output "adb-storage-account_hns" {
  value = azurerm_storage_account.adf-storage-account.is_hns_enabled
}
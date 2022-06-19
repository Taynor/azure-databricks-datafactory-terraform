output "adb-workspace-name" {
  value = azurerm_databricks_workspace.this.name
}

output "adb-workspace-id" {
  value = azurerm_databricks_workspace.this.workspace_id
}

output "adb-workspace-url" {
  value = azurerm_databricks_workspace.this.workspace_url
}
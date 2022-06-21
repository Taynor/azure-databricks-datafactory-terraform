provider "databricks" {
  host                = data.azurerm_databricks_workspace.adb.workspace_url
  azure_client_id     = var.CLIENT_ID
  azure_client_secret = var.SECRET
  azure_tenant_id     = var.TENANT_ID
}

data "azurerm_resource_group" "adf-rg-name" {
  name = var.resource_group_name
}

data "azurerm_data_factory" "adf" {
  name                = var.adf_name 
  resource_group_name = data.azurerm_resource_group.adf-rg-name.name
}

data "azurerm_key_vault" "adf-keyvault" {
  name                = var.keyvault_name
  resource_group_name = var.resource_group_name
}

data "azurerm_databricks_workspace" "adb" {
  name                = var.adb-ws-name
  resource_group_name = data.azurerm_resource_group.adf-rg-name.name
}

data "databricks_clusters" "prod_cluster" {
  cluster_name_contains = var.prod_cluster_name
  depends_on            = [data.azurerm_databricks_workspace.adb]
}

data "azurerm_client_config" "current" {
}

resource "azurerm_data_factory_linked_service_key_vault" "kv-linkedservice" {
  name            = var.adf_kv_linkedservice
  data_factory_id = data.azurerm_data_factory.adf.id
  key_vault_id    = data.azurerm_key_vault.adf-keyvault.id
}

resource "azurerm_data_factory_linked_service_data_lake_storage_gen2" "dl-linkedservice" {
  name                  = var.adf_dl_linkedservice
  data_factory_id       = data.azurerm_data_factory.adf.id
  service_principal_id  = var.CLIENT_ID
  service_principal_key = var.SECRET
  tenant                = var.TENANT_ID
  url                   = "https://${var.storage_account_name}.dfs.core.windows.net/"
}

resource "azurerm_data_factory_linked_service_azure_databricks" "msi_linked" {
  for_each                   = data.databricks_clusters.prod_cluster.ids
  existing_cluster_id        = each.value
  name                       = "ADBLinkedServiceViaMSI"
  data_factory_id            = data.azurerm_data_factory.adf.id
  description                = "ADB Linked Service via MSI"
  adb_domain                 = data.azurerm_databricks_workspace.adb.workspace_url
  msi_work_space_resource_id = data.azurerm_databricks_workspace.adb.id
} 
terraform {
  required_version = ">=1.1.9"

  required_providers {
    databricks = {
      source  = "databrickslabs/databricks"
      version = "0.6.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.10.0"
    }
  }
}

provider "azurerm" {
  features {}  
  client_id       = var.CLIENT_ID
  client_secret   = var.SECRET
  tenant_id       = var.TENANT_ID
  subscription_id = var.SUB_ID
}

provider "databricks" {
  host                = data.azurerm_databricks_workspace.ws.workspace_url
  azure_client_id     = var.CLIENT_ID
  azure_client_secret = var.SECRET
  azure_tenant_id     = var.TENANT_ID
}

data "azurerm_databricks_workspace" "ws" {
  name                = var.wsname
  resource_group_name = var.rgname
}

data "databricks_spark_version" "latest" {
  depends_on = [data.azurerm_databricks_workspace.ws]
}

data "databricks_spark_version" "latest_lts" {
  long_term_support = true
  depends_on = [data.azurerm_databricks_workspace.ws]
}

data "databricks_node_type" "smallest" {
  local_disk = true
  depends_on = [data.azurerm_databricks_workspace.ws]
}

resource "databricks_cluster" "prod_cluster" {
  cluster_name            = var.prod_cluster_name
  spark_version           = data.databricks_spark_version.latest.id
  node_type_id            = data.databricks_node_type.smallest.id
  autotermination_minutes = 20
  autoscale {
    min_workers = 1
    max_workers = 4
  }
  lifecycle {
    prevent_destroy = true
  }
}
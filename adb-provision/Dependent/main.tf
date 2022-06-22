terraform {
  required_version = ">=1.1.9"

  required_providers {
    databricks = {
      source  = "databrickslabs/databricks"
      version = "0.6.0"
    }
    azuread = {
      source = "hashicorp/azuread"
      version = "2.23.0"
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

module "workspace_users" {
  source              = "./modules/workspace_users"
  CLIENT_ID           = var.CLIENT_ID
  SECRET              = var.SECRET
  TENANT_ID           = var.TENANT_ID
  SUB_ID              = var.SUB_ID
  wsname              = var.wsname
  rgname              = var.rgname
  analyst_group_name  = var.analyst_group_name
  dev_group_name      = var.dev_group_name
  devops_group_name   = var.devops_group_name
  engineer_group_name = var.engineer_group_name
  testers_group_name  = var.testers_group_name
  prod_group_name     = var.prod_group_name
  analyst_users       = var.analyst_users
  dev_users           = var.dev_users
  devops_users        = var.devops_users
  engineer_users      = var.engineer_users
  ops_users           = var.ops_users
  tester_users        = var.tester_users
} 

/* module "ad_group_users" {
  source              = "./modules/ad_group_users"
  CLIENT_ID           = var.CLIENT_ID
  SECRET              = var.SECRET
  TENANT_ID           = var.TENANT_ID
  SUB_ID              = var.SUB_ID
  wsname              = var.wsname
  rgname              = var.rgname
  ad_analyst_group    = var.ad_analyst_group
  ad_dev_group        = var.ad_dev_group
  ad_devops_group     = var.ad_devops_group
  ad_engineer_group   = var.ad_engineer_group
  ad_operations_group = var.ad_operations_group
  ad_tester_group     = var.ad_tester_group
} */

module "notebooks" {
  source                    = "./modules/notebooks"
  CLIENT_ID                 = var.CLIENT_ID
  SECRET                    = var.SECRET
  TENANT_ID                 = var.TENANT_ID
  SUB_ID                    = var.SUB_ID
  wsname                    = var.wsname
  rgname                    = var.rgname
  analyst_notebook_path     = var.analyst_notebook_path
  dev_notebook_path         = var.dev_notebook_path
  devops_notebook_path      = var.devops_notebook_path
  engineer_notebook_path    = var.engineer_notebook_path
  tester_notebook_path      = var.tester_notebook_path
  prod_notebook_path        = var.prod_notebook_path
  mountscript_notebook_path = var.mountscript_notebook_path
  storage_account_name      = var.storage_account_name
  adf-dl-gen2-fs_name       = var.adf-dl-gen2-fs_name
  keyvault_name             = var.keyvault_name
}
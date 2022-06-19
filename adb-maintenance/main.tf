terraform {
  required_version = ">=1.1.9"

  required_providers {
    databricks = {
      source  = "databrickslabs/databricks"
      version = "0.6.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
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

module "workspace_group_membership" {
  source              = "./modules/workspace_group_membership"
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
  dev_users           = var.dev_users
  devops_users        = var.devops_users
  ops_users           = var.ops_users
  tester_users        = var.tester_users
}

/* module "ad_group_membership" {
  source              = "./modules/ad_group_membership"
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
  ad_analyst_group    = var.ad_analyst_group
  ad_dev_group        = var.ad_dev_group
  ad_devops_group     = var.ad_devops_group
  ad_engineer_group   = var.ad_engineer_group
  ad_operations_group = var.ad_operations_group
  ad_tester_group     = var.ad_tester_group
} */

module "cluster_configuration" {
  source              = "./modules/cluster_configuration"
  CLIENT_ID           = var.CLIENT_ID
  SECRET              = var.SECRET
  TENANT_ID           = var.TENANT_ID
  SUB_ID              = var.SUB_ID
  wsname              = var.wsname
  rgname              = var.rgname
  prod_cluster_policy = var.prod_cluster_policy
}
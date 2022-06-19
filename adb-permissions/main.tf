terraform {
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

module "jobs_permissions" {
  source                 = "./modules/jobs_permissions"
  CLIENT_ID              = var.CLIENT_ID
  SECRET                 = var.SECRET
  TENANT_ID              = var.TENANT_ID
  SUB_ID                 = var.SUB_ID
  wsname                 = var.wsname
  rgname                 = var.rgname
  analyst_notebook_path  = var.analyst_notebook_path
  dev_notebook_path      = var.dev_notebook_path
  devops_notebook_path   = var.devops_notebook_path
  engineer_notebook_path = var.engineer_notebook_path
  tester_notebook_path   = var.tester_notebook_path
  prod_notebook_path     = var.prod_notebook_path
  analyst_job_name       = var.analyst_job_name
  dev_job_name           = var.dev_job_name
  devops_job_name        = var.devops_job_name
  engineer_job_name      = var.engineer_job_name
  tester_job_name        = var.tester_job_name
  prod_job_name          = var.prod_job_name
  analyst_group_name     = var.analyst_group_name
  dev_group_name         = var.dev_group_name
  devops_group_name      = var.devops_group_name
  engineer_group_name    = var.engineer_group_name
  testers_group_name     = var.testers_group_name
  prod_group_name        = var.prod_group_name
}

module "workspace_folders_permissions" {
  source              = "./modules/workspace_folders_permissions"
  CLIENT_ID           = var.CLIENT_ID
  SECRET              = var.SECRET
  TENANT_ID           = var.TENANT_ID
  SUB_ID              = var.SUB_ID
  wsname              = var.wsname
  rgname              = var.rgname
  analyst_path        = var.analyst_path
  dev_path            = var.dev_path
  devops_path         = var.devops_path
  engineer_path       = var.engineer_path
  prod_path           = var.prod_path
  test_path           = var.test_path
  analyst_group_name  = var.analyst_group_name
  dev_group_name      = var.dev_group_name
  devops_group_name   = var.devops_group_name
  engineer_group_name = var.engineer_group_name
  testers_group_name  = var.testers_group_name
  prod_group_name     = var.prod_group_name
}

module "cluster_permissions" {
  source              = "./modules/cluster_permissions"
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
  prod_cluster_name   = var.prod_cluster_name
}
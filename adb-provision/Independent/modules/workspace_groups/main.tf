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

data "databricks_current_user" "me" {
  depends_on = [data.azurerm_databricks_workspace.ws]
}

data "azurerm_databricks_workspace" "ws" {
  name                = var.wsname
  resource_group_name = var.rgname
}

#Uncomment if the groups have been deleted and need to be created
#Otherwise create a new group using the below template
resource "databricks_group" "analystgroup" {
  display_name = var.analyst_group_name
}

resource "databricks_group" "devgroup" {
  display_name = var.dev_group_name
}

resource "databricks_group" "devopsgroup" {
  display_name = var.devops_group_name
}

resource "databricks_group" "engineergroup" {
  display_name = var.engineer_group_name
}

resource "databricks_group" "testgroup" {
  display_name = var.testers_group_name
}

resource "databricks_group" "prodgroup" {
  display_name = var.prod_group_name
}
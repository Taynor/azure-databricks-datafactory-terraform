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

resource "databricks_directory" "dev" {
  path = var.dev_path
  lifecycle {
    prevent_destroy = true
  }
}

resource "databricks_directory" "test" {
  path = var.test_path
  lifecycle {
    prevent_destroy = true
  }
}

resource "databricks_directory" "prod" {
  path = var.prod_path
  lifecycle {
    prevent_destroy = true
  }
}

resource "databricks_directory" "devops" {
  path = var.devops_path
  lifecycle {
    prevent_destroy = true
  }
}

resource "databricks_directory" "analyst" {
  path = var.analyst_path
  lifecycle {
    prevent_destroy = true
  }
}

resource "databricks_directory" "engineer" {
  path = var.engineer_path
  lifecycle {
    prevent_destroy = true
  }
}
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

data "databricks_current_user" "me" {}

data "azuread_group" "analystadgroup" {
  display_name     = var.ad_analyst_group
  security_enabled = true
}

data "azuread_group" "devadgroup" {
  display_name     = var.ad_dev_group
  security_enabled = true
}

data "azuread_group" "devopsadgroup" {
  display_name     = var.ad_devops_group
  security_enabled = true
}

data "azuread_group" "engineeradgroup" {
  display_name     = var.ad_engineer_group
  security_enabled = true
}

data "azuread_group" "operationsadgroup" {
  display_name     = var.ad_operations_group
  security_enabled = true
}

data "azuread_group" "testeradgroup" {
  display_name     = var.ad_tester_group
  security_enabled = true
}

data "azuread_users" "analystadusers" {
  object_ids = data.azuread_group.analystadgroup.members
}

data "azuread_users" "devadusers" {
  object_ids = data.azuread_group.devadgroup.members
}

data "azuread_users" "devopsaduser" {
  object_ids = data.azuread_group.devopsadgroup.members
}

data "azuread_users" "engineeraduser" {
  object_ids = data.azuread_group.engineeradgroup.members
}

data "azuread_users" "operationsaduser" {
  object_ids = data.azuread_group.operationsadgroup.members
}

data "azuread_users" "testeraduser" {
  object_ids = data.azuread_group.testeradgroup.members
}

resource "databricks_user" "new_analyst_user" {
  for_each = { for i, v in data.azuread_users.analystadusers.users: i => v }
    user_name     = each.value.user_principal_name
    display_name  = each.value.display_name 
  force    = true   
  lifecycle {
    create_before_destroy = true
  } 
}

resource "databricks_user" "new_developer_user" {
  for_each = { for i, v in data.azuread_users.devadusers.users: i => v }
    user_name     = each.value.user_principal_name
    display_name  = each.value.display_name     
  force    = true
  lifecycle {
    create_before_destroy = true
  }
}

resource "databricks_user" "new_devops_user" {
    for_each = { for i, v in data.azuread_users.devopsaduser.users: i => v }
      user_name     = each.value.user_principal_name
      display_name  = each.value.display_name
  force    = true 
  lifecycle {
    create_before_destroy = true
  } 
} 
 
resource "databricks_user" "new_engineer_user" {
  for_each = { for i, v in data.azuread_users.engineeraduser.users: i => v }
    user_name     = each.value.user_principal_name
    display_name  = each.value.display_name
  force    = true 
  lifecycle {
    create_before_destroy = true
  } 
}

resource "databricks_user" "new_operations_user" {
  for_each = { for i, v in data.azuread_users.operationsaduser.users: i => v }
    user_name     = each.value.user_principal_name
    display_name  = each.value.display_name
  force    = true  
  lifecycle {
    create_before_destroy = true
  }
}

resource "databricks_user" "new_tester_user" {
  for_each = { for i, v in data.azuread_users.testeraduser.users: i => v }
    user_name     = each.value.user_principal_name
    display_name  = each.value.display_name
  force    = true  
  lifecycle {
    create_before_destroy = true
  }
}
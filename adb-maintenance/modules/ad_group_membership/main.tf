terraform {
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

data "databricks_group" "analystgroup" {
  display_name = var.analyst_group_name
}

data "databricks_group" "devopsgroup" {
  display_name = var.devops_group_name
}

data "databricks_group" "devgroup" {
  display_name = var.dev_group_name
}

data "databricks_group" "engineergroup" {
  display_name = var.engineer_group_name
}

data "databricks_group" "testgroup" {
  display_name = var.testers_group_name
}

data "databricks_group" "prodgroup" {
  display_name = var.prod_group_name
}

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

data "databricks_user" "load_analyst_user" {
    for_each = { for i, v in data.azuread_users.analystadusers.users: i => v }
      user_name  = each.value.user_principal_name
      depends_on = [data.azuread_users.analystadusers]
}

data "databricks_user" "load_dev_user" {
    for_each = { for i, v in data.azuread_users.devadusers.users: i => v }
      user_name  = each.value.user_principal_name
      depends_on = [data.azuread_users.devadusers]
}

data "databricks_user" "load_devops_user" {
    for_each = { for i, v in data.azuread_users.devopsaduser.users: i => v }
      user_name  = each.value.user_principal_name
      depends_on = [data.azuread_users.devopsaduser]
}

data "databricks_user" "load_engineer_user" {
    for_each = { for i, v in data.azuread_users.engineeraduser.users: i => v }
      user_name  = each.value.user_principal_name
      depends_on = [data.azuread_users.engineeraduser]
}

data "databricks_user" "load_operations_user" {
    for_each = { for i, v in data.azuread_users.operationsaduser.users: i => v }
      user_name  = each.value.user_principal_name
      depends_on = [data.azuread_users.operationsaduser]
}

data "databricks_user" "load_tester_user" {
    for_each = { for i, v in data.azuread_users.testeraduser.users: i => v }
      user_name  = each.value.user_principal_name
      depends_on = [data.azuread_users.testeraduser]
}

resource "databricks_group_member" "analyst_members" {
  for_each   = data.databricks_user.load_analyst_user
  group_id   = data.databricks_group.analystgroup.id
  member_id  = data.databricks_user.load_analyst_user[each.key].id 
  lifecycle {
    create_before_destroy = true
  }
  depends_on = [data.databricks_user.load_analyst_user]
}

resource "databricks_group_member" "dev_members" {
  for_each   = data.databricks_user.load_dev_user
  group_id   = data.databricks_group.devgroup.id
  member_id  = data.databricks_user.load_dev_user[each.key].id 
  lifecycle {
    create_before_destroy = true
  }
  depends_on = [data.databricks_user.load_dev_user]
}

resource "databricks_group_member" "devops_members" {
  for_each   = data.databricks_user.load_devops_user
  group_id   = data.databricks_group.devopsgroup.id
  member_id  = data.databricks_user.load_devops_user[each.key].id 
  lifecycle {
    create_before_destroy = true
  }
  depends_on = [data.databricks_user.load_devops_user]
}

resource "databricks_group_member" "engineer_members" {
  for_each   = data.databricks_user.load_engineer_user
  group_id   = data.databricks_group.engineergroup.id
  member_id  = data.databricks_user.load_engineer_user[each.key].id 
  lifecycle {
    create_before_destroy = true
  }
  depends_on = [data.databricks_user.load_engineer_user]
}

resource "databricks_group_member" "operations_members" {
  for_each   = data.databricks_user.load_operations_user
  group_id   = data.databricks_group.prodgroup.id
  member_id  = data.databricks_user.load_operations_user[each.key].id 
  lifecycle {
    create_before_destroy = true
  }
  depends_on = [data.databricks_user.load_operations_user]
}

resource "databricks_group_member" "tester_members" {
  for_each   = data.databricks_user.load_tester_user
  group_id   = data.databricks_group.testgroup.id
  member_id  = data.databricks_user.load_tester_user[each.key].id 
  lifecycle {
    create_before_destroy = true
  }
  depends_on = [data.databricks_user.load_tester_user]
}
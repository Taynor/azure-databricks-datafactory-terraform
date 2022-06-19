terraform {
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

data "databricks_group" "devopsgroup" {
  display_name = var.devops_group_name
}

data "databricks_group" "devgroup" {
  display_name = var.dev_group_name
}

data "databricks_group" "testgroup" {
  display_name = var.testers_group_name
}

data "databricks_group" "prodgroup" {
  display_name = var.prod_group_name
}

data "databricks_group" "analystgroup" {
  display_name = var.analyst_group_name
}

data "databricks_group" "engineergroup" {
  display_name = var.engineer_group_name
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

resource "databricks_directory" "analysts" {
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

resource "databricks_permissions" "dev_folder_perms" {
  directory_path = databricks_directory.dev.path
  depends_on     = [databricks_directory.dev]
  access_control {
    group_name       = data.databricks_group.devgroup.display_name
    permission_level = "CAN_EDIT"
  }
  access_control {
    group_name       = data.databricks_group.devopsgroup.display_name
    permission_level = "CAN_MANAGE"
  }
  access_control {
    group_name       = data.databricks_group.prodgroup.display_name
    permission_level = "CAN_MANAGE"
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "databricks_permissions" "tester_folder_perms" {
  directory_path = databricks_directory.test.path
  depends_on     = [databricks_directory.test]
  access_control {
    group_name       = data.databricks_group.testgroup.display_name
    permission_level = "CAN_EDIT"
  }
  access_control {
    group_name       = data.databricks_group.devopsgroup.display_name
    permission_level = "CAN_MANAGE"
  }
  access_control {
    group_name       = data.databricks_group.prodgroup.display_name
    permission_level = "CAN_MANAGE"
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "databricks_permissions" "devops_folder_perms" {
  directory_path = databricks_directory.devops.path
  depends_on     = [databricks_directory.devops]
  access_control {
    group_name       = data.databricks_group.devopsgroup.display_name
    permission_level = "CAN_MANAGE"
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "databricks_permissions" "prod_folder_perms" {
  directory_path = databricks_directory.prod.path
  depends_on     = [databricks_directory.prod]
  access_control {
    group_name       = data.databricks_group.prodgroup.display_name
    permission_level = "CAN_MANAGE"
  }
  lifecycle {
    prevent_destroy = true
  }
}

#newly created resources
resource "databricks_permissions" "analyst_folder_perms" {
  directory_path = databricks_directory.analysts.path
  depends_on     = [databricks_directory.analysts]
  access_control {
    group_name       = data.databricks_group.analystgroup.display_name
    permission_level = "CAN_MANAGE"
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "databricks_permissions" "engineer_folder_perms" {
  directory_path = databricks_directory.engineer.path
  depends_on     = [databricks_directory.engineer]
  access_control {
    group_name       = data.databricks_group.engineergroup.display_name
    permission_level = "CAN_MANAGE"
  }
  lifecycle {
    prevent_destroy = true
  }
}
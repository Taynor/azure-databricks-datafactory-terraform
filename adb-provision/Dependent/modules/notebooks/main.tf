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

data "databricks_current_user" "me" {}

resource "databricks_notebook" "devnotebook" {
  path     = var.dev_notebook_path
  language = "PYTHON"
  content_base64 = base64encode(<<-EOT
    print(f'This is the Development job notebook')
    EOT
  )
  lifecycle {
    prevent_destroy = true
  }
}

resource "databricks_notebook" "devopsnotebook" {
  path     = var.devops_notebook_path
  language = "PYTHON"
  content_base64 = base64encode(<<-EOT
    print(f'This is the DevOps job notebook')
    EOT
  )
  lifecycle {
    prevent_destroy = true
  }
}

resource "databricks_notebook" "testernotebook" {
  path     = var.tester_notebook_path
  language = "PYTHON"
  content_base64 = base64encode(<<-EOT
    print(f'This is the Tester job notebook')
    EOT
  )
  lifecycle {
    prevent_destroy = true
  }
}

resource "databricks_notebook" "prodnotebook" {
  path     = var.prod_notebook_path
  language = "PYTHON"
  content_base64 = base64encode(<<-EOT
    print(f'This is the Operations job notebook')
    EOT
  )
  lifecycle {
    prevent_destroy = true
  }
}

resource "databricks_notebook" "analystnotebook" {
  path     = var.analyst_notebook_path
  language = "PYTHON"
  content_base64 = base64encode(<<-EOT
    print(f'This is the Analyst job notebook')
    EOT
  )
  lifecycle {
    prevent_destroy = true
  }
}

resource "databricks_notebook" "engineernotebook" {
  path     = var.engineer_notebook_path
  language = "PYTHON"
  content_base64 = base64encode(<<-EOT
    print(f'This is the Engineer job notebook')
    EOT
  )
  lifecycle {
    prevent_destroy = true
  }
}
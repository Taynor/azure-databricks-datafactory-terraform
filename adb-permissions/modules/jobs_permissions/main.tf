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

data "databricks_notebook" "devnotebook" {
  path   = var.dev_notebook_path
  format = "SOURCE"
}

data "databricks_notebook" "devopsnotebook" {
  path   = var.devops_notebook_path
  format = "SOURCE"
}

data "databricks_notebook" "testernotebook" {
  path   = var.tester_notebook_path
  format = "SOURCE"
}

data "databricks_notebook" "prodnotebook" {
  path   = var.prod_notebook_path
  format = "SOURCE"
}

data "databricks_notebook" "analystnotebook" {
  path   = var.analyst_notebook_path
  format = "SOURCE"
}

data "databricks_notebook" "engineernotebook" {
  path   = var.engineer_notebook_path
  format = "SOURCE"
}

data "databricks_spark_version" "latest_lts" {
  long_term_support = true
  depends_on = [data.azurerm_databricks_workspace.ws]
}

data "databricks_node_type" "smallest" {
  local_disk = true
  depends_on = [data.azurerm_databricks_workspace.ws]
}

resource "databricks_job" "devjob" {
  name = var.dev_job_name
  new_cluster {
    num_workers   = 1
    spark_version = data.databricks_spark_version.latest_lts.id
    node_type_id  = data.databricks_node_type.smallest.id
  }
  notebook_task {
    notebook_path = data.databricks_notebook.devnotebook.path
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "databricks_job" "devopsjob" {
  name = var.devops_job_name
  new_cluster {
    num_workers   = 1
    spark_version = data.databricks_spark_version.latest_lts.id
    node_type_id  = data.databricks_node_type.smallest.id
  }
  notebook_task {
    notebook_path = data.databricks_notebook.devopsnotebook.path
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "databricks_job" "testerjob" {
  name = var.tester_job_name
  new_cluster {
    num_workers   = 1
    spark_version = data.databricks_spark_version.latest_lts.id
    node_type_id  = data.databricks_node_type.smallest.id
  }
  notebook_task {
    notebook_path = data.databricks_notebook.testernotebook.path
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "databricks_job" "prodjob" {
  name = var.prod_job_name
  new_cluster {
    num_workers   = 1
    spark_version = data.databricks_spark_version.latest_lts.id
    node_type_id  = data.databricks_node_type.smallest.id
  }
  notebook_task {
    notebook_path = data.databricks_notebook.prodnotebook.path
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "databricks_job" "analystjob" {
  name = var.analyst_job_name
  new_cluster {
    num_workers   = 1
    spark_version = data.databricks_spark_version.latest_lts.id
    node_type_id  = data.databricks_node_type.smallest.id
  }
  notebook_task {
    notebook_path = data.databricks_notebook.analystnotebook.path
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "databricks_job" "engineerjob" {
  name = var.engineer_job_name
  new_cluster {
    num_workers   = 1
    spark_version = data.databricks_spark_version.latest_lts.id
    node_type_id  = data.databricks_node_type.smallest.id
  }
  notebook_task {
    notebook_path = data.databricks_notebook.engineernotebook.path
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "databricks_permissions" "dev_job_perms" {
  job_id = databricks_job.devjob.id
  access_control {
    group_name       = "users"
    permission_level = "CAN_VIEW"
  }
  access_control {
    group_name       = data.databricks_group.devgroup.display_name
    permission_level = "CAN_MANAGE_RUN"
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

resource "databricks_permissions" "tester_job_perms" {
  job_id = databricks_job.testerjob.id
  access_control {
    group_name       = "users"
    permission_level = "CAN_VIEW"
  }
  access_control {
    group_name       = data.databricks_group.testgroup.display_name
    permission_level = "CAN_MANAGE_RUN"
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

resource "databricks_permissions" "devops_job_perms" {
  job_id = databricks_job.devopsjob.id
  access_control {
    group_name       = "users"
    permission_level = "CAN_VIEW"
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

resource "databricks_permissions" "prod_job_perms" {
  job_id = databricks_job.prodjob.id
  access_control {
    group_name       = "users"
    permission_level = "CAN_VIEW"
  }
  access_control {
    group_name       = data.databricks_group.prodgroup.display_name
    permission_level = "CAN_MANAGE"
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "databricks_permissions" "analyst_job_perms" {
  job_id = databricks_job.analystjob.id
  access_control {
    group_name       = "users"
    permission_level = "CAN_VIEW"
  }
  access_control {
    group_name       = data.databricks_group.analystgroup.display_name
    permission_level = "CAN_MANAGE"
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "databricks_permissions" "engineer_job_perms" {
  job_id = databricks_job.engineerjob.id
  access_control {
    group_name       = "users"
    permission_level = "CAN_VIEW"
  }
  access_control {
    group_name       = data.databricks_group.engineergroup.display_name
    permission_level = "CAN_MANAGE"
  }
  lifecycle {
    prevent_destroy = true
  }
}
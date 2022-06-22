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

resource "databricks_notebook" "mountscript" {
  path     = var.mountscript_notebook_path
  language = "PYTHON"
  content_base64 = base64encode(<<-EOT
adlsAccountName = "${var.storage_account_name}"
adlsContainerName = "${var.adf-dl-gen2-fs_name}"
adlsFolderNameRaw = "raw"
mountPointRaw = "/mnt/raw"
adlsFolderNameProcess = "process"
mountPointProcess = "/mnt/process"
adlsFolderNameOutput = "output"
mountPointOutput = "/mnt/output"

applicationId = dbutils.secrets.get(scope="${var.keyvault_name}",key="ClientId")
authenticationKey = dbutils.secrets.get(scope="${var.keyvault_name}",key="ClientSecret")
tenandId = dbutils.secrets.get(scope="${var.keyvault_name}",key="TenantId") 
endpoint = "https://login.microsoftonline.com/" + tenandId + "/oauth2/token"
sourceRaw = "abfss://" + adlsContainerName + "@" + adlsAccountName + ".dfs.core.windows.net/" + adlsFolderNameRaw
sourceProcess = "abfss://" + adlsContainerName + "@" + adlsAccountName + ".dfs.core.windows.net/" + adlsFolderNameProcess
sourceOutput = "abfss://" + adlsContainerName + "@" + adlsAccountName + ".dfs.core.windows.net/" + adlsFolderNameOutput
 
configs = {"fs.azure.account.auth.type": "OAuth",
           "fs.azure.account.oauth.provider.type": "org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider",
           "fs.azure.account.oauth2.client.id": applicationId,
           "fs.azure.account.oauth2.client.secret": authenticationKey,
           "fs.azure.account.oauth2.client.endpoint": endpoint}
 
if not any(mount.mountPoint == mountPointRaw for mount in dbutils.fs.mounts()):
  dbutils.fs.mount(
    source = sourceRaw,
    mount_point = mountPointRaw,
    extra_configs = configs)

if not any(mount.mountPoint == mountPointProcess for mount in dbutils.fs.mounts()):
  dbutils.fs.mount(
    source = sourceProcess,
    mount_point = mountPointProcess,
    extra_configs = configs) 

if not any(mount.mountPoint == mountPointOutput for mount in dbutils.fs.mounts()):
  dbutils.fs.mount(
    source = sourceOutput,
    mount_point = mountPointOutput,
    extra_configs = configs)        

    EOT
  )
  lifecycle {
    prevent_destroy = true
  }
}
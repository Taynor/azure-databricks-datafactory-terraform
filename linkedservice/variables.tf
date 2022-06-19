variable "resource_group_name" {
  description = "resource group name for adf"
  type        = string
}
variable "adb-ws-name" {
  description = "adb workspace name"
  type        = string
}
variable "adf_name" {
 description = "name for adf keyvault"
 type        = string
}
variable "adf_location" {
 description = "location for adf"
 type        = string
}
variable "adf_kv_linkedservice" {
 description = "name for adf keyvault linkedservice"
 type        = string
}
variable "adf_dl_linkedservice" {
 description = "name for adf datalake linkedservice"
 type        = string
}
variable "keyvault_name" {
 description = "name for adf keyvault"
 type        = string
}
variable "CLIENT_ID" {
    description = <<EOF
    "The service principal client id, authentication for the azurerm and databricks providers. 
    A shared variable for all child modules to authenticate against the workspace."
    EOF
    type        = string
}
variable "SECRET" {
    description = <<EOF
    "The service principal secret, authentication for the azurerm and databricks providers.
    A shared variable for all child modules to authenticate against the workspace."
    EOF
    type        = string
    sensitive   = true
}
variable "TENANT_ID" {
    description = <<EOF
    "The service principal tenamt id, authentication for the azurerm and databricks providers.
    A shared variable for all child modules to authenticate against the workspace."
    EOF
    type        = string
}
variable "SUB_ID" {
    description = <<EOF
    "The subscription id that the databricks workspace runs from.
    A shared variable for all child modules to authenticate against the workspace."
    EOF
    type        = string
}
variable "storage_account_name" {
 description = "storage account name for adf data lake"
 type        = string
}
variable "adf-dl-gen2-fs_name" {
  description = "dl gen2 name for adf data lake"
  type        = string
}
variable "prod_cluster_name" {
    description = <<EOF
    "This is a demo all purpose cluster named ProdCluster. This is a shared variable used in
    the following modules:
    - cluster"
    EOF
    type        = string
}
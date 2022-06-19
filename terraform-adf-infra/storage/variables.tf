variable "storage_account_name" {
 description = "storage account name for adf data lake"
 type        = string
}
variable "storage_account_location" {
 description = "storage account location for adf data lake"
 type        = string
}
variable "adf-dl-gen2-fs_name" {
  description = "dl gen2 name for adf data lake"
  type        = string
}
variable "resource_group_name" {
  description = "resource group name for adf"
  type        = string
}
variable "dl_paths" {
  description = "paths for dl storage"
  type        = list
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
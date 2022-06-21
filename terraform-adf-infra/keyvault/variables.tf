variable "resource_group_name" {
  description = "resource group name for adf keyvault"
  type        = string
}
variable "keyvault_location" {
 description = "storage account location for adf keyvault"
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
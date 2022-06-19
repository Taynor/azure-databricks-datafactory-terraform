variable "adb-ws-location" {
  description = "adb workspace location"
  type        = string
}
variable "abd-ws-name" {
  description = "adb workspace name"
  type        = string
}
variable "adb-managed-ws-name" {
  description = "adb managed workspace name"
  type        = string
}
variable "resource_group_name" {
  description = "resource group name for adb"
  type        = string
}
variable "adb-vnet_name" {
  description = "vnet name for adb"
  type        = string     
}
variable "adb-public-subnet_name" {
  description = "adb public subnet"
  type        = string
}
variable "adb-private-subnet-name" {
  description = "adb private subnet"
  type        = string
}
variable "adb-endpoint-subnet-name" {
  description = "adb endpoint subnet"
  type        = string
}
variable "adb-nsg_name" {
  description = "nsg for adb vnet"
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
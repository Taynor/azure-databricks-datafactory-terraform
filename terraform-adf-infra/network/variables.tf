variable "adf-vnet_name" {
  description = "vnet name for adf"
  type        = string     
}

variable "adf-nsg_name" {
  description = "nsg for adf vnet"
  type        = string
}

variable "adf-public-subnet_name" {
  description = "adf public subnet"
  type        = string
}

variable "adf-private-subnet-name" {
  description = "adf private subnet"
  type        = string
}

variable "adf-endpoint-subnet-name" {
  description = "adf endpoint subnet"
  type        = string
}

variable "adf-ssesp-name" {
  description = "adf ssesp name"
  type        = string
}

variable "adf-public-ip-name" {
  description = "adf public ip name"
  type        = string
}

variable "adf-public-ip-prefix-name" {
  description = "adf public ip prefix name"
  type        = string
}

variable "adf-nat-gateway-name" {
  description = "adf nat gateway name"
  type        = string
}

variable "resource_group_name" {
  description = "resource group name for adf"
  type        = string
}

variable "storage_account_name" {
 description = "storage account name for adf data lake"
 type        = string
}
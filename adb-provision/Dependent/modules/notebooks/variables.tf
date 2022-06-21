variable "CLIENT_ID" {
    type = string
}
variable "SECRET" {
    type      = string
    sensitive = true
}
variable "TENANT_ID" {
    type = string
}
variable "SUB_ID" {
    type = string
}
variable "rgname" {
    type = string
}
variable "wsname" {
    type = string
}
variable "analyst_notebook_path" {
    type = string
}
variable "dev_notebook_path" {
    type = string
}
variable "devops_notebook_path" {
    type = string
}
variable "engineer_notebook_path" {
    type = string
}
variable "prod_notebook_path" {
    type = string
}
variable "tester_notebook_path" {
    type = string
}
variable "mountscript_notebook_path" {
    type = string
}
variable "storage_account_name" {
 description = "storage account name for adf data lake"
 type        = string
}
variable "adf-dl-gen2-fs_name" {
  description = "dl gen2 name for adf data lake"
  type        = string
}
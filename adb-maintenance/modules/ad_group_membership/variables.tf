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
variable "ad_analyst_group" {
    type = string
}
variable "ad_dev_group" {
    type = string
}
variable "ad_devops_group" {
    type = string
}
variable "ad_engineer_group" {
    type = string
}
variable "ad_operations_group" {
    type = string
}
variable "ad_tester_group" {
    type = string
}
variable "analyst_group_name" {
    type = string
}
variable "dev_group_name" {
    type = string
}
variable "devops_group_name" {
    type = string
}
variable "engineer_group_name" {
    type = string
}
variable "prod_group_name" {
    type = string
}
variable "testers_group_name" {
    type = string
}
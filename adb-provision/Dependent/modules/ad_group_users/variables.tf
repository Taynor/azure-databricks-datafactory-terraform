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
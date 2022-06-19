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
variable "dev_path" {
    type    = string
}
variable "devops_path" {
    type    = string
}
variable "test_path" {
    type    = string
}
variable "prod_path" {
    type    = string
}
variable "analyst_path" {
    type    = string
}
variable "engineer_path" {
    type    = string
}
variable "analyst_group_name" {
    type    = string
}
variable "dev_group_name" {
    type    = string
}
variable "devops_group_name" {
    type    = string
}
variable "engineer_group_name" {
    type    = string
}
variable "prod_group_name" {
    type    = string
}
variable "testers_group_name" {
    type    = string
}
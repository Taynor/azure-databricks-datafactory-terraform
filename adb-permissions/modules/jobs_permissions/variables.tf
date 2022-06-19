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
variable "dev_notebook_path" {
    type    = string
}
variable "devops_notebook_path" {
    type    = string
}
variable "tester_notebook_path" {
    type    = string
}
variable "prod_notebook_path" {
    type    = string
}
variable "analyst_notebook_path" {
    type    = string
}
variable "engineer_notebook_path" {
    type    = string
}
variable "dev_job_name" {
    type    = string
}
variable "devops_job_name" {
    type    = string
}
variable "tester_job_name" {
    type    = string
}
variable "prod_job_name" {
    type    = string
}
variable "analyst_job_name" {
    type    = string
}
variable "engineer_job_name" {
    type    = string
}
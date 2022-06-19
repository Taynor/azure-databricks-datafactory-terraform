variable "rgname" {
    description = <<EOF
    "The name of resource group that the databricks workspace instance is hosted. 
    A shared variable for all child modules to authenticate against the workspace."
    EOF
    type        = string
}
variable "wsname" {
    description = <<EOF
    "The name of the databricks workspace instance. 
    A shared variable for all child modules to authenticate against the workspace."
    EOF
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
variable "ad_analyst_group" {
    description = <<EOF
    "This is demo AD user group named AZR-ANALYST that will pull it's members. Each member 
    will be placed in Analyst workspace user group. To inherit Analyst permissions on the
    workspace. This is a shared variable used in the following modules:
    - ad_group_membership"
    EOF
    type        = string
}
variable "ad_dev_group" {
    description = <<EOF
    "This is demo AD user group named AZR-DEVELOPER that will pull it's members. Each member 
    will be placed in Developer workspace user group. To inherit Developer permissions on the
    workspace. This is a shared variable used in the following modules:
    - ad_group_membership"
    EOF
    type        = string
}
variable "ad_devops_group" {
    description = <<EOF
    "This is demo AD user group named AZR-DEVOPS that will pull it's members. Each member 
    will be placed in Devops workspace user group. To inherit DevOps permissions on the
    workspace. This is a shared variable used in the following modules:
    - ad_group_membership"
    EOF
    type        = string
}
variable "ad_engineer_group" {
    description = <<EOF
    "This is demo AD user group named AZR-ENGINEER that will pull it's members. Each member 
    will be placed in Engineers workspace user group. To inherit Engineer permissions on the
    workspace. This is a shared variable used in the following modules:
    - ad_group_membership"
    EOF
    type        = string
}
variable "ad_operations_group" {
    description = <<EOF
    "This is demo AD user group named AZR-OPERATIONS that will pull it's members. Each member 
    will be placed in Operations workspace user group. To inherit Operations permissions on the
    workspace. This is a shared variable used in the following modules:
    - ad_group_membership"
    EOF
    type        = string
}
variable "ad_tester_group" {
    description = <<EOF
    "This is demo AD user group named AZR-TESTER that will pull it's members. Each member 
    will be placed in Testers workspace user group. To inherit Tester permissions on the
    workspace. This is a shared variable used in the following modules:
    - ad_group_membership"
    EOF
    type        = string
}
variable "analyst_group_name" {
    description = <<EOF
    "This is demo workspace group name Analysts, is used to add users that need to inherit
    Analyst level permissions on the workspace. This is a shared variable used in the 
    following modules:
    - workspace_group_membership
    - ad_group_membership"
    EOF
    type        = string
}
variable "dev_group_name" {
    description = <<EOF
    "This is demo workspace group name Developers, is used to add users that need to inherit
    Developer level permissions on the workspace. This is a shared variable used in the 
    following modules:
    - workspace_group_membership
    - ad_group_membership"
    EOF
    type        = string
}
variable "devops_group_name" {
    description = <<EOF
    "This is demo workspace group name Devops, is used to add users that need to inherit
    DevOps level permissions on the workspace. This is a shared variable used in the 
    following modules:
    - workspace_group_membership
    - ad_group_membership"
    EOF
    type        = string
}
variable "engineer_group_name" {
    description = <<EOF
    "This is demo workspace group name Engineers, is used to add users that need to inherit
    Engineer level permissions on the workspace. This is a shared variable used in the 
    following modules:
    - workspace_group_membership
    - ad_group_membership"
    EOF
    type        = string
}
variable "prod_group_name" {
    description = <<EOF
    "This is demo workspace group name Operations, is used to add users that need to inherit
    Operations level permissions on the workspace. This is a shared variable used in the 
    following modules:
    - workspace_group_membership
    - ad_group_membership"
    EOF
    type        = string
}
variable "testers_group_name" {
    description = <<EOF
    "This is demo workspace group name Testers, is used to add users that need to inherit
    Tester level permissions on the workspace. This is a shared variable used in the 
    following modules:
    - workspace_group_membership
    - ad_group_membership"
    EOF
    type        = string
}
variable "analyst_users" {
    description = <<EOF
    "This is the demo list of users contained in a list data structure, managed interactively
    with the terraform.tfvars. These users will be become members of the Analyst user group.
    This is a shared variable used in the following modules:
    - workspace_group_membership"
    EOF
    type = list
}
variable "dev_users" {
    description = <<EOF
    "This is the demo list of users contained in a list data structure, managed interactively
    with the terraform.tfvars. These users will be become members of the Developers user group.
    This is a shared variable used in the following modules:
    - workspace_group_membership"
    EOF
    type = list
}
variable "devops_users" {
    description = <<EOF
    "This is the demo list of users contained in a list data structure, managed interactively
    with the terraform.tfvars. These users will be become members of the Devops user group.
    This is a shared variable used in the following modules:
    - workspace_group_membership"
    EOF
    type = list 
}
variable "engineer_users" {
    description = <<EOF
    "This is the demo list of users contained in a list data structure, managed interactively
    with the terraform.tfvars. These users will be become members of the Engineers user group.
    This is a shared variable used in the following modules:
    - workspace_group_membership"
    EOF
    type = list
}
variable "ops_users" {
    description = <<EOF
    "This is the demo list of users contained in a list data structure, managed interactively
    with the terraform.tfvars. These users will be become members of the Operations user group.
    This is a shared variable used in the following modules:
    - workspace_group_membership"
    EOF
    type = list
}
variable "tester_users" {
    description = <<EOF
    "This is the demo list of users contained in a list data structure, managed interactively
    with the terraform.tfvars. These users will be become members of the Testers user group.
    This is a shared variable used in the following modules:
    - workspace_group_membership"
    EOF
    type = list
}
variable "prod_cluster_policy" {
    description = <<EOF
    "This is the demo cluster policy that will be associated with the demo prod cluster. This is
    a shared variable used in the following modules:
    - cluster_configuration"
    EOF
    type        = string
}
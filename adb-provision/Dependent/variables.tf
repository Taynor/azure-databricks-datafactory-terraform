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
    is a user that will be added to the workspace as a databricks user. This is a shared 
    variable used in the following modules:
    - ad_group_users"
    EOF
    type        = string
}
variable "ad_dev_group" {
    description = <<EOF
    "This is demo AD user group named AZR-DEVELOPER that will pull it's members. Each member
    is a user that will be added to the workspace as a databricks user. This is a shared 
    variable used in the following modules:
    - ad_group_users"
    EOF
    type        = string
}
variable "ad_devops_group" {
    description = <<EOF
    "This is demo AD user group named AZR-DEVOPS that will pull it's members. Each member
    is a user that will be added to the workspace as a databricks user. This is a shared 
    variable used in the following modules:
    - ad_group_users"
    EOF
    type        = string
}
variable "ad_engineer_group" {
    description = <<EOF
    "This is demo AD user group named AZR-ENGINEER that will pull it's members. Each member
    is a user that will be added to the workspace as a databricks user. This is a shared 
    variable used in the following modules:
    - ad_group_users"
    EOF
    type        = string
}
variable "ad_operations_group" {
    description = <<EOF
    "This is demo AD user group named AZR-OPERATIONS that will pull it's members. Each member
    is a user that will be added to the workspace as a databricks user. This is a shared 
    variable used in the following modules:
    - ad_group_users"
    EOF
    type        = string
}
variable "ad_tester_group" {
    description = <<EOF
    "This is demo AD user group named AZR-TESTER that will pull it's members. Each member
    is a user that will be added to the workspace as a databricks user. This is a shared 
    variable used in the following modules:
    - ad_group_users"
    EOF
    type        = string
}
variable "analyst_group_name" {
    description = <<EOF
    "This is demo workspace group name Analysts, is used to add users that need to inherit
    Analyst level permissions on the workspace. This is a shared variable used in the 
    following modules:
    - workspace_groups
    - workspace_users"
    EOF
    type        = string
}
variable "dev_group_name" {
    description = <<EOF
    "This is demo workspace group name Developers, is used to add users that need to inherit
    Developer level permissions on the workspace. This is a shared variable used in the 
    following modules:
    - workspace_groups
    - workspace_users"
    EOF
    type        = string
}
variable "devops_group_name" {
    description = <<EOF
    "This is demo workspace group name Devops, is used to add users that need to inherit
    Devops level permissions on the workspace. This is a shared variable used in the 
    following modules:
    - workspace_groups
    - workspace_users"
    EOF
    type        = string
}
variable "engineer_group_name" {
    description = <<EOF
    "This is demo workspace group name Engineers, is used to add users that need to inherit
    Engineer level permissions on the workspace. This is a shared variable used in the 
    following modules:
    - workspace_groups
    - workspace_users"
    EOF
    type        = string
}
variable "prod_group_name" {
    description = <<EOF
    "This is demo workspace group name Operations, is used to add users that need to inherit
    Operations level permissions on the workspace. This is a shared variable used in the 
    following modules:
    - workspace_groups
    - workspace_users"
    EOF
    type        = string
}
variable "testers_group_name" {
    description = <<EOF
    "This is demo workspace group name Testers, is used to add users that need to inherit
    Tester level permissions on the workspace. This is a shared variable used in the 
    following modules:
    - workspace_groups
    - workspace_users"
    EOF
    type        = string
}
variable "prod_cluster_name" {
    description = <<EOF
    "This is a demo all purpose cluster named ProdCluster. This is a shared variable used in
    the following modules:
    - cluster"
    EOF
    type        = string
}
variable "analyst_notebook_path" {
    description = <<EOF
    "This is a demo workspace folder path that will host the demo analyst job.
    This is a shared variable used in the following modules:
    - jobs
    - notebooks"
    EOF
    type        = string
}
variable "dev_notebook_path" {
    description = <<EOF
    "This is a demo workspace folder path that will host the demo developer job.
    This is a shared variable used in the following modules:
    - jobs
    - notebooks"
    EOF
    type        = string
}
variable "devops_notebook_path" {
    description = <<EOF
    "This is a demo workspace folder path that will host the demo devops job.
    This is a shared variable used in the following modules:
    - jobs
    - notebooks"
    EOF
    type        = string
}
variable "engineer_notebook_path" {
    description = <<EOF
    "This is a demo workspace folder path that will host the demo engineer job.
    This is a shared variable used in the following modules:
    - jobs
    - notebooks"
    EOF
    type        = string
}
variable "prod_notebook_path" {
    description = <<EOF
    "This is a demo workspace folder path that will host the demo operations job.
    This is a shared variable used in the following modules:
    - jobs
    - notebooks"
    EOF
    type        = string
}
variable "tester_notebook_path" {
    description = <<EOF
    "This is a demo workspace folder path that will host the demo tester job.
    This is a shared variable used in the following modules:
    - jobs
    - notebooks"
    EOF
    type        = string
}
variable "analyst_job_name" {
    description = <<EOF
    "This is a demo job named Analysts job, created for the users in the
    Analyst workspace group. This is a shared variable used in the following modules:
    - jobs"
    EOF
    type        = string
}
variable "dev_job_name" {
    description = <<EOF
    "This is a demo job named Developer job, created for the users in the
    Developer workspace group. This is a shared variable used in the following modules:
    - jobs"
    EOF
    type        = string
}
variable "devops_job_name" {
    description = <<EOF
    "This is a demo job named DevOps job, created for the users in the
    Devops workspace group. This is a shared variable used in the following modules:
    - jobs"
    EOF
    type        = string
}
variable "engineer_job_name" {
    description = <<EOF
    "This is a demo job named Engineers job, created for the users in the
    Engineer workspace group. This is a shared variable used in the following modules:
    - jobs"
    EOF
    type        = string
}
variable "prod_job_name" {
    description = <<EOF
    "This is a demo job named Operations job, created for the users in the
    Operations workspace group. This is a shared variable used in the following modules:
    - jobs"
    EOF
    type        = string
}
variable "tester_job_name" {
    description = <<EOF
    "This is a demo job named Testers job, created for the users in the
    Testers workspace group. This is a shared variable used in the following modules:
    - jobs"
    EOF
    type        = string
}
variable "analyst_path" {
    description = <<EOF
    "This is a demo workspace folder path that will be the root folder for the Analyst
    workspace user group. Objects/resources owned and managed by the Analyst group, will
    be stored here. This is a shared variable used in the following modules:
    - jobs
    - notebooks"
    EOF
    type        = string
}
variable "dev_path" {
    description = <<EOF
    "This is a demo workspace folder path that will be the root folder for the Developer
    workspace user group. Objects/resources owned and managed by the Analyst group, will
    be stored here. This is a shared variable used in the following modules:
    - jobs
    - notebooks"
    EOF
    type        = string
}
variable "devops_path" {
    description = <<EOF
    "This is a demo workspace folder path that will be the root folder for the Devops
    workspace user group. Objects/resources owned and managed by the Analyst group, will
    be stored here. This is a shared variable used in the following modules:
    - jobs
    - notebooks"
    EOF
    type        = string
}
variable "engineer_path" {
    description = <<EOF
    "This is a demo workspace folder path that will be the root folder for the Engineers
    workspace user group. Objects/resources owned and managed by the Analyst group, will
    be stored here. This is a shared variable used in the following modules:
    - jobs
    - notebooks"
    EOF
    type        = string
}
variable "prod_path" {
    description = <<EOF
    "This is a demo workspace folder path that will be the root folder for the Operations
    workspace user group. Objects/resources owned and managed by the Analyst group, will
    be stored here. This is a shared variable used in the following modules:
    - jobs
    - notebooks"
    EOF
    type        = string
}
variable "test_path" {
    description = <<EOF
    "This is a demo workspace folder path that will be the root folder for the Testers
    workspace user group. Objects/resources owned and managed by the Analyst group, will
    be stored here. This is a shared variable used in the following modules:
    - jobs
    - notebooks"
    EOF
    type        = string
}
variable "analyst_users" {
    description = <<EOF
    "This is the demo list of users contained in a list data structure, managed interactively
    with the terraform.tfvars. These users will be become members of the Analyst user group.
    This is a shared variable used in the following modules:
    - workspace_users"
    EOF
    type = list
}
variable "dev_users" {
    description = <<EOF
    "This is the demo list of users contained in a list data structure, managed interactively
    with the terraform.tfvars. These users will be become members of the Developer user group.
    This is a shared variable used in the following modules:
    - workspace_users"
    EOF
    type = list
}
variable "devops_users" {
    description = <<EOF
    "This is the demo list of users contained in a list data structure, managed interactively
    with the terraform.tfvars. These users will be become members of the Devops user group.
    This is a shared variable used in the following modules:
    - workspace_users"
    EOF
    type = list 
}
variable "engineer_users" {
    description = <<EOF
    "This is the demo list of users contained in a list data structure, managed interactively
    with the terraform.tfvars. These users will be become members of the Engineers user group.
    This is a shared variable used in the following modules:
    - workspace_users"
    EOF
    type = list
}
variable "ops_users" {
    description = <<EOF
    "This is the demo list of users contained in a list data structure, managed interactively
    with the terraform.tfvars. These users will be become members of the Operations user group.
    This is a shared variable used in the following modules:
    - workspace_users"
    EOF
    type = list
}
variable "tester_users" {
    description = <<EOF
    "This is the demo list of users contained in a list data structure, managed interactively
    with the terraform.tfvars. These users will be become members of the Testers user group.
    This is a shared variable used in the following modules:
    - workspace_users"
    EOF
    type = list
}
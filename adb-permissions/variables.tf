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
variable "analyst_group_name" {
    description = <<EOF
    "This is demo workspace group name Analysts, is used to add users that need to inherit
    Analyst level permissions on the workspace. This is a shared variable used in the 
    following modules:
    - jobs_permissions
    - workspace_folders_permissions
    - cluster_permissions"
    EOF
    type        = string
}
variable "dev_group_name" {
    description = <<EOF
    "This is demo workspace group name Developers, is used to add users that need to inherit
    Developer level permissions on the workspace. This is a shared variable used in the 
    following modules:
    - jobs_permissions
    - workspace_folders_permissions
    - cluster_permissions"
    EOF
    type        = string
}
variable "devops_group_name" {
    description = <<EOF
    "This is demo workspace group name Devops, is used to add users that need to inherit
    DevOps level permissions on the workspace. This is a shared variable used in the 
    following modules:
    - jobs_permissions
    - workspace_folders_permissions
    - cluster_permissions"
    EOF
    type        = string
}
variable "engineer_group_name" {
    description = <<EOF
    "This is demo workspace group name Engineers, is used to add users that need to inherit
    Engineer level permissions on the workspace. This is a shared variable used in the 
    following modules:
    - jobs_permissions
    - workspace_folders_permissions
    - cluster_permissions"
    EOF
    type        = string
}
variable "prod_group_name" {
    description = <<EOF
    "This is demo workspace group name Operations, is used to add users that need to inherit
    Operations level permissions on the workspace. This is a shared variable used in the 
    following modules:
    - jobs_permissions
    - workspace_folders_permissions
    - cluster_permissions"
    EOF
    type        = string
}
variable "testers_group_name" {
    description = <<EOF
    "This is demo workspace group name Testers, is used to add users that need to inherit
    Tester level permissions on the workspace. This is a shared variable used in the 
    following modules:
    - jobs_permissions
    - workspace_folders_permissions
    - cluster_permissions"
    EOF
    type        = string
}
variable "prod_cluster_name" {
    description = <<EOF
    "This is a demo all purpose cluster named ProdCluster. This is a shared variable used in
    the following modules:
    - cluster_permissions"
    EOF
    type        = string
}
variable "analyst_notebook_path" {
    description = <<EOF
    "This is a demo workspace folder path that will host the demo analyst job.
    This is a shared variable used in the following modules:
    - jobs_permissions"
    EOF
    type        = string
}
variable "dev_notebook_path" {
    description = <<EOF
    "This is a demo workspace folder path that will host the demo developers job.
    This is a shared variable used in the following modules:
    - jobs_permissions"
    EOF
    type        = string
}
variable "devops_notebook_path" {
    description = <<EOF
    "This is a demo workspace folder path that will host the demo devops job.
    This is a shared variable used in the following modules:
    - jobs_permissions"
    EOF
    type        = string
}
variable "engineer_notebook_path" {
    description = <<EOF
    "This is a demo workspace folder path that will host the demo engineers job.
    This is a shared variable used in the following modules:
    - jobs_permissions"
    EOF
    type        = string
}
variable "prod_notebook_path" {
    description = <<EOF
    "This is a demo workspace folder path that will host the demo operations job.
    This is a shared variable used in the following modules:
    - jobs_permissions"
    EOF
    type        = string
}
variable "tester_notebook_path" {
    description = <<EOF
    "This is a demo workspace folder path that will host the demo testers job.
    This is a shared variable used in the following modules:
    - jobs_permissions"
    EOF
    type        = string
}
variable "analyst_job_name" {
    description = <<EOF
    "This is a demo job named Analysts job, created for the users in the Analyst workspace group. 
    Analyst level permissions will be applied to this job, using the Analyst user group. 
    This is a shared variable used in the following modules:
    - jobs_permissions"
    EOF
    type        = string
}
variable "dev_job_name" {
    description = <<EOF
    "This is a demo job named Developers job, created for the users in the Developer workspace 
    group. Developer level permissions will be applied to this job, using the Developer user group. 
    This is a shared variable used in the following modules:
    - jobs_permissions"
    EOF
    type        = string
}
variable "devops_job_name" {
    description = <<EOF
    "This is a demo job named Devops job, created for the users in the Devops workspace group. 
    DevOps level permissions will be applied to this job, using the Devops user group. 
    This is a shared variable used in the following modules:
    - jobs_permissions"
    EOF
    type        = string
}
variable "engineer_job_name" {
    description = <<EOF
    "This is a demo job named Engineers job, created for the users in the Engineers workspace group. 
    Engineer level permissions will be applied to this job, using the Engineer user group. 
    This is a shared variable used in the following modules:
    - jobs_permissions"
    EOF
    type        = string
}
variable "prod_job_name" {
    description = <<EOF
    "This is a demo job named Operations job, created for the users in the Operations workspace group. 
    Operations level permissions will be applied to this job, using the Operations user group. 
    This is a shared variable used in the following modules:
    - jobs_permissions"
    EOF
    type        = string
}
variable "tester_job_name" {
    description = <<EOF
    "This is a demo job named Testers job, created for the users in the Testers workspace group. 
    Tester level permissions will be applied to this job, using the Testers user group. 
    This is a shared variable used in the following modules:
    - jobs_permissions"
    EOF
    type        = string
}
variable "analyst_path" {
    description = <<EOF
    "This is a demo workspace folder path that will be the root folder for the Analyst
    workspace user group. Objects/resources owned and managed by the Analyst group, will
    be stored here. Analyst level permissions will be inherited by the members of the
    Analyst user group. This is a shared variable used in the following modules:
    - workspace_folders_permissions"
    EOF
    type        = string
}
variable "dev_path" {
    description = <<EOF
    "This is a demo workspace folder path that will be the root folder for the Developers
    workspace user group. Objects/resources owned and managed by the Developers group, will
    be stored here. Developer level permissions will be inherited by the members of the
    Developers user group. This is a shared variable used in the following modules:
    - workspace_folders_permissions"
    EOF
    type        = string
}
variable "devops_path" {
    description = <<EOF
    "This is a demo workspace folder path that will be the root folder for the Devops
    workspace user group. Objects/resources owned and managed by the Devops group, will
    be stored here. DevOps level permissions will be inherited by the members of the
    Devops user group. This is a shared variable used in the following modules:
    - workspace_folders_permissions"
    EOF
    type        = string
}
variable "engineer_path" {
    description = <<EOF
    "This is a demo workspace folder path that will be the root folder for the Engineers
    workspace user group. Objects/resources owned and managed by the Engineers group, will
    be stored here. Engineer level permissions will be inherited by the members of the
    Engineers user group. This is a shared variable used in the following modules:
    - workspace_folders_permissions"
    EOF
    type        = string
}
variable "prod_path" {
    description = <<EOF
    "This is a demo workspace folder path that will be the root folder for the Operations
    workspace user group. Objects/resources owned and managed by the Operations group, will
    be stored here. Operations level permissions will be inherited by the members of the
    Operations user group. This is a shared variable used in the following modules:
    - workspace_folders_permissions"
    EOF
    type        = string
}
variable "test_path" {
    description = <<EOF
    "This is a demo workspace folder path that will be the root folder for the Testers
    workspace user group. Objects/resources owned and managed by the Testers group, will
    be stored here. Testers level permissions will be inherited by the members of the
    Testers user group. This is a shared variable used in the following modules:
    - workspace_folders_permissions"
    EOF
    type        = string
}
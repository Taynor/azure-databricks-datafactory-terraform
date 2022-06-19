# Azure Data Factory and Databricks Platform 
This project delivers data engineering technologies from Azure, using Terraform and an Azure DevOps CI/CD pipeline to provision,
configure and maintain the services. The following technologies are used within this solution:
- Azure data lake
- Azure data factory
- Azure Databricks
It also includes the IaaS components to enhance the architecture, for security, governance and best practice:
- Azure IaaS Network
- Key Vault 

At the time of writing, the project Terraform was written and tested using the following providers locked in with their
respective versions:
- hashicorp/azurerm 3.10.0
- databrickslabs/databricks 0.6.0
- hashicorp/azuread 2.23.0

# Project Structure 
The solution is designed to initially be deployed as a single unit, however once deployed the configuration and 
permissions modules can be reused for general maintenance and housekeeping. The deployment is split up into three sections:
- Infrastructure set up:
  - Resource Group

image.png

  - Storage and data lake
  - Network
  - Key Vault

image.png  

- Data engineering service set up for Data Factory and Databricks:
  - Azure Data Factory 
  - Azure Databricks workspace

image.png

image.png

Once the base infrastructure and data engineering services have been deployed, the solution moves onto provisioning the resources in 
Databricks. The resources are separated into two categories:
- Independent (resources that can be deployed to the Databricks workspace without the existence of other resources to associate itself to).
This provisions the Databricks cluster, workspace folders and workspace groups.

image.png

- Dependent (resources that required the independent Databricks resources to be deployed to associate themselves with). This provisions
the AD group users, Notebooks and local workspace users.

image.png

Resources in the adb-provision directory are required for the adb-maintenance and adb-permissions modules to work. 

The next phase of the deployment is deploying the Databricks maintenance resources. This module configures the Databricks cluster, 
and adds users to the groups created in the Databricks provision phase:

image.png

The next phase of the deployment is adding permissions to resources created in the Databricks provision phase. This module adds permissions
to the Databricks cluster, jobs and workspace folders:

image.png

The final phase of the deployment is adding the Azure Data Factory LinkedServices. The LinkedServices are set up for the Data Lake,
Databricks workspace and Key Vault.

image.png

# Known issues
At the time of testing with the provider versions listed above, adding users from Azure AD to the Databricks workspace and
Creating the private network for the Databricks workspace is failing. Testg
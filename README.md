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

![image](https://user-images.githubusercontent.com/59668937/174487096-58544a01-91ab-49cc-9371-d32611ea7d26.png)

  - Storage and data lake
  - Network
  - Key Vault

![image](https://user-images.githubusercontent.com/59668937/174487143-ddfa890a-08cb-4a89-a557-395fbabf0875.png)  

- Data engineering service set up for Data Factory and Databricks:
  - Azure Data Factory 
  - Azure Databricks workspace

![image](https://user-images.githubusercontent.com/59668937/174487188-27f281b0-032a-4c66-8a08-cac654b88645.png)

Once the base infrastructure and data engineering services have been deployed, the solution moves onto provisioning the resources in 
Databricks. The resources are separated into two categories:
- Independent (resources that can be deployed to the Databricks workspace without the existence of other resources to associate itself to).
This provisions the Databricks cluster, workspace folders and workspace groups.
- Dependent (resources that required the independent Databricks resources to be deployed to associate themselves with). This provisions
the AD group users, Notebooks and local workspace users.

![image](https://user-images.githubusercontent.com/59668937/174487251-e4dbf36b-2738-4e75-b330-cb1ece64ee5d.png)

Resources in the adb-provision directory are required for the adb-maintenance and adb-permissions modules to work. 

The next phase of the deployment is deploying the Databricks maintenance resources. This module configures the Databricks cluster, 
and adds users to the groups created in the Databricks provision phase:

![image](https://user-images.githubusercontent.com/59668937/174487281-1e62d5a5-9c1b-4dcf-a963-5cbd633d395a.png)

The next phase of the deployment is adding permissions to resources created in the Databricks provision phase. This module adds permissions
to the Databricks cluster, jobs and workspace folders:

![image](https://user-images.githubusercontent.com/59668937/174487304-c3b677b1-1544-4fba-9238-eb331790df8b.png)

The final phase of the deployment is adding the Azure Data Factory LinkedServices. The LinkedServices are set up for the Data Lake,
Databricks workspace and Key Vault.

![image](https://user-images.githubusercontent.com/59668937/174487323-aa2a3583-1e6c-45e4-8da4-02ffb328fdb2.png)

# Known issues
At the time of testing with the provider versions listed above, adding users from Azure AD to the Databricks workspace and
Creating the private network for the Databricks workspace is failing. Testing is ongoing to confirm when these features/functionality can
be enabled in the project. The Terraform resources have been commented out, in the main.tf parent configuration files in the following modules:
- adb-provision
- adb-maintenance
- adb-permissions
- terraform-infra/network

# How to use
To use the solution the following resources would need to be available in an Azure subscription to deploy via an Azure DevOps pipeline:
- Service Principal
- Azure DevOps project to upload the code and create an Azure DevOps pipeline from
- Resource group to store the Terraform remote state
The service principal will need the following API permissions set in Azure AD to deploy via the Azure DevOps pipeline:

![image](https://user-images.githubusercontent.com/59668937/174487853-5400d663-90d2-4f3f-8be9-ff647c4db740.png)

The resource group will need to host a storage account, set up with containers to store the Terraform state. The Terraform is designed to execute as 
individual modules, so a container would be needed for each module:

![image](https://user-images.githubusercontent.com/59668937/174488042-ebf6a304-e522-4aa4-be46-84be42de663b.png)

The XXX-build.yml and XXX-release.yml files need the resource group, storage account and container name set up to reflect what will be in the resource group
to store the remote state:

For the XXX-build.yml file from lines 13 - 15

![image](https://user-images.githubusercontent.com/59668937/174488115-116f45c8-618b-495c-b80f-53c5681ea127.png)

For the XXX-release.yml file from lines 30 - 32

![image](https://user-images.githubusercontent.com/59668937/174488156-b97b9361-9540-4f87-8092-63a4072acf8c.png)

The service principal name will need to be changed in those respective files on lines 12 for the XXX-build.yml and 29 for the XXX-release.yml. To set up the
secret of the service principal in the Azure DevOps pipeline. The values have been stored in a variable group, with the following names:

![image](https://user-images.githubusercontent.com/59668937/174488430-9726829d-3e29-49d5-906c-2687d5dc3cc9.png)

- TF_VAR_CLIENT_ID (service principal ID)
- TF_VAR_SECRET (service principal secret)
- TF_VAR_SUB (Azure subscription ID where the solution will be deployed to)
- TF_VAR_TENANT_ID (Azure tenant ID where the solution will be deployed to)

The capitalisation of the service principal details are required in order for the Azure DevOps pipeline to pass these values to the Terraform configuration files.
Do not amend the capitalisation, only set the necessary values.

In the Azure-Pipeline.yml file checkov is used to test and review the configuration. A number of checks have been skipped as part of the solution, as they
have been reviewed as not being relevant for the solution. Add and remove the checks you feel are necessary, understanding doing so is at your own risk and must pass the checkov assessment.

![image](https://user-images.githubusercontent.com/59668937/174488684-2336dc91-5b8b-472a-9626-58f675bd02e8.png)

Set the email address that needs to be notified when the checkov assessment completes to receive the notification to manually review the report. Set this at line 32
adding how many other email addresses as you require on each separate line with the same indentation.

To set up the Terraform file for configuration, set the desired values within the terraform.tfvars file. The following example is what is used for resource group:

![image](https://user-images.githubusercontent.com/59668937/174488823-7fcdb4c3-b7ea-4a14-b1e7-efe97bcc2159.png)

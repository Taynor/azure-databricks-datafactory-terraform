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
be enabled in the project. Provisioning a linked service connection for Databricks using the managed service identity, is not supported in this version of the solution. A guide on how to configure this is included, until this feature has been added. The Terraform resources have been commented out, in the main.tf parent configuration files in the following modules:
- adb-provision
- adb-maintenance
- adb-permissions
- terraform-infra/network
- linkedservice

# Prepare to use
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
to store the remote state. The service principal will need the following permissions applied in advance, to ensure it can read and write to the terraform.tfvars state file:

![image](https://user-images.githubusercontent.com/59668937/174902677-771969d0-0a43-4958-9b00-930e13c2eb32.png)

Ensure in the following YAML XXX-build.yml and XXX-release.yml files that the resource group, storage account and container have been set up with the same matching values:

For the XXX-build.yml file from lines 13 - 15

![image](https://user-images.githubusercontent.com/59668937/174488115-116f45c8-618b-495c-b80f-53c5681ea127.png)

For the XXX-release.yml file from lines 30 - 32

![image](https://user-images.githubusercontent.com/59668937/174488156-b97b9361-9540-4f87-8092-63a4072acf8c.png)

The service principal name will need to be changed in those respective files on lines 12 for the XXX-build.yml and 29 for the XXX-release.yml. To set up the
secret of the service principal in the Azure DevOps pipeline. The values have been stored in an Azure DevOps variable group (located under pipelines --> library), with the following names:

![image](https://user-images.githubusercontent.com/59668937/174488430-9726829d-3e29-49d5-906c-2687d5dc3cc9.png)

- TF_VAR_CLIENT_ID (service principal ID)
- TF_VAR_SECRET (service principal secret)
- TF_VAR_SUB (Azure subscription ID where the solution will be deployed to)
- TF_VAR_TENANT_ID (Azure tenant ID where the solution will be deployed to)

The capitalisation of the service principal details are required in order for the Azure DevOps pipeline to pass these values to the Terraform configuration files.
Do not amend the capitalisation, only set the necessary values.

The values from the Azure DevOps variable group, are pulled into the Azure-pipelines.yml file using the variables --> group YAML property. The name of the variable group can be changed, but needs to be reflected in the Azure-pipelines.yml file and the variables group --> library name as well.

![image](https://user-images.githubusercontent.com/59668937/174555782-8d643cea-87b2-4086-9bff-9de8318d5c2e.png)

In the Azure-Pipeline.yml file checkov is used to test and review the configuration. A number of checks have been skipped as part of the solution, as they
have been reviewed as not being relevant for the solution. Add and remove the checks you feel are necessary, understanding doing so is at your own risk and must pass the checkov assessment.

![image](https://user-images.githubusercontent.com/59668937/174488684-2336dc91-5b8b-472a-9626-58f675bd02e8.png)

Set the email address that needs to be notified when the checkov assessment completes to receive the notification to manually review the report. Set this at line 32
adding how many other email addresses as you require on each separate line with the same indentation.

To set up the Terraform file for configuration, set the desired values within the terraform.tfvars file. The following example is what is used for resource group:

![image](https://user-images.githubusercontent.com/59668937/174488823-7fcdb4c3-b7ea-4a14-b1e7-efe97bcc2159.png)

# How to use
The following example uses Azure DevOps as the repo to store the code, and execute the CI/CD pipeline. The pipeline will use the Azure-pipeline.yml file to execute the deployment. The following steps will be used to set up the pipeline:

- Click on Pipelines on the left hand side 



![image](https://user-images.githubusercontent.com/59668937/174559454-3ea5a73d-fadb-41e7-a0eb-e570f9a0b80d.png)

- Click on New pipeline on the right hand side



![image](https://user-images.githubusercontent.com/59668937/174559713-c7411d84-84e3-42ca-8a91-3a013b128d96.png)

- Choose Azure Repos Git YML



![image](https://user-images.githubusercontent.com/59668937/174559866-ec78a171-bcbb-4aa0-afbe-17a6fc63c04e.png)

- Choose the repo that you have uploaded the code to

![image](https://user-images.githubusercontent.com/59668937/174560187-205385f7-45c2-4648-ba2c-a7322c2fa86f.png)

- Choose Existing Azure Pipeline YAML file



![image](https://user-images.githubusercontent.com/59668937/174560365-fb67fd66-e148-4ff7-9c24-071b5e1a0c73.png)

- Choose the respective branch (if different from the main branch) and select the Azure-Pipeline.yml file, and click on Continue



![image](https://user-images.githubusercontent.com/59668937/174560982-1abedf79-f1e4-47a0-ac59-4ec60da71d0c.png)

- Click on Run



![image](https://user-images.githubusercontent.com/59668937/174561236-b1bb6689-d238-41dc-9e76-d4a72ad2fb5b.png)

- The pipeline will begin to run



![image](https://user-images.githubusercontent.com/59668937/174561385-3f70ff67-aa9b-4a93-aaf5-65afcff6c766.png)

- The checkov task will require the engineer to approve the checkov report, click in Stage to review ther report output



![image](https://user-images.githubusercontent.com/59668937/174561610-b0cbc6d1-5706-470b-9606-5aacc2d48ff4.png)

- Click on Bash to expose the report to the verbose screen on the right hand side



![image](https://user-images.githubusercontent.com/59668937/174561916-d5cb1c71-938e-4fa9-abfb-f7378d9896f2.png)

- Review the report to ensure you're happy with the results before proceeding



![image](https://user-images.githubusercontent.com/59668937/174562056-35b2bec4-8f10-46cf-bfed-57ad4ada7bcb.png)

- Once the review is complete, click on ManualValidation under the check_checkov_results nesting



![image](https://user-images.githubusercontent.com/59668937/174562366-0839ad7c-2a37-4b0e-95ad-92922b198190.png)

- Click on Review on the right hand side



![image](https://user-images.githubusercontent.com/59668937/174562483-aed692ac-31df-4def-bdc9-032e660f2500.png)

- Enter a comment to reflect the checkov report assessment, and click on Resume



![image](https://user-images.githubusercontent.com/59668937/174562665-d6791403-1945-4daa-b933-5768268dfdc6.png)

- The pipleine will continue to run, it will take approximately 30 minutes to complete. Afterward go into the Azure Portal to start using the solution



![image](https://user-images.githubusercontent.com/59668937/174558791-9b7f0b72-7852-4c65-adb3-eeacbf347c0f.png)

Once the deployment is complete, additional configuration in setting up Databricks mounts to the Data lake and linked service is required. The following steps will go through what is required to get this completed. Firstly create the secret scope for the Databricks workspace, the following guide from Microsoft details how to do so using a key vault backed scope. Which is what this solution has been configured to use:

https://docs.microsoft.com/en-us/azure/databricks/security/secrets/secret-scopes

Once this is done, to configure the Databricks linked service in Azure Data Factory complete the following steps:

- Select Azure Data Factory in the Azure Portal from the resource group blade

![image](https://user-images.githubusercontent.com/59668937/175060838-66c59236-ad6b-4bef-a35c-4fed30904fff.png)


![image](https://user-images.githubusercontent.com/59668937/175061098-33b30483-d515-496b-b92c-161334d7da82.png)

- Click on Managed Identites on the left hand side

![image](https://user-images.githubusercontent.com/59668937/175061750-9cfd3460-aeda-4cba-9f06-3779a1cd8958.png)

- Ensure that System Assigned is selected, and change the status to On and Save

![image](https://user-images.githubusercontent.com/59668937/175062451-e0792375-3bbd-42fe-a04b-f5944aeff0ab.png)

- Confirme enabling the MSI feature

![image](https://user-images.githubusercontent.com/59668937/175062718-8f1b5a89-8d72-4de3-9f37-6b711e646ae6.png)

- Click on Azure Role Assignments

![image](https://user-images.githubusercontent.com/59668937/175063006-8adf64ea-8e04-4c47-9f30-cb00c6cf5e4c.png)

- Ensure the correct subscription is selected and click on Add Role Assignment plus sign






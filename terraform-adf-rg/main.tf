resource "azurerm_resource_group" "adf-rg-name" {
  name     = var.resource_group_name
  location = var.resource_group_location
  tags = {
    TerraformManaged = true
    Project          = "Ronyat Solutions"
    Repo             = "https://dev.azure.com/taynor/IaC%20and%20DevOps/_git/adf-adb-stack-tf"
    Environment      = "Development"
    Created          = timestamp()
  }
}
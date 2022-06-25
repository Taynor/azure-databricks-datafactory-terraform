resource "azurerm_resource_group" "adf-rg-name" {
  name     = var.resource_group_name
  location = var.resource_group_location
  tags = {
    TerraformManaged = true
    Project          = "Project Name"
    Repo             = "repo URL"
    Environment      = "Development"
    Created          = timestamp()
  }
}
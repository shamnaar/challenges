resource "azurerm_resource_group" "rg" {
  name = "test-rg"
  location = var.location
}
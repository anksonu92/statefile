resource "azurerm_storage_account" "lens" {
  name                     = format("%s%s", var.storage_account.name, random_integer.suffix.result)
  resource_group_name      =  var.resource_group_name
  location                 = var.location
  account_tier             = var.storage_account.tier
  account_replication_type = var.storage_account.replication_type

  tags = var.tags

}

resource "azurerm_storage_container" "lens" {
  name                  = "statefile"
  storage_account_name  = azurerm_storage_account.lens.name
  container_access_type = "private"
}



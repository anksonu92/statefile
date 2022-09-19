output "storage_account" {
    description = "storage account resource"
    value={
        storage_account_name =azurerm_storage_account.lens.name
        container_name       = azurerm_storage_container.lens.name
    }
}


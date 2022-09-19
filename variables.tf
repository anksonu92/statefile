variable "resource_group_name" {
  description = "The name of the resource group where modules resources will be deployed. The resource group location will be used for all resources in this module as well."
  type        = string
}

variable "location" {
  description = "The Azure region where the resources will be deployed."
  type        = string
}


variable "tags" {
  description = "Tags to set for all resources"
  type        = map(string)
  default = {
    Team        = "analytics",
    Application = "analytics",
    Department  = "it"
  }
}

variable "storage_account" {
  description = "Details of Storage Account DataLake to create. Note there are two access models: 'rbac' and 'sas'. RBAC is preferred, but requires the user or service principal who is running Terraform to be assigned at minimum 'Owner' role on the Resource Group where LENS is deployed (Subscription Owner role would work as well as it would be inherited by the Resource Group)."
  type = object({
    name                   = string
    tier                   = string
    replication_type       = string
  })
  default = {
    name                   = "lensdatalake"
    tier                   = "Standard"
    replication_type       = "LRS"
  }
}
/*
  validation {
    condition = (
      length(var.datalake.name) <= 19 &&
      length(var.datalake.name) >= 3 &&
      length(regexall("[^\\w]", var.datalake.name)) == 0 &&
      contains(["sas", "rbac"], var.datalake.access_model) &&
      can(var.datalake.access_model == "rbac" ?
        (
          can({ for k, v in var.datalake.rbac_roles : k => contains([
            "Storage Blob Data Reader",
            "Storage Blob Data Contributor",
            "Storage Blob Data Owner"
          ], v.role_definition_name) if length(var.datalake.rbac_roles) > 0 })
        ) : true
      )
    )
    error_message = "Please check your var.datalake object to ensure compatibility."
  }
}

*/
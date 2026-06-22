variable "name" {
  description = "Name of the Function App"
  type        = string
}

variable "location" {
  description = "Azure region where the Function App will be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "os_type" {
  description = "Type of the operating system"
  type        = string
}

variable "sku_name" {
  description = "Name of the SKU"
  type        = string
}

variable "tags" {
  description = "Tags to associate with the Function App"
  type        = map(string)
}
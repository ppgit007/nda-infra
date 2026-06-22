variable "name" {
  description = "Name of the Service Bus Namespace"
  type        = string
}

variable "location" {
  description = "Azure region where the Service Bus Namespace will be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "sku" {
  description = "SKU of the Service Bus Namespace"
  type        = string
  default     = "Standard"
}

variable "tags" {
  description = "Tags to associate with the Service Bus Namespace"
  type        = map(string)
}
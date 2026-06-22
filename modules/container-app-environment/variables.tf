variable "name" {
  description = "Name of the Container App Environment"
  type        = string
}

variable "location" {
  description = "Azure region where the Container App Environment will be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "tags" {
  description = "Tags to associate with the Container App Environment"
  type        = map(string)
}
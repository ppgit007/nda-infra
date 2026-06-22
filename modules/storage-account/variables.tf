variable "name" {
  description = "Name of the Storage Account"
  type        = string
}

variable "location" {
  description = "Azure region where the Storage Account will be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "account_tier" {
  description = "Tier of the Storage Account"
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "Replication type of the Storage Account"
  type        = string
  default     = "LRS"
}

variable "tags" {
  description = "Tags to associate with the Storage Account"
  type        = map(string)
}
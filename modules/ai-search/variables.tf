variable "name" {
  description = "Azure AI Search service name"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for AI Search"
  type        = string
}

variable "sku" {
  description = "AI Search SKU"
  type        = string
  default     = "basic"
}

variable "replica_count" {
  description = "Replica count for AI Search"
  type        = number
  default     = 1
}

variable "partition_count" {
  description = "Partition count for AI Search"
  type        = number
  default     = 1
}

variable "tags" {
  description = "Tags for AI Search"
  type        = map(string)
  default     = {}
}

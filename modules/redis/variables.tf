variable "name" {
  description = "Name of the Redis Cache"
  type        = string
}

variable "location" {
  description = "Azure region where the Redis Cache will be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "capacity" {
  description = "Capacity of the Redis Enterprise Cluster"
  type        = number
  default     = 1
}

variable "sku_name" {
  description = "SKU of the Redis Enterprise Cluster"
  type        = string
  default     = "Basic"
}

variable "shard_count" {
  description = "Shard count for the Redis Enterprise Cluster"
  type        = number
  default     = 1
}

variable "tags" {
  description = "Tags to associate with the Redis Cache"
  type        = map(string)
}
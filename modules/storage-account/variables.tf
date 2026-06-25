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

variable "network_rules_default_action" {
  description = "Default action for the Storage Account network rules when no rule matches (Deny/Allow)"
  type        = string
  default     = "Deny"
}

variable "network_rules_bypass" {
  description = "Traffic that can bypass the network rules (e.g. AzureServices, Logging, Metrics)"
  type        = list(string)
  default     = ["AzureServices"]
}

variable "network_rules_ip_rules" {
  description = "List of public IP or CIDR ranges allowed to access the Storage Account"
  type        = list(string)
  default     = []
}

variable "network_rules_subnet_ids" {
  description = "List of subnet IDs allowed to access the Storage Account"
  type        = list(string)
  default     = []
}
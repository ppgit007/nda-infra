variable "name" {
  description = "Name of the Key Vault"
  type        = string
}

variable "location" {
  description = "Azure region where the Key Vault will be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}

variable "tags" {
  description = "Tags to associate with the Key Vault"
  type        = map(string)
}

variable "network_acls_default_action" {
  description = "Default action for the Key Vault network ACL when no rule matches (Deny/Allow)"
  type        = string
  default     = "Deny"
}

variable "network_acls_bypass" {
  description = "Traffic that can bypass the network ACL (AzureServices/None)"
  type        = string
  default     = "AzureServices"
}

variable "network_acls_ip_rules" {
  description = "List of public IP or CIDR ranges allowed to access the Key Vault"
  type        = list(string)
  default     = []
}

variable "network_acls_subnet_ids" {
  description = "List of subnet IDs allowed to access the Key Vault"
  type        = list(string)
  default     = []
}
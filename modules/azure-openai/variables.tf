variable "name" {
  description = "Azure OpenAI account name"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for Azure OpenAI"
  type        = string
}

variable "sku_name" {
  description = "Azure OpenAI SKU name"
  type        = string
  default     = "S0"
}

variable "custom_subdomain_name" {
  description = "Custom subdomain required for managed-identity auth"
  type        = string
}

variable "deployments" {
  description = "Model deployments to create in the Azure OpenAI account"
  type = list(object({
    name          = string
    model_name    = string
    model_version = string
    sku_name      = optional(string, "GlobalStandard")
    sku_capacity  = optional(number, 10)
  }))
  default = []
}

variable "tags" {
  description = "Tags for Azure OpenAI"
  type        = map(string)
  default     = {}
}

variable "name" {
  description = "Name of the Application Insights resource"
  type        = string
}

variable "location" {
  description = "Azure region where the Application Insights will be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "application_type" {
  description = "Type of application for Application Insights"
  type        = string
  default     = "web"
}

variable "tags" {
  description = "Tags to associate with the Application Insights resource"
  type        = map(string)
}
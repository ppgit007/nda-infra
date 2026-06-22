variable "name" {
  description = "Name of the Container App"
  type        = string
}

variable "location" {
  description = "Azure region where the Container App will be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "container_app_environment_id" {
  description = "ID of the container app environment"
  type        = string
}

variable "image" {
  description = "Container image to deploy"
  type        = string
}

variable "cpu" {
  description = "CPU allocation for the container"
  type        = number
  default     = 0.5
}

variable "memory" {
  description = "Memory allocation for the container"
  type        = string
  default     = "1Gi"
}

variable "tags" {
  description = "Tags to associate with the Container App"
  type        = map(string)
}

variable "identity_ids" {
  description = "List of user-assigned identity IDs to attach to the Container App"
  type        = list(string)
  default     = []
}

variable "registry_server" {
  description = "Container registry server for private image pulls"
  type        = string
  default     = ""
}

variable "registry_username" {
  description = "Container registry username for private image pulls"
  type        = string
  default     = ""
}

variable "registry_password" {
  description = "Container registry password for private image pulls"
  type        = string
  default     = ""
}

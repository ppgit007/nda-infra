variable "project" {
  description = "Project name to be used in resource naming"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, qa, prod)"
  type        = string
}

variable "component" {
  description = "Component name to be used in resource naming"
  type        = string
}
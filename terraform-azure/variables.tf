variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = "rg-fastapi-react-fullstack"
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
  default     = "West US 2"
}

variable "project_name" {
  description = "Name of the project, used as prefix for resources"
  type        = string
  default     = "fastapi-react"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
  
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

variable "owner" {
  description = "Owner of the resources"
  type        = string
  default     = "DevOps-Team"
}

variable "vm_size" {
  description = "Size of the Virtual Machine"
  type        = string
  default     = "Standard_B2s"
}

variable "admin_username" {
  description = "Admin username for the Virtual Machine"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key" {
  description = "SSH public key for VM access"
  type        = string
  # This should be provided via terraform.tfvars or environment variable
}

variable "allowed_ssh_sources" {
  description = "List of IP addresses/CIDR blocks allowed to SSH to the VM"
  type        = list(string)
  default     = ["0.0.0.0/0"] # Warning: This allows SSH from anywhere. Restrict in production.
}

variable "domain_name" {
  description = "Domain name for the application (optional)"
  type        = string
  default     = ""
}


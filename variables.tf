variable "enable_vpc" {
  type        = bool
  default     = true
  description = "Create VPC or not?"
}

variable "vpc_cidr" {
  type        = string
  description = "Valid AWS VPC CIDR block"
}

variable "prefix" {
  type        = string
  description = "Prefix to all resources in the module"
}

variable "tags" {
  type        = map(string)
  description = "Tags which are going to be attached to all resources"
  default     = {}
}

variable "vpc_tags" {
  type        = map(string)
  description = "Tags which are going to be attached to VPC resource only"
  default     = {}
}

variable "enable_dns_support" {
  type        = bool
  default     = true
  description = "Enable/disable DNS Support in the VPC"
}


variable "enable_dns_hostnames" {
  type        = bool
  default     = false
  description = "Enable/disable DNS Hostnames in the VPC"
}
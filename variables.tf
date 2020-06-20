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

variable "public_subnets" {
  type        = map(string)
  default     = {}
  description = "CIDR blocks for subnets"
}

variable "private_subnets" {
  type        = map(string)
  default     = {}
  description = "CIDR blocks for subnets"
}

variable "db_subnets" {
  type        = map(string)
  default     = {}
  description = "CIDR blocks for subnets"
}

variable "assign_public_ips_on_launch" {
  type        = bool
  default     = true
  description = "Will resources in public subnets get public IP during creation?"
}

variable "subnet_tags" {
  type        = map(string)
  description = "Tags which are going to be attached to all subnets"
  default     = {}
}

variable "public_subnet_tags" {
  type        = map(string)
  description = "Tags which are going to be attached to all public subnets"
  default     = {}
}

variable "private_subnet_tags" {
  type        = map(string)
  description = "Tags which are going to be attached to all private subnets"
  default     = {}
}

variable "db_subnet_tags" {
  type        = map(string)
  description = "Tags which are going to be attached to all DB subnets"
  default     = {}
}

variable "custom_eips_for_nat" {
  type        = map(string)
  default     = {}
  description = "Pass custom EIPs if you have some already, otherwise they will be created by the module"
}

variable "create_dynamodb_vpc_endpoint" {
  type        = bool
  default     = true
  description = "Create VPC enpoint associated with private subnets"
}

variable "create_s3_vpc_endpoint" {
  type        = bool
  default     = true
  description = "Create VPC enpoint associated with private subnets"
}

variable "create_secrets_manager_vpc_endpoint" {
  type        = bool
  default     = true
  description = "Create VPC enpoint associated with private subnets"
}
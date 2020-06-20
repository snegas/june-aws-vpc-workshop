locals {
  create_vpc                     = var.enable_vpc ? 1 : 0
  create_eips                    = length(var.custom_eips_for_nat) == 0 ? var.private_subnets : {}
  create_if_public_subnets_exist = length(var.public_subnets) > 0 ? 1 : 0

  create_dynamodb_vpc_endpoint        = var.create_dynamodb_vpc_endpoint ? 1 : 0
  create_s3_vpc_endpoint              = var.create_s3_vpc_endpoint ? 1 : 0
  create_secrets_manager_vpc_endpoint = var.create_secrets_manager_vpc_endpoint ? 1 : 0
}
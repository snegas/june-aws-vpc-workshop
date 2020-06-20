resource "aws_vpc" "default" {
  count = local.create_vpc

  cidr_block = var.vpc_cidr

  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = merge(var.tags, var.vpc_tags, {
    Name = "${var.prefix}-vpc"
  })
}
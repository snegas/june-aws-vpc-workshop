data "aws_region" "current" {}

resource "aws_subnet" "public" {
  for_each = var.public_subnets

  vpc_id                  = aws_vpc.default[0].id
  cidr_block              = each.value
  map_public_ip_on_launch = var.assign_public_ips_on_launch
  availability_zone       = "${data.aws_region.current.name}${each.key}"

  tags = merge(var.tags, var.subnet_tags, var.public_subnet_tags, {
    Name = "${var.prefix}-public-${each.key}"
  })
}

resource "aws_subnet" "private" {
  for_each = var.private_subnets

  vpc_id                  = aws_vpc.default[0].id
  cidr_block              = each.value
  map_public_ip_on_launch = false
  availability_zone       = "${data.aws_region.current.name}${each.key}"

  tags = merge(var.tags, var.subnet_tags, var.private_subnet_tags, {
    Name = "${var.prefix}-private-${each.key}"
  })
}

resource "aws_subnet" "db" {
  for_each = var.db_subnets

  vpc_id                  = aws_vpc.default[0].id
  cidr_block              = each.value
  map_public_ip_on_launch = false
  availability_zone       = "${data.aws_region.current.name}${each.key}"

  tags = merge(var.tags, var.subnet_tags, var.db_subnet_tags, {
    Name = "${var.prefix}-db-${each.key}"
  })
}
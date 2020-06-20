resource "aws_eip" "default" {
  for_each = local.create_eips

  vpc = true
  tags = merge(var.tags, {
    Name = "${var.prefix}-eip-${each.key}"
  })
}

resource "aws_nat_gateway" "default" {
  depends_on = [aws_internet_gateway.default]

  for_each = var.private_subnets

  subnet_id     = aws_subnet.public[each.key].id
  allocation_id = length(var.custom_eips_for_nat) == 0 ? aws_eip.default[each.key].id : var.custom_eips_for_nat[each.key]

  tags = merge(var.tags, {
    Name = "${var.prefix}-nat-${each.key}"
  })
}

resource "aws_internet_gateway" "default" {
  count = local.create_if_public_subnets_exist

  vpc_id = aws_vpc.default[0].id

  tags = merge(var.tags, {
    Name = "${var.prefix}-igw"
  })
}
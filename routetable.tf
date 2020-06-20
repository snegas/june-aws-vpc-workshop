resource "aws_route_table" "db" {
  for_each = var.db_subnets

  vpc_id = aws_vpc.default[0].id

  tags = merge(var.tags, {
    Name = "${var.prefix}-db-rt"
  })
}

resource "aws_route_table_association" "db" {
  depends_on = [aws_route_table.db]
  for_each   = var.db_subnets

  subnet_id      = aws_subnet.db[each.key].id
  route_table_id = aws_route_table.db[each.key].id
}

///////////////////////////////////////////////////////////////

resource "aws_route_table" "private" {
  for_each = var.private_subnets

  vpc_id = aws_vpc.default[0].id

  tags = merge(var.tags, {
    Name = "${var.prefix}-private-rt"
  })
}

resource "aws_route_table_association" "private" {
  depends_on = [aws_route_table.private]
  for_each   = var.private_subnets

  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private[each.key].id
}

resource "aws_route" "private" {
  for_each = var.private_subnets

  route_table_id         = aws_route_table.private[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.default[each.key].id

  timeouts {
    create = "5m"
  }
}

///////////////////////////////////////////////////////////////

resource "aws_route_table" "public" {
  count = local.create_if_public_subnets_exist

  vpc_id = aws_vpc.default[0].id

  tags = merge(var.tags, {
    Name = "${var.prefix}-public-rt"
  })
}

resource "aws_route_table_association" "public" {
  depends_on = [aws_route_table.public]
  for_each   = var.public_subnets

  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public[0].id
}

resource "aws_route" "public" {
  for_each = local.create_if_public_subnets_exist

  route_table_id         = aws_route_table.public[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.default[0].id

  timeouts {
    create = "5m"
  }
}
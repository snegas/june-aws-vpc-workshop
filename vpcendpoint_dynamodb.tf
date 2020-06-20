data "aws_vpc_endpoint_service" "dynamodb" {
  service = "dynamodb"
}

resource "aws_vpc_endpoint" "dynamodb" {
  count        = local.create_dynamodb_vpc_endpoint
  service_name = data.aws_vpc_endpoint_service.dynamodb.service_name
  vpc_id       = aws_vpc.default[0].id

  vpc_endpoint_type = "Gateway"

  tags = {
    Name = "${aws_vpc.default[0].id}-dynamodb-endpoint"
  }
}

resource "aws_vpc_endpoint_route_table_association" "dynamodb" {
  for_each = toset(tolist(values(aws_route_table.private)[*].id))

  route_table_id  = each.value
  vpc_endpoint_id = aws_vpc_endpoint.dynamodb[0].id
}
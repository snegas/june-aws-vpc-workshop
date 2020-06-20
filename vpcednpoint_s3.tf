data "aws_vpc_endpoint_service" "s3" {
  service = "s3"
}

resource "aws_vpc_endpoint" "s3" {
  count        = local.create_s3_vpc_endpoint
  service_name = data.aws_vpc_endpoint_service.s3.service_name
  vpc_id       = aws_vpc.default[0].id

  vpc_endpoint_type = "Gateway"

  tags = {
    Name = "${aws_vpc.default[0].id}-s3-endpoint"
  }
}

resource "aws_vpc_endpoint_route_table_association" "s3" {
  for_each = toset(tolist(values(aws_route_table.private)[*].id))

  route_table_id  = each.value
  vpc_endpoint_id = aws_vpc_endpoint.s3[0].id
}
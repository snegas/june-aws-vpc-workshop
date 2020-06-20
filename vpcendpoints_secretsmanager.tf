data "aws_vpc_endpoint_service" "secretsmanager" {
  service = "secretsmanager"
}

resource "aws_vpc_endpoint" "secretsmanager" {
  count        = local.create_secrets_manager_vpc_endpoint
  service_name = data.aws_vpc_endpoint_service.secretsmanager.service_name
  vpc_id       = aws_vpc.default[0].id

  vpc_endpoint_type  = "Interface"
  security_group_ids = [aws_security_group.vpcendpoints.id]

  tags = {
    Name = "${aws_vpc.default[0].id}-secretsmanager-endpoint"
  }
}

resource "aws_vpc_endpoint_route_table_association" "secretsmanager" {
  for_each = toset(tolist(values(aws_route_table.private)[*].id))

  route_table_id  = each.value
  vpc_endpoint_id = aws_vpc_endpoint.s3[0].id
}
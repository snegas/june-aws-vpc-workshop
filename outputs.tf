output "this_vpc_id" {
  value = aws_vpc.default[0].id
}

output "public_subnets" {
  value = {
    ids = values(aws_subnet.public)[*].id
    arn = values(aws_subnet.public)[*].arn
  }
}

output "private_subnets" {
  value = {
    ids = values(aws_subnet.private)[*].id
    arn = values(aws_subnet.private)[*].arn
  }
}

output "db_subnets" {
  value = {
    ids = values(aws_subnet.db)[*].id
    arn = values(aws_subnet.db)[*].arn
  }
}
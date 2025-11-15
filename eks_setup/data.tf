data "aws_vpc" "vpc_id" {
  tags = {
    Name = "IlluminatiProject"
  }
}

data "aws_route_table" "public_route_table" {
  tags = {
    Name = "public_route_table_dev"
  }
}

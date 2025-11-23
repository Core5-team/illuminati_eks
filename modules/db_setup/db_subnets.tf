resource "aws_subnet" "db_private_subnet_1" {
  vpc_id            = var.vpc_id
  cidr_block        = var.db_private_subnet_1
  availability_zone = var.db_availability_zone_1
}

resource "aws_subnet" "db_private_subnet_2" {
  vpc_id            = var.vpc_id
  cidr_block        = var.db_private_subnet_2
  availability_zone = var.db_availability_zone_2
}

#TODO
#Databases should not be open to the whole world.
resource "aws_route_table_association" "subnet_a" {
  subnet_id      = aws_subnet.subnet_a.id
  route_table_id = var.public_route_table_id
}

resource "aws_route_table_association" "subnet_b" {
  subnet_id      = aws_subnet.subnet_b.id
  route_table_id = var.public_route_table_id
}


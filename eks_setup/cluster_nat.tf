resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "${var.environment_name}-${var.eks_cluster_name}-nat"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_zone1.id

  tags = {
    Name = "${var.environment_name}-${var.eks_cluster_name}-nat"
  }
}

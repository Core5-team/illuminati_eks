resource "aws_security_group" "rds_sg" {
  name_prefix = "rds-"

  vpc_id = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.private_cluster_cidr_block_1, var.private_cluster_cidr_block_2]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "my_db_subnet_group" {
  name       = "illuminati-db-subnet-group"
  subnet_ids = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]

  tags = {
    Name = "My DB Subnet Group"
  }
}

resource "aws_db_instance" "illuminati_db" {
  allocated_storage      = 10
  db_name                = "illuminaties"
  engine                 = "mariadb"
  instance_class         = "db.t3.micro"
  username               = var.db_username
  password               = var.db_password
  storage_type           = "gp2"
  engine_version         = "10.11"
  publicly_accessible    = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.my_db_subnet_group.name
  skip_final_snapshot    = true

}

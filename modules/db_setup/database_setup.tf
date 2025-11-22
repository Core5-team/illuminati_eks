resource "aws_subnet" "subnet_a" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.21.0/24"
  availability_zone = "eu-central-1a"
}

resource "aws_subnet" "subnet_b" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.22.0/24"
  availability_zone = "eu-central-1b"
}

resource "aws_route_table_association" "subnet_a" {
  subnet_id      = aws_subnet.subnet_a.id
  route_table_id = var.public_route_table_id
}

resource "aws_route_table_association" "subnet_b" {
  subnet_id      = aws_subnet.subnet_b.id
  route_table_id = var.public_route_table_id
}


resource "aws_security_group" "rds_sg" {
  name_prefix = "rds-"

  vpc_id = var.vpc_id

  # Add any additional ingress/egress rules as needed
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "my_db_subnet_group" {
  name       = "my-db-subnet-group"
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
  username               = ""
  password               = ""
  storage_type           = "gp2"
  engine_version         = "10.11"
  publicly_accessible    = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.my_db_subnet_group.name
  #   apply_immediately      = true
  #   final_snapshot_identifier = "illum-snp"
  skip_final_snapshot = true

}

resource "kubernetes_namespace" "liquibase_namespace" {
  metadata {
    name = "liquibase-migrations"
  }
}

resource "helm_release" "liquibase" {
  name       = "liquibase-migrations"
  chart      = "liquibase_migrations"
  repository = "."
  version    = "0.1.0"
  namespace  = "liquibase-migrations"

  set = [
    {
      name  = "host"
      value = aws_db_instance.illuminati_db.address
    },
    {
      name  = "port"
      value = aws_db_instance.illuminati_db.port
    },
    {
      name  = "dbname"
      value = aws_db_instance.illuminati_db.db_name
    },
    {
      name  = "user"
      value = aws_db_instance.illuminati_db.username
    },
    {
      name  = "passwd"
      value = aws_db_instance.illuminati_db.password
    }
  ]

  depends_on = [aws_db_instance.illuminati_db, kubernetes_namespace.liquibase_namespace]

}

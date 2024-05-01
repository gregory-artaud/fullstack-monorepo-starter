resource "aws_security_group" "_" {
  name        = "postgres-security-group-prod"
  description = "Postgres security group"
  vpc_id      = var.VPC_ID

  ingress {
    protocol    = "tcp"
    from_port   = 5432
    to_port     = 5432
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "_" {

  allocated_storage    = 5
  storage_type         = "gp2"
  instance_class       = "db.t4g.micro"
  identifier           = var.INSTANCE_IDENTIFIER
  engine               = "postgres"
  engine_version       = "16.2"
  parameter_group_name = "default.postgres16"

  username = var.DB_USERNAME
  password = var.DB_PASSWORD

  publicly_accessible    = var.is_publicly_accessible
  skip_final_snapshot    = true
}

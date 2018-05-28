# Default RDS implementation with PostGreSQL as the database server

resource "aws_db_instance" "rds" {
  identifier               = "${var.rds_name}"
  #enabled_cloudwatch_logs_exports

  db_subnet_group_name     = "${aws_db_subnet_group.rds.id}"

  engine                   = "postgres"
  engine_version           = "10.3"
  instance_class           = "db.r4.large"
  allocated_storage        = 10 # gigabytes
  storage_type             = "gp2"
  storage_encrypted        = true
  backup_retention_period  = 7   # in days
  skip_final_snapshot      = true

  name                     = "capsdb" #name of the database
  username                 = "postgres"
  password                 = "postgres"
  port                     = 5432

  publicly_accessible      = false
  vpc_security_group_ids   = ["${aws_security_group.rds.id}"]
}

resource "aws_db_subnet_group" "rds" {
  name       = "${var.rds_name}-db-subnet-group"
  subnet_ids = ["${var.private_subnet_ids}"]

  tags {
    Environment = "${var.environment}"
  }
}

resource "aws_security_group" "rds" {
  name = "${var.rds_name}-security-group"
  vpc_id = "${var.vpc_id}"

#  ingress {
#    from_port = 5432
#    to_port = 5432
#    protocol = "tcp"
#    cidr_blocks = ["0.0.0.0/0"]
#  }

  # Allow all outbound traffic.
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "rds_security_group_id" {
  value = "${aws_security_group.rds.id}"
}

output "rds_subnet_group_id" {
  value = "${aws_db_subnet_group.rds.id}"
}

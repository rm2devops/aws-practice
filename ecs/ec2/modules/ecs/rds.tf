module "rds" {
  source = "../rds"

  environment       = "${var.environment}"
  rds_name          = "${var.environment}-${var.cluster}-pgsql"
  vpc_id            = "${module.network.vpc_id}"
  private_subnet_ids = "${module.network.private_subnet_ids}"
}

resource "aws_security_group_rule" "ecs_to_rds" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "TCP"
  source_security_group_id = "${module.ecs_instances.ecs_instance_security_group_id}"
  security_group_id        = "${module.rds.rds_security_group_id}"
}

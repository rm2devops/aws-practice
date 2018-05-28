module "network" {
  source               = "../network"
  environment          = "${var.environment}"
  vpc_cidr             = "${var.vpc_cidr}"
  public_subnet_cidrs  = "${var.public_subnet_cidrs}"
  private_subnet_cidrs = "${var.private_subnet_cidrs}"
  availability_zones   = "${var.availability_zones}"
  depends_id           = ""
}

module "alb" {
  source = "../alb"
  environment          = "${var.environment}"
  alb_name             = "${var.environment}-${var.cluster}-alb"
  vpc_id               = "${module.network.vpc_id}"
  public_subnet_ids    = "${module.network.public_subnet_ids}"
}

#resource "aws_security_group_rule" "alb_to_ecs" {
#  type                 = "ingress"
#  from_port            = 80
#  to_port              = 80
#  protocol             = "TCP"
#  cidr_blocks          = ["0.0.0.0/0"]
#  security_group_id    = "${module.alb.alb_security_group_id}"
#}

resource "aws_security_group" "ecs-tasks" {
  name                 = "${var.environment}-${var.cluster}-ecs-security-group"
  description          = "Allow inbound access from the ALB only"
  vpc_id               = "${module.network.vpc_id}"

  tags {
    Environment   = "${var.environment}"
    Cluster       = "${var.cluster}"
  }
}

resource "aws_security_group_rule" "ecs_from_alb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "TCP"
  source_security_group_id   = "${module.alb.alb_security_group_id}"
  security_group_id = "${aws_security_group.ecs-tasks.id}"
}

resource "aws_security_group_rule" "outbound_internet_access" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ecs-tasks.id}"
}

module "fargate" {
  source = "../fargate"
  cluster           = "${var.cluster}"
  security_groups   = ["${aws_security_group.ecs-tasks.id}"]
  subnets           = "${module.network.private_subnet_ids}"
  target_group_arn  = "${module.alb.default_alb_target_group}"
}

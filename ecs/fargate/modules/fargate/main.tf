resource "aws_ecs_cluster" "main" {
  name = "${var.cluster}"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "${var.fargate_cpu}"
  memory                   = "${var.fargate_memory}"

  container_definitions = <<DEFINITION
  [
    {
      "cpu": ${var.fargate_cpu},
      "image": "${var.app_image}",
      "memory": ${var.fargate_memory},
      "name": "app",
      "networkMode": "awsvpc",
      "portMappings": [
        {
          "containerPort": ${var.app_port},
          "hostPort": ${var.app_port}
        }
      ]
    }
  ]
DEFINITION
}

resource "aws_ecs_service" "main" {
  name            = "pcl-qa-ecs-service"
  cluster         = "${aws_ecs_cluster.main.id}"
  task_definition = "${aws_ecs_task_definition.app.arn}"
  desired_count   = "${var.app_count}"
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = ["${var.security_groups}"]
    subnets         = ["${var.subnets}"]
  }

  load_balancer {
    target_group_arn = "${var.target_group_arn}"
    container_name   = "app"
    container_port   = "${var.app_port}"
  }

#  depends_on = [
#    "module.alb.aws_alb_listener.http",
#  ]
}

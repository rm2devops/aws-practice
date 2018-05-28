variable "app_image" {
  description = "Docker image to run in the ECS cluster"
  default     = "httpd:latest"
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 80
}

variable "app_count" {
  description = "Number of docker containers to run"
  default     = 1
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "256"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "512"
}

variable "cluster" {
  description = "The name of the ECS cluster"
}

variable "security_groups" {
  type        = "list"
  description = "Security group for the ECS cluster"
}

variable "subnets" {
  type        = "list"
  description = "List of private subnet ids to place the ECS cluster in"
}

variable "target_group_arn" {
  description = "ARN for the ALB target group"
}

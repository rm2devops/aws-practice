variable "rds_name" {
  default     = "default"
  description = "The name of the rds"
}

variable "environment" {
  description = "The name of the environment"
}

variable "private_subnet_ids" {
  type        = "list"
  description = "List of private subnet ids to place the rds in"
}

variable "vpc_id" {
  description = "The VPC id"
}

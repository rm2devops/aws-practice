# Keeping your terraform.state files locally or commited in a version control is generally a bad idea.
# Hence why we are telling terraform to use "s3" as our "backend" to put state files into
terraform {
  backend "s3" {}
}

provider "aws" {
  region = "${var.region}"
}

# Where to store the terraform state file. Note that you won't have a local tfstate file, because it is now stored remotely.
data "terraform_remote_state" "infra_state" {
  backend = "s3"
  config {
    bucket = "terraform-states-${var.region}"
    key = "${var.environment}/project.tfstate"
    region = "${var.region}"
  }
}

module "ecs" {
  source = "modules/ecs"

  environment          = "${var.environment}"
  cluster              = "${var.cluster}"
  cloudwatch_prefix    = "${var.environment}"
  vpc_cidr             = "${var.vpc_cidr}"
  public_subnet_cidrs  = "${var.public_subnet_cidrs}"
  private_subnet_cidrs = "${var.private_subnet_cidrs}"
  availability_zones   = "${var.availability_zones}"
  max_size             = "${var.max_size}"
  min_size             = "${var.min_size}"
  desired_capacity     = "${var.desired_capacity}"
  key_name             = "${var.ecs_key_pair_name}"
  instance_type        = "${var.instance_type}"
  ecs_aws_ami          = "${var.ecs_aws_ami}"
}

variable "vpc_cidr" {}
variable "environment" {}
variable "region" {}
variable "cluster" {}
variable "max_size" {}
variable "min_size" {}
variable "desired_capacity" {}
variable "ecs_key_pair_name" {}
variable "instance_type" {}
variable "ecs_aws_ami" {}

variable "private_subnet_cidrs" {
  type = "list"
}

variable "public_subnet_cidrs" {
  type = "list"
}

variable "availability_zones" {
  type = "list"
}

output "default_alb_target_group" {
  value = "${module.ecs.default_alb_target_group}"
}

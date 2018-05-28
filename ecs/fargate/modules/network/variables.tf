variable "vpc_cidr" {
  description = "IP addressing for VPC CIDR block"
}

variable "environment" {
  description = "The name of the environment"
}

variable "destination_cidr_block" {
  default     = "0.0.0.0/0"
  description = "Specify all traffic to be routed either trough Internet Gateway or NAT to access the internet"
}

variable "private_subnet_cidrs" {
  type        = "list"
  description = "List of private cidrs, required one for every avalibility zone"
}

variable "public_subnet_cidrs" {
  type        = "list"
  description = "List of public cidrs, required one for every avalibility zone"
}

variable "availability_zones" {
  type        = "list"
  description = "List of avalibility zones"
}

variable "depends_id" {}

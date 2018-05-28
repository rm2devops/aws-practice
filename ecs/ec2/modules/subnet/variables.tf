variable "name" {
  description = "Name of the subnet"
}

variable "environment" {
  description = "The name of the environment"
}

variable "cidrs" {
  type        = "list"
  description = "List of cidrs, one per avalibility zone"
}

variable "availability_zones" {
  type        = "list"
  description = "List of avalibility zones where we want to perform our setup"
}

variable "vpc_id" {
  description = "This subnet will be associated with this VPC"
}

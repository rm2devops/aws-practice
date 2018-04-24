variable "subnet_ids" {
  type        = "list"
  description = "List of subnets where NAT Gateway will be placed"
}

variable "subnet_count" {
  description = "Size of the subnet_ids. This needs to be provided because: value of 'count' cannot be computed"
}

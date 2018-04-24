access_key = "AKIAI5EOQB5HSSCLBKUQ"

secret_key = "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"

vpc_cidr = "10.0.0.0/16"

environment = "pcl-qa"

#alb_name = "pcl-qa-alb"

cluster = "aps-1"

#public_subnet_cidrs = ["10.0.0.0/24", "10.0.1.0/24"]
public_subnet_cidrs = ["10.0.0.0/24"]

#private_subnet_cidrs = ["10.0.50.0/24", "10.0.51.0/24"]
private_subnet_cidrs = ["10.0.50.0/24"]

#availability_zones = ["ap-south-1a", "ap-south-1b"]
availability_zones = ["ap-south-1a"]

max_size = 1

min_size = 1

desired_capacity = 1

instance_type = "t2.micro"

ecs_aws_ami = "ami-e60e5a89"

ecs_key_pair_name = "test-instance"

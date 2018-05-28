# This is a custom file which has been created to dynamically pass certain variables to our main terraform file, as per the AWS architecture designed for PCL.
# The values of these variables are based on certain assumptions & shall be modified accordingly when used by a developer to suit his infrastructure setup requirements.
# Please treat this file as a reference to create your own before attempting to run terraform engine.

# Allocate a set of flexible IP's using CIDR (Classless Inter-Domain Routing) for the VPC, which is an optimized software-defined network (SDN) within AWS.
# Read more as to how many IP's you should need for a practical setup - https://medium.com/aws-activate-startup-blog/practical-vpc-design-8412e1a18dcc
vpc_cidr = "x.x.x.x/16"

# Populate this value to reflect the name of your software environment for the project, ideally in the form of project-environment
environment = "qa"

# Provide a name for the Amazon ECS cluster
cluster = "demo"

# Specify the no. of IP's to be reserved for each subnet using CIDR (refer to the same link mentioned above)

public_subnet_cidrs = ["x.x.x.x/24", "x.x.y.x/24"]
private_subnet_cidrs = ["x.x.z.x/24", "x.x.a.x/24"]

# Mention the region where you want to create the VPC (refer to https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html#concepts-available-regions)
region = "us-east-2"

# Mention the AZ's that are targeted to be spanned within the VPC (refer to https://aws.amazon.com/about-aws/global-infrastructure/)
availability_zones = ["us-east-2a", "us-east-2b"]

# Specify the no. of minimum , maximum & desired instances for the auto-scaling group configuration
max_size = 1
min_size = 1
desired_capacity = 1

# Specify the type in instance you want to provision within the ECS (refer to https://aws.amazon.com/ec2/instance-types)
instance_type = "t2.micro"

# This must be a recommended AMI to launch your Amazon ECS container instances (refer to https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html)
ecs_aws_ami = "ami-64300001"

# Specify a key-pair for the instances , if you are going to access them from the internet
ecs_key_pair_name = "qa-instance"

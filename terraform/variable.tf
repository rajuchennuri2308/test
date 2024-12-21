variable "region" {
  description = "AWS region"
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "Instance type for EC2 instances"
}

variable "key_name" {
  description = "Key pair name for SSH access"
}

variable "user_data" {
  description = "User data script for EC2 instances"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
}

variable "vpc_name" {
  description = "Name tag for the VPC"
}

variable "subnet1_cidr" {
  description = "CIDR block for Subnet 1"
}

variable "subnet2_cidr" {
  description = "CIDR block for Subnet 2"
}

variable "subnet1_name" {
  description = "Name tag for Subnet 1"
}

variable "subnet2_name" {
  description = "Name tag for Subnet 2"
}

variable "igw_name" {
  description = "Name tag for the Internet Gateway"
}

variable "route_cidr" {
  description = "CIDR block for route table"
}

variable "route_table_name" {
  description = "Name tag for the Route Table"
}

variable "sg_name" {
  description = "Name tag for the Security Group"
}
variable "launch_template_name" {
  description = "Name tag for the Launch Template"
}

variable "min_size" {
  description = "Minimum size for the Auto Scaling Group"
}

variable "max_size" {
  description = "Maximum size for the Auto Scaling Group"
}

variable "desired_capacity" {
  description = "Desired capacity for the Auto Scaling Group"
}

variable "lb_name" {
  description = "Name tag for the Load Balancer"
}

variable "target_group_name" {
  description = "Name tag for the Target Group"
}

variable "health_check_path" {
  description = "Path for health checks"
}

variable "health_check_interval" {
  description = "Interval for health checks"
}

variable "health_check_timeout" {
  description = "Timeout for health checks"
}

variable "healthy_threshold" {
  description = "Healthy threshold for health checks"
}

variable "unhealthy_threshold" {
  description = "Unhealthy threshold for health checks"
}

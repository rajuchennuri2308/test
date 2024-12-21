region            = "us-east-1"
ami_id            = "ami-0453ec754f44f9a4a"
instance_type     = "t2.micro"
key_name          = "sk" # Replace with your actual key pair name
user_data         = <<EOF
#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1> My hostname is :$(hostname -i)</h1>" > /var/www/html/index.html
EOF

vpc_cidr          = "10.0.0.0/16"
vpc_name          = "main-vpc"
subnet1_cidr      = "10.0.1.0/24"
subnet2_cidr      = "10.0.2.0/24"
subnet1_name      = "subnet1"
subnet2_name      = "subnet2"
igw_name          = "main-igw"
route_cidr        = "0.0.0.0/0"
route_table_name  = "main-route-table"
sg_name           = "web-sg"
launch_template_name = "web-launch-template"
min_size             = 1
max_size             = 3
desired_capacity     = 2

lb_name              = "web-load-balancer"
target_group_name    = "web-target-group"

health_check_path     = "/"
health_check_interval = 30
health_check_timeout  = 5
healthy_threshold     = 2
unhealthy_threshold   = 2

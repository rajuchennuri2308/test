region            = "eu-central-1"
ami_id            = ""
instance_type     = "t2.micro"
key_name          = "raju" # Replace with your actual key pair name
user_data         = <<EOF
#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1> My hostname is :$(hostname -i)</h1>" > /var/www/html/index.html
EOF

vpc_cidr          = "10.0.0.0/16"
vpc_name          = "skivori-vpc"
subnet1_cidr      = "10.0.1.0/24"
subnet2_cidr      = "10.0.2.0/24"
subnet1_name      = "skivori-subnet1"
subnet2_name      = "skivori-subnet2"
igw_name          = "skivorimain-igw"
route_cidr        = "0.0.0.0/0"
route_table_name  = "skivori-route-table"
sg_name           = "skivoriweb-sg"
launch_template_name = "skivoriweb-launch-template"
min_size             = 1
max_size             = 3
desired_capacity     = 2

lb_name              = "skivoriweb-load-balancer"
target_group_name    = "skivoriweb-target-group"

health_check_path     = "/"
health_check_interval = 30
health_check_timeout  = 5
healthy_threshold     = 2
unhealthy_threshold   = 2

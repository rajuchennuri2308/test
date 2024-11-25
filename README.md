# test
Terraform AWS Auto Scaling Group with Load Balancer
This Terraform project sets up a scalable and highly available web application infrastructure on AWS. It includes a VPC, subnets, security groups, an auto-scaling group, and an application load balancer.

Features
VPC and Networking: Creates a VPC with two subnets in different availability zones.
Security Group: Configures security rules for SSH and HTTP access.
Launch Template: Defines the configuration for EC2 instances.
Auto Scaling Group: Automatically scales instances based on the desired capacity.
Application Load Balancer: Balances incoming traffic and ensures availability.
Target Group with Health Checks: Configures health checks to maintain instance availability.
Prerequisites
Terraform: Installed and configured on your system.
AWS CLI: Installed and authenticated.
Key Pair: An existing AWS key pair for SSH access to instances.
Usage
1. Clone the Repository
bash
Copy code
git clone <repository-url>
cd <repository-directory>
2. Update Variables
Modify the terraform.tfvars file with your own values if necessary. Key variables include:

region: AWS region to deploy resources.
ami_id: AMI ID for EC2 instances.
key_name: Name of your AWS key pair.
user_data: Custom script to initialize EC2 instances.
3. Initialize Terraform
bash
Copy code
terraform init
4. Validate Configuration
bash
Copy code
terraform validate
5. Plan Deployment
bash
Copy code
terraform plan
6. Apply Configuration
bash
Copy code
terraform apply
7. Destroy Resources (When No Longer Needed)
bash
Copy code
terraform destroy
Resources Created
Networking
VPC: A new VPC with CIDR 10.0.0.0/16.
Subnets: Two public subnets in different availability zones.
Internet Gateway: For internet access.
Route Table: Routes traffic to the internet gateway.
Compute
Launch Template: Defines EC2 instance configurations, including user data to install and start Apache.
Auto Scaling Group: Manages EC2 instances with a minimum size of 1 and maximum size of 3.
Load Balancer
Application Load Balancer: Distributes HTTP traffic across instances.
Target Group: Configures health checks for instances.
Security
Security Group: Allows SSH (22) and HTTP (80) access from anywhere.
Variables
Key variables used in this project are defined in variables.tf and configured in terraform.tfvars. Some important variables include:

Variable	Description	Default Value
region	AWS region	us-east-1
ami_id	AMI ID for EC2 instances	ami-0453ec754f44f9a4a
instance_type	Type of EC2 instance	t2.micro
key_name	Key pair name for SSH access	sk (replace as needed)
vpc_cidr	CIDR block for the VPC	10.0.0.0/16
subnet1_cidr	CIDR block for Subnet 1	10.0.1.0/24
subnet2_cidr	CIDR block for Subnet 2	10.0.2.0/24
min_size	Minimum number of instances in ASG	1
max_size	Maximum number of instances in ASG	3
desired_capacity	Desired number of instances in ASG	2
Outputs (Optional)
Customize outputs in your outputs.tf file to display key details such as:

Public DNS of the Load Balancer.
VPC ID.
Subnet IDs.
Notes
Replace the placeholder key_name in terraform.tfvars with your actual AWS key pair name.
Ensure the ami_id corresponds to a valid Linux-based AMI in your region.
----------------------------------------------------------------------------------------------------------------------

Jenkins Pipeline for Maven Project with Docker Integration
This repository contains a Jenkins pipeline configuration for building a Maven-based Java project, packaging it into a Docker image, and pushing it to Docker Hub.

Pipeline Workflow
Checkout Stage
The pipeline checks out the code from the master branch of the GitHub repository.

Build Docker Image
A Docker image is built using the Dockerfile present in the root directory of the repository. The image is tagged with the Jenkins build number for versioning.

Push Docker Image
The Docker image is pushed to Docker Hub using credentials stored in Jenkins (docker-cred).

Post-Build Steps

Success: The pipeline logs a success message if all stages complete without error.
Failure: The pipeline logs an error message if any stage fails.
Pre-requisites
Jenkins Setup
Install Jenkins and configure it.
Install the following Jenkins plugins:
Pipeline
Git
Docker Pipeline
Docker Hub Credentials
Add Docker Hub credentials in Jenkins:
Go to Manage Jenkins > Manage Credentials.
Add a new credential with:
ID: docker-cred
Username: Your Docker Hub username.
Password: Your Docker Hub password.
Environment
Ensure Docker is installed on the Jenkins agent and configured properly.
Maven must be installed and available in the system's PATH.
Project Structure
plaintext
Copy code
.
├── app/                     # Application source code directory
│   ├── src/                 # Source code
│   ├── pom.xml              # Maven build configuration
├── Dockerfile               # Docker build configuration
├── Jenkinsfile              # Jenkins pipeline definition
└── README.md                # Documentation
Replace app/ with the name of the directory containing your application code if applicable.
Jenkinsfile Configuration
The Jenkinsfile defines the pipeline stages. Below is a summary of its key components:

Git URL: https://github.com/yudfgh/shanu.git
Build Command: mvn clean package -DskipTests
Docker Image Name: prakharm1234/shanu-app
Image Tag: Jenkins build number
Usage
Step 1: Clone Repository
bash
Copy code
git clone https://github.com/yudfgh/shanu.git
cd shanu
Step 2: Configure Jenkins Job
Create a new pipeline job in Jenkins.
Point the pipeline script to the Jenkinsfile in this repository.
Step 3: Run Pipeline
Trigger the Jenkins pipeline. On successful execution, the Docker image will be built and pushed to Docker Hub.

Troubleshooting
Error: MissingProjectException
Ensure the pom.xml file is present in the correct directory. Update the Jenkinsfile to navigate to the directory containing the pom.xml.

Docker Login Issues
Verify that the Docker Hub credentials (ID: docker-cred) are configured correctly in Jenkins.

Build Failures
Check the logs for errors. Ensure Maven and Docker are correctly installed on the Jenkins agent.

Contributing
If you'd like to contribute, feel free to open a pull request or raise an issue.

---------------------------------------------------------------------------------------------------------------------------------------------------




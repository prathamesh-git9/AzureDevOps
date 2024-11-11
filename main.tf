provider "aws" {
  region = "eu-west-1"
}


# Define a Security Group with a unique name or check if it exists

resource "aws_security_group" "vm_sg" {
  # Dynamically generate a unique name by using a timestamp to avoid duplicates
  name        = "vm_security_group_${timestamp()}"
  description = "Allow SSH and HTTP access"

  # Allow SSH (port 22)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTP (port 80)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress (Allow all outbound traffic)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Data source to fetch an existing key pair from your AWS account
data "aws_key_pair" "existing_key" {
  key_name = "my-key-pair"  # Replace with your existing key pair name
}

d Containers in main.tf
hcl
Copy code
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.0"
    }
  }
}

provider "docker" {}

# Pull an Image from Docker Hub
resource "docker_image" "nginx" {
  name = "nginx:latest"
  keep_locally = false  # Set to true if you want to keep it after the container is deleted
}

# Define a Container that Uses the Pulled Image
resource "docker_container" "nginx_container" {
  image = docker_image.nginx.latest
  name  = "my-nginx-container"

  ports {
    internal = 80
    external = 8080
  }
}

# Output the container's IP address
output "nginx_container_ip" {
  value = docker_container.nginx_container.ip_address
}

# EC2 Instance using the key pair and security group
resource "aws_instance" "vm" {
  ami           = "ami-03ca36368dbc9cfa1"  # Replace with your preferred AMI ID
  instance_type = "t2.micro"
  key_name      = data.aws_key_pair.existing_key.key_name   # Reference the existing key pair

  # Associate the EC2 instance with the security group
  vpc_security_group_ids = [aws_security_group.vm_sg.id]

  tags = {
    Name = "TerraformVM"
  }
}


output "vm_ip" {
  value = aws_instance.vm.public_ip
}

resource "local_file" "output_ip" {
  content  = aws_instance.vm.public_ip
  filename = "${path.module}/vm_ip.txt"
}

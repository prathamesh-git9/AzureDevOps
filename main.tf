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


output "vm_ip" {
  value = aws_instance.vm.public_ip
}

resource "local_file" "output_ip" {
  content  = aws_instance.vm.public_ip
  filename = "${path.module}/vm_ip.txt"
}

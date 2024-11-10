provider "aws" {
  region = "eu-west-1"
}

# Define or import the SSH key pair
resource "aws_key_pair" "my_key" {
  key_name   = "my-key-pair"                             # Name for the key pair in AWS
  public_key = file("~/.ssh/my-key-pair.pub")       # Replace with the actual path to your .pub file
}

# Security Group for SSH and HTTP access
resource "aws_security_group" "vm_sg" {
  name        = "vm_security_group"
  description = "Allow SSH and HTTP"

  # Allow SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance using the key pair and security group
resource "aws_instance" "vm" {
  ami           = "ami-03ca36368dbc9cfa1"    # Ubuntu 18.04 for eu-west-1 (update as needed)
  instance_type = "t2.micro"
  key_name      = aws_key_pair.my_key.key_name   # Reference the SSH key pair

  vpc_security_group_ids = [aws_security_group.vm_sg.id]

  tags = {
    Name = "TerraformVM"
  }
}

# Output the public IP of the instance
output "vm_ip" {
  value = aws_instance.vm.public_ip
}

# Save the public IP to a .txt file on apply
resource "local_file" "output_ip" {
  content  = aws_instance.vm.public_ip
  filename = "${path.module}/vm_ip.txt"
}

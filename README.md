# Automated Cloud Infrastructure Setup with Terraform

This project uses **Terraform** to set up an automated cloud infrastructure on AWS. The main goal is to create a secure and accessible EC2 instance (a virtual server) to host a web application or other services. The setup includes network configurations to allow access through HTTP and SSH, while securing other traffic.

## Project Overview

1. **Provider Configuration**: We specify AWS as our cloud provider and set the region to `eu-west-1`.

2. **Security Group**: A security group acts as a virtual firewall for our instance, controlling incoming and outgoing traffic. Here’s what we set up:
   - Allow **HTTP traffic** on port 80 for web access.
   - Allow **SSH traffic** on port 22 for secure remote access.

3. **Ubuntu AMI**: We use the latest version of Ubuntu 20.04 as the operating system for our EC2 instance. AMI (Amazon Machine Image) is the template for this OS.

4. **EC2 Instance**: We create an `EC2 instance` (a virtual server) with the following properties:
   - **Instance Type**: `t2.micro`, which is suitable for low-cost, small workloads.
   - **Key Pair**: Used to securely connect to the instance via SSH.
   - **Security Group**: Linked to allow HTTP and SSH traffic as specified.

5. **Output**: After creating the instance, Terraform outputs the **public IP address** of the instance, allowing us to connect to or view it.

## File Structure

Here’s a breakdown of the main files:

- `main.tf`: This file includes all the configuration settings for setting up the EC2 instance, security group, AMI, and key pair.

## Flow of Execution

1. **Terraform Initialization**: Run `terraform init` to download and set up the provider and any necessary plugins.

2. **Terraform Plan**: Run `terraform plan` to view the changes that will be applied without actually deploying anything. This helps in verifying the setup.

3. **Terraform Apply**: Run `terraform apply` to create the EC2 instance and security group on AWS. Confirm the action when prompted. Once complete, Terraform will output the instance’s public IP address.

4. **Access the Instance**:
   - Use the **public IP address** output by Terraform to access your instance.
   - Connect via **SSH** using your key pair.

## Prerequisites

1. **AWS Account**: You need an AWS account to deploy infrastructure.
2. **AWS CLI**: The AWS CLI must be installed and configured on your machine.
3. **Terraform**: Install Terraform to deploy the infrastructure.

## Diagram

The architecture diagram includes:

- **AWS Provider**: Defines the AWS region for deployment.
- **Security Group**: Manages HTTP and SSH traffic.
- **Ubuntu AMI**: The operating system used for the EC2 instance.
- **EC2 Instance**: The virtual server that runs the application.
- **Output**: Shows the public IP of the instance for access.

## Commands

1. **Initialize Terraform**:
   ```bash
   terraform init

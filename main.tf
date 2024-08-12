# 1. Create VPC
# 2. Create Internet Gateway
# 3. Create Custom Route Table
# 4. Create a Subnet
# 5. Associate subnet with Route Table
# 6. Create Security Group to allow TCP port 22,80 and ICMP echo-req
# 7. Create a network interface with an ip in the subnet
# 8. Assign an elastic IP to the network interface
# 9. Launch an instance with ubuntu ami and user_date should execute by cloud-init
# TODO : introduce variables from this main module

provider "aws" {
  region = var.region # Singapore
}

resource "aws_vpc" "Development" {
  cidr_block = var.vpc_cidr_block
  tags = {
    name = "Development"
  }
}

resource "aws_internet_gateway" "nexthop" {
  vpc_id = aws_vpc.Development.id
}

resource "aws_route_table" "development_route_table" {
  vpc_id = aws_vpc.Development.id
  route {
    cidr_block = var.any_network
    gateway_id = aws_internet_gateway.nexthop.id
  }

  tags = {
    name = "Default Gateway"
  }
}

resource "aws_subnet" "apps01-subnet" {
  vpc_id            = aws_vpc.Development.id
  cidr_block        = var.apps01_subnet_cidr_block
  availability_zone = var.ami_availability_zone
  tags = {
    name = "apps01-subnet"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.apps01-subnet.id
  route_table_id = aws_route_table.development_route_table.id
}

resource "aws_security_group" "allow_basic_services" {

  name        = "TCP-22,TCP-80"
  description = "Allow inbound traffic on port 80 and 22"
  vpc_id      = aws_vpc.Development.id

  # Define inbound rules
  ingress {
    description = "Allow ICMP"
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Secure Shell"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Egress Traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    name = "Allow Basic Services"
  }
}

resource "aws_network_interface" "netif" {
  subnet_id       = aws_subnet.apps01-subnet.id
  private_ips     = [var.apps01_devel_private_ip]
  security_groups = [aws_security_group.allow_basic_services.id]
}

resource "aws_eip" "first" {
  instance                  = aws_instance.RealServer-01.id
  network_interface         = aws_network_interface.netif.id
  associate_with_private_ip = var.apps01_devel_private_ip
  depends_on                = [aws_instance.RealServer-01, aws_internet_gateway.nexthop]
}

resource "aws_instance" "RealServer-01" {
  ami               = var.ubuntu-ami
  instance_type     = var.instance_type
  key_name          = var.devel_ssh_key_pairs
  availability_zone = var.ami_availability_zone
  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.netif.id
  }
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install apache2
              sudo systemctl enable apache2
              sudo systemctl start apache2
              
              EOF

  tags = {
    Name = "Frontend-01"
  }
}

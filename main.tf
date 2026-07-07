provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "kamal_vpc" {
    cidr_block = var.cidr_block
}

resource "aws_subnet" "kamal_subnet" {
  vpc_id     = aws_vpc.kamal_vpc.id
  cidr_block = cidrsubnet(var.cidr_block, 8, 1)
}

resource "aws_security_group" "kamal_security_group" {
  name        = "kamal_security_group"
  description = "Allow SSH and RDP inbound traffic"
  vpc_id      = aws_vpc.kamal_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


#this is kamal comment after applying 444 permission
#this is the second comment after applying 444 permission

resource "aws_instance" "kamalterraformec2" {
    ami = var.ami_id
    instance_type = var.instance_type

    subnet_id = aws_subnet.kamal_subnet.id
    vpc_security_group_ids = [aws_security_group.kamal_security_group.id]
}


output "public_ip" {
    description = "prints the output of the public ip"
    value = aws_instance.kamalterraformec2.public_ip
}

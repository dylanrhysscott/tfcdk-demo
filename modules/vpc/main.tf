terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4"
    }
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  subnet_bits = [
    for az in data.aws_availability_zones.available.names : var.subnet_newbits
  ]
  subnet_cidrs = cidrsubnets(var.cidr_block, local.subnet_bits...)
}

resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block
   tags = {
    Name = var.name
  }
}

resource "aws_subnet" "subnet" {
  for_each =  toset(local.subnet_cidrs)
  availability_zone = element(data.aws_availability_zones.available.names, index(local.subnet_cidrs, each.key))
  vpc_id     = aws_vpc.vpc.id
  cidr_block = each.key
  tags = {
    Name = "${var.name}-subnet-0${index(local.subnet_cidrs, each.key)}"
  }
}

resource "aws_route_table" "rtb" {
  for_each =  toset(local.subnet_cidrs)
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
     Name = "${var.name}-rtb-0${index(local.subnet_cidrs, each.key)}"
  }
}

resource "aws_route_table_association" "rtb_a" {
  for_each =  toset(local.subnet_cidrs)
  subnet_id      = aws_subnet.subnet[each.key].id
  route_table_id = aws_route_table.rtb[each.key].id
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.name}-igw"
  }
}
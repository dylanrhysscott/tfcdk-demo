output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "subnets" {
  value = [
    for cidr in local.subnet_cidrs : aws_subnet.subnet[cidr].id
  ]
}

output "igw" {
  value = aws_internet_gateway.igw.id
}

output "rtbs" {
  value = [
    for cidr in local.subnet_cidrs : aws_route_table.rtb[cidr].id
  ]
}
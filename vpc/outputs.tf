output "security_group" {
  value = aws_security_group.wearslot.id
}

output "vpc_id" {
  value = aws_vpc.wearslot.id
}

output "subnets" {
  value = aws_subnet.public
}
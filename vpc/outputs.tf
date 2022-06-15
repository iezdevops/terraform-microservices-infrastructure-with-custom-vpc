output "security_group" {
  value = aws_security_group.wearslot.id
}

output "vpc_id" {
  value = aws_vpc.wearslot.id
}

output "public_subnet" {
  value = aws_subnet.public
}

output "private_subnet" {
  value = aws_subnet.private
}

output "eips" {
  value = aws_eip.wearslot
}


output "wearslot_ecs_tasks" {
  value = aws_security_group.wearslot_ecs_tasks
}
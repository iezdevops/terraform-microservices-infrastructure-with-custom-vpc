output "security_group" {
  value = aws_security_group.security_group.id
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet" {
  value = aws_subnet.public
}

output "private_subnet" {
  value = aws_subnet.private
}

output "eips" {
  value = aws_eip.eip
}


output "ecs_tasks" {
  value = aws_security_group.ecs_tasks
}
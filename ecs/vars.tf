variable "registry_name" {
  description = "ECR repo name"
  type        = string
}

variable "app_count" {
  description = "Number of containers to be create by the ecs service"
  type = number
}

variable "app_port" {
  description = "Port for app service"
  default     = 3000
}

variable "project_name" {
  description = "Name of project"
  type        = string
}

variable "container_name" {
  description = "Name of app container"
  type        = string
}

variable "security_group" {
  description = "Security groups created by the vpc resource module"
}

variable "ecs_sg" {
  description = "ECS Security groups created by the vpc resource module"
}

variable "vpc_id" {
  description = "Vpc id from the vpc resource module"
}

variable "public_subnet" {
  description = "public subnet ips from vpc module"
}

variable "private_subnet" {
  description = "private subnet ips from vpc module"
}

variable "eips" {
  description = "Elastic ips created in the vpc module"
}


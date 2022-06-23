variable "registry_name" {
  description = "Wearslot ECR repo name"
  default     = "wearslotapi/services"
}

variable "app_count" {
  description = "Number of containers to be create by the ecs service"
  default     = 1
}

variable "app_port" {
  description = "Port for app service"
  default     = 3000
}


variable "project_name" {
  description = "Name of project"
  default     = "wearslot"
}

variable "container_name" {
  description = "Name of app container"
  default     = "wearslot_store_app"
}

variable "security_group" {
  description = "Security groups created by the vpc resource module"
}

variable "ecs_tasks" {
  description = "ECS tasks Security groups created by the vpc resource module"
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


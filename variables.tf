variable "region" {
  description = "Aws region to create resources"
  type = string
}

variable "project_name" {
  description = "Name of project"
  type        = string
}

variable "ecs_app_count" {
  description = "Number of ecs application count"
  type = number
}

variable "container_name" {
  description = "Name of ecs task container"
  type = string
}

variable "container_port" {
  description = "Port to access the container"
  type = number
}
variable "project_name" {
  description = "Name of project"
  type        = string
}

variable "az_count" {
  description = "Number of resources to be created"
  type        = number
}

variable "app_port" {
  description = "Port for the container that will be created by the ecs task"
  type        = number
}

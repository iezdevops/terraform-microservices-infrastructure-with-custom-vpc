variable "registry_name" {
  description = "ECR repo name"
  type        = string
}

variable "app_count" {
  description = "Number of containers to be created"
  type = number
}

variable "container_port" {
  description = "Port for app container service"
  type = number
  default     = 8000
}

variable "project_name" {
  description = "Name of project"
  type        = string
}

variable "container_name" {
  description = "Name of app container"
  type        = string
}

variable "vpc_id" {
  description = "Vpc id from the vpc resource module"
}

variable "subnets" {
  description = "subnet ips from vpc module"
}

# variable "s3_storage" {
#   type = string
#   description = "app s3 bucket storage"
# }
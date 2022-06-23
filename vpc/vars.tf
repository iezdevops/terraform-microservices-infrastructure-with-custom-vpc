variable "az_count" {

  description = "Number of subnets ids to be created"
  default     = 2
}

variable "app_port" {

  description = "Port for app service"
  default     = 3000
}


variable "project_name" {
  description = "Name of project"
  default     = "wearslot"
}

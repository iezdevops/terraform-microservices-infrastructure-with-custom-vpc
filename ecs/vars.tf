variable "registry_name" {

	description = "Wearslot ECR repo name"
	default = "wearslotapi/services"
}

variable "app_count" {

  description = "Number of containers to be create by the ecs service"
  default     = 1
}

variable "security_group" {
  
  description = "Security groups created by the vpc resource module"
}

variable "vpc_id" {

  description = "Vpc id from the vpc resource module"
}

variable "subnets" {
  
  description = "Subnet ips from vpc module"
}
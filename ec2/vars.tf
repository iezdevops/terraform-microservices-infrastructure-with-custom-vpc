variable "project_name" {
  description = "Name of project"
  type        = string
}

variable "instance_name" {
  type    = string
  default = "Wearslot"
}

variable "key_name" {
  default = "wearslot"
  type    = string
}

variable "az_count" {
  default = 2
}

variable "security_group" {}
variable "public_subnet" {}
variable "private_subnet" {}

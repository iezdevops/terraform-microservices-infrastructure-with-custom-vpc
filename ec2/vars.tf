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

variable "app_owner" {
  default = "wearslot"
}

variable "security_group" {}
variable "public_subnet" {}
variable "private_subnet" {}

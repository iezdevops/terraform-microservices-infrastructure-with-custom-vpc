variable "instance_name" {
  description = ""
  type        = string
  default     = "Wearslot"
}

variable "key_name" {
  description = "access to ec2 machine key name"
  default     = "wearslot"
  type        = string
}

variable "az_count" {

  description = "Number of availablility zones"
  default     = 2
}

variable "security_group" {

}

variable "public_subnet" {

}

variable "private_subnet" {

}

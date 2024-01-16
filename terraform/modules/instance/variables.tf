variable "name" {
  description = "Name of the instance"
}

variable "image_id" {
  description = "Image to use for the instance"
}

variable "flavor_id" {
  description = "Flavor to use for the instance"
}

variable "key_pair" {
  description = "Key pair to use for the instance"
}

variable "network" {
  description = "Network to use for the instance"

  type = object({
    name             = string
    floating_ip_pool = string
  })
}

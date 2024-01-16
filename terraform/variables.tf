variable "external_network_id" {
  description = "ID of the external network"
  default     = "93b0c983-69e2-4e52-89da-5521deb2b7a9"
}

variable "image_id" {
  description = "ID of the image to use for the instance"
  default     = "64c90d30-2ce0-404a-a25f-1bad88d86e3b"
}

variable "flavor_id" {
  description = "ID of the flavor to use for the instance"
  default     = "f6da6437-9a55-4719-b8c8-58bbed7bf34f"
}

variable "key_pair_name" {
  description = "Name of the key pair to use for the instance"
  default     = "mfoucher"
}

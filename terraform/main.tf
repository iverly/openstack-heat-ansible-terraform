module "network" {
  source = "./modules/network"

  name                = "private"
  cidr                = "10.10.10.0/24"
  external_network_id = var.external_network_id
}

module "instance" {
  source = "./modules/instance"

  name      = "terraform-webserver"
  image_id  = var.image_id
  flavor_id = var.flavor_id
  key_pair  = var.key_pair_name

  network = {
    name             = module.network.name
    floating_ip_pool = "public"
  }
}

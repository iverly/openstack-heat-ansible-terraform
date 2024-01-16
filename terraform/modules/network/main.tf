resource "openstack_networking_router_v2" "this" {
  name                = var.name
  admin_state_up      = true
  external_network_id = var.external_network_id
}

module "network" {
  source  = "tf-openstack-modules/networks/openstack"
  version = "0.1.0"

  router_id = openstack_networking_router_v2.this.id
  network = {
    name        = var.name
    subnet_name = "${var.name}.subnet",
    cidr        = var.cidr
  }

  depends_on = [openstack_networking_router_v2.this]
}

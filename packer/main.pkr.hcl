packer {
  required_plugins {
    openstack = {
      version = "~> 1"
      source  = "github.com/hashicorp/openstack"
    }
  }
}

source "openstack" "fedora" {
  source_image_name = "Fedora-39"
  
  image_name        = "Fedora-39-docker-wordpress:php8.3-apache-mariadb:11.1-pulled"
  image_visibility = "shared"
  
  flavor = "m1.medium"
  floating_ip_network = "public"
  ssh_username = "fedora"
  network_discovery_cidrs = ["10.1.0.0/24"]
}

build {
  sources = ["source.openstack.fedora"]

  provisioner "shell" {
    inline = [
      "sudo dnf update",
      "sudo dnf upgrade -y",
      "sudo dnf -y install dnf-plugins-core",
      "sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo",
      "sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin",
      "sudo systemctl enable docker",
      "sudo systemctl start docker",
      "sudo docker pull wordpress:php8.3-apache",
      "sudo docker pull mariadb:11.1"
    ]
  }
}

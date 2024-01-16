# openstack-heat-ansible-terraform

A playground for managing OpenStack resources thought heat/ansible/terraform. The goal is to have a working example of how to use these tools together to manage OpenStack resources. This is not a production ready example, but a playground to test and learn.

## Requirements

- OpenStack
- Ansible
- Terraform
- Packer
- Heat

## Usage

### Heat

Heat is used to create the OpenStack resources. The resources are defined in the `heat` directory. The resources are created using the `openstack stack create` command.

The heat will deploy the following resources:

- 1 private network with 1 subnet (cidr: `10.1.0.0/24`).
- 1 router with a gateway to the `public` network.
- 1 instance with a floating IP attached to the `public` network in the private network acting as a webserver (wordpress) associated to a load balancer.
- 1 instance with a floating IP attached to the `public` network in the private network acting as a database (mariadb).
- 1 instance with a floating IP attached to the `public` network in the private network acting as a nfs server for the wordpress instance.
- 1 load balancer with a floating IP attached to the `public` network.

> Note: All the instances have a floating IP attached to the `public` network. This is done to simplify the deployment and to allow access to the instances from the outside.

In order to gain startup time, the heat template will use the `Fedora-39-docker-wordpress:php8.3-apache-mariadb:11.1-pulled` image. This image is a custom image that has been created using the `Fedora-39` image with `docker` installed and the necessary docker images pulled. In order to build this image run the following commands:

```bash
cd packer/
packer build .
```

> Note: The `packer build` command will use the environment variables `OS_USERNAME`, `OS_PASSWORD`, `OS_TENANT_NAME`, `OS_AUTH_URL` and `OS_REGION_NAME` to connect to OpenStack. These variables can be set using the `source openrc.sh` command.

Now that the image has been built, the heat template can be deployed. To deploy the heat template, run the following commands:

```bash
cd heat/
openstack stack create -t index.yaml app
```

> Note: The `openstack stack create` command will use the environment variables `OS_USERNAME`, `OS_PASSWORD`, `OS_TENANT_NAME`, `OS_AUTH_URL` and `OS_REGION_NAME` to connect to OpenStack. These variables can be set using the `source openrc.sh` command.

> Note: The `openstack stack delete` command will delete the stack and all the resources created by the `openstack stack create` command.

### Terraform

Terraform is used to create the OpenStack resources. The resources are defined in the `terraform` directory. The resources are created using the `terraform apply` command.

The terraform will deploy the following resources:

- 1 private network with 1 subnet (cidr: `10.10.10.0/24`) named `private` and `private.subnet` respectively.
- 1 router named `router` with a gateway to the `public` network.
- 1 instance named `terraform-webserver` with a floating IP attached to the `public` network in the `private` network.

To the deploy the resources, run the following commands:

```bash
cd terraform/
terraform init
terraform apply
```

> Note: The `terraform apply` command will use the environment variables `OS_USERNAME`, `OS_PASSWORD`, `OS_TENANT_NAME`, `OS_AUTH_URL` and `OS_REGION_NAME` to connect to OpenStack. These variables can be set using the `source openrc.sh` command.

> Note: The `terraform destroy` command will destroy all the resources created by the `terraform apply` command.

### Ansible

Ansible is used to configure the OpenStack resources. The resources are defined in the `ansible` directory. The resources are configured using the `ansible-playbook` command.

The ansible will configure the following resources:

- 1 private network with 1 subnet (cidr: `192.168.100.0/24`) named `ansible-network` and `ansible-subnet` respectively.
- 1 router named `ansible-router` with a gateway to the `public` network.
- 1 instance named `ansible-instance` with a floating IP attached to the `public` network in the `ansible-network` network.

To the deploy the resources, run the following commands:

```bash
cd ansible/
ansible-playbook main.yml
```

> Note: The `ansible-playbook` command will use the environment variables `OS_USERNAME`, `OS_PASSWORD`, `OS_TENANT_NAME`, `OS_AUTH_URL` and `OS_REGION_NAME` to connect to OpenStack. These variables can be set using the `source openrc.sh` command.

# Contributing

Contributions are welcome. Please follow the standard Git workflow - fork, branch, and pull request.

# License

This project is licensed under the Apache 2.0 - see the `LICENSE` file for details.

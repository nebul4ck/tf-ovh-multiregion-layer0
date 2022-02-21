# Define required provider in order to download the plugins #
terraform {
  required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.44.0"
    }

    ovh = {
      source  = "ovh/ovh"
      version = ">= 0.15.0"
    }
  }
  #  backend "swift" {
  #    container         = "terraform-state"
  #    archive_container = "terraform-state-archive"
  #  }
}

# Define OpenStack provider authentication #
provider "openstack" {
  cloud = "openstack"
}

# Define OVHCloud provider authentication #
provider "ovh" {
  endpoint           = "ovh-eu"
  application_key    = var.application_key
  application_secret = var.application_secret
  consumer_key       = var.consumer_key
  alias              = "ovh"
}

# Export Network ID
data "openstack_networking_network_v2" "ext_net" {
  name = var.default_ovh_pub_net
}

# Define the resources to be deployed #

resource "ovh_cloud_project_network_private" "private_network" {
  service_name = var.tenant_id
  name         = "${var.name}-private-network"
  regions      = var.regions
  provider     = ovh.ovh
}

resource "ovh_cloud_project_network_private_subnet" "private_subnet_a" {
  service_name = var.tenant_id
  network_id   = ovh_cloud_project_network_private.private_network.id
  region       = var.regions[0]
  start        = "10.10.0.2"
  end          = "10.10.0.126"
  network      = "10.10.0.0/16"
  dhcp         = true
  no_gateway   = false
  provider     = ovh.ovh
}

resource "ovh_cloud_project_network_private_subnet" "private_subnet_b" {
  service_name = var.tenant_id
  network_id   = ovh_cloud_project_network_private.private_network.id
  region       = var.regions[1]
  start        = "10.10.0.127"
  end          = "10.10.0.253"
  network      = "10.10.0.0/16"
  dhcp         = true
  no_gateway   = false
  provider     = ovh.ovh
}

# TODO: SET A BOOLEAN 'create_virtual_router' VARIABLE IN ORDER CREATE OR NOT DE VIRTUAL ROUTER.

# EL ROUTER NO ES POSIBLE CREARLO HASTA QUE OVH LO EXPANDA AL RESTO DE REGIONES
# # 3. Create router
# resource "openstack_networking_router_v2" "intra_router" {
#   name                = "${var.name}-priv-router"
#   description         = "The router which act as private_router allowing Internet access."
#   admin_state_up      = true
#   external_network_id = data.openstack_networking_network_v2.ext_net.id
# }

# # 4. Create Router Interface (subnet attachment)
# resource "openstack_networking_router_interface_v2" "private_router_interface_a" {
#   router_id = openstack_networking_router_v2.intra_router.id
#   subnet_id = ovh_cloud_project_network_private_subnet.private_subnet_a.id
# }

# # 5. Create Router Interface (subnet attachment)
# resource "openstack_networking_router_interface_v2" "private_router_interface_b" {
#   router_id = openstack_networking_router_v2.intra_router.id
#   subnet_id = ovh_cloud_project_network_private_subnet.private_subnet_b.id
# }

output "external_network" {
  value = data.openstack_networking_network_v2.ext_net
}

output "private_network" {
  value = ovh_cloud_project_network_private.private_network
}

output "private_subnet_a" {
  value = ovh_cloud_project_network_private_subnet.private_subnet_a
}

output "private_subnet_b" {
  value = ovh_cloud_project_network_private_subnet.private_subnet_b
}

# output "intra_router" {
#   value = openstack_networking_router_v2.intra_router
# }

# output "private_router_interface_a" {
#   value = openstack_networking_router_interface_v2.private_router_interface_a
# }

# output "private_router_interface_b" {
#   value = openstack_networking_router_interface_v2.private_router_interface_b
# }
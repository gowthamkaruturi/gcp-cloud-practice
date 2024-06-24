provider "google" {
  project     = "terraform-on-gcp-426811"
  credentials = file("credentials.json")
  region      = "us-west1"
  zone        = "us-west1-b"
  
}

module "network"{
  source = "./modules/network"
  // Variables to be defined based on your requirements
}

module "firewall"{
  source = "./modules/firewall"
  network_name = "terraform-on-gcp-nw"
  // Variables to be defined based on your requirements
}

module "disk" {
  source = "./modules/disk"
  // Variables to be defined based on your requirements
}

module "instance" {
  source = "./modules/instance"
  // Variables to be defined based on your requirements
}

module "loadbalancer"{
  source = "./modules/loadbalancer"
}
output "instance_template_name" {
  value = module.instance.instance_template_name
}

output "instance_group_name" {
  value = module.instance.instance_group_manager_name
}

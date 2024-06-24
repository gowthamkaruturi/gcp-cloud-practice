resource "google_compute_network" "terraform_network" {
  name                    = var.network_name
  auto_create_subnetworks = false
 
}

resource "google_compute_subnetwork" "terraform_subnet" {
  name          = var.subnetwork_name
  ip_cidr_range = var.subnetwork_cidr
  region        = var.region
  network       = google_compute_network.terraform_network.id
   depends_on = [ google_compute_network.terraform_network ]
}

output "network_name" {
  value = google_compute_network.terraform_network.name
}

output "subnet_name" {
  value = google_compute_subnetwork.terraform_subnet.name
}

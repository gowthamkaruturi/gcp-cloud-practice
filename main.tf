provider "google" {
  project     = "terraform-on-gcp-426811"
  credentials = file("credentials.json")
  region      = "us-west1"
  zone        = "us-west1-b"
}
resource "google_compute_disk" "additional_disk" {
  name = "additional-disk"
  type = "pd-standard"
  zone = "us-west1-b"
  size = 100
}

resource "google_compute_firewall" "ssh-rule" {
  name = "terraform-on-scp-ssh"
  network = google_compute_network.terraform_network.name
  allow {
    protocol = "tcp"
    ports = ["22"]
  }
  target_tags   = ["ssh-access"]
  source_ranges = ["0.0.0.0/0"]
}
resource "google_compute_instance" "terraform-on-gcp" {
  name                      = "terraform-instance"
  machine_type              = "f1-micro"
  zone                      = "us-west1-b"
  allow_stopping_for_update = true
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }
  metadata_startup_script = file("./install.sh")
  network_interface {
    network = google_compute_network.terraform_network.self_link
    subnetwork = google_compute_subnetwork.terraform_subnet.self_link
  
    access_config {
      //necessary even when empty
    }
  }
  attached_disk {
    source = google_compute_disk.additional_disk.self_link
  }
   tags = ["ssh-access", "http-server"]
}

resource "google_compute_network" "terraform_network" {
  name                    = "terraform-network"
  auto_create_subnetworks = false
  
}


resource "google_compute_firewall" "http-rule" {
  name    = "allow-http"
  network = google_compute_network.terraform_network.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}
resource "google_compute_subnetwork" "terraform_subnet" {
  name          = "terraform-subnetwork"
  ip_cidr_range = "10.20.0.0/16"
  region        = "us-west1"
  network       = google_compute_network.terraform_network.id
}

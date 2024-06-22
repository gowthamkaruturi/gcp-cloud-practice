resource "google_compute_firewall" "ssh-rule" {
  name          = var.ssh_firewall_name
  network       = var.network_name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  target_tags   = var.ssh_target_tags
  source_ranges = var.ssh_source_ranges
}

resource "google_compute_firewall" "http-rule" {
  name          = var.http_firewall_name
  network       = var.network_name
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  target_tags   = var.http_target_tags
  source_ranges = var.http_source_ranges
}

output "ssh_firewall_name" {
  value = google_compute_firewall.ssh-rule.name
}

output "http_firewall_name" {
  value = google_compute_firewall.http-rule.name
}

resource "google_compute_disk" "additional_disk" {
  name = var.disk_name
  type = var.disk_type
  zone = var.zone
  size = var.disk_size_gb
}

output "disk_name" {
  value = google_compute_disk.additional_disk.name
}
